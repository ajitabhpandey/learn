# some python functions
import math

# area of pollygon
def pollygon_area(n,s):
    denom = math.tan(math.pi/n)
    numer = 1.0/4.0 * (n * (s ** 2.0))
    area = numer / denom
    return area

print pollygon_area(7.0,3.0)

def project_to_distance(point_x, point_y, distance):
    dist_to_origin = math.sqrt(point_x ** 2 + point_y ** 2)    
    scale = distance / dist_to_origin
    print point_x * scale, point_y * scale
    
project_to_distance(2, 7, 4)

# compund interest
def future_value(present_value, annual_rate, periods_per_year, years):
    rate_per_period = annual_rate / periods_per_year
    periods = periods_per_year * years
    
    future_value = present_value * ((1 + rate_per_period) ** periods)
    return future_value
print future_value(500,0.04,10,10)
print "$1000 at 2% compounded daily for 3 years yields $", future_value(1000, .02, 365, 3)

# Return True if year is a leap year, false otherwise
def is_leap_year(year):
    if (year % 400) == 0:
        return True
    elif (year % 100) == 0:
        return False
    elif (year % 4) == 0:
        return True
    else:
        return False


year = 2012
leap_year = is_leap_year(year)
    
if leap_year:
    print year, "is a leap year"
else:
    print year, "is not a leap year"
