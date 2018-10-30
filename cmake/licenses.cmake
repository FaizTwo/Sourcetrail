# Generates the lincens.h file
# For adding a new 3rd Party License add the License File to the 3rd Party License Folder
# and a new AddLicense Line in below

set(LICENSES "")
set(LICENSE_ARRAY "")
set(LICENSEFOLDER "${CMAKE_SOURCE_DIR}/bin/app/data/3rd_party_licenses")

function(ReadLicense licenseFile licenseVariable)
    file(READ ${licenseFile} tempVariable)
    STRING(REGEX REPLACE "\"" "\\\\\"" tempVariable "${tempVariable}")
    STRING(REGEX REPLACE "\n" "\\\\n\"\n\t\"" tempVariable "${tempVariable}")
    set(var "\n\nstatic const char *${licenseVariable}=\n\t\"")
    set(LICENSES "${LICENSES}${var}${tempVariable}\"\;" PARENT_SCOPE)
endfunction(ReadLicense)

function(AddLicense softwareName softwareVersion softwareURL licenseFile)
        ReadLicense(${licenseFile} ${softwareName}_license)
        set(LICENSES ${LICENSES} PARENT_SCOPE)
        set(LICENSE_ARRAY "${LICENSE_ARRAY}\n\tThirdPartyLicense(\"${softwareName}\", \"${softwareVersion}\", \"${softwareURL}\", ${softwareName}_license)," PARENT_SCOPE)
endfunction(AddLicense)


AddLicense("Boost" "1.64" "http://www.boost.org" "${LICENSEFOLDER}/license_boost.txt")
AddLicense("Botan" "2.1.0" "http://botan.randombit.net/" "${LICENSEFOLDER}/license_botan.txt")
AddLicense("Clang" "7.0.0" "http://clang.llvm.org/" "${LICENSEFOLDER}/license_clang.txt")
AddLicense("CppSQLite" "3.2" "http://www.codeproject.com/Articles/6343/CppSQLite-C-Wrapper-for-SQLite" "${LICENSEFOLDER}/license_cpp_sqlite.txt")
AddLicense("Eclipse" "" "https://github.com/eclipse/eclipse.jdt.core" "${LICENSEFOLDER}/license_eclipse.txt")
AddLicense("Gradle" "4.2" "https://github.com/gradle/gradle" "${LICENSEFOLDER}/license_gradle.txt")
AddLicense("OpenSSL" "" "https://www.openssl.org/" "${LICENSEFOLDER}/license_openssl.txt")
AddLicense("Qt" "5.10.1" "http://qt.io" "${LICENSEFOLDER}/license_qt.txt")
AddLicense("TinyXML" "2.0" "https://sourceforge.net/projects/tinyxml/" "${LICENSEFOLDER}/license_tinyxml.txt")

set(LICENSE_ARRAY "${LICENSE_ARRAY}\n")

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/licenses.h.in
    ${CMAKE_BINARY_DIR}/src/lib_gui/licenses.h
)
