const displayExercise = () => {
  const exercise = document.querySelector(".select");
  if (exercise) {
    exercise.addEventListener("change", (event) => {
      event.preventDefault();
      const otherDestinations = document.querySelectorAll(".other-destinations");
      if (exercise.value === "bonus") {
        otherDestinations.forEach((destination) => {
          destination.classList.remove("hidden");
        });
      }
      else if (exercise.value === "exo") {
        otherDestinations.forEach((destination) => {
          destination.classList.add("hidden");
        });
      }
    });
  }
};

export { displayExercise };
