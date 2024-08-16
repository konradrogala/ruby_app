require './stats_printer'
describe StatsPrinter do
  let(:file_path) { 'spec/test.log' }
  let(:stats_type) { nil }
  let(:printer) { described_class.new(file_path, stats_type) }

  describe '#perform' do
    context 'when file does not exist' do
      let(:file_path) { 'test2.log' }

      it do
        expect { printer.perform }.to output("file does not exist\n").to_stdout
      end
    end

    context 'when file exists' do
      context 'when without type' do
        it do
          expect { printer.perform }.to output("wrong argument given, use UNIQ or MOST_VIEWD\n").to_stdout
        end
      end

      context 'when type UNIQ' do
        let(:stats_type) { 'UNIQ' }
        let(:sorted_logs) do
          "/help_page/1 - 3 uniq views\n/home - 2 uniq views\n/contact - 1 uniq views\n/about/2 - 1 uniq views\n/index - 1 uniq views\n/about - 1 uniq views\n"
        end

        it do
          expect { printer.perform }.to output(sorted_logs).to_stdout
        end
      end

      context 'when type MOST VIEWED' do
        let(:stats_type) { 'MOST_VIEWED' }
        let(:sorted_logs) do
          "/help_page/1 - 4 uniq views\n/home - 2 uniq views\n/contact - 1 uniq views\n/about/2 - 1 uniq views\n/index - 1 uniq views\n/about - 1 uniq views\n"
        end

        it do
          expect { printer.perform }.to output(sorted_logs).to_stdout
        end
      end
    end
  end
end
