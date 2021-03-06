angular
  .module('habitplan.habits', ['habitplan.habits.resource'])
  .controller('HabitsController',
    ($scope, $timeout, Habit) ->
      habit_resource = new Habit()

      $scope.dateRange = new DateRange
      $scope.rangeString = $scope.dateRange.toString()

      $scope.habits = habit_resource.between($scope.dateRange.startDate, $scope.dateRange.endDate)

      $scope.days_in_range = $scope.dateRange.days_in_range()

      $scope.prev = () ->
        $scope.dateRange.prev()
        $scope.rangeString = $scope.dateRange.toString()
        $scope.days_in_range = $scope.dateRange.days_in_range()
        $scope.habits = habit_resource.between($scope.dateRange.startDate, $scope.dateRange.endDate)

      $scope.next = () ->
        $scope.dateRange.next()
        $scope.rangeString = $scope.dateRange.toString()
        $scope.days_in_range = $scope.dateRange.days_in_range()
        $scope.habits = habit_resource.between($scope.dateRange.startDate, $scope.dateRange.endDate)

      $scope.focus_habit = (habit) ->
        $timeout(
          () ->
            $("input[name='habit#{habit.id}']").focus()
          0
        )

      $scope.add = () ->
        habit = habit_resource.add($scope.dateRange.startDate)
        habit.$promise.then(() -> $scope.focus_habit(habit))
        $scope.habits.push(habit)

      $scope.edit = (habit) ->
        habit.renaming = true
        $scope.focus_habit(habit)

      $scope.rename = (habit) ->
        description = $("input[name='habit#{habit.id}']").val()

        habit.description = description
        delete habit.renaming

        habit_resource.update(habit)

      $scope.changeDay = (habit, day) ->
        if day.v
          habit_resource.setDay(habit, day)
        else
          habit_resource.removeDay(habit, day)

      $scope.toggleDay = (habit, day) ->
        day.v = !day.v
        $scope.changeDay(habit, day)

      $scope.remove = (habit) ->
        habit_resource.remove(habit)
        $scope.habits.splice($scope.habits.indexOf(habit), 1)
  )