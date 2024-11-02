class CreateSpreePrintInvoiceSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :spree_print_invoice_settings do |t|
      t.integer :next_number, default: nil
      t.string :logo_path, default: 'store/star.png'
      t.string :page_size, default: 'LETTER'
      t.string :page_layout, default: 'landscape'
      t.string :footer_left, default: ''
      t.string :footer_right, default: ''
      t.text :return_message, default: ''
      t.text :anomaly_message, default: ''
      t.boolean :use_footer, default: false
      t.boolean :use_page_numbers, default: false
      t.integer :logo_scale, default: 50
      t.string :font_face, default: 'Helvetica'
      t.integer :font_size, default: 9
      t.boolean :store_pdf, default: false
      t.string :storage_path, default: 'tmp/invoice_prints'
      t.belongs_to :store

      t.timestamps
    end
  end
end
