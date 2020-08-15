Pod::Spec.new do |spec|
  spec.name             = 'WeatherApi'
  spec.version          = '1.0.0'
  spec.summary          = 'collects weather information from an API.'
  spec.description      = 'collects weather information from an open weather api'
  spec.homepage         = 'https://github.com/djabirsadaoui/WeatherApi.git'
  spec.license          = { :type => 'Copyright', :text => <<-LICENSE
                                                         * Copyright 2019
                                                         * Permission is granted to PSA Peugeot Citröen
                                                         * All Rights Reserved
                                                         LICENSE
                       }
  spec.author           = { 'djabir sadaoui' => 'sadaoui.djabir@yahoo.com' }
  spec.source           = { :git => 'https://github.com/djabirsadaoui/WeatherApi.git', :tag => '1.0.0' }
 
  spec.ios.deployment_target = '11.0'
  spec.swift_version = '4.0'
  spec.source_files = 'WeatherApi/**/*.{swift,h,xcdatamodeld}'
  spec.resources = 'WeatherApi/**/*.xcdatamodeld'
 
end
