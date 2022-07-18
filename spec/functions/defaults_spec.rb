# frozen_string_literal: true

require 'spec_helper'

describe 'sudo::defaults' do
  it {
    is_expected.to run.with_params(['mailto', { 'value' => 'root' }]).and_return("Defaults\tmailto=\"root\"\n")
  }
  it {
    is_expected.to run.with_params(['env_reset', nil]).and_return("Defaults\tenv_reset\n")
  }

  it { is_expected.to run.with_params(nil).and_raise_error(StandardError) }
end
