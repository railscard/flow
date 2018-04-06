class Stream < ApplicationRecord
  belongs_to :user

  has_many :outputs, dependent: :destroy

  validates :name, presence: true

  def process(input)
    cxt = V8::Context.new
    cxt.eval(code)
    process = cxt[:process]

    input = parse(input)

    input.each_with_index do |el, i|
      Input.create(line: i, content: el.to_json, download_id: 1)

      cxt['input']  = el
      cxt['output'] = process.call(cxt['input'])
      result = cxt.eval('JSON.stringify(output)')

      Output.create(line: i, content: result, responce: 'success', download_id: 1, stream_id: self.id)
    end
  end

  private

  def parse(file)
    SmarterCSV.process(
      File.open(
        Rails.root.join('public', 'uploads', file.original_filename)
      )
    )
  end
end
