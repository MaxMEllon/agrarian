# == Schema Information
#
# Table name: shops
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Shop, type: :model do
  it { is_expected.to have_many(:showcases) }
end

