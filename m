Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0919F01C7
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbfKEPpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 10:45:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34121 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEPpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 10:45:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so22436144ljf.1;
        Tue, 05 Nov 2019 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ay+h7c6u74y0NDeAAMw4e9/VcMJ072gLoBrrzIdrw+4=;
        b=dywZ6FpAkymA6khuADv5aozdmj+qm8Ih+0CsbdG53LZ53xAAFb6miFnpuZclfH19JD
         4uHXVPdmZFzYVJoOHJtboVneTqLMx5U8l0+uxQANTMH1Utw/MPrSQy9wvj3EbZ7ZPFBD
         I3Pk8IJcJCibzzyu3G+IrQQudXl0bWdcv+7oKscO3UI6zqbgU8CQZ4EFoEnJQKGbodL9
         vOVmdFAFpiKNoP9Ks/Ivl2orsTYcuwsThyvgDkqyJefqkumjNWscHUCJxxiV/7SKP0QF
         8h1rFJHbrRIL3bSanhznb31tea+zYasdGaxQDaC/5PwDPqzG5xJMVQuLnSOaWaPPTkZX
         P7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ay+h7c6u74y0NDeAAMw4e9/VcMJ072gLoBrrzIdrw+4=;
        b=PFsAxjrbBLJ5EtTwb6FGYCvkHqvUrsT8I5HRNn0pLSux0hpVAH3px8rcC446Vw2EBJ
         QzhsbZZxjE46e+uCiCGAdMzJbjWZ0//BVqBni92XNdRTbrIU4ww4UQGV0k9DppvN53Un
         M5lSSInVdTW0N2qMx0v2epK8zoqeovT6mukhNoFz9sSiudHKjTtLY/hZ1FAcMJwrGZwN
         vmW0kFEXs+BVIqufIbrUsDyQZjoHdulHVB97mr/1dlUgmMbr0lGrS1zxlGLKJ1n0Qrp4
         /E6LcmvIwWrb7yvtYsYK8yeQnghSCvrYXKM9LyvYCjWuaJjQDlxzCIb/2vD/lGNBUngX
         aftw==
X-Gm-Message-State: APjAAAVQKsmr8xFltcxrt0QvactLi4gU7CwIRdnnGEJz38ZxlII6nu3z
        3iE/jgiI216mJ4UOi69nFlUgssnwYrAAfC7wOm8W2+Gw
X-Google-Smtp-Source: APXvYqwgP223ysQHD0U2ApItHEUOrYRG++kDvJ8HQF8nebhnlOaxv4s/qoh1vpev3gpdrwpDFsgYxc6JjaWYO9ujXrw=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr6656552ljj.93.1572968707730;
 Tue, 05 Nov 2019 07:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20191102145530.16104-1-linux@roeck-us.net> <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
In-Reply-To: <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 6 Nov 2019 00:44:56 +0900
Message-ID: <CAC5umyiJT300+MunDi4wwwAgSxiqx7_rersbNRvybcNoo3kGDg@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B411=E6=9C=886=E6=97=A5(=E6=B0=B4) 0:38 Akinobu Mita <akinobu.mi=
ta@gmail.com>:
>
> 2019=E5=B9=B411=E6=9C=882=E6=97=A5(=E5=9C=9F) 23:55 Guenter Roeck <linux@=
roeck-us.net>:
> > diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hw=
mon.c
> > new file mode 100644
> > index 000000000000..28b4b7f43bb0
> > --- /dev/null
> > +++ b/drivers/nvme/host/nvme-hwmon.c
> > @@ -0,0 +1,181 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * NVM Express hardware monitoring support
> > + * Copyright (c) 2019, Guenter Roeck
> > + */
> > +
> > +#include <linux/hwmon.h>
> > +#include <asm/unaligned.h>
> > +
> > +#include "nvme.h"
> > +
> > +struct nvme_hwmon_data {
> > +       struct nvme_ctrl *ctrl;
> > +       struct nvme_smart_log log;
> > +       struct mutex read_lock;
> > +};
> > +
> > +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> > +{
> > +       int ret;
> > +
> > +       ret =3D nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART,=
 0,
> > +                          &data->log, sizeof(data->log), 0);
> > +
> > +       return ret <=3D 0 ? ret : -EIO;
> > +}
> > +
> > +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types=
 type,
> > +                          u32 attr, int channel, long *val)
> > +{
> > +       struct nvme_hwmon_data *data =3D dev_get_drvdata(dev);
> > +       struct nvme_smart_log *log =3D &data->log;
> > +       int temp;
> > +       int err;
> > +
> > +       /*
> > +        * First handle attributes which don't require us to read
> > +        * the smart log.
> > +        */
> > +       switch (attr) {
> > +       case hwmon_temp_max:
> > +               *val =3D (data->ctrl->wctemp - 273) * 1000;
> > +               return 0;
> > +       case hwmon_temp_crit:
> > +               *val =3D (data->ctrl->cctemp - 273) * 1000;
>
> This attribute should be 'hwmon_temp_max_alarm' rather than
> 'hwmon_temp_crit_alarm'?

Oops, I misquoted the code.

This comment should be addressed to the code below:

+       case hwmon_temp_crit_alarm:
+               *val =3D !!(log->critical_warning & NVME_SMART_CRIT_TEMPERA=
TURE);
+               break;
