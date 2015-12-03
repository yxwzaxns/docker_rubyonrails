FROM centos:6.6

RUN yum -y update

RUN curl --silent --location https://rpm.nodesource.com/setup | bash -

RUN yum -y install which tar nodejs

RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -

RUN curl -sSL https://get.rvm.io | bash -s stable

RUN bash --login -c "rvm install ruby"

RUN bash --login -c "gem source -a https://ruby.taobao.org/"

RUN bash --login -c "gem source --remove https://rubygems.org/"

RUN bash --login -c "gem install rails"

ADD . /app/

WORKDIR /app

RUN bash --login -c "rails new . -B"

RUN echo "gem 'newrelic_rpm'" >> ./Gemfile


RUN bash --login -c "bundle install"

RUN cp ./newrelic.yml  ./config/

EXPOSE 3000
# Default command

RUN chmod a+x /app/start.sh
CMD ["/app/start.sh"]
