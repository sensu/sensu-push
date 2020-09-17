RSpec.describe Sensu::Push do
  it "has a version number" do
    expect(Sensu::Push::VERSION).not_to be nil
  end

  it "can parse cli arguments" do
    options = Sensu::Push.read_cli_opts(["-c", "foo", "--", "true"])
    expected = {
      :check_name => "foo",
      :command => "true"
    }
    expect(options).to eq(expected)
  end
end
