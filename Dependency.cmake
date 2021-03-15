# ExternalProject 관련 명령어 셋 추가                   A
include(ExternalProject)

# Dependency 관련 변수 설정                             B
set(DEP_INSTALL_DIR ${PROJECT_BINARY_DIR}/install)                  # project__DIR이라는 건 cmake_project_example 안에있는 build 폴더를 말하는거고, 그 안의 install폴더에 DEP_INS_를 다운로드하겠다는 뜻
set(DEP_INCLUDE_DIR ${DEP_INSTALL_DIR}/include)                     
set(DEP_LIB_DIR ${DEP_INSTALL_DIR}/lib)

# spdlog: fast logger library                          C
ExternalProject_Add(
    dep_spdlog                                                      # 프로그램 타겟명
    GIT_REPOSITORY "https://github.com/gabime/spdlog.git"           # 이 홈페이지에서 git_repository를 다운받겠다는 뜻
    GIT_TAG "v1.x"                                                  # 홈페이지에서 branch나 tags중 하나 골라서 쓰는건데 branch에서 default 값이 v1.x라서 그걸로 가져온거
    GIT_SHALLOW 1                                                   # on off 기능 1이면 on이라는 뜻     shallow기능은 그간 있었던 commit 중 가장 최신의 변경내역만 다운로드 받는 기능
    UPDATE_COMMAND ""                                               # 내가 쓴 코드가 구형일 경우 업데이트 하겠다는 의미         지금은 아니니깐 ""를 넣어 안하겠다는 뜻
    PATCH_COMMAND ""                                                # v1.x에서 다운로드한 코드를 수정해 쓰겠다는 의미인데, 우리는 안할꺼니깐 ""를 넣어 안하겠다는 뜻을 비춤
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}            # CMAKE_ARGS이하의 값이 어떻게 내가 준 값들을 넘길지에 관한건데, -D이후의 CMAKE_INSTALL_PREFIX는 변수(CMAKE가 변수를 INSTALL했을 때 어디에 저장할것인지 묻는 변수)이고 DEP_INSTALL_DIR은 변수에 들어가는 값
    TEST_COMMAND ""                                                 # 자동으로 테스트하게 지정했을 경우에 어떻게 테스트할건지 설정하는 줄   대충 다 잘 다운됐을거같으니깐 패스
)
# Dependency 리스트 및 라이브러리 파일 리스트 추가       D
set(DEP_LIST ${DEP_LIST} dep_spdlog)
set(DEP_LIBS ${DEP_LIBS} spdlog$<$<CONFIG:Debug>:d>)                ## config가 Debug일때는 D를 붙히고, 아니면 붙히지마란 뜻     지금 우리는 Debug모드를 쓰고있으니 spdlogd 와 같은 뜻이란 말

# glfw                                                E
ExternalProject_Add(
    dep_glfw
    GIT_REPOSITORY "https://github.com/glfw/glfw.git"
    GIT_TAG "3.3.3"
    GIT_SHALLOW 1
    UPDATE_COMMAND "" PATCH_COMMAND "" TEST_COMMAND ""              # 위와 다르게 한줄로 붙어있는데, 이렇게써도 문제는 없음
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
        -DGLFW_BUILD_EXAMPLES=OFF                                   # |GLFW를 다운로드 받으면 같이받아지는 예제, 테스트파일, 문서파일을 끄겠다는 의미
        -DGLFW_BUILD_TESTS=OFF                                      # |
        -DGLFW_BUILD_DOCS=OFF                                       # |찾아보고싶으면 glfw의 github에 가서 cmake 파일에 들어가보면 알 수 있음    option의 defualt값도 지정되있고 설명도 있음
    )
set(DEP_LIST ${DEP_LIST} dep_glfw)
set(DEP_LIBS ${DEP_LIBS} glfw3)

# glad
ExternalProject_Add(
    dep_glad
    GIT_REPOSITORY "https://github.com/Dav1dde/glad"
    GIT_TAG "v0.1.34"
    GIT_SHALLOW 1
    UPDATE_COMMAND ""
    PATCH_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
        -DGLAD_INSTALL=ON
    TEST_COMMAND ""
    )
set(DEP_LIST ${DEP_LIST} dep_glad)
set(DEP_LIBS ${DEP_LIBS} glad)

