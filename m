Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A132998B
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbfEXN5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 09:57:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43104 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404038AbfEXN5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2019 09:57:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so5113102pgv.10
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2019 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J+9ArWl9WPscfCbVgoKL2Q96tnzkWovxeKRqbqmzl+E=;
        b=AVC2vEJsaDzEDsP66sPKoPRE26J3SFmnqqVH3vJTk7YqimN/FJEov+bcRzQw8sAhQ1
         1fU0sT7XyVL6jNjSVhZjnJ/7G3BuBRZtXmaoT4Za8bsaCqrH6r8WAGerPNGrI7a5RkdX
         VtGKVJxXlcgT9My1nkvCbCMfYFYnd+pMbKXLSlY7HKli0+kfoKedfmAZwAkZuIUrIEE2
         XuKxWt1cYLHUimcsSFdRMNK9d6Smpwp/sZ4DXt27IBsbU8UrbpGLvn0wb01RePe0a8eg
         lVrSDTiB8Ekx5MRom1e0xY1SUhJ0sXoiJ67uMN9lnLf0E5R72iXvR7noeotmYAudXH2M
         xcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+9ArWl9WPscfCbVgoKL2Q96tnzkWovxeKRqbqmzl+E=;
        b=erj6PVJK43gpJ/KMrMD+nCoSfhJNHcgZ4IMmq2d5JvqnzNnW7Wm63piexBgXaN44Fg
         MaVeU+QbcXE3p8HXItkaTJmSKwIbfkVW/iHwLGN7+FKyVoHj1m9ccvIYfFFFFYZ+qYhe
         l/mKI7Ar2LyZcn0Xj4FCQsuTUKLgDj2LkZcO2mmW3UYo6tCEiB43MHL/ukmBA3460HFD
         C1Z1T4hCQHp7e27whDb/77VVBx2Qpja7b3ef5lrsyaHgtQ6JiagL2JRivAib44Oxlt1A
         bQx6KixommQ5wpvrY5nhuFFtzeK/WMndDKCtQloF8/8AZKtZnabu1GkQe0aofFwMk9UZ
         qDIA==
X-Gm-Message-State: APjAAAUzRKjecbkUmQ0RztD3y8HplDLs13fKvdPclnb1YUA3QzD5pqjO
        yWvus/yGawZuDsFSH7TY87SU+oXoHzy6UNfsz9fF9t6DWng=
X-Google-Smtp-Source: APXvYqyeC+ADosQs2ZXz+XREFLimM/NJinGAXTb6g/dhu9W+rABaBWFORF6/V5BpX93SMHFKn1QdPv54hgI+1c+Hdmg=
X-Received: by 2002:a63:78cf:: with SMTP id t198mr16810106pgc.82.1558706268593;
 Fri, 24 May 2019 06:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com> <20190524023520.GC1936@localhost.localdomain>
In-Reply-To: <20190524023520.GC1936@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 24 May 2019 22:57:36 +0900
Message-ID: <CAC5umyhCHJrzSSEy3NF38BhRQ9FSjVr8YfjChN-_3pVR5QwXsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8824=E6=97=A5(=E9=87=91) 11:35 Eduardo Valentin <edube=
zval@gmail.com>:
>
> Hello Mita,
>
> On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART =
/
> > Health log page (the composite temperature and temperature sensor 1 thr=
ough
> > temperature sensor 8).
>
> Is this a fixed number or we should be more flexible on the amount of
> sensors?

Max number is fixed.  In NVMe spec revision 1.3, a controller reports up
to nine temperature values in the SMART / Health information log.

It may change to more than nine in the future, but we can fix then.

> > The temperature threshold feature (Feature Identifier 04h) configures t=
he
> > asynchronous event request command to complete when the temperature is
> > crossed its corresponding temperature threshold.
> >
> > This adds infrastructure to provide these temperatures and thresholds v=
ia
> > thermal zone devices.
> >
> > The nvme_thermal_zones_register() creates up to nine thermal zone devic=
es
> > for all implemented temperature sensors including the composite
> > temperature.
>
> great!
>
> >
> > /sys/class/thermal/thermal_zone[0-*]:
> >     |---temp: Temperature
> >     |---trip_point_0_temp: Over temperature threshold
> >
> > The thermal_zone[0-*] contains a symlink to the corresponding nvme devi=
ce.
> > On the other hand, the following symlinks to the thermal zone devices a=
re
> > created in the nvme device sysfs directory.
> >
> > - nvme_temp0: Composite temperature
> > - nvme_temp1: Temperature sensor 1
> > ...
> > - nvme_temp8: Temperature sensor 8
> >
> > The nvme_thermal_zones_unregister() removes the registered thermal zone
> > devices and symlinks.
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> > Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> > Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> > * v2
> > - s/correspoinding/corresponding/ typo in commit log
> > - Borrowed nvme_get_features() from Keith's patch
> > - Temperature threshold notification is splitted into another patch
> > - Change the data type of 'sensor' to unsigned
> > - Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
> > - Add WARN_ON_ONCE for paranoid checks
> > - Fix off-by-one error in nvme_get_temp
> > - Validate 'sensor' where the value is actually used
> > - Define and utilize two enums related to the temperature threshold fea=
ture
> > - Remove hysteresis value for this trip point and don't utilize the und=
er
> >   temperature threshold
> > - Print error message for thermal_zone_device_register() failure
> > - Add function comments for nvme_thermal_zones_{,un}register
> > - Suppress non-fatal errors from nvme_thermal_zones_register()
> > - Add comment about implemented temperature sensors
> > - Instead of creating a new 'thermal_work', append async smart event's
> >   action to the existing async_event_work
> > - Add comment for tzdev member in nvme_ctrl
> >
> >  drivers/nvme/host/core.c | 265 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/nvme/host/nvme.h |  27 +++++
> >  include/linux/nvme.h     |   5 +
> >  3 files changed, 297 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index c04df80..0ec303c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2179,6 +2179,271 @@ static void nvme_set_latency_tolerance(struct d=
evice *dev, s32 val)
> >       }
> >  }
> >
> > +#ifdef CONFIG_THERMAL
> > +
> > +static int nvme_get_temp(struct nvme_ctrl *ctrl, unsigned int sensor, =
int *temp)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +
> > +     BUILD_BUG_ON(ARRAY_SIZE(log->temp_sensor) + 1 !=3D
> > +                  ARRAY_SIZE(ctrl->tzdev));
>
> When would this be triggered?

This just ensures that the temperature fields for the SMART log page
structure and nvme_ctrl are not changed accidentally.

> > +
> > +     if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
> > +             return -EINVAL;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
>
> Do we really need to allocate memory every time we want to read
> temperature? Is this struct too large to fit stack?

I think 512 bytes is too large in the kernel stack

> > +     if (!log)
> > +             return -ENOMEM;
> > +
> > +     ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > +                        log, sizeof(*log), 0);
> > +     if (ret) {
> > +             ret =3D ret > 0 ? -EINVAL : ret;
> > +             goto free_log;
> > +     }
> > +
> > +     if (sensor)
> > +             *temp =3D le16_to_cpu(log->temp_sensor[sensor - 1]);
> > +     else
> > +             *temp =3D get_unaligned_le16(log->temperature);
> > +
> > +     if (!*temp)
> > +             ret =3D -EINVAL;
> > +
> > +free_log:
> > +     kfree(log);
> > +
> > +     return ret;
> > +}
> > +
> > +static unsigned int nvme_tz_type_to_sensor(const char *type)
> > +{
> > +     unsigned int sensor;
> > +
> > +     if (sscanf(type, "nvme_temp%u", &sensor) !=3D 1)
> > +             return UINT_MAX;
> > +
> > +     return sensor;
> > +}
> > +
> > +#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10=
)
> > +#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5=
) / 10)
> > +
> > +static int nvme_tz_get_temp(struct thermal_zone_device *tzdev,
> > +                         int *temp)
> > +{
> > +     unsigned int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl =3D tzdev->devdata;
> > +     int ret;
> > +
> > +     ret =3D nvme_get_temp(ctrl, sensor, temp);
> > +     if (!ret)
> > +             *temp =3D KELVIN_TO_MILLICELSIUS(*temp);
> > +
> > +     return ret;
> > +}
> > +
> > +static int nvme_tz_get_trip_type(struct thermal_zone_device *tzdev,
> > +                              int trip, enum thermal_trip_type *type)
> > +{
> > +     *type =3D THERMAL_TRIP_ACTIVE;
> > +
> > +     return 0;
> > +}
> > +
> > +static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl,
> > +                                  unsigned int sensor, int *temp)
> > +{
> > +     unsigned int threshold =3D sensor << NVME_TEMP_THRESH_SELECT_SHIF=
T;
> > +     int status;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(sensor >=3D ARRAY_SIZE(ctrl->tzdev)))
> > +             return -EINVAL;
> > +
> > +     ret =3D nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold,=
 NULL, 0,
> > +                             &status);
> > +     if (!ret)
> > +             *temp =3D status & NVME_TEMP_THRESH_MASK;
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> > +                                  unsigned int sensor, int temp)
> > +{
> > +     unsigned int threshold =3D sensor << NVME_TEMP_THRESH_SELECT_SHIF=
T;
> > +     int status;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(sensor >=3D ARRAY_SIZE(ctrl->tzdev)))
> > +             return -EINVAL;
> > +
> > +     if (temp > NVME_TEMP_THRESH_MASK)
> > +             return -EINVAL;
> > +
> > +     threshold |=3D temp & NVME_TEMP_THRESH_MASK;
> > +
> > +     ret =3D nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold,=
 NULL, 0,
> > +                             &status);
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,
> > +                              int trip, int *temp)
> > +{
> > +     unsigned int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl =3D tzdev->devdata;
> > +     int ret;
> > +
> > +     ret =3D nvme_get_over_temp_thresh(ctrl, sensor, temp);
> > +     if (!ret)
> > +             *temp =3D KELVIN_TO_MILLICELSIUS(*temp);
> > +
> > +     return ret;
> > +}
> > +
> > +static int nvme_tz_set_trip_temp(struct thermal_zone_device *tzdev,
> > +                              int trip, int temp)
> > +{
> > +     unsigned int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl =3D tzdev->devdata;
> > +
> > +     temp =3D MILLICELSIUS_TO_KELVIN(temp);
> > +
> > +     return nvme_set_over_temp_thresh(ctrl, sensor, temp);
> > +}
> > +
> > +static struct thermal_zone_device_ops nvme_tz_ops =3D {
> > +     .get_temp =3D nvme_tz_get_temp,
> > +     .get_trip_type =3D nvme_tz_get_trip_type,
> > +     .get_trip_temp =3D nvme_tz_get_trip_temp,
> > +     .set_trip_temp =3D nvme_tz_set_trip_temp,
> > +};
> > +
> > +static struct thermal_zone_params nvme_tz_params =3D {
> > +     .governor_name =3D "user_space",
> > +     .no_hwmon =3D true,
> > +};
> > +
> > +static struct thermal_zone_device *
> > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor=
)
> > +{
> > +     struct thermal_zone_device *tzdev;
> > +     char type[THERMAL_NAME_LENGTH];
> > +     int ret;
> > +
> > +     snprintf(type, sizeof(type), "nvme_temp%d", sensor);
> > +
>
> Do we have something more meaningful or descriptive here? A more
> interesting type would be a string that could remind of the sensor
> location. Unless nvme_temp0 is enough to understand where this
> temperature is coming from, I would ask to get something more
> descriptive.

The SMART log page defines composite temperature and temperature sensor 1
through temperature sensor 8.  So I think nvme_temp1 to nvme_temp8 are
descriptive.  And I personally prefer 'nvme_temp0' rather than
'nvme_composite_temp'.

BTW, if we have more than two controllers, we'll have same type names
in the system.  So I'm going to append instance number after 'nvme'.
(e.g. nvme0_temp0).

> > +     tzdev =3D thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz=
_ops,
> > +                                          &nvme_tz_params, 0, 0);
>
> Have you considered if there is a use case for using of-thermal here?

Is it possible to specify the device node properties for the pci devices?
If so, of-thermal zone devices are very useful.

I think normal thermal zone devices and of-thermal zone devices can
co-exist. (i.e. add 'tzdev_of[9]' in nvme_ctrl and the operations are
almost same with the normal one)
