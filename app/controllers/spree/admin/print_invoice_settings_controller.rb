module Spree
  module Admin
    class PrintInvoiceSettingsController < ResourceController
      before_action :find_or_create_setting, only: [:index, :update]

      def update
        settings = current_store.print_invoice_setting.update(print_invoice_setting_params)

        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:settings, scope: :print_invoice))
        redirect_to admin_print_invoice_settings_path
      end

      private

      def find_or_create_setting
        unless @print_invoice_setting = current_store.print_invoice_setting
          @print_invoice_setting = Spree::PrintInvoiceSetting.create!(store_id: current_store.id)
        end
      end

      def print_invoice_setting_params
        params.require(:print_invoice_setting).permit(:next_number, :logo_path, :page_size, :page_layout, :footer_left, :footer_right, :return_message, :anomaly_message, :use_footer, :use_page_numbers, :logo_scale, :font_face, :font_size, :store_pdf, :storage_path, :store_id )
      end
    end
  end
end
