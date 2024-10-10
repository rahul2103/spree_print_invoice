module Spree
  module Admin
    class PrintInvoiceSettingsController < ResourceController
      before_action :find_or_create_setting, only: [:index, :update]

      def update
        @print_invoice_setting.update(print_invoice_setting_params)

        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:settings, scope: :print_invoice))
        redirect_to admin_print_invoice_settings_path
      end

      private

      def find_or_create_setting
        @print_invoice_setting = if current_spree_vendor.present? && current_spree_vendor.print_invoice_setting.present?
                                    current_spree_vendor.print_invoice_setting
        else
                                    Spree::PrintInvoiceSetting.create!(store_id: current_store.id,
                                                                       vendor_id: current_spree_vendor.try(:id))
        end
      end

      def print_invoice_setting_params
        params.require(:print_invoice_setting).permit(:next_number, :logo_path, :page_size, :page_layout, :footer_left, :footer_right,
                                                      :return_message, :anomaly_message, :use_footer, :use_page_numbers, :logo_scale, :font_face,
                                                      :font_size, :store_pdf, :storage_path, :store_id, :logo)
      end
    end
  end
end
