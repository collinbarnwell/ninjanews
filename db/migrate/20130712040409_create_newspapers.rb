class CreateNewspapers < ActiveRecord::Migration
  def change
    create_table :newspapers do |t|
      t.string :title
      t.belongs_to :user

      t.timestamps
    end

    create_table :articles_newspapers, id: false do |t|
      t.belongs_to :newspaper
      t.belongs_to :article
    end
  end
end
