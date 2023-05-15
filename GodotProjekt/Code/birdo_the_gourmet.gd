extends CharacterBody2D

func _ready():
	if(!$AttentionArea.body_entered.is_connected(_on_attention_area_body_entered)):
		$AttentionArea.body_entered.connect(_on_attention_area_body_entered)

func _on_attention_area_body_entered(body):
	if(body.has_method("player")):
		$AnimationTree.get("parameters/playback").travel("secrets")
