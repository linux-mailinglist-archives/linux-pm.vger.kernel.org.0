Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15354E9AA0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 12:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJ3LRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 07:17:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37007 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJ3LRB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 07:17:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id p13so849935pll.4;
        Wed, 30 Oct 2019 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0M10ohuWo+ZvYS5iML77SXzkc6HJmcmNLrKxyOaOKHo=;
        b=ldvbF7s9tpvO+LPxcA8+Ez0lsFl6FMzLaLfis/OHarEAKOpXuiJEgRPxyN81XClAf4
         9+gnDjnCeDosks+lU2vYG7KGaYvbokBjsLu7yEfUyxj93jDAuhNWfzDeg80RjOE+a2Zz
         Pl+LZADf8k4qEcMgvccoQ0lurYKWfd9mYZpjsZDQHCZxKcv2XGn6jWTJs1M746MVrFj8
         pa4MtWwTrxb12XxPax5O2zuV4OfF4Ix3n3L1tkscIgAT30nZwP6uKOUK49+1lmNCmbMQ
         BpaZE+wD1iVG7I058gzttqVUyLIZV0oEN5SKDqpq3pIhtpCpN4NtaWMqjTMUWSEIrCuB
         96HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0M10ohuWo+ZvYS5iML77SXzkc6HJmcmNLrKxyOaOKHo=;
        b=MELZnhYUjhfoc7c2UmVVIcxr+O3cpcDzb6cLcumc3eNoZcSOB+pGVXLvf9FZYSC46g
         S3o02zmsFJcxE+TKNuoh5EVqUb20PQYUYz2y1pYSOo2i4cdElUxvMZXlfvaju2MX3jHQ
         cS6VI1bhdmM/l9x6kT/1tZ3px0S0n5RueezUAF3ybbHhYRWt6wvFhH92d/I8EUmmUxpF
         ydi6XzzyYGwSMDr2RNHTodu4ogWidMgIV7J+5U6IPjRbcLjfl2f1anbQsoZSFZTJBiqg
         E5XsCgLJaLPf+Px2m0Zy5FI5SErjONz41QK89KnL76XhUU9UE3j2LGFs7x5dX6W9FxAd
         zTZA==
X-Gm-Message-State: APjAAAWpuNxN890r6aqSJzBXh0Baai4OPWG3qG62497IzGOZcFf+KVzt
        NHe+aaQbJsCLYfx4uw9lGU/iubRpQy+qzYeOvkE=
X-Google-Smtp-Source: APXvYqxPP7K1TcX0QpfF/pVkhpbeDr+WqtqFWkW7FZiGMwTTqXV2+kvhaQUMPk5OfGl9cILNiSXcfkkl3Oi0S3lGCxc=
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr4037783plk.192.1572434219222;
 Wed, 30 Oct 2019 04:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191029223214.18889-1-linux@roeck-us.net>
In-Reply-To: <20191029223214.18889-1-linux@roeck-us.net>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 30 Oct 2019 20:16:48 +0900
Message-ID: <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B410=E6=9C=8830=E6=97=A5(=E6=B0=B4) 7:32 Guenter Roeck <linux@ro=
eck-us.net>:
>
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
>
> At the same time, it would be desirable to use NVME temperature informati=
on
> for thermal control.
>
> This patch adds support to read NVME temperatures from the kernel using t=
he
> hwmon API and adds temperature zones for NVME drives. The thermal subsyst=
em
> can use this information to set thermal policies, and userspace can acces=
s
> it using libsensors and/or the "sensors" command.
>
> Example output from the "sensors" command:
>
> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0=C2=B0C  (high =3D +85.0=C2=B0C, crit =3D +85.0=C2=B0C=
)
> Sensor 1:     +39.0=C2=B0C
> Sensor 2:     +41.0=C2=B0C
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use devm_kfree() to release memory in error path
>
>  drivers/nvme/host/Kconfig      |  10 ++
>  drivers/nvme/host/Makefile     |   1 +
>  drivers/nvme/host/core.c       |   5 +
>  drivers/nvme/host/nvme-hwmon.c | 163 +++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h       |   8 ++
>  5 files changed, 187 insertions(+)
>  create mode 100644 drivers/nvme/host/nvme-hwmon.c
>
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 2b36f052bfb9..aeb49e16e386 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -23,6 +23,16 @@ config NVME_MULTIPATH
>            /dev/nvmeXnY device will show up for each NVMe namespaces,
>            even if it is accessible through multiple controllers.
>
> +config NVME_HWMON
> +       bool "NVME hardware monitoring"
> +       depends on (NVME_CORE=3Dy && HWMON=3Dy) || (NVME_CORE=3Dm && HWMO=
N)
> +       help
> +         This provides support for NVME hardware monitoring. If enabled,
> +         a hardware monitoring device will be created for each NVME driv=
e
> +         in the system.
> +
> +         If unsure, say N.
> +
>  config NVME_FABRICS
>         tristate
>
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index 8a4b671c5f0c..03de4797a877 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -14,6 +14,7 @@ nvme-core-$(CONFIG_TRACING)           +=3D trace.o
>  nvme-core-$(CONFIG_NVME_MULTIPATH)     +=3D multipath.o
>  nvme-core-$(CONFIG_NVM)                        +=3D lightnvm.o
>  nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)   +=3D fault_inject.o
> +nvme-core-$(CONFIG_NVME_HWMON)         +=3D nvme-hwmon.o
>
>  nvme-y                                 +=3D pci.o
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7ba09dca77..fc1d4b146717 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2796,6 +2796,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>         ctrl->oncs =3D le16_to_cpu(id->oncs);
>         ctrl->mtfa =3D le16_to_cpu(id->mtfa);
>         ctrl->oaes =3D le32_to_cpu(id->oaes);
> +       ctrl->wctemp =3D le16_to_cpu(id->wctemp);
> +       ctrl->cctemp =3D le16_to_cpu(id->cctemp);
> +
>         atomic_set(&ctrl->abort_limit, id->acl + 1);
>         ctrl->vwc =3D id->vwc;
>         if (id->mdts)
> @@ -2897,6 +2900,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>
>         ctrl->identified =3D true;
>
> +       nvme_hwmon_init(ctrl);
> +
>         return 0;
>
>  out_free:

The nvme_init_identify() can be called multiple time in nvme ctrl's
lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
should we need to prevent nvme_hwmon_init() from registering hwmon
device more than twice?

In the nvme thermal zone patchset[1], thernal zone is registered in
nvme_init_identify and unregistered in nvme_stop_ctrl().

[1] https://lore.kernel.org/linux-devicetree/1561990354-4084-2-git-send-ema=
il-akinobu.mita@gmail.com/

> diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmo=
n.c
> new file mode 100644
> index 000000000000..af5eda326ec6
> --- /dev/null
> +++ b/drivers/nvme/host/nvme-hwmon.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVM Express hardware monitoring support
> + * Copyright (c) 2019, Guenter Roeck
> + */
> +
> +#include <linux/hwmon.h>
> +
> +#include "nvme.h"
> +
> +struct nvme_hwmon_data {
> +       struct nvme_ctrl *ctrl;
> +       struct nvme_smart_log log;
> +};
> +
> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> +{
> +       return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +                           &data->log, sizeof(data->log), 0);
> +}

The 'data->log' is allocated per nvme_ctrl, so are there any locks to
prevent multiple callers of nvme_hwmon_get_smart_log() from breaking
the log buffer?

> +
> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types t=
ype,
> +                          u32 attr, int channel, long *val)
> +{
> +       struct nvme_hwmon_data *data =3D dev_get_drvdata(dev);
> +       struct nvme_smart_log *log =3D &data->log;
> +       int err;
> +       int temp;
> +
> +       err =3D nvme_hwmon_get_smart_log(data);
> +       if (err)
> +               return err < 0 ? err : -EPROTO;
> +
> +       switch (attr) {
> +       case hwmon_temp_max:
> +               *val =3D (data->ctrl->wctemp - 273) * 1000;
> +               break;
> +       case hwmon_temp_crit:
> +               *val =3D (data->ctrl->cctemp - 273) * 1000;
> +               break;

When this function is called with 'hwmon_temp_max' or 'hwmon_temp_crit',
we don't need to call nvme_hwmon_get_smart_log() at all, do we?

> +       case hwmon_temp_input:
> +               if (!channel)
> +                       temp =3D le16_to_cpup((__le16 *)log->temperature)=
;
> +               else
> +                       temp =3D le16_to_cpu(log->temp_sensor[channel - 1=
]);
> +               *val =3D (temp - 273) * 1000;
> +               break;
> +       case hwmon_temp_crit_alarm:
> +               *val =3D !!(log->critical_warning & NVME_SMART_CRIT_TEMPE=
RATURE);
> +               break;
> +       default:
> +               err =3D -EOPNOTSUPP;
> +               break;
> +       }
> +       return err;
> +}
