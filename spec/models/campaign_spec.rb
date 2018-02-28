require 'spec_helper'

RSpec.describe Campaign, type: :model do
  it {should validate_presence_of(:verification)}
  it {should validate_presence_of(:self_reference)}
  it {should validate_presence_of(:external_reference)}
  it {should validate_presence_of(:status)}
  it {should belong_to(:verification)}
  it {should have_one(:ad).dependent(:destroy)}
end
