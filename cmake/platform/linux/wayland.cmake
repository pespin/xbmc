set(PLATFORM_REQUIRED_DEPS WaylandProtocols>=1.7 Waylandpp>=0.2.2 LibDRM Xkbcommon>=0.4.1)
set(PLATFORM_OPTIONAL_DEPS VAAPI)

set(WAYLAND_RENDER_SYSTEM "" CACHE STRING "Render system to use with Wayland: \"gl\" or \"gles\"")

if(WAYLAND_RENDER_SYSTEM STREQUAL "gl")
  list(APPEND PLATFORM_REQUIRED_DEPS OpenGl EGL)
  set(APP_RENDER_SYSTEM gl)
elseif(WAYLAND_RENDER_SYSTEM STREQUAL "gles")
  list(APPEND PLATFORM_REQUIRED_DEPS OpenGLES EGL)
  set(APP_RENDER_SYSTEM gles)
else()
  message(SEND_ERROR "You need to decide whether you want to use GL- or GLES-based rendering in combination with the Wayland windowing system. Please set WAYLAND_RENDER_SYSTEM to either \"gl\" or \"gles\". For normal desktop systems, you will usually want to use \"gl\".")
endif()

set(PLATFORM_GLOBAL_TARGET_DEPS generate-wayland-extra-protocols)
set(WAYLAND_EXTRA_PROTOCOL_GENERATED_DIR "${CMAKE_CURRENT_BINARY_DIR}")
list(APPEND PLATFORM_DEFINES -DPLATFORM_SETTINGS_FILE=wayland.xml)
# for wayland-extra-protocols.hpp
include_directories("${WAYLAND_EXTRA_PROTOCOL_GENERATED_DIR}")
