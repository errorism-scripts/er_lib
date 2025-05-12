import type { VehicleProperties } from 'shared';

export * from './acl';
export * from './locale';
export * from './callback';
export * from './version';
export * from './addCommand';

export function setVehicleProperties(vehicle: number, props: VehicleProperties) {
  Entity(vehicle).state.set('er_lib:setVehicleProperties', props, true);
}
