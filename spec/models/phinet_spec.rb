require 'rails_helper'

RSpec.describe Phinet, type: :model do

  it { should have_many(:canal) }


end
