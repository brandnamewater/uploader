Rails.configuration.stripe = {
  :publishable_key => 'pk_test_3vXaqxqFsRG6LyWMYKE1f0B8',
  :secret_key      => 'sk_test_5RwdUKMOUYo1TQnbDAgPy0QG'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
