require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}
  before(:each) do
    sign_in user
  end

  let(:valid_attributes) { {title: 'test blog', desc: 'this is a test blog.', user_id: user.id} }
  let(:invalid_attributes) { {title: nil, desc: 'this is an invalid blog'} }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "serves index page" do
      blog = Blog.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to render_template :index
    end
    it "assigns @blogs" do
      blog = Blog.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:blogs)).to eq([blog])
    end
  end

  describe "GET #show" do
    it "returns blog object" do
      blog = Blog.create! valid_attributes
      get :show, params: {id: blog.to_param}, session: valid_session
      expect(response).to render_template :show
      expect(assigns(:blog)).to eq(blog)
    end
  end

  describe "GET #new" do
    it "serves the new template" do
      get :new, params: {}, session: valid_session
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      blog = Blog.create! valid_attributes
      get :edit, params: {id: blog.to_param}, session: valid_session
      expect(assigns(:blog)).to eq(blog)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Blog" do
        expect {
          post :create, params: {blog: valid_attributes}, session: valid_session
        }.to change(Blog, :count).by(1)
      end

      it "redirects to the created blog" do
        post :create, params: {blog: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Blog.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {blog: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
      it "does not create new blog" do
        expect {
          post :create, params: {blog: invalid_attributes}, session: valid_session
        }.to change(Blog, :count).by(0)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {title: 'test blog', desc: 'this is a test blog with updated description', user_id: user.id} }

      it "updates the requested blog" do
        blog = Blog.create! valid_attributes
        put :update, params: {id: blog.to_param, blog: new_attributes}, session: valid_session
        blog.reload
        expect(blog.desc).to eq('this is a test blog with updated description')
      end

      it "redirects to the blog" do
        blog = Blog.create! valid_attributes
        put :update, params: {id: blog.to_param, blog: valid_attributes}, session: valid_session
        expect(response).to redirect_to(blog)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        blog = Blog.create! valid_attributes
        put :update, params: {id: blog.to_param, blog: invalid_attributes}, session: valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested blog" do
      blog = Blog.create! valid_attributes
      expect {
        delete :destroy, params: {id: blog.to_param}, session: valid_session
      }.to change(Blog, :count).by(-1)
    end

    it "redirects to the blogs list" do
      blog = Blog.create! valid_attributes
      delete :destroy, params: {id: blog.to_param}, session: valid_session
      expect(response).to redirect_to(blogs_url)
    end
  end

  describe "GET manage" do
    it "serves manage blogs page" do
      blog = Blog.create! valid_attributes
      get :manage, params: {}, session: valid_session
      expect(response).to render_template :manage
    end
    it "assigns @blogs (user specific)" do
      blog = Blog.create! valid_attributes
      get :manage, params: {}, session: valid_session
      expect(assigns(:blogs)).to eq([blog])
    end
  end

  describe "GET posts" do
    it "serves posts page for given blog" do
      blog = Blog.create! valid_attributes
      get :posts, params: {id: blog.to_param}, session: valid_session
      expect(response).to render_template :posts
    end
    it "assigns @posts (user specific)" do
      blog = Blog.create! valid_attributes
      post = Post.create! title: 'post', body: 'post-body', blog_id: blog.id, user_id: user.id, published: true
      get :posts, params: {id: blog.to_param}, session: valid_session
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET post_details" do
    it "serves posts page for given blog's selected post" do
      blog = Blog.create! valid_attributes
      post = Post.create! title: 'post', body: 'post-body', blog_id: blog.id, user_id: user.id, published: true
      get :post_details, params: {id: blog.to_param, post_id: post.to_param}, session: valid_session
      expect(response).to render_template :post_details
    end
    it "assigns @posts (user specific)" do
      blog = Blog.create! valid_attributes
      post = Post.create! title: 'post', body: 'post-body', blog_id: blog.id, user_id: user.id, published: true
      get :post_details, params: {id: blog.to_param, post_id: post.to_param}, session: valid_session
      expect(assigns(:post)).to eq(post)
    end
  end

end
