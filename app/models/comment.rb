class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  after_create_commit :broadcast_comment

  private


  def broadcast_comment
    if self.commentable_type == "StatusReport"
      broadcast_replace_to commentable,
                          target: "dsr-new-comments-#{commentable.encrypted_id}-#{commentable.user_id}",
                          partial: "dsr/comment",
                          locals: {dsr: self.commentable, current_user: self.user, comment: self}
    end
  end

end
