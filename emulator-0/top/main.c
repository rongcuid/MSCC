extern void adainit(void);
extern void adafinal(void);
extern void Hello();

int main()
{
    adainit();
    Hello();
    adafinal();
    return 0;
}