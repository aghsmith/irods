# TODO  f 644 root root /usr/share/man/man1 ./man/*.gz

install(
  TARGETS
#  irodsAgent
  irodsServer
  irodsReServer
  irodsXmsgServer
  hostname_resolves_to_local_address
  RUNTIME
  DESTINATION usr/sbin
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  FILES ${CMAKE_BINARY_DIR}/VERSION.json.dist
  DESTINATION ${IRODS_HOME_DIRECTORY}
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  DIRECTORY
  DESTINATION ${IRODS_HOME_DIRECTORY}/log
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  DIRECTORY
  DESTINATION etc/irods
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/packaging/connectControl.config.template
  ${CMAKE_SOURCE_DIR}/packaging/core.dvm.template
  ${CMAKE_SOURCE_DIR}/packaging/core.fnm.template
  ${CMAKE_SOURCE_DIR}/packaging/core.re.template
  ${CMAKE_SOURCE_DIR}/packaging/database_config.json.template
  ${CMAKE_SOURCE_DIR}/packaging/host_access_control_config.json.template
  ${CMAKE_SOURCE_DIR}/packaging/hosts_config.json.template
  ${CMAKE_SOURCE_DIR}/packaging/irodsMonPerf.config.in
  ${CMAKE_SOURCE_DIR}/packaging/server_config.json.template
  ${CMAKE_SOURCE_DIR}/packaging/server_setup_instructions.txt
  DESTINATION ${IRODS_HOME_DIRECTORY}/packaging
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/packaging/find_os.sh
  ${CMAKE_SOURCE_DIR}/packaging/postinstall.sh
  ${CMAKE_SOURCE_DIR}/packaging/preremove.sh
  DESTINATION ${IRODS_HOME_DIRECTORY}/packaging
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ WORLD_READ
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/packaging/irods
  DESTINATION etc/init.d
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

set(IRODS_DOC_DIR usr/share/doc/irods)

install(
  FILES
  ${CMAKE_SOURCE_DIR}/README.md
  DESTINATION ${IRODS_DOC_DIR}
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  RENAME readme
  )

if (CPACK_GENERATOR STREQUAL DEB)
  install(
    FILES
    ${CMAKE_SOURCE_DIR}/LICENSE
    DESTINATION ${IRODS_DOC_DIR}
    COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
    RENAME copyright
    )
else()
  install(
    FILES
    ${CMAKE_SOURCE_DIR}/LICENSE
    DESTINATION ${IRODS_DOC_DIR}
    COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
    )
endif()

install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/scripts
  DESTINATION ${IRODS_HOME_DIRECTORY}
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  DIRECTORY
  DESTINATION ${IRODS_HOME_DIRECTORY}/config/lockFileDir
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  DIRECTORY
  DESTINATION ${IRODS_HOME_DIRECTORY}/config/packedRei
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/msiExecCmd_bin/irodsServerMonPerf
  ${CMAKE_SOURCE_DIR}/msiExecCmd_bin/test_execstream.py
  ${CMAKE_SOURCE_DIR}/msiExecCmd_bin/hello
  DESTINATION ${IRODS_HOME_DIRECTORY}/msiExecCmd_bin
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ WORLD_READ
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/msiExecCmd_bin/univMSSInterface.sh.template
  DESTINATION ${IRODS_HOME_DIRECTORY}/msiExecCmd_bin
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS OWNER_READ GROUP_READ WORLD_READ
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/test/test_framework_configuration.json
  DESTINATION ${IRODS_HOME_DIRECTORY}/test
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/test/filesystem
  DESTINATION ${IRODS_HOME_DIRECTORY}/test
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  TARGETS
  irodsPamAuthCheck
  RUNTIME
  DESTINATION usr/sbin
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS SETUID OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

install(
  TARGETS
  genOSAuth
  RUNTIME
  DESTINATION var/lib/irods/clients/bin
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  )

install(
  FILES
  ${CMAKE_SOURCE_DIR}/irodsctl
  DESTINATION ${IRODS_HOME_DIRECTORY}
  COMPONENT ${IRODS_PACKAGE_COMPONENT_SERVER_NAME}
  PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ WORLD_READ
  )


set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_NAME "irods-server")
set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_DEPENDS "${IRODS_PACKAGE_DEPENDENCIES_STRING}, irods-runtime (= ${CPACK_DEBIAN_PACKAGE_VERSION}), irods-icommands (= ${CPACK_DEBIAN_PACKAGE_VERSION}), libc6, sudo, libssl1.0.0, libfuse2, libxml2, python, openssl, python-psutil, python-requests, lsof")
set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_PROVIDES "irods")
set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_CONFLICTS "eirods")
set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_BREAKS "irods-icat, irods-resource")
set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_REPLACES "irods-icat, irods-resource")
set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_CONTROL_EXTRA "${CMAKE_SOURCE_DIR}/preinst;${CMAKE_SOURCE_DIR}/postinst;${CMAKE_SOURCE_DIR}/prerm;")

if (IRODS_LINUX_DISTRIBUTION_NAME STREQUAL "ubuntu" AND IRODS_LINUX_DISTRIBUTION_VERSION_MAJOR STREQUAL "12")
else()
  set(CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_DEPENDS "${CPACK_DEBIAN_${IRODS_PACKAGE_COMPONENT_SERVER_NAME_UPPERCASE}_PACKAGE_DEPENDS}, python-jsonschema")
endif()


set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PACKAGE_NAME "irods-server")
if (IRODS_LINUX_DISTRIBUTION_NAME STREQUAL "centos")
  set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PACKAGE_REQUIRES "${IRODS_PACKAGE_DEPENDENCIES_STRING}, irods-runtime = ${IRODS_VERSION}, irods-icommands = ${IRODS_VERSION}, openssl, libxml2, python, python-psutil, python-requests, python-jsonschema")
elseif (IRODS_LINUX_DISTRIBUTION_NAME STREQUAL "opensuse")
  set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PACKAGE_REQUIRES "${IRODS_PACKAGE_DEPENDENCIES_STRING}, irods-runtime = ${IRODS_VERSION}, irods-icommands = ${IRODS_VERSION}, libopenssl1_0_0, python, openssl, python-psutil, python-requests, python-jsonschema")
endif()
set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PRE_INSTALL_SCRIPT_FILE "${CMAKE_SOURCE_DIR}/preinst")
set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_POST_INSTALL_SCRIPT_FILE "${CMAKE_SOURCE_DIR}/postinst")
set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PRE_UNINSTALL_SCRIPT_FILE "${CMAKE_SOURCE_DIR}/prerm")
set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PACKAGE_PROVIDES "irods")
set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PACKAGE_CONFLICTS "eirods")
set(CPACK_RPM_${IRODS_PACKAGE_COMPONENT_SERVER_NAME}_PACKAGE_OBSOLETES "irods-icat, irods-resource")
