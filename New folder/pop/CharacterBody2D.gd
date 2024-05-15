extends CharacterBody2D

var speed_direction = Vector2()
const MAX_SPEED = 2500
const SLOWDOWN = 10.0


##Add: Gravity value, on earth, the normal value near surface is 9.81 m/s^2
const GRAVITY = 1100
const JUMP = 1775
var flag=0
## Add the variable points that stores the points belonging to the player
var points = 0
func _physics_process(delta):
	## Add the gravity to the game cycle
	velocity.y += GRAVITY * delta
	
	if  is_on_floor():
		flag=0
	if Input.is_action_pressed("ui_left"):
		speed_direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		speed_direction.x = 1
	else:
		speed_direction.x = 0
		## Add the handling of ui_up button to jump
	if Input.is_action_just_pressed("ui_up") and flag<2:
		velocity.y -= JUMP	
		flag=flag+1
	if Input.is_action_just_pressed("ui_down"):
		velocity.y += JUMP*2	
		
	if speed_direction:
		velocity.x = speed_direction.x * MAX_SPEED
	else:
		##Optional: decrease the speed with some slowdown or just set to 0
		velocity.x = move_toward(velocity.x, 0, SLOWDOWN)
#		velocity.x = 0
	get_node("LayerPoints/Label").set_text("Score: {my_points}".format({'my_points': points}))
	move_and_slide()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
	if body.is_in_group("GameOver"):
		get_tree().reload_current_scene()
	if body.is_in_group("Collectable"):
		body.queue_free()
		points += 1
		
		#$"Layerpoints"/Labelpoints".set_text("Points: {my_points}".format({'my_points': points}))
	move_and_slide()
