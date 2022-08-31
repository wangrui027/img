if [ -z ${REFRESH_TOKEN} ];then
    echo "缺少 [REFRESH_TOKEN] 配置，请通过 https://alist-doc.nn.ci/docs/driver/aliyundrive/ 扫码登陆获取"
    exit 1
fi

if [ -z ${WEBDAV_VERSION} ];then
    echo "没有传递 [WEBDAV_VERSION] 配置，将使用最新版 aliyundrive-webdav"
    export WEBDAV_VERSION="v1.10.1"
fi

if [ ! -f "aliyundrive-webdav" ];then
  curl -L https://github.com/messense/aliyundrive-webdav/releases/download/${WEBDAV_VERSION}/aliyundrive-webdav-${WEBDAV_VERSION}.x86_64-unknown-linux-musl.tar.gz -o aliyundrive-webdav.tar.gz
  tar -zxvf aliyundrive-webdav.tar.gz
  rm -f aliyundrive-webdav.tar.gz
fi

echo -n "./aliyundrive-webdav -r ${REFRESH_TOKEN}" > startup.sh

if [ ${ROOT_DIR} ];then
    echo -n " --root ${ROOT_DIR}" >> startup.sh
fi

if [ ${READ_ONLY} ];then
    echo -n " --read-only" >> startup.sh
fi

if [ ${AUTH_USER} ];then
    echo -n " --auth-user ${AUTH_USER}" >> startup.sh
fi

if [ ${AUTH_PASSWORD} ];then
    echo -n " --auth-password ${AUTH_PASSWORD}" >> startup.sh
fi

if [ -z ${AUTO_INDEX} ];then
    echo -n " --auto-index" >> startup.sh
fi

if [ "${AUTO_INDEX}" -ne "0" ];then
    echo -n " --auto-index" >> startup.sh
fi

echo >> startup.sh

sh startup.sh
