class ApplicationController < ActionController::Base
  helper :application
  include Pagy::Backend
  before_action :authenticate_user!, :set_paper_trail_whodunnit
  before_action :build_node

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_index_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  # build side nav nodes according to user privileges
  def build_node
    return if request.xhr? || !current_user.present?
    @nodes = Node.includes(:nodes).where('parent_id is NULL').order("position ASC")
    @nodes.each {|node| build_sub_node(node) }
  end

  def build_sub_node(node)
    if node.nodes.size == 0
        node.count = 1
    else
      count = 0
      node.nodes.each {|child|
        count = count + build_sub_node(child)
      }
      node.count = count
    end
  end

  # set paper trail (Trails logs)
  def user_for_paper_trail
    current_user.id if current_user.present?
  end

  # common method to run broadcast messages
  def broadcast_flash_message(type, message)
    decrypted_id = current_user.encrypted_id
    Turbo::StreamsChannel.broadcast_append_to("flash-#{decrypted_id}-flash-message",
                                              target: "flash-#{decrypted_id}-flash-message",
                                              partial: "layouts/shared/flash_message",
                                              locals: {message: message, type: type})
  end
end
