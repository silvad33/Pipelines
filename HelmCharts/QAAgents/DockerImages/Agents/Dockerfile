FROM maven:3.8.5-jdk-11

USER root
RUN useradd -m nonroot -u 10001 --create-home --user-group \
 && echo "nonroot:nonroot" | chpasswd \
 && echo 'root:toor' | chpasswd \
 && apt-get update \
 && apt-get install -y iputils-ping \
 && apt-get install -y jq \
 && apt-get install -y npm \
 && npm install -g newman \
 && npm install -g newman-reporter-htmlextra

COPY prestop.sh /prestop.sh
COPY poststart.sh /poststart.sh

# PowerShell
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && apt-get update \
  && apt-get install -y powershell

# ADO Agent
RUN mkdir /myagent \
 && wget -P /myagent https://vstsagentpackage.azureedge.net/agent/3.225.0/vsts-agent-linux-x64-3.225.0.tar.gz \
 && tar zxvf /myagent/vsts-agent-linux-x64-3.225.0.tar.gz -C /myagent \
 && chown -R nonroot /myagent \
 && chmod o+w /myagent \
 && chmod +x poststart.sh \
 && chmod +x prestop.sh

# Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update -qqy \
 && apt-get -qqy install google-chrome-stable \
 && rm /etc/apt/sources.list.d/google-chrome.list \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
 && sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

## ChromeDriver
RUN CHROME_DRIVER_VERSION=$(google-chrome --product-version) \
  && echo $CHROME_DRIVER_VERSION \
  && curl -s -o /tmp/chromedriver_linux64.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_DRIVER_VERSION/linux64/chromedriver-linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver-linux64/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION  \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -s /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

ENTRYPOINT ["/bin/bash", "poststart.sh"]