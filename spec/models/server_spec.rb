require 'spec_helper'

describe Server do

  before do
    subject.stub(:server_info => stub(:map_name => "cp_badlands",
                                      :number_of_players => 10,
                                      :max_players => 12,
                                      :server_name => "stubbed server name",
                                      :status => {}))
  end
  it { should validate_presence_of :name }
  it { should validate_presence_of :host_and_port }
  it { should validate_presence_of :location_id }

  context 'validations' do

    it "should validate uniqueness by host and port" do
      server    = create(:server, :host => "fakkelbrigade.eu", :port => "27015")
      duplicate = build(:server, :host => "fakkelbrigade.eu", :port => "27015")
    end

    it "verifies the server is up on creation" do
      subject.should_receive(:server_info)
      subject.name = "Foo"
      subject.host_and_port = "example.com:27015"
      subject.save
    end

    it "doesnt verify server being up on update" do
      server = create(:server)
      server.should_not_receive(:server_info)
      server.update_attributes(:name => "Foobar")
    end

    it "adds an error if the server was unreachable" do
      subject.stub(:server_name => "unknown")
      subject.should have_at_least(1).errors_on(:host_and_port)
    end

  end

  describe '#host_and_port' do

    it 'sets the host and port' do
      subject.host_and_port = 'example.com:27055'
      subject.host.should == 'example.com'
      subject.port.should == '27055'
    end

    it 'returns the host and port' do
      subject.stub(:host => "example.com")
      subject.stub(:port => "27025")
      subject.host_and_port.should == "example.com:27025"
    end

    it "defaults to port 27015" do
      subject.host_and_port = "example.com"
      subject.host_and_port.should == "example.com:27015"
    end
  end

  describe '#steam_connect_url' do
    it 'returns a steam connect url' do
      subject.stub(:host => "example.com", :port => "27015")
      subject.server_connect_url.should == "steam://connect/example.com:27015"
    end
  end

end
