#include <stdio.h>
//diegos work 
int power(int a, int b) // function to find the power of a number 
{
  if (b == 0) // if power is zero answer is 1
    return 1;
  int answer = a;
  int inc = a;
  int i, j;
  for(i = 1; i < b; i++) // nested loop to determine the result of the power 
  {
     for(j = 1; j < a; j++)
     {
        answer += inc;
     }
     inc = answer;
  }
  return answer;
}
int DecToBase(int n, int base) // function to convert a decimal number to any base
{
    int num =0;
	int counter = 0;  
	int quo= n;  
	int rem = 0; 
	
	while(quo != 0){ // while the decimal number is not equal to zero find theremaninders
		
		rem = quo%base;
		quo = quo / base;
		
		num = power(10,counter)*rem + num;
		counter++;
	}
	
	return num;
}

// Parker's work
int stringLen(char str[]){
  int i = 0;

  while (str[i] != '\0'){
    i++;
  }
  
  return i;
}

int letterSwap(char c) {
  int result;
  if (c >= '0' && c <= '9'){
    result = (int)c - '0';
  }else{
    result = (int)c - 'A' + 10;
  }
 return result;
}

int baseToDec(char *str, int base){
  int res = 0;  //initialize the result
  int length = stringLen(str); // using the stringLen() from above to get the length of a string
  int power = 1; //the power of the base
  int i = 0;
  for (i = length - 1; i >= 0; i--){
    if (letterSwap(str[i]) >= base){
      printf("invalid number");
      return -1;
    }
    res += letterSwap(str[i]) * power;
    power = power * base;
  }
  return res;
}

int anyBaseToAnyBase(char *str,int baseFrom, int baseTo){
  int res;
  
  //check if the bases have a common exponent
  //if they do then redirect to another function
  //else convert the baseFrom to decimal
  res = baseToDec(str, baseFrom);

  //convert the new number in deciamal to the baseTo
  res = DecToBase(res, baseTo);

  return res;
}
// end of Parker's work

int main(void) {
  char str[20];
  int num, baseFrom, baseTo, res;
  printf("Input the base of the number: ");
  scanf("%d", &baseFrom);
  printf("Input the base to convert to: ");
  scanf("%d", &baseTo);
  printf("Input the number to be converted: ");
  scanf("%s", str);

  if (baseFrom == 10)
  {
    sscanf(str, "%d", &num);
    printf(" %d", DecToBase(num, baseTo));
  }
  else if(baseFrom != 10 && baseTo == 10){
    printf(" %d", baseToDec(str, baseFrom));
  }
  else if(baseFrom != 10 && baseTo != 10){
    printf(" %d", anyBaseToAnyBase(str, baseFrom, baseTo));
  }
    return 0;
}

