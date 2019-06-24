import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const select2 = document.querySelector(".select2");
  if (select2) {
    $('.select2').select2();
  }
};

export { initSelect2 };
