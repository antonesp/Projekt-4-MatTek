
function phan = genPhantom(x)

P = phantom('Modified Shepp-Logan',x);

phan = imshow(P);
imsave