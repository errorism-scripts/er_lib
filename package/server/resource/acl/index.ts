type aceFunction = (principal: string | number, ace: string, allow: boolean) => void;
type principalFunction = (child: string, parent: string) => void;

export const addAce: aceFunction = (principal, ace, allow) => exports.er_lib.addAce(principal, ace, allow);
export const removeAce: aceFunction = (principal, ace, allow) => exports.er_lib.addAce(principal, ace, allow);

export const addPrincipal: principalFunction = (child, parent) => exports.er_lib.addPrincipal(child, parent);
export const removePrincipal: principalFunction = (child, parent) => exports.er_lib.removePrincipal(child, parent);
