require 'nn'

--
function get_32x32_to_64(p)
	--
	--
	--

	--
	local encoder = nn.Sequential()

	--
	encoder:add( nn.View(1, 32, 32) )

	--
	encoder:add(nn.SpatialConvolution(1, 32, 3, 3))
	encoder:add(nn.ReLU())
	encoder:add(nn.SpatialConvolution(32, 64, 4, 4, 2, 2))
	encoder:add(nn.ReLU())
	encoder:add(nn.SpatialConvolution(64, 128, 3, 3))
	encoder:add(nn.SpatialMaxPooling(2, 2, 2, 2))
	encoder:add(nn.SpatialConvolution(128, 32, 1, 1))

	--
	encoder:add(nn.View(1152))
	encoder:add(nn.Linear(1152, 64))

	--
	encoder:add(nn.Normalize(2))

	--
	if p then
		--
		params = encoder:getParameters()
		params:copy(p)
	end

	--
    return encoder
end

--
function get_3x32x32_to_64(p)
	--
	--
	--

	--
	local conv = nn.Sequential()

	conv:add(nn.SpatialConvolution(3, 32, 3, 3))
	conv:add(nn.ReLU())
	conv:add(nn.SpatialConvolution(32, 64, 4, 4, 2, 2))
	conv:add(nn.ReLU())
	conv:add(nn.SpatialConvolution(64, 128, 3, 3))
	conv:add(nn.SpatialMaxPooling(2, 2, 2, 2))
	conv:add(nn.SpatialConvolution(128, 32, 1, 1))
	conv:add(nn.SpatialConvolution(32, 64, 6, 6))

	--
	--
	local encoder = nn.Sequential()

	encoder:add(nn.View(3, 32, 32))
	encoder:add(conv)
	encoder:add(nn.View(64))
	encoder:add(nn.Normalize(2))

	--
	if p then
		--
		params = encoder:getParameters()
		params:copy(p)
	end

	--
    return encoder
end