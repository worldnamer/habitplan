angular
  .module('habitplan.somedays.resource', [])
  .factory('Someday',
    ($resource) ->
      class Someday
        constructor: () ->

        all: () ->
          somedays = $resource("/somedays.json").query()

        add: () ->
          someday = $resource('/somedays').save({}, () =>
            someday.renaming = true
          )

        remove: (someday) ->
          $resource("/somedays/:id", {id: someday.id}).remove()

        update: (someday) ->
          $resource("/somedays/:id", {id: someday.id},
            update:
              method: 'PUT'
          ).update(someday)
  )