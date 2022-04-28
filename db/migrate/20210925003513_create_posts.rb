class CreatePosts < ActiveRecord::Migration[6.1]
  def change
   
    create_table :posts do |t|
      t.text :content

      t.timestamps
    end
     def change
    drop_table :rocords
  end
  end
  
end
