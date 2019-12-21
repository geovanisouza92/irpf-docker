FROM openjdk:9

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://downloadirpf.receita.fazenda.gov.br/irpf/2019/leao/LEAO2019v1.0.zip -O LEAO2019v1.0.zip --no-check-certificate \
    && unzip LEAO2019v1.0.zip -d /opt/ \
    && mv /opt/LEAO*/ /opt/leao2019

RUN groupadd --gid 1000 leao && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash leao

USER leao

ENV TZ=America/Sao_Paulo

CMD ["java", "-Xms128M", "-Xmx512M", "-jar", "/opt/leao2019/PgdCarneLeao.jar"]
