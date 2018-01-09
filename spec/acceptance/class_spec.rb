require 'spec_helper_acceptance'

describe 'sudo class' do
  context 'with default parameters' do
    # Using puppet_apply as a helper
    it 'works with no errors' do
      pp = <<-PP
      class { 'sudo': }
      PP

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
