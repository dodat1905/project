class Supports::User
  attr_reader :user, :page, :current_user, :followed_id

  def initialize args = {}
    @current_user = args[:current_user]
    @followed_id = args[:followed_id]
  end

  def create_relationship
    @create_relationship = current_user.active_relationships.build
  end

  def destroy_relationship
    @destroy_relationship = current_user.active_relationships.find_by followed_id: followed_id
  end
end
