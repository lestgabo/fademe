
Analytics = Segment::Analytics.new({
    write_key: 'VoiHyrqAmYWp1etD1K5ChITpTgaSWR7S',
    on_error: Proc.new { |status, msg| print msg }
})
