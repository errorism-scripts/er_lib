type SkillCheckDifficulty = 'easy' | 'medium' | 'hard' | { areaSize: number; speedMultiplier: number };

export const skillCheck = (difficulty: SkillCheckDifficulty | SkillCheckDifficulty[], inputs?: string[]) =>
  exports.er_lib.skillCheck(difficulty);

export const skillCheckActive = (): boolean => exports.er_lib.skillCheckActive();

export const cancelSkillCheck = (): void => exports.er_lib.cancelSkillCheck();
