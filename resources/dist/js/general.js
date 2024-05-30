import { logoutSession } from "./helpers/ajax.js";

$ (document).ready (function () {
    $ ('#logout').click (function () {
      logoutSession();
    });
  });
  
  $.fn.formJson = function (){
      var formJson = {};
      var formSerial = this.serializeArray();
      $.each(formSerial, function(){
          if(formJson[this.name]){
              if(!formJson[this.name].push){
                  formJson[this.name] = [formJson[this.name]];
              }
              formJson[this.name].push(this.value || '');
          }else{
              formJson[this.name] = this.value || '';
          }
      });
  
      var formCheckbox = $('input[type=checkbox]', this);
      $.each(formCheckbox, function(){
          if(!formJson.hasOwnProperty(this.name)){
              formJson[this.name]=0;
          }
      });
  
      return formJson;
  }