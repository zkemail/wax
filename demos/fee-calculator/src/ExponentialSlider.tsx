import React, { useState } from 'react';

const ExponentialSlider = ({
  init,
  scale,
  onChange,
}: {
  init: number;
  scale: number;
  onChange: (value: number) => void;
}) => {
  const [sliderValue, setSliderValue] = useState(0);

  return (
    <div>
      <input
        type="range"
        min="-1"
        max="1"
        value={sliderValue}
        step={0.01}
        onInput={(e) => {
          const newSliderValue = parseFloat(e.currentTarget.value);
          setSliderValue(newSliderValue);
          onChange(
            scale **
              (Math.sign(newSliderValue) * Math.abs(newSliderValue) ** 1.5) *
              init,
          );
        }}
      />
    </div>
  );
};

export default ExponentialSlider;
