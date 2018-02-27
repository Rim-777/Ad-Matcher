require 'spec_helper'

RSpec.describe Verification, type: :model do
  it {should have_many(:campaigns).dependent(:destroy)}
  it {should have_many(:reports).dependent(:destroy)}
  it {should validate_presence_of(:campaign_list)}
end