require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
    describe '#new' do
        it 'responds successfully' do
            get :new
            expect(response).to be_successful
        end
    end
end