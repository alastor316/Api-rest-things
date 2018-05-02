require 'rails_helper'

RSpec.describe Muestra, type: :model do


  it { should belong_to(:curva) }

end
