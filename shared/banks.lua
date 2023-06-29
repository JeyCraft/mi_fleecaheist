BK = {}

--[[ ideas
what if door + security camera set for each bank
if camera active and player enters zone, alert police
if they fail to disable the camera, cameras turn on
if they use drill on door, cameras turn on
if use pad or card, no security sys alert
option to open / close vault door with inside / outside pad

]]


BK.banks  = {
    alta = {
        camera = vec4(271.758, -309.673, 57.025, 70.00),
        cameracontrol = vec4(276.055, -308.707, 49.864, 340.00),
        camzoneoutside = {
            loc = vec3(290.500, -317.200, 50.500),
            head = 70,
            size = vec3(6, 30, 4),
        },
        camzoneinside = {
            loc = vec3(308.449, -279.66, 54.164),
            head = 157.843,
            size = vec3(2, 3, 3),
        },
        secsystemoutside = {
            loc = vec3(311.053, -284.734, 54.364),
            head = 160.00,
            size = vec3(0.5, 0.2, 0.6),
        },
        secsysteminside = {
            loc = vec3(312.772, -285.051, 54.364),
            head = 160.00,
            size = vec3(0.5, 0.2, 0.6),
        },
        vaultdoor = {
            hash = 2121050683,
            loc = vec3(312.858, -283.730, 54.303),
            head = 249.865,
            size = vec3(2, 1.9, 2.5),
            headend = 149.865, -- head - 100.00
            drill = vec3(311.810, -283.530, 54.303),
            drillhead = 70.000
        },
        manager = {
            ped = 'a_f_y_business_01',
            anim = 'WORLD_HUMAN_DRINKING_FACILITY',
            loc = {
                [1] = vec4(316.241, -282.126, 54.164, 64.575),
                [2] = vec4(289.563, -318.885, 49.864, 158.638),
                [3] = vec4(303.659, -276.756, 54.166, 45.574)
            }
        },
        money = {
            loc = {
                [1] = vec4(315.467, -284.806, 54.142, 65.479),
                [2] = vec4(311.255, -288.659, 54.143, 339.541),
                [3] = vec4(315.149, -287.406, 54.143, 70.666)
            },
        }
    }
}