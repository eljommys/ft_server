# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/25 11:11:13 by jserrano          #+#    #+#              #
#    Updated: 2020/08/29 19:55:01 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get install -y procps && apt-get install nano && apt-get install -y wget
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server

COPY ./srcs/setup.sh ./
COPY ./srcs/default.conf ./
COPY ./srcs/info.php ./
COPY ./srcs/config.inc.php ./
COPY ./srcs/wp-config.php ./
COPY ./srcs/wordpress.conf ./
COPY ./srcs/wordpress.tar.gz ./

CMD bash setup.sh
