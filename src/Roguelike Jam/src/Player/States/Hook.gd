# Hook state
extends State

var claw :Node2D

# warning-ignore:unused_argument
func physics_process(delta) -> void:
	if claw != null:
		if claw.has_interrupted and not claw.has_finished:
			owner.animationPlayer.play("Hooking")
			owner.move_and_slide(owner.player_direction * 400)
			
		elif claw.has_finished:
			claw.reset()
			_state_machine.transition_to("Move/Run")
	
	
# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	owner.animationPlayer.play("Hook")
	yield(owner.animationPlayer, "animation_finished")
	set_audio_stream(owner.chain_sound)
	claw = owner.claw
	claw.set_process(true)


func exit() -> void:
	return


func set_audio_stream(_audio_stream: AudioStream) -> void:
	owner.audio.stream = _audio_stream
	owner.audio.play()
	
	
