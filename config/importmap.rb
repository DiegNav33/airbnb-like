# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap" # @5.3.3
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.8/dist/umd/popper.min.js"
# pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "flatpickr" # @4.6.13
pin "sweetalert2" # @11.12.4
