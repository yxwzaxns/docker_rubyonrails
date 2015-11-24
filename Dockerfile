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

RUN mkdir /app

WORKDIR /app

RUN rails new . -B

RUN echo "gem 'redis'" >> ./Gemfile

RUN sed -i "1c source 'https://ruby.taobao.org'" ./Gemfile

RUN bash --login -c "bundle install"

RUN ln -s /app /var/vo

EXPOSE 3000
# Default command

RUN chmod a+x /app/start.sh
CMD ["/app/start.sh"]
