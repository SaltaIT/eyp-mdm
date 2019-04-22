Facter.add(:eyp_mdm_disk_type) do
  # Fact should be confined to only linux servers that have the blkid command
  confine do
    Facter.value('kernel') == 'Linux' &&
    Facter::Core::Execution.which('blkid')
  end

  setcode do
    Facter::Util::Resolution.exec('blkid').to_s.split(/\n/).map { |s| s.split(':') }
  end
end
