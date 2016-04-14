class CreateArticlesAndDesignersArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :name, :limit => 255, :null => false
      t.integer :provider_id, :null => false
      t.datetime :provided_at
      t.text :description
      t.float :price
      t.timestamps
    end

    create_table :articles_designers do |t|
      t.integer :designer_id, :null => false
      t.integer :article_id, :null => false
      t.timestamps
    end

    say_with_time 'Adding foreing keys' do
      # Add foreign key reference to articles_designers table
      execute 'ALTER TABLE articles_designers ADD CONSTRAINT fk_articles_designers_designers
              FOREIGN KEY (designer_id) REFERENCES designers(id) ON DELETE CASCADE'
      execute 'ALTER TABLE articles_designers ADD CONSTRAINT fk_articles_designers_articles
              FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE'
      # Add foreign key reference to publishers table
      execute 'ALTER TABLE articles ADD CONSTRAINT fk_articles_publishers
              FOREIGN KEY (provider_id) REFERENCES providers(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :articles
    drop_table :articles_designers
  end
end
