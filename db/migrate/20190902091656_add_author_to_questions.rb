class AddAuthorToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :author, index: true
    add_foreign_key :questions, :users, column: :author_id
  end
end
