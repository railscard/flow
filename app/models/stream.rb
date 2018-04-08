class Stream < ApplicationRecord
  belongs_to :user

  has_many :downloads, dependent: :destroy

  validates :name, presence: true

  def process(input, download_id)
    parse(input).each_with_index do |el, i|
      Input.create(line: i, content: el.to_json, download_id: download_id)

      begin
        cxt = V8::Context.new
        cxt.eval(code)
        process = cxt[:process]
        cxt['input'] = el
        cxt['output'] = process.call(cxt['input'])
      rescue Exception => error
        output_error(download_id, error, i)
      else
        output_success(cxt, download_id, i)
      end
    end
  end

  private

  def output_success(cxt, download_id, i)
    result = cxt.eval('JSON.stringify(output)')
    Output.create(line: i, content: result, download_id: download_id)
  end

  def output_error(download_id, error, i)
    OutputError.create(download_id: download_id, message: error.message)
    Output.create(line: i, content: 'null', download_id: download_id)
  end

  def parse(file)
    uploader = CsvUploader.new
    uploader.store!(file)

    uploader.retrieve_from_store!("#{file.original_filename}")

    file = File.open(uploader.path)

    delimiter = CsvSniffer.detect_delimiter(file)

    SmarterCSV.process(file, col_sep: delimiter)
  end
end
