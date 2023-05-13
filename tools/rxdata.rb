require "zlib"
require "fileutils"

module RXDATA

  def self.extract_script(outdir, rxdata)
    raise "File not found: #{rxdata}" unless File.exist? rxdata
    FileUtils.remove_dir(outdir) if Dir.exist? outdir
    Dir.mkdir(outdir)

    input = File.open(rxdata, "rb")
    scripts = Marshal.load(input.read)
    filenames = []
    info = ""

    scripts.each do |script|
      if script[1].empty?
        filename = "Untitled_#{script[0]}"
      else
        filename = script[1]
        filename += "_#{script[0]}" if filenames.include?(filename)
      end
      filenames.push(filename)

      if script[1] == filename
        info += "#{filename}\n"
      else
        info += "\"#{script[1]}\" -> \"#{filename}\"\n"
      end

      output = File.new(File.join(outdir, "#{filename}.rb"), "wb")
      output.write(Zlib.inflate(script[2]))
      output.close
    end

    output = File.new(File.join(outdir, "info.txt"), "wb")
    output.write(info)
    output.close

    input.close
  end

  def self.compress_script(indir, rxdata)
    raise "Directory not found: #{indir}" unless Dir.exist? indir
    raise "info.txt not found: #{indir}" unless File.exist? File.join(indir, "info.txt")
    raise "File not found: #{rxdata}" unless File.exist? rxdata

    infos = []
    input = File.open(File.join(indir, "info.txt"), "r")
    input.read.each_line do |line|
      if /"(.*)" -> "(.*)"/ =~ line
        infos.push([$1, $2])
      else
        title = line.chomp
        infos.push([title, title])
      end
    end
    input.close

    scripts = []
    infos.each_with_index do |info, index|
      input = File.open(File.join(indir, "#{info[1]}.rb"), "r")
      scripts.push([
        index,
        info[0],
        Zlib.deflate(input.read.force_encoding(Encoding::UTF_8)),
      ])
      input.close
    end

    output = File.new(rxdata, "wb+")
    output.write(Marshal.dump(scripts))
    output.close
  end

end

begin

end
