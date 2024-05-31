from enum import Enum
class RESERVE_TYPE(str, Enum):
    CULTURE="60"
    EDUCATE="50"
    SPORT="40"
    MEDICAL="30"
    RESRAURANT="20"
    ETC="10"

class RESERVE_STATUS(str, Enum):
    PENDING = "100"
    CONVERT = "200"
    COMPLETE = "300"
    REJECT = "400"

class ROLE(str, Enum):
    MANAGER= "03"
    HELPER = "02"
    NORMAL = "01"

class RESPONSER_AVG_TIME(str, Enum):
    TENMIN = "0010"
    THRMIN = "0030"
    ONEHOR = "0100"
    THRHOR = "0300"
    SIXHOR = "0600"
    ONEDAY = "1000"