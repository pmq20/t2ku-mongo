class T2Ku.Views.Console extends Backbone.View
  constructor:(options)->
    super(options)
    this.tasks = new T2Ku.Collections.Tasks
    this.consoleCtrlInterval = window.setInterval(->
      if $('#console_ctrl_pre').css('visibility') is 'hidden'
        $('#console_ctrl_pre').css('visibility','visible')
      else
        $('#console_ctrl_pre').css('visibility','hidden')
    ,650)
    $(document).keypress((e)->
      console.log(e.charCode)
    )

  setLoading:->
    this.setValue('Loading ...')
    this.LoadingDots = 0
    this.LoadingInterval = window.setInterval(->
      T2KuConsole.LoadingDots += 1
      T2KuConsole.LoadingDots %= 4
      svalue = 'Loading '
      if T2KuConsole.LoadingDots > 0
        svalue += '.' for i in [1..T2KuConsole.LoadingDots]
      this.setValue(svalue)
    ,500)

  setNotLoading:->
    window.clearInterval(this.LoadingInterval)

  setPage:->
    val = ''
    task = this.tasks.first()
    widths = new Array()
    widths[0] = task.id.toString().length + 1
    # widths[2] = task.
    this.tasks.each((task)->
      val += task.id
    )
    val="
+------+------------------------------+---------+---------+<br>
| id   | description                  | user    | status  |<br>
+------+------------------------------+---------+---------+<br>
| 1    | pmq2001@gmail.com            | P.S.V.R | NULL    |<br>
| 2    | pmq2001@126.com              | pmq20   | NULL    |<br>
+------+------------------------------+---------+---------+<br>
        "
    this.setValue(val)

  setValue:(arg)->
		 $(this.el).html(arg.split(' ').join('&nbsp;'))