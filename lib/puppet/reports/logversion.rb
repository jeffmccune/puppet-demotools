# Jeff McCune <jmccune@puppetlabs.com>
# 2010-05-24
# Report processer to place the config version in every message
#
# TODO: Parse the config_version output to support key/value pairs.

require 'puppet/reports'

Puppet::Reports.register_report(:logversion) do
  desc "Send all received logs to the local log destinations.  Usually
        the log destination is syslog."

  def process
    # Obtain the configuration version from the "first" log message
    log = self.logs.find(ifnone=lambda{'NOTFOUND'}) do |log|
      log.message =~ /Applying configuration version \'(.*?)\'/
    end
    config_version = Regexp.last_match(1)

    # Append the audit keys to the log message for splunk to pick up.
    self.logs.each do |log|
      saved_message = "#{log.message}"
      log.message << " " << config_version
      Puppet::Util::Log.newmessage(log)
      log.message = saved_message
    end

  end
end
