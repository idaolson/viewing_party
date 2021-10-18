require 'rails_helper'

RSpec.describe ApplicationHelper do
  include ApplicationHelper

  describe '#convert_to_hr_min' do
    context 'when there is more than 1 hour' do
      it 'converts minutes to hr min format' do
        minutes = 95
        expected = '1 hr 35 min'
        actual = format_runtime(minutes)
        expect(actual).to eq(expected)
      end
    end

    context 'when there is less than 1 hour' do
      it 'converts minutes to hr min format' do
        minutes = 35
        expected = '0 hr 35 min'
        actual = format_runtime(minutes)
        expect(actual).to eq(expected)
      end
    end
  end
end
