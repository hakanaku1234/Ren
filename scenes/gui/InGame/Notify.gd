extends Panel

func _ready():
	Ren.connect("exec_statement", self, "_on_statement")
	# $Timer.connect("timeout", self, "hide")
	Ren.notify_timer.connect("timeout", self, "hide")

func _on_statement(type, kwargs):
	if type == Ren.StatementType.NOTIFY:
		$Dialog.bbcode_text = kwargs.info
		# if kwargs.has("length"):
		# 	$Timer.wait_time = kwargs.length
		# $Timer.start()
		show()
		Ren.notified()


