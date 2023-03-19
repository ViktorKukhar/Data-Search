require 'rails_helper'
require_relative '../../app/controllers/concerns/search_method'

RSpec.describe SearchMethod do
  include SearchMethod

  let(:json_data) do
    [
      {'Name' => 'Python', 'Type' => 'Scripting', 'Designed by' => 'Guido van Rossum'},
      {'Name' => 'Ruby', 'Type' => 'Scripting', 'Designed by' => 'Yukihiro Matsumoto'},
      {'Name' => 'Java', 'Type' => 'Compiled', 'Designed by' => 'James Gosling'},
      {'Name' => 'C++', 'Type' => 'Compiled', 'Designed by' => 'Bjarne Stroustrup'},
      {'Name' => 'C#', 'Type' => 'Compiled', 'Designed by' => 'Microsoft'}
    ]
  end

  before do
    @json_data = json_data.dup
  end

  describe '#search_method' do
    context 'when searching for a term that matches a language name' do
      it 'returns the language with the highest match precision first' do
        result = search_method('ruby')
        expect(result).to eq [json_data[1]]
      end
    end

      context 'when searching for a term that matches a language type' do
        it 'returns the language with the highest match precision first' do
          result = search_method('compiled')
          expect(result).to eq [json_data[3],json_data[4],json_data[2]]
        end
      end

      context 'when searching for a term that matches a designer name' do
        it 'returns the language with the highest match precision first' do
          result = search_method('matsumoto')
          expect(result).to eq [json_data[1]]
        end
      end

      context 'when searching for multiple terms' do
        it 'returns the languages that match all terms' do
          result = search_method('scripting ruby')
          expect(result).to eq [json_data[1]]
        end
      end

      context 'when searching for a term that is excluded' do
        it 'excludes the languages that match the excluded term' do
          result = search_method('scripting -ruby')
          expect(result).to eq [json_data[0]]
        end
      end
  end
end
