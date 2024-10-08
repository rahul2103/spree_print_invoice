class StoreIdToSpreeDocuments < ActiveRecord::Migration[7.2]
  def change
    add_reference :spree_bookkeeping_documents, :store, foreign_key: { to_table: :spree_stores }
    add_reference :spree_bookkeeping_documents, :setting, foreign_key: { to_table: :spree_print_invoice_settings }

    Spree::BookkeepingDocument.all.each do |bd|
      bd_store_id = bd.printable.store_id
      bd.update_columns(store_id: bd_store_id)
    end

    Spree::Store.all.each do |store|
      #create a default setting for all stores
      Spree::PrintInvoiceSetting.find_or_create_by(store_id: store.id)
    end
    
    Spree::BookkeepingDocument.all.each do |bd|
      bd_store = bd.printable.store
      bd.update_columns(setting_id: bd_store.print_invoice_setting.id)
    end
  end
end
