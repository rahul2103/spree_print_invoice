font_style = {
  face: doc.print_invoice_setting.font_face,
  size: doc.print_invoice_setting.font_size
}

prawn_document(force_download: true) do |pdf|
  pdf.font_families.update(Spree::PrintInvoiceSetting.additional_fonts)
  pdf.define_grid(columns: 5, rows: 8, gutter: 10)
  pdf.font font_style[:face], size: font_style[:size]

  pdf.repeat(:all) do
    render 'spree/printables/shared/header', pdf: pdf, printable: doc
  end

  # CONTENT
  pdf.grid([1,0], [6,4]).bounding_box do

    # address block on first page only
    if pdf.page_number == 1
      render 'spree/printables/shared/address_block', pdf: pdf, printable: doc
    end

    pdf.move_down 10

    render 'spree/printables/shared/invoice/items', pdf: pdf, invoice: doc

    pdf.move_down 10

    render 'spree/printables/shared/totals', pdf: pdf, invoice: doc

    pdf.move_down 30

    pdf.text doc.print_invoice_setting.return_message, align: :right, size: font_style[:size]
  end

  # Footer
  if doc.print_invoice_setting.use_footer
    render 'spree/printables/shared/footer', pdf: pdf
  end

  # Page Number
  if doc.print_invoice_setting.use_page_numbers
    render 'spree/printables/shared/page_number', pdf: pdf
  end
end
