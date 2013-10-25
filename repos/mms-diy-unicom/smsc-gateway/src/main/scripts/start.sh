#!/bin/sh
if [ $? -eq 0 ]
then
       lib=../conf/:../lib/activemq-all-5.8.0.jar:../lib/activemq-amqp-5.8.0.jar:../lib/activemq-broker-5.8.0.jar:../lib/activemq-client-5.8.0.jar:../lib/activemq-openwire-legacy-5.8.0.jar:../lib/aopalliance-1.0.jar:../lib/bcpkix-jdk15on-1.47.jar:../lib/bcprov-jdk15on-1.47.jar:../lib/commons-beanutils-1.8.3.jar:../lib/commons-beanutils-core-1.8.0.jar:../lib/commons-codec-1.4.jar:../lib/commons-collections-3.2.jar:../lib/commons-configuration-1.6.jar:../lib/commons-digester-1.8.jar:../lib/commons-io-1.3.2.jar:../lib/commons-lang-2.4.jar:../lib/commons-logging-1.1.1.jar:../lib/commons-transaction-1.2.jar:../lib/commons-transaction-spring-0.9.jar:../lib/fastutil-5.0.9.jar:../lib/geronimo-j2ee-management_1.1_spec-1.0.1.jar:../lib/geronimo-jms_1.1_spec-1.1.1.jar:../lib/hawtbuf-1.9.jar:../lib/httpclient-4.2-beta1.jar:../lib/httpcore-4.2-beta1.jar:../lib/jcl-over-slf4j-1.6.1.jar:../lib/jta-1.1.jar:../lib/log4j-1.2.17.jar:../lib/logback-classic-0.9.27.jar:../lib/logback-core-0.9.27.jar:../lib/proton-0.3.0-fuse-2.jar:../lib/proton-api-0.3.0-fuse-2.jar:../lib/proton-jms-0.3.0-fuse-2.jar:../lib/slf4j-api-1.6.1.jar:../lib/smproxy-1.0.jar:../lib/smsc-gateway-1.0-SNAPSHOT.jar:../lib/spring-aop-3.1.1.RELEASE.jar:../lib/spring-asm-3.1.1.RELEASE.jar:../lib/spring-beans-3.1.1.RELEASE.jar:../lib/spring-context-3.1.1.RELEASE.jar:../lib/spring-core-3.1.1.RELEASE.jar:../lib/spring-expression-3.1.1.RELEASE.jar:../lib/spring-jms-3.1.1.RELEASE.jar:../lib/spring-tx-3.1.1.RELEASE.jar    
        nohup java -cp $lib -Xms256m -Xmx512m com.unicom.mms.sgip.SgipMT  &
	./status.sh
else
        echo "Task is already running."
        echo " "
fi
