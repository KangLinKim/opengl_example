cmake_minimum_required(VERSION 3.13)

set(PROJECT_NAME first_opengl_example)                             #cmake_project_example이라는 프로젝트명을 PROJECT_NAME이라는 타겟명으로 대체시킴
set(CMAKE_CXX_STANDARD 17)
	
set(WINDOW_NAME "First OpenGL Example")
set(WINDOW_WIDTH 960)
set(WINDOW_HEIGHT 540)

project(${PROJECT_NAME})
add_executable(${PROJECT_NAME} src/main.cpp)                        #scr/main.cpp가 PROJECT_NAME이란 타겟이 지정됐을때 실행되는 파일이됨

include(Dependency.cmake)

# 우리 프로젝트에 include / lib 관련 옵션 추가           A
target_include_directories(${PROJECT_NAME} PUBLIC ${DEP_INCLUDE_DIR})#타겟을 컴파일할때 DEP_INCLUDE_DIR이 필요하다는 뜻인데, 이 파일은 B탭 2번째줄에 지정되있음
target_link_directories(${PROJECT_NAME} PUBLIC ${DEP_LIB_DIR})      
target_link_libraries(${PROJECT_NAME} PUBLIC ${DEP_LIBS})           

target_compile_definitions(${PROJECT_NAME} PUBLIC      #B
  WINDOW_NAME="${WINDOW_NAME}"
  WINDOW_WIDTH=${WINDOW_WIDTH}
  WINDOW_HEIGHT=${WINDOW_HEIGHT}
  )

# Dependency들이 먼저 build 될 수 있게 관계 설정         C
add_dependencies(${PROJECT_NAME} ${DEP_LIST})                       #우리 프로젝트를 컴파일하기전에 DEP_LIST안에있는 프로젝트를 먼저 컴파일해라
