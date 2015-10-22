class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.integer :tag_id, null:false
      t.integer :question_id, null:false
      t.timestamps
    end
  end
end
