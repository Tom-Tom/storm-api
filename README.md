# Livestorm Backend test

Création d'une route d'API, permettant dans un premier temps de sauvegarder un Utilisateur en base; et, dans un second, d'envoyer ses données sur le service [Hubspot](https://www.hubspot.com/) (pour lequel il faut préalablement créer un compte), tout en lui rattachant une Note (contenu libre).

#### Attention

- L'action de contacter le service Hubspot ne doit pas bloquer l'exécution de la requête.

- Tous les differents cas d'usage doivent etre prévus et testés.

- Dans "Hubspot > Sales > Contacts", on doit pouvoir voir cet utilisateur ainsi que la note attachée.

#### Resources Suggerées

- [Hubspot](https://github.com/adimichele/hubspot-ruby)
- [Sidekiq](https://github.com/mperham/sidekiq)
- [Rspec](https://github.com/rspec/rspec-rails)

---

## Work organisation
1. Hubspot understanding
	* Get [Hubspot API KEY](https://app.hubspot.com/hapikeys)
	* Find [create method](https://developers.hubspot.com/docs/methods/contacts/create_or_update)
	
2. Storm API
	* Very small authentification
	* No authentification for `/status`
	* Create user (with sidekiq worker on Hubspot creation)
	* [List Hubspot Users](https://developers.hubspot.com/docs/methods/contacts/get_contacts)
	
3. Documentation
	* Describe every unclear part
	* Describe top class
	* Describe every method throwing errors

## How to

1. Download [Postman](https://www.getpostman.com/apps)
2. Join with email sent (`tom@livestorm.co` & `gilles@livestorm.co`)
3. Log into Postman. It should look like the following screenshot.
![postman config](https://image.ibb.co/bHnASA/Capture-d-cran-2018-11-21-12-11-26.png)

	| Name | Value |
	| ---- | ----- |
	| DEFAULT_URL | localhost:3001 |
	| HTTP\_VERY\_SMALL\_AUTH | RSIZQYMQKODIOQTZBHRI |
	| CONTENT_TYPE | application/vnd.api+json |

4. Start server with `rails s -p 3001`
5. Start Sidekiq with `bundle exec sidekiq`
5. Run requests from Postman

## Requests
There are 3 requests:

1. `GET /api/status`

	To be sure everything is ok (no authentification required)

2. `POST /api/users`

	To create a user

3. `GET /api/users/list_hubspot_users`

	To check if hubspot API has been populated correctly

## Testing
Files tested:

* `spec/services/user_creation_service_spec.rb`
* `spec/workers/hubspot_creation_worker_spec.rb`
* `spec/controllers/api/users_controller_test.rb`

Run tests with:
	`bin/rspec spec/controllers/api/* spec/services/* spec/workers/*`
	
## Comment
* The `Note` is always the same, hardcoded with `Some text`.
* `list_hubspot_users` does not return the note attached. If necessary, screenshot of the account online might be given.	