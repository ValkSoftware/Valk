project('valk', 'cpp',
  version : '0.0.1',
  default_options : ['warning_level=3', 'cpp_std=c++14'])

spdlog_dep = dependency('spdlog')
thread_dep = dependency('threads')
evpp_dep = meson.get_compiler('cpp').find_library('evpp', required : true)

src = ['main.cpp', 'arguments.cpp', 'server/server.cpp']

executable('valk',
           sources : src,
           install : false,
           dependencies : [spdlog_dep, thread_dep, evpp_dep])
