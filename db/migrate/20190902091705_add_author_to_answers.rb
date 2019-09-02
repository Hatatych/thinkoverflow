class AddAuthorToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :author, index: true
    add_foreign_key :answers, :users, column: :author_id
  end
end
