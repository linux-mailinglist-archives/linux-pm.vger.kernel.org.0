Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C56F04BA
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbfKESK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 13:10:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32835 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390520AbfKESK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 13:10:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so2857775plb.0;
        Tue, 05 Nov 2019 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xgf/R13CTbGVKZNJzECasZDqFPajX8jIrP4cc+cKW80=;
        b=L0jcEC6SQD3mY4ac3RNnZmyTkHPxwfhGTToCGoRmcz/E+NU4dBYOlS4rHvp23TuHwW
         wOi1oGhz2chNwp3Kx3JHIMOk0BYM4Abu50vG4jO6GBypeeNHOZoSPPDQp9mS9pdRjTBC
         cq9Kq7vmSA6qwX0jUmpHh2NDiiUreUEYOaLxfCWZjFPjKOKscmkke74ryDyHi6Sl5KfA
         oHzQnQK1iJmsXyu99IoJzltlaQOBPRtboRQ1TKK2emnvaUbc/zieSX9UObIrvgyEyc0i
         CYpnLWA8WNxsSe4f57/iAvPK1jcvAO24yPOYlrjyFqFhEcl7L86LQBIBs19aLCBYPuPt
         wcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xgf/R13CTbGVKZNJzECasZDqFPajX8jIrP4cc+cKW80=;
        b=hOi37X/lYriSsGI/d/Zuh+70VzJl9yUmj3wCtifkWYJ578+F0Jb1qg4FGS6XO6Wnlv
         OEug+hZRcfrQQWyD0y3c3rwIy5zQTpkvG1qG1dpJzvhhx4nFW4H0xYEYbb1ZyIQYalB7
         WHY5rxCIwQaRfYEb/0ayCUx/GxRUcQSU7irV4Cq3nh0I/m6OVITM+WHc+B8qXIz0S7kB
         1TwzIKZZ6ndFq5RKOPhBQxHy7b5rJ9HGQV//0Ph/NodaZaFRN/pfzxMJ9BbXvlS9bZt6
         +s7vDYl7bUsTfkyOFmkhQ/stZMPUdtnVe1LZq4jTg4ygWi4JxER9ZG79ORXzHBgWEier
         5AHg==
X-Gm-Message-State: APjAAAXlEKpHOiwAo/+ypydmPPr/4HPhoeflXP4BWAwBZ0ex2gjtoZiE
        RJRypeNtG7VC5AUBSEZ4nS8=
X-Google-Smtp-Source: APXvYqyxs1xQj4ZFUNM7OCsA+7jN0O9lyTXVuaIFG0YagWGyt9o+u2FfRGxmjyAlDYitRpgHNOp5ug==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr35276811pls.281.1572977426163;
        Tue, 05 Nov 2019 10:10:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18sm20421819pfp.100.2019.11.05.10.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 10:10:25 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:10:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
Message-ID: <20191105181023.GA22468@roeck-us.net>
References: <20191102145530.16104-1-linux@roeck-us.net>
 <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
 <CAC5umyiJT300+MunDi4wwwAgSxiqx7_rersbNRvybcNoo3kGDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyiJT300+MunDi4wwwAgSxiqx7_rersbNRvybcNoo3kGDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 06, 2019 at 12:44:56AM +0900, Akinobu Mita wrote:
> 2019年11月6日(水) 0:38 Akinobu Mita <akinobu.mita@gmail.com>:
> >
> > 2019年11月2日(土) 23:55 Guenter Roeck <linux@roeck-us.net>:
> > > diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmon.c
> > > new file mode 100644
> > > index 000000000000..28b4b7f43bb0
> > > --- /dev/null
> > > +++ b/drivers/nvme/host/nvme-hwmon.c
> > > @@ -0,0 +1,181 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * NVM Express hardware monitoring support
> > > + * Copyright (c) 2019, Guenter Roeck
> > > + */
> > > +
> > > +#include <linux/hwmon.h>
> > > +#include <asm/unaligned.h>
> > > +
> > > +#include "nvme.h"
> > > +
> > > +struct nvme_hwmon_data {
> > > +       struct nvme_ctrl *ctrl;
> > > +       struct nvme_smart_log log;
> > > +       struct mutex read_lock;
> > > +};
> > > +
> > > +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                          &data->log, sizeof(data->log), 0);
> > > +
> > > +       return ret <= 0 ? ret : -EIO;
> > > +}
> > > +
> > > +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > > +                          u32 attr, int channel, long *val)
> > > +{
> > > +       struct nvme_hwmon_data *data = dev_get_drvdata(dev);
> > > +       struct nvme_smart_log *log = &data->log;
> > > +       int temp;
> > > +       int err;
> > > +
> > > +       /*
> > > +        * First handle attributes which don't require us to read
> > > +        * the smart log.
> > > +        */
> > > +       switch (attr) {
> > > +       case hwmon_temp_max:
> > > +               *val = (data->ctrl->wctemp - 273) * 1000;
> > > +               return 0;
> > > +       case hwmon_temp_crit:
> > > +               *val = (data->ctrl->cctemp - 273) * 1000;
> >
> > This attribute should be 'hwmon_temp_max_alarm' rather than
> > 'hwmon_temp_crit_alarm'?
> 

Yes, you are correct. Actually, re-reading the specification,
the bit may also be set for under-temperature alarms, so I'll
use the more generic hwmon_temp_alarm.

Thanks,
Guenter

> Oops, I misquoted the code.
> 
> This comment should be addressed to the code below:
> 
> +       case hwmon_temp_crit_alarm:
> +               *val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
> +               break;
