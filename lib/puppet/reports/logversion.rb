# Jeff McCune <jmccune@puppetlabs.com>
# 2010-05-24
# Report processer to place the config version in every message
#
# TODO: Parse the config_version output to support key/value pairs.

require 'puppet/reports'

# Debugging
require 'rubygems'
require 'ruby-debug'
Debugger.start

Puppet::Reports.register_report(:logversion) do
  desc "Send all received logs to the local log destinations.  Usually
        the log destination is syslog."

  def process
    # Append key/value pairs to the log message.
    # Splunk will parse them into fields.
    self.logs.each do |log|
      saved_message = "#{log.message}"
      if log.source then log.message << " resource=\"#{log.source}\"" end
      if log.time then log.message << " eventtime=\"#{log.time}\"" end
      if log.file then log.message << " manifest=\"#{log.file}\"" end
      if log.line then log.message << " line=#{log.line}"   end
      # The version should be key=value already
      if log.version then log.message << " " << log.version end
      Puppet::Util::Log.newmessage(log)
      log.message = saved_message
    end

  end
end
