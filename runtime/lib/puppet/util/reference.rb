require 'puppet/util/instance_loader'

# Manage Reference Documentation.
class Puppet::Util::Reference
    include Puppet::Util
    include Puppet::Util::Docs

    extend Puppet::Util::InstanceLoader

    instance_load(:reference, 'puppet/reference')

    def self.footer
        "\n\n----------------\n\n*This page autogenerated on %s*\n" % Time.now
    end

    def self.modes
        %w{pdf trac text markdown}
    end

    def self.newreference(name, options = {}, &block)
        ref = self.new(name, options, &block)
        instance_hash(:reference)[symbolize(name)] = ref

        ref
    end

    def self.page(*sections)
        depth = 4
        # Use the minimum depth
        sections.each do |name|
            section = reference(name) or raise "Could not find section %s" % name
            depth = section.depth if section.depth < depth
        end
        text = ".. contents:: :depth: 2\n\n"
    end

    def self.pdf(text)
        puts "creating pdf"
        Puppet::Util.secure_open("/tmp/puppetdoc.txt", "w") do |f|
            f.puts text
        end
        rst2latex = %x{which rst2latex}
        if $? != 0 or rst2latex =~ /no /
            rst2latex = %x{which rst2latex.py}
        end
        if $? != 0 or rst2latex =~ /no /
            raise "Could not find rst2latex"
        end
        rst2latex.chomp!
        cmd = %{#{rst2latex} /tmp/puppetdoc.txt > /tmp/puppetdoc.tex}
        Puppet::Util.secure_open("/tmp/puppetdoc.tex","w") do |f|
            # If we get here without an error, /tmp/puppetdoc.tex isn't a tricky cracker's symlink
        end
        output = %x{#{cmd}}
        unless $? == 0
            $stderr.puts "rst2latex failed"
            $stderr.puts output
            exit(1)
        end
        $stderr.puts output

        # Now convert to pdf
        Dir.chdir("/tmp") do
            %x{texi2pdf puppetdoc.tex >/dev/null 2>/dev/null}
        end

    end

    def self.markdown(name, text)
        puts "Creating markdown for #{name} reference."
        dir = "/tmp/" + Puppet::PUPPETVERSION
        FileUtils.mkdir(dir) unless File.directory?(dir) 
        Puppet::Util.secure_open(dir + "/" + "#{name}.rst", "w") do |f|
            f.puts text
        end
        pandoc = %x{which pandoc}
        if $? != 0 or pandoc =~ /no /
            pandoc = %x{which pandoc}
        end
        if $? != 0 or pandoc =~ /no /
            raise "Could not find pandoc"
        end
        pandoc.chomp!
        cmd = %{#{pandoc} -s -r rst -w markdown #{dir}/#{name}.rst -o #{dir}/#{name}.mdwn}
        output = %x{#{cmd}}
        unless $? == 0
            $stderr.puts "Pandoc failed to create #{name} reference."
            $stderr.puts output
            exit(1)
        end
 
        File.unlink(dir + "/" + "#{name}.rst")
    end

    def self.references
        instance_loader(:reference).loadall
        loaded_instances(:reference).sort { |a,b| a.to_s <=> b.to_s }
    end

    HEADER_LEVELS = [nil, "=", "-", "+", "'", "~"]

    attr_accessor :page, :depth, :header, :title, :dynamic
    attr_writer :doc

    def doc
        if defined?(@doc)
            return "%s - %s" % [@name, @doc]
        else
            return @title
        end
    end

    def dynamic?
        self.dynamic
    end

    def h(name, level)
        return "%s\n%s\n\n" % [name, HEADER_LEVELS[level] * name.to_s.length]
    end

    def initialize(name, options = {}, &block)
        @name = name
        options.each do |option, value|
            send(option.to_s + "=", value)
        end

        meta_def(:generate, &block)

        # Now handle the defaults
        @title ||= "%s Reference" % @name.to_s.capitalize
        @page ||= @title.gsub(/\s+/, '')
        @depth ||= 2
        @header ||= ""
    end

    # Indent every line in the chunk except those which begin with '..'.
    def indent(text, tab)
        return text.gsub(/(^|\A)/, tab).gsub(/^ +\.\./, "..")
    end

    def option(name, value)
        ":%s: %s\n" % [name.to_s.capitalize, value]
    end

    def paramwrap(name, text, options = {})
        options[:level] ||= 5
        #str = "%s : " % name
        str = h(name, options[:level])
        if options[:namevar]
            str += "- **namevar**\n\n"
        end
        str += text
        #str += text.gsub(/\n/, "\n    ")

        str += "\n\n"
        return str
    end

    # Remove all trac links.
    def strip_trac(text)
        text.gsub(/`\w+\s+([^`]+)`:trac:/) { |m| $1 }
    end

    def text
        puts output
    end

    def to_rest(withcontents = true)
        # First the header
        text = h(@title, 1)
        text += "\n\n**This page is autogenerated; any changes will get overwritten** *(last generated on #{Time.now.to_s})*\n\n"
        if withcontents
            text +=  ".. contents:: :depth: %s\n\n" % @depth
        end

        text += @header

        text += generate()

        if withcontents
            text += self.class.footer
        end

        return text
    end

    def to_text(withcontents = true)
        strip_trac(to_rest(withcontents))
    end

    def to_trac(with_contents = true)
        "{{{\n#!rst\n#{self.to_rest(with_contents)}\n}}}"
    end

    def trac
        Puppet::Util.secure_open("/tmp/puppetdoc.txt", "w") do |f|
            f.puts self.to_trac
        end

        puts "Writing %s reference to trac as %s" % [@name, @page]
        cmd = %{sudo trac-admin /opt/rl/trac/puppet wiki import %s /tmp/puppetdoc.txt} % self.page
        output = %x{#{cmd}}
        unless $? == 0
            $stderr.puts "trac-admin failed"
            $stderr.puts output
            exit(1)
        end
        unless output =~ /^\s+/
            $stderr.puts output
        end
    end
end
