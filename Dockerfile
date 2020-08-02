FROM tiangolo/uwsgi-nginx-flask:python3.8-alpine

# copy over our requirements.txt file
COPY ./requirements.txt /tmp/

# upgrade pip and install required python packages
RUN pip install -U pip
RUN pip install -r /tmp/requirements.txt

# copy over our app code
#the requirements.txt file is copied twice
COPY ./app.py ./uwsgi.ini /app/
