FROM skurtzemann/base-image
MAINTAINER Sébastien Kurtzemann <seb@kurtzemann.fr>

# Add init script 
ADD conf/init.sh /init.sh
RUN chmod +x /init.sh

# Start command
CMD /init.sh
