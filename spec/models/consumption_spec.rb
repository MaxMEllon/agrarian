# == Schema Information
#
# Table name: consumptions
#
#  id               :integer          not null, primary key
#  item_id          :integer
#  consumption_type :integer
#  type_value       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_consumptions_on_item_id  (item_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Consumption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

