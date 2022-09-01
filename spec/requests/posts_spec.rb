require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    subject { get :posts }

    it 'renders the index template' do
      expect(subject).to render_template(:posts)
      expect(subject).to render_template('posts')
      expect(subject).to render_template('posts/index')
    end

    it 'does not render a different template' do
      expect(subject).to_not render_template('posts/show')
    end
  end
end
