class CreatePartials < ActiveRecord::Migration
  def change
    create_table :partials do |t|

      t.timestamps null: false
      t.string :title, null: false
      t.text :content
      t.text :stylesheet
      t.text :javascript
    end
  end
end
