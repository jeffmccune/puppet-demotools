require 'puppet/reports'

Puppet::Reports.register_report(:logversion) do
  desc "Send all received logs to the local log destinations.  Usually
        the log destination is syslog."

  # JJM: The configuration version needs to be added here.
  def process
    self.logs.each do |log|
      Puppet::Util::Log.newmessage("audit=puppet #{log}")
    end
  end
end
