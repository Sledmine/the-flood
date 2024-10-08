---@class EngineTagDataGlowBoundaryEffectEnum : Enum 

---@class EngineTagDataGlowBoundaryEffectBounce : EngineTagDataGlowBoundaryEffectEnum 
---@class EngineTagDataGlowBoundaryEffectWrap : EngineTagDataGlowBoundaryEffectEnum 

---@alias EngineTagDataGlowBoundaryEffect 
---| EngineTagDataGlowBoundaryEffectBounce
---| EngineTagDataGlowBoundaryEffectWrap

---@class EngineTagDataGlowBoundaryEffectTable 
---@field tBounce EngineTagDataGlowBoundaryEffectBounce
---@field tWrap EngineTagDataGlowBoundaryEffectWrap
Engine.tag.glowBoundaryEffect = {} 

---@class EngineTagDataGlowNormalParticleDistributionEnum : Enum 

---@class EngineTagDataGlowNormalParticleDistributionDistributedRandomly : EngineTagDataGlowNormalParticleDistributionEnum 
---@class EngineTagDataGlowNormalParticleDistributionDistributedUniformly : EngineTagDataGlowNormalParticleDistributionEnum 

---@alias EngineTagDataGlowNormalParticleDistribution 
---| EngineTagDataGlowNormalParticleDistributionDistributedRandomly
---| EngineTagDataGlowNormalParticleDistributionDistributedUniformly

---@class EngineTagDataGlowNormalParticleDistributionTable 
---@field onDistributedRandomly EngineTagDataGlowNormalParticleDistributionDistributedRandomly
---@field onDistributedUniformly EngineTagDataGlowNormalParticleDistributionDistributedUniformly
Engine.tag.glowNormalParticleDistribution = {} 

---@class EngineTagDataGlowTrailingParticleDistributionEnum : Enum 

---@class EngineTagDataGlowTrailingParticleDistributionEmitVertically : EngineTagDataGlowTrailingParticleDistributionEnum 
---@class EngineTagDataGlowTrailingParticleDistributionEmitNormalUp : EngineTagDataGlowTrailingParticleDistributionEnum 
---@class EngineTagDataGlowTrailingParticleDistributionEmitRandomly : EngineTagDataGlowTrailingParticleDistributionEnum 

---@alias EngineTagDataGlowTrailingParticleDistribution 
---| EngineTagDataGlowTrailingParticleDistributionEmitVertically
---| EngineTagDataGlowTrailingParticleDistributionEmitNormalUp
---| EngineTagDataGlowTrailingParticleDistributionEmitRandomly

---@class EngineTagDataGlowTrailingParticleDistributionTable 
---@field onEmitVertically EngineTagDataGlowTrailingParticleDistributionEmitVertically
---@field onEmitNormalUp EngineTagDataGlowTrailingParticleDistributionEmitNormalUp
---@field onEmitRandomly EngineTagDataGlowTrailingParticleDistributionEmitRandomly
Engine.tag.glowTrailingParticleDistribution = {} 

---@class MetaEngineTagDataGlowFlags 
---@field modifyParticleColorInRange boolean 
---@field particlesMoveBackwards boolean 
---@field particesMoveInBothDirections boolean 
---@field trailingParticlesFadeOverTime boolean 
---@field trailingParticlesShrinkOverTime boolean 
---@field trailingParticlesSlowOverTime boolean 

---@class MetaEngineTagDataGlow 
---@field attachmentMarker MetaEngineTagString 
---@field numberOfParticles integer 
---@field boundaryEffect EngineTagDataGlowBoundaryEffect 
---@field normalParticleDistribution EngineTagDataGlowNormalParticleDistribution 
---@field trailingParticleDistribution EngineTagDataGlowTrailingParticleDistribution 
---@field glowFlags MetaEngineTagDataGlowFlags 
---@field attachment_0 EngineTagDataFunctionOut 
---@field particleRotationalVelocity number 
---@field particleRotVelMulLow number 
---@field particleRotVelMulHigh number 
---@field attachment_1 EngineTagDataFunctionOut 
---@field effectRotationalVelocity number 
---@field effectRotVelMulLow number 
---@field effectRotVelMulHigh number 
---@field attachment_2 EngineTagDataFunctionOut 
---@field effectTranslationalVelocity number 
---@field effectTransVelMulLow number 
---@field effectTransVelMulHigh number 
---@field attachment_3 EngineTagDataFunctionOut 
---@field minDistanceParticleToObject number 
---@field maxDistanceParticleToObject number 
---@field distanceToObjectMulLow number 
---@field distanceToObjectMulHigh number 
---@field attachment_4 EngineTagDataFunctionOut 
---@field particleSizeBounds number 
---@field sizeAttachmentMultiplier number 
---@field attachment_5 EngineTagDataFunctionOut 
---@field colorBound_0 MetaEngineColorARGB 
---@field colorBound_1 MetaEngineColorARGB 
---@field scaleColor_0 MetaEngineColorARGB 
---@field scaleColor_1 MetaEngineColorARGB 
---@field colorRateOfChange number 
---@field fadingPercentageOfGlow number 
---@field particleGenerationFreq number 
---@field lifetimeOfTrailingParticles number 
---@field velocityOfTrailingParticles number 
---@field trailingParticleMinimumT number 
---@field trailingParticleMaximumT number 
---@field texture MetaEngineTagDependency 


