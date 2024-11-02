module SpreePrintInvoice
  module StoreDecorator
    def self.prepended(base)
      base.has_many :bookkeeping_documents
      base.has_one :print_invoice_setting, class_name: 'Spree::PrintInvoiceSetting', dependent: :destroy
    end
  end
end

Spree::Store.prepend SpreePrintInvoice::StoreDecorator
