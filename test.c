#include <arrow-glib/arrow-glib.h>
int main(void) {
  GArrowNullArray *array = garrow_null_array_new(10);
  g_object_unref(array);
  return 0;
}

