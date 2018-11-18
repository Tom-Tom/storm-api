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
