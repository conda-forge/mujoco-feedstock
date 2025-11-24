# fetchcontent_to_find_package_provider.cmake
cmake_minimum_required(VERSION 3.24)

include(FetchContent)

macro(fetchcontent_to_find_package_provider method dep_name)
  if("${method}" STREQUAL "FETCHCONTENT_MAKEAVAILABLE_SERIAL")
    message(STATUS "fetchcontent_to_find_package_provider: redirecting FetchContent_MakeAvailable(${dep_name}) to find_package(${dep_name} REQUIRED)")
    find_package(${dep_name} REQUIRED)
    FetchContent_SetPopulated(${dep_name})
  endif()
endmacro()

cmake_language(
  SET_DEPENDENCY_PROVIDER fetchcontent_to_find_package_provider
  SUPPORTED_METHODS
    FETCHCONTENT_MAKEAVAILABLE_SERIAL
)
