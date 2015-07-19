# == Schema Information
#
# Table name: user_equipments
#
#  id           :integer          not null, primary key
#  player_id    :integer
#  body_region  :integer
#  user_item_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_equipments_on_player_id_and_body_region  (player_id,body_region)
#

require 'rails_helper'

RSpec.describe UserEquipment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
