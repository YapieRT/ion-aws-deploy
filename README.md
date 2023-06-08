### ion-aws-deploy

## Installation

1. Use `terraform init`

2. Create folder `ssh` with keys `aws_key` and `aws_key.pub`.

3. Create file with variables of your creds or just add it to the end of _variables.tf_.

```

variable "ac_key" {
    type = string
    default = ""
}

variable "sc_key" {
    type = string
    default = ""
}

```

4. Create folder _connection_ and specify url to your mongodb as shown in file _db.js_.

```

import mongoose from 'mongoose';

export const connectDB = () => {
    mongoose
    .connect('_Your connection URI here_')
    .then(() => console.log('DB conected'))
    .catch((err) => console.log('DB error', err));
};

```

**Note**

You can specify port(variable wport) on which you want to run backend part in _variables.tf_.
