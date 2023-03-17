require 'rails_helper'
require_relative '../../app/controllers/concerns/search_method'

RSpec.describe SearchMethod do
  let(:search_class) { Class.new { extend SearchMethod } }

  describe '#search_method' do
    let(:items) do
      [
        FactoryBot.create(:item, name: 'C++', category: 'Programming Language', designed_by: 'Yukihiro Matsumoto'),
        FactoryBot.create(:item, name: 'Kotlin', category: 'Programming Language', designed_by: 'Guido van Rossum'),
        FactoryBot.create(:item, name: 'Java', category: 'Programming Language', designed_by: 'James Gosling')
      ]
    end

    before do
      search_class.instance_variable_set(:@items, Item.all)
    end

    it 'returns all items that match the query terms in any of the fields' do
      result = search_class.search_method('programming language')
      expect(result).to contain_exactly(*items)
    end

    it 'excludes items that contain excluded terms' do
      result = search_class.search_method('programming -java')
      expect(result).to contain_exactly(items[0], items[1])
    end

  end
end
