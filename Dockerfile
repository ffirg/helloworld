FROM fedora
MAINTAINER Phil Griffiths phil@redhat.com
LABEL Description="Test install of runtime.js under QEMU within OSE!"
RUN dnf -y install nodejs npm qemu git
RUN git clone https://github.com/ffirg/helloworld
WORKDIR /helloworld 
RUN npm install
RUN npm start
RUN npm install runtimeify -g
RUN npm install runtime-tools -g
RUN npm init
RUN npm install runtimejs --save
RUN npm install runtimeify --save-dev
RUN npm install runtime-tools --save-dev
COPY index.js /
RUN runtimeify index.js -o initrd
RUN runtime-qemu ./initrd
#EXPOSE 9000
#ENTRYPOINT ["/opt/mono/bin/xsp4", "--port 9000", "--nonstop"]
