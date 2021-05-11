%Activation
function[v]=activation(S,A,Km,Ka,alpha,beta)
	v=S .* (1 + beta*A/(alpha * Ka)) ./ (Km * (1 + A/Ka) + S .* (1+ A/(Ka * alpha)));
end
