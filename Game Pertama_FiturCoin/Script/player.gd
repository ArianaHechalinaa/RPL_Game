extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var player_u1: AnimatedSprite2D = $AnimatedSprite2D

# aturan main (panah kanan dan kiri untuk arah kanan dan kiri)
# untuk lompat adalah tombol spasi

func _physics_process(delta: float) -> void:
	# player_u1.animation = "Run"
	if velocity.x > 0 or velocity.x < 0:
		#print("ke kanan")
		player_u1.animation = "Run"
	else:
		player_u1.animation = "Idle"
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_u1.animation = "Jump"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		#digunakan untuk membalik balikkan badan palyer sesuai dengan arah
		#jangan lupa nyalakan flip H di offset animated sprite2D
	if direction < 0:
		print("flip badan player")
		player_u1.flip_h = true
	else:
		player_u1.flip_h = false

	move_and_slide()
