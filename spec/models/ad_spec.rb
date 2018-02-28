require 'spec_helper'

RSpec.describe Ad, type: :model do
  it {should belong_to(:campaign)}
  it {should validate_presence_of(:status)}
  it {should validate_presence_of(:campaign)}
end
