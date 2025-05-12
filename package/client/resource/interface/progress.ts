type Position = {
  x: number;
  y: number;
  z: number;
};

interface PropProps {
  model: string;
  bone?: number;
  pos: Position;
  rot: Position;
}

interface ProgressProps {
  duration: number;
  position?: 'middle' | 'bottom';
  useWhileDead?: boolean;
  allowRagdoll?: boolean;
  allowCuffed?: boolean;
  allowFalling?: boolean;
  canCancel?: boolean;
  anim?: {
    dict?: string;
    clip: string;
    flag?: number;
    blendIn?: number;
    blendOut?: number;
    duration?: number;
    playbackRate?: number;
    lockX?: boolean;
    lockY?: boolean;
    lockZ?: boolean;
    scenario?: string;
    playEnter?: boolean;
  };
  prop?: PropProps | PropProps[];
  disable?: {
    move?: boolean;
    car?: boolean;
    combat?: boolean;
    mouse?: boolean;
  };
}

interface ProgressbarProps extends Omit<ProgressProps, 'position'> {
  label: string;
}

export const progressBar = async (data: ProgressbarProps): Promise<boolean> => exports.er_lib.progressBar(data);

export const progressCircle = async (data: ProgressProps): Promise<boolean> => exports.er_lib.progressCircle(data);

export const progressActive = (): boolean => exports.er_lib.progressActive();

export const cancelProgress = (): void => exports.er_lib.cancelProgress();
