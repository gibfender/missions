import json

import requests
from flask import current_app
from flask_babel import _


def translate(text, source_language, dest_language):
    if 'TRANSLATOR_KEY' not in current_app.config or not current_app.config['TRANSLATOR_KEY']:
        return _('Error: the translation service is not configured.')
    key = current_app.config['TRANSLATOR_KEY']
    r = 'https://translate.yandex.net/api/v1.5/tr.json/translate?key={}&text={}&lang={}-{}'.format(key, text, source_language, dest_language)
    response = requests.post(r)
    if response.status_code != 200:
        return _('Error: the translation service failed.')
    return json.loads(response.content.decode('utf-8-sig'))
