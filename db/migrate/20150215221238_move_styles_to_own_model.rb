class MoveStylesToOwnModel < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :style
      t.text :description

      t.timestamps null: false
    end

    add_column :beers, :style_id, :integer

    rename_column :beers, :style, :old_style

    tyylit = Beer.uniq.pluck(:old_style)
    tyylit.each { |t| Style.create style:t }
    Beer.all.each do |b|
      b.style = Style.find_by style:b.old_style
      b.save
    end

    remove_column :beers, :old_style, :string
  end
end