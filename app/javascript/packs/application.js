// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import MarkdownIt from 'markdown-it'
import "channels"

// var MarkdownIt = require('markdown-it'), md = new MarkdownIt();

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("stylesheets/application.scss")

document.addEventListener("turbolinks:load", function() {  
  const md = new MarkdownIt();
  const elementWithMarkdown = document.getElementById('md');

  if (elementWithMarkdown != null) {
    const content = elementWithMarkdown.dataset.description;
    elementWithMarkdown.innerHTML = md.render(content);
  }
});
