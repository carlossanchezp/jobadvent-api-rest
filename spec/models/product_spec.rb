require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to have_db_column(:user_id).of_type(:integer) }

  it { is_expected.to belong_to(:user) }
end
