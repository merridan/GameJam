extends entity

var tilemap
onready var rootNode = get_tree().get_root().get_node("Root")
func _ready():
	#body = get_node("physicsbody")
	entityType = "Player"
	anim = get_node("AnimatedSprite")
	hitbox = get_node("CollisionShape2D")
	tilemap = get_node("../Background")
	add_camera()

func add_camera():
	var cameraNode = camera.instance()
	self.add_child(cameraNode)
	
func shift_colour(colour):
	if tilemap.change != true:
		tilemap.trigger(colour)

func input():
	if(Input.is_action_pressed("colour_shift_red")):
		shift_colour(1)
		rootNode.set_colour(1.0)
	if(Input.is_action_pressed("colour_shift_green")):
		shift_colour(2)
		rootNode.set_colour(2.0)
	if(Input.is_action_pressed("colour_shift_blue")):
		shift_colour(3)
		rootNode.set_colour(3.0)
	if(Input.is_action_pressed("left")):
		self.change_input("x","left")
	elif(Input.is_action_pressed("right")):
		self.change_input("x","right")
	elif(Input.is_action_just_released("right")):
		self.change_input("x","idle")
	elif(Input.is_action_just_released("left")):
		self.change_input("x","idle")
	else:
		self.change_input("x","idle")
		
	if(Input.is_action_just_pressed("up")):
		self.change_input("y","up")
	elif(Input.is_action_just_pressed("down")):
		self.change_input("y","down")
	elif(Input.is_action_just_released("up")):
		self.change_input("y","idle")
	elif(Input.is_action_just_released("down")):
		self.change_input("y","idle")

	if(Input.is_mouse_button_pressed(1)):
		self.change_input("attack", "basic")
	else:
		self.change_input("attack", "idle")
	
func die():
	print("PLAYER WAS KILLED BY", self.attacked_by)
	self.anim.disconnect("animation_finished", self, "die")

	
func _process(delta):
	input()