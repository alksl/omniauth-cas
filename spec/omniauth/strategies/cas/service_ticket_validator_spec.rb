require 'spec_helper'

describe OmniAuth::Strategies::CAS::ServiceTicketValidator do
  let(:strategy) do
    double('strategy',
      service_validate_url: 'https://example.org/serviceValidate'
    )
  end

  let(:provider_options) do
    double('provider_options',
      disable_ssl_verification?: false,
      ca_path: '/etc/ssl/certsZOMG'
    )
  end

  let(:validator) do
    OmniAuth::Strategies::CAS::ServiceTicketValidator.new( strategy, provider_options, '/foo', nil )
  end

  describe '#user_info' do
    before do
      stub_request(:get, 'https://example.org/serviceValidate?')
        .to_return(status: 200, body: '')
      validator.user_info
    end

    it 'uses the configured CA path' do
      expect(provider_options).to have_received :ca_path
    end
  end
end