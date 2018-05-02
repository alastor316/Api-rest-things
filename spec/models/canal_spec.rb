require 'rails_helper'

RSpec.describe Canal, type: :model do

  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:phinet) }
  it { should have_many(:curva) }
  it { should have_many(:errore) }

  # Validation test
  # ensure column name is present before saving



end
