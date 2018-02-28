require 'spec_helper'

RSpec.describe Report, type: :model do
  it {should belong_to(:verification)}
  it {should validate_presence_of(:verification)}
  it {should validate_presence_of(:message)}
end
