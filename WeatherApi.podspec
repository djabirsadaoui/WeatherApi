Pod::Spec.new do |s|
  s.name             = 'WeatherApi'
  s.version          = '1.0.0'
  s.summary          = 'collects weather information from an API.'
  s.description      = 'collects weather information from an open weather api'
  s.homepage         = 'https://github.com/djabirsadaoui/WeatherApi.git'
  s.license          = { :type => 'Copyright', :text => <<-LICENSE
                                                         * Copyright 2019
                                                         * Permission is granted to PSA Peugeot Citröen
                                                         * All Rights Reserved
                                                         LICENSE
                       }
  s.author           = { 'djabir sadaoui' => 'sadaoui.djabir@yahoo.com' }
  s.source           = { :git => 'https://github.com/djabirsadaoui/WeatherApi.git', :tag => '1.0.0' }
 
  s.ios.deployment_target = '11.0'
  s.swift_version = '4.0'
  s.source_files = 'WeatherApi/*/*.{swift,h,xcdatamodeld}'
  s.resources = 'WeatherApi/**/*.xcdatamodeld'
 
end
