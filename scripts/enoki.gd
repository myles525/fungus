extends CharacterBody2D
#
#@export var max_stamina: int = 100
#@export var speed: float = 200
#@export var stamina_depletion_rate: float = 25.0
#
#var stamina: float
#var is_colliding = false
#var previous_position: Vector2
#var collision_timer: Timer
#
#signal area_entered(area)
#signal area_exited(area)
#
#func _ready() -> void:
	#stamina = max_stamina
	#previous_position = position
	#collision_timer = Timer.new()
	#add_child(collision_timer)
	#collision_timer.connect("timeout", Callable(self, "_on_collision_timeout"))
#
#func _process(delta: float) -> void:
	#var velocity = Vector2.ZERO
#
	## Handle input
	#if Input.is_action_pressed("right"):
		#velocity.x += 1
	#if Input.is_action_pressed("left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("down"):
		#velocity.y += 1
	#if Input.is_action_pressed("up"):
		#velocity.y -= 1
#
	## Normalize the velocity to ensure consistent speed in all directions
	#if velocity.length() > 0:
		#if stamina > 0:
			#velocity = velocity.normalized() * speed
#
			## Move and handle collisions
			#move_and_slide()
#
			## Deplete stamina
			#stamina -= stamina_depletion_rate * delta
			#print(stamina)
			#if stamina < 0:
				#stamina = 0
		#else:
			#pass
#
#func _on_area_entered(area):
	#is_colliding = true
	#collision_timer.start(0.1)  # Start a short timer to allow movement after collision
	#emit_signal("area_entered", area)
#
#func _on_area_exited(area):
	#is_colliding = false
	#emit_signal("area_exited", area)
	#
#func _on_collision_timeout():
	#is_colliding = false
