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
        }

        --[[
        manager = {
            vec4(),
            vec4(),
            vec4()
        },

        termpad = vec4()
        ]]
    }
}