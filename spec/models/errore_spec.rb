require 'rails_helper'

RSpec.describe Errore, type: :model do

  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:canal) }
  # Validation test
  # ensure column name is present before saving

end
