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
    key = 'phone',
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
    },

    legion = {
        camera = vec4(129.944, -1029.304, 32.879, 0.00),
        cameracontrol = vec4(148.750, -1056.645, 29.197, 70.00),
        camzoneoutside = {
            loc = vec3(128.855, -1037.911, 29.433),
            head = 160.00,
            size = vec3(4, 10, 4),
        },
        camzoneinside = {
            loc = vec3(144.257, -1041.662, 29.367),
            head = 160,
            size = vec3(2, 3, 3),
        },
        secsystemoutside = {
            loc = vec3(146.721, -1046.367, 29.568),
            head = 160.00,
            size = vec3(0.5, 0.2, 0.6),
        },
        secsysteminside = {
            loc = vec3(148.439, -1046.685, 29.568),
            head = 160.00,
            size = vec3(0.5, 0.2, 0.6),
        },
        vaultdoor = {
            hash = 2121050683,
            loc = vec3(148.626, -1045.363, 29.506),
            head = 249.865,
            size = vec3(2, 1.9, 2.5),
            headend = 149.865, -- head - 100.00
            drill = vec3(147.476, -1045.163, 29.506),
            drillhead = 70.000
        },
        manager = {
            ped = 'a_f_y_business_01',
            anim = 'WORLD_HUMAN_DRINKING_FACILITY',
            loc = {
                [1] = vec4(130.697, -1036.227, 29.433, 75.925),
                [2] = vec4(142.057, -1043.885, 29.368, 251.146),
                [3] = vec4(142.057, -1043.885, 29.368, 251.146)
            }
        },
        money = {
            loc = {
                [1] = vec4(151.130, -1046.527, 29.367, 69.95),
                [2] = vec4(147.061, -1048.404, 29.367, 250.575),
                [3] = vec4(149.094, -1049.866, 29.367, 204.148)
            },
        }
    },

    burton = {
        camera = vec4(-378.329, -69.841, 48.292, 70.00),
        cameracontrol = vec4(-340.777, -65.787, 54.585, 70.00),
        camzoneoutside = {
            loc = vec3(-365.577, -77.607, 45.661),
            head = 251.50,
            size = vec3(10.5, 20, 4),
        },
        camzoneinside = {
            loc = vec3(-356.490, -50.442, 49.035),
            head = 251.50,
            size = vec3(2, 3, 3),
        },
        secsystemoutside = {
            loc = vec3(-354.006, -55.598, 49.236),
            head = 160.00,
            size = vec3(0.5, 0.2, 0.6),
        },
        secsysteminside = {
            loc = vec3(-352.282, -55.886, 49.236),
            head = 160.00,
            size = vec3(0.5, 0.2, 0.6),
        },
        vaultdoor = {
            hash = 2121050683,
            loc = vec3(-352.136, -54.572, 49.175),
            head = 249.865,
            size = vec3(2, 1.9, 2.5),
            headend = 149.865, -- head - 100.00
            drill = vec3(-353.336, -54.572, 49.175),
            drillhead = 70.000
        },
        manager = {
            ped = 'a_f_y_business_01',
            anim = 'WORLD_HUMAN_DRINKING_FACILITY',
            loc = {
                [1] = vec4(-368.051, -71.355, 45.673, 167.081),
                [2] = vec4(-350.230, -52.661, 49.036, 155.145),
                [3] = vec4(-362.363, -38.153, 49.036, 158.509)
            }
        },
        money = {
            loc = {
                [1] = vec4(151.130, -1046.527, 29.367, 69.95),
                [2] = vec4(147.061, -1048.404, 29.367, 250.575),
                [3] = vec4(149.094, -1049.866, 29.367, 204.148)
            },
        }
    }
}





local loc = BK.banks
BK.debug = loc.burton