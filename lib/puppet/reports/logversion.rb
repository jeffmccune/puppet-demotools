# Jeff McCune <jmccune@puppetlabs.com>
# 2010-05-24
# Report processer to place the config version in every message
#
# TODO: Parse the config_version output to support key/value pairs.

require 'puppet/reports'

# JJM - Debugging
# require 'rubygems'
# require 'ruby-debug'
# Debugger.start

Puppet::Reports.register_report(:logversion) do
  desc "Send all received logs to the local log destinations.  Usually
        the log destination is syslog."

  def process
    # Append key/value pairs to the log message.
    # Splunk will parse them into fields.
    self.logs.each do |log|
      # Save the original message into a new String instance
      saved_message = "#{log.message}"
      # Append the resource field.
      if log.source then log.message << " resource=\"#{log.source}\"" end
      # Append the time of the event from puppetd itself.
      if log.time then log.message << " eventtime=\"#{log.time}\"" end
      # Append the path to the manifest this event came from.
      if log.file then log.message << " manifest=\"#{log.file}\"" end
      # Append the line number
      if log.line then log.message << " line=#{log.line}"   end
      # The version should be key=value already
      if log.version then log.message << " " << log.version end
      Puppet::Util::Log.newmessage(log)
      log.message = saved_message
    end

  end
end
