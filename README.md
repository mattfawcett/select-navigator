SelectNavigator
===============

A Jquery plugin that turns select lists into navigation elements

Usage
-----
$('#myselect').selectNavigator();

Examples
--------
    <select id="myselect">
      <option value="/users">Users</option>
      <option value="/addresses">Addresses</option>
    </select>

    <select id="user-deletion-tool" data-method="delete">
      <option value="/users/john">Delete John</option>
      <option value="/users/matt">Delete Matt</option>
      <option value="/users" data-method="get">More Users</option>
    </select>

Notes
-----
* By default actions will be made as GET requests
* You can set a attribute called `data-method` at either the select level (default for all the options) or individual option level
* A hidden form is generated and submitted for anything other than GET (the default)
* If the method is neither GET or POST, the form will include a hidden field called _method. Frameworks like rails use this because of the limited support for requests other than GET and POST
* If there is a meta tag for csrf-param and csrf-token, these will be included in anything other than GET requests in order to pass CSRF checks
