module Spree
  class PrintInvoiceSetting < Spree::Base
    belongs_to :store
    has_many :bookkeeping_documents

    has_one_attached :logo

    def page_sizes
      ::PDF::Core::PageGeometry::SIZES.keys
    end

    def page_layouts
      %w[landscape portrait]
    end

    def use_sequential_number?
      next_number.present? && next_number > 0
    end

    def increase_invoice_number!
      next_number + 1
    end

    def font_faces
      ::Prawn::Font::AFM::BUILT_INS.reject do |font|
        font =~ /zapf|symbol|bold|italic|oblique/i
      end + self.class.additional_fonts.keys
    end

    def font_sizes
      (7..14).to_a
    end

    def logo_scaling
      logo_scale.to_f / 100
    end

    def self.additional_fonts
      @additional_font_faces ||= {
        'DejaVuSans' => {
          bold: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'DejaVuSans-Bold.ttf'),
          italic: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'DejaVuSans-Oblique.ttf'),
          bold_italic: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'DejaVuSans-BoldOblique.ttf'),
          normal: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'DejaVuSans.ttf')
        },
        'msjh' => {
          bold: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msjh.ttf'),
          italic: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msjh.ttf'),
          bold_italic: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msjh.ttf'),
          normal: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msjh.ttf')
        },
        'msyh' => {
          bold: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msyh.ttf'),
          italic: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msyh.ttf'),
          bold_italic: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msyh.ttf'),
          normal: SpreePrintInvoice::Engine.root.join('data', 'fonts', 'msyh.ttf')
        }
      }
    end
  end
end
