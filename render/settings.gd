extends CanvasLayer

# Export variables to assign in editor
@export var camera_ref: Camera3D
@export var world_env_ref: WorldEnvironment

var visible_on_start = false
@onready var settings_menu: SettingsMenu = $Settings

# Handler nodes for settings
@onready var camera_handler = Node.new()
@onready var world_env_handler = Node.new()

func _ready():
    # Setup visibility
    settings_menu.visible = visible_on_start
    
    # Validate references
    if !camera_ref:
        push_error("Camera reference not set in Settings node")
        return
        
    if !world_env_ref:
        push_error("WorldEnvironment reference not set in Settings node")
        return
        
    if !world_env_ref.environment:
        push_error("WorldEnvironment has no environment resource")
        return
    
    # Setup handlers
    camera_handler.set_script(load("res://addons/modular-settings-menu/scripts/settings-handler-scripts/camera_settings_handler.gd"))
    world_env_handler.set_script(load("res://addons/modular-settings-menu/scripts/settings-handler-scripts/world_env_settings_handler.gd"))
    
    # Add handlers as children
    add_child(camera_handler)
    add_child(world_env_handler)
    
    # Connect references
    camera_handler.CameraRef = camera_ref
    world_env_handler.WorldEnvRef = world_env_ref
    
    # Apply initial settings if any exist
    apply_initial_settings()

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        settings_menu.visible = !settings_menu.visible

func apply_initial_settings():
    if SettingsDataManager.settingsData_.has("Graphics"):
        var graphics = SettingsDataManager.settingsData_["Graphics"]
        for setting in graphics:
            world_env_handler.apply_in_game_settings("Graphics", setting, graphics[setting])
    
    if SettingsDataManager.settingsData_.has("Gameplay"):
        var gameplay = SettingsDataManager.settingsData_["Gameplay"] 
        for setting in gameplay:
            camera_handler.apply_in_game_settings("Gameplay", setting, gameplay[setting])
