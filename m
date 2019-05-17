Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372A421AB8
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfEQPft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 11:35:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45211 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfEQPft (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 11:35:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so3454903pgi.12
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2019 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RxAkuma/VPx+aJP96bA7TY9c60YXBgsYK8EsT243noM=;
        b=GEA1UOicD++Qa5sAqNUKSGcMefMdZvDS6EM/OzW4BMzKltc+rWFZ2U68DnhOfZgtFr
         2I3tMo6v3iMqqklw3kzgdfRlKhGm3uw6indLXgGtpKwyzEVZgEnGoxVuad1bOwOjpF+X
         4MRhqnm3Wqgi68rNjF3rkwQXzD/9RNHvz+1DawmZTGuuQGnCf3h7Gacb9zcpmEDyuhpt
         I3afXe8FuKYjPTOPbHPj0pqM8SIM4ftwBjweu0rwWDMwoIqiCTjnQNNksxjEkhbEvmqT
         ctLB7ipeCCirRduS2UDSkpsXhw3CXmJ4Z0oMTpczaGOTU6XEeswjgGwbTPKwBGHpcfAX
         KZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RxAkuma/VPx+aJP96bA7TY9c60YXBgsYK8EsT243noM=;
        b=dNh2+z0qC0Jwo9bJIDqQcoDiiL6cmRKNofabyJm4mbNsqsYM0s25YaleyQYAt9v+9B
         YOxYg9A29MLoBOYE2ylYYiCALubGrR25eWAdWrns+VBB2gG2uFxlDpDRLMUhyw/pPB6S
         AbDCpFD4Qc2RR0YG7iuiaE86fKJmDCKQRHmoQhInga4jBKmemFpkiWQEPsVLM79yVGgF
         qy0cu+3eKfAclX1Wi/RDIpDYng3klK6onlQhu0C9ebpAc0Yr/a1mJlgTRZFObJ3L5OCK
         5nseTpay7ZvnBT0q5GiyE2zVvLfoGElA/CduckrG93QwJoJI+66tc4pUZvNJFyjMnULo
         Sp0Q==
X-Gm-Message-State: APjAAAUGKcGiLt6DL5wx3w3B5Xhsa71ZPt6lPB5v47cT06bZThi+YgBJ
        sTgBIDZWcqbEAXt4x3VHcCVLNuugYxBp+gi56w4=
X-Google-Smtp-Source: APXvYqwxf3hR/62HbBtjGQP9QRdie2RzQbYskAE7lSYQN7WMChsTBLXXvEFcbm9lTBX4MnIV6DPLZg5WnDzqcFdUHjg=
X-Received: by 2002:a63:930d:: with SMTP id b13mr46170363pge.18.1558107348194;
 Fri, 17 May 2019 08:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com> <DM6PR04MB4521D53A9243977EF0B1EE2B860A0@DM6PR04MB4521.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB4521D53A9243977EF0B1EE2B860A0@DM6PR04MB4521.namprd04.prod.outlook.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 18 May 2019 00:35:36 +0900
Message-ID: <CAC5umyhePjJf5=8Kk4-ewfZVEXCz0aKX=b1pTyXyJ1FJd5FyVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8817=E6=97=A5(=E9=87=91) 8:44 Chaitanya Kulkarni <Chai=
tanya.Kulkarni@wdc.com>:
>
> Thanks Akinobu for this work, please see some nit comments.
>
> On 5/15/19 8:18 AM, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART =
/
> > Health log page (the composite temperature and temperature sensor 1 thr=
ough
> > temperature sensor 8).
> > The temperature threshold feature (Feature Identifier 04h) configures t=
he
> > asynchronous event request command to complete when the temperature is
> > crossed its correspoinding temperature threshold.
> >
> > This adds infrastructure to provide these temperatures and thresholds v=
ia
> > thermal zone devices.
> >
> > The nvme_thermal_zones_register() creates up to nine thermal zone devic=
es
> > for valid temperature sensors including composite temperature.
> >
> > /sys/class/thermal/thermal_zone[0-*]:
> >     |---temp: Temperature
> >     |---trip_point_0_temp: Over temperature threshold
> >     |---trip_point_0_hyst: Under temperature threshold
> >
> > The thermal_zone[0-*] contains a symlink to the correspoinding nvme dev=
ice.
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
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  drivers/nvme/host/core.c | 368 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  drivers/nvme/host/nvme.h |  24 ++++
> >  include/linux/nvme.h     |   4 +
> >  3 files changed, 392 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 172551b..a915c6b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1113,15 +1113,16 @@ static struct nvme_id_ns *nvme_identify_ns(stru=
ct nvme_ctrl *ctrl,
> >       return id;
> >  }
> >
> > -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsi=
gned dword11,
> > -                   void *buffer, size_t buflen, u32 *result)
> > +static int nvme_features(struct nvme_ctrl *dev, u8 opcode, unsigned in=
t fid,
> > +                      unsigned int dword11, void *buffer, size_t bufle=
n,
> > +                      u32 *result)
> >  {
> >       struct nvme_command c;
> >       union nvme_result res;
> >       int ret;
> >
> >       memset(&c, 0, sizeof(c));
> > -     c.features.opcode =3D nvme_admin_set_features;
> > +     c.features.opcode =3D opcode;
> >       c.features.fid =3D cpu_to_le32(fid);
> >       c.features.dword11 =3D cpu_to_le32(dword11);
> >
> > @@ -1132,6 +1133,22 @@ static int nvme_set_features(struct nvme_ctrl *d=
ev, unsigned fid, unsigned dword
> >       return ret;
> >  }
> >
> > +static int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
> > +                          unsigned int dword11, void *buffer, size_t b=
uflen,
> > +                          u32 *result)
>
> 1. nit:- can we align the start of the line to start of the character
> and not to the (.

This just looks unaligned in the patch form becuase of the leading '+'.

> +static int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
> +                             unsigned int dword11, void *buffer, size_t =
buflen,
> +                             u32 *result)
>
> > +{
> > +     return nvme_features(dev, nvme_admin_get_features, fid, dword11, =
buffer,
> > +                          buflen, result);
> > +}
> > +
> > +static int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
> > +                          unsigned int dword11, void *buffer, size_t b=
uflen,
> > +                          u32 *result)
> > +{
> > +     return nvme_features(dev, nvme_admin_set_features, fid, dword11, =
buffer,
> > +                          buflen, result);
> > +}
> > +
> I think above code change should go into the prep patch.

OK.

> >  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
> >  {
> >       u32 q_count =3D (*count - 1) | ((*count - 1) << 16);
> > @@ -1168,6 +1185,9 @@ static void nvme_enable_aen(struct nvme_ctrl *ctr=
l)
> >       u32 result, supported_aens =3D ctrl->oaes & NVME_AEN_SUPPORTED;
> >       int status;
> >
> > +     if (IS_ENABLED(CONFIG_THERMAL))
> > +             supported_aens |=3D NVME_SMART_CRIT_TEMPERATURE;
> > +
> >       if (!supported_aens)
> >               return;
> >
> > @@ -2164,6 +2184,334 @@ static void nvme_set_latency_tolerance(struct d=
evice *dev, s32 val)
> >       }
> >  }
> >
> > +#ifdef CONFIG_THERMAL
> > +
> > +static int nvme_get_temp(struct nvme_ctrl *ctrl, int sensor, int *temp=
)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +
> > +     if (sensor >=3D ARRAY_SIZE(log->temp_sensor))
> Can we add a print warn or error message here ?

OK.  I'll add WARN_ON_ONCE.

> > +             return -EINVAL;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
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
> > +static int nvme_tz_type_to_sensor(const char *type)
> > +{
> > +     int sensor;
> > +
> > +     if (sscanf(type, "nvme_temp%d", &sensor) !=3D 1)
> > +             return -EINVAL;
> > +
> > +     if (sensor < 0 || sensor > 8)
>
> nit:- please avoid using hard coded value 8 in the above, can we please
> define
>
> a macro in nvme.h ?

I'm going to remove this range check.  Instead, the range check will
be done with ARRAY_SIZE(ctrl->tzdev) where the value is actually used
(i.e. in nvme_get_temp() and nvme_{get,set}_over_temp_thresh())

> > +             return -EINVAL;
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
> > +     int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
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
> > +static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bo=
ol under,
> > +                             int *temp)
> > +{
> > +     unsigned int threshold =3D sensor << 16;
> > +     int status;
> > +     int ret;
> > +
> > +     if (under)
> > +             threshold |=3D 0x100000;
> hardcoded value, possible macro ?

This line will be removed, because the under temperature threshold will
not be used in the next version.

> > +
> > +     ret =3D nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold,=
 NULL, 0,
> > +                             &status);
> > +     if (!ret)
> > +             *temp =3D status & 0xffff;
> hardcoded value, possible macro ?

OK. I'll add two enums:

enum {
        NVME_TEMP_THRESH_MASK =3D 0xffff,
        NVME_TEMP_THRESH_SELECT_SHIFT =3D 16,
};

> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl, int senso=
r,
> > +                                  int *temp)
> > +{
> > +     return nvme_get_temp_thresh(ctrl, sensor, false, temp);
> > +}
> > +
> > +static int nvme_get_under_temp_thresh(struct nvme_ctrl *ctrl, int sens=
or,
> > +                                  int *temp)
> > +{
> > +     return nvme_get_temp_thresh(ctrl, sensor, true, temp);
> > +}
> > +
> > +static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bo=
ol under,
> > +                             int temp)
> > +{
> > +     unsigned int threshold =3D (sensor << 16) | temp;
> > +     int status;
> > +     int ret;
> > +
> > +     if (temp > 0xffff)
> > +             return -EINVAL;
> > +
> > +     if (under)
> > +             threshold |=3D 0x100000;
> > +
> > +     ret =3D nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold,=
 NULL, 0,
> > +                             &status);
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl, int senso=
r,
> > +                                  int temp)
> > +{
> > +     return nvme_set_temp_thresh(ctrl, sensor, false, temp);
> > +}
> > +
> > +static int nvme_set_under_temp_thresh(struct nvme_ctrl *ctrl, int sens=
or,
> > +                                  int temp)
> > +{
> > +     return nvme_set_temp_thresh(ctrl, sensor, true, temp);
> > +}
> > +
> > +static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,
> > +                              int trip, int *temp)
> > +{
> > +     int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
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
> > +     int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl =3D tzdev->devdata;
> > +     int ret;
> > +
> > +     temp =3D MILLICELSIUS_TO_KELVIN(temp);
> > +
> > +     ret =3D nvme_set_over_temp_thresh(ctrl, sensor, temp);
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_tz_get_trip_hyst(struct thermal_zone_device *tzdev,
> > +                              int trip, int *hyst)
> > +{
> > +     int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl =3D tzdev->devdata;
> > +     int ret;
> > +
> > +     ret =3D nvme_get_under_temp_thresh(ctrl, sensor, hyst);
> > +     if (!ret)
> > +             *hyst =3D KELVIN_TO_MILLICELSIUS(*hyst);
> > +
> > +     return ret;
> > +}
> > +
> > +static int nvme_tz_set_trip_hyst(struct thermal_zone_device *tzdev,
> > +                              int trip, int hyst)
> > +{
> > +     int sensor =3D nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl =3D tzdev->devdata;
> > +     int ret;
> > +
> > +     hyst =3D MILLICELSIUS_TO_KELVIN(hyst);
> > +
> > +     ret =3D nvme_set_under_temp_thresh(ctrl, sensor, hyst);
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static struct thermal_zone_device_ops nvme_tz_ops =3D {
> > +     .get_temp =3D nvme_tz_get_temp,
> > +     .get_trip_type =3D nvme_tz_get_trip_type,
> > +     .get_trip_temp =3D nvme_tz_get_trip_temp,
> > +     .set_trip_temp =3D nvme_tz_set_trip_temp,
> > +     .get_trip_hyst =3D nvme_tz_get_trip_hyst,
> > +     .set_trip_hyst =3D nvme_tz_set_trip_hyst,
> > +};
> > +
> > +static struct thermal_zone_params nvme_tz_params =3D {
> > +     .governor_name =3D "user_space",
> > +     .no_hwmon =3D true,
> > +};
> > +
> > +static struct thermal_zone_device *
> > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)
> > +{
> > +     struct thermal_zone_device *tzdev;
> > +     char type[THERMAL_NAME_LENGTH];
> > +     int ret;
> > +
> > +     snprintf(type, sizeof(type), "nvme_temp%d", sensor);
> > +
> > +     tzdev =3D thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz=
_ops,
> > +                                          &nvme_tz_params, 0, 0);
> The trips and type values should be #defined with a nice comment.

I'm going to add comment that explains this trip point.

> > +     if (IS_ERR(tzdev))
> > +             return tzdev;
> > +
> > +     ret =3D sysfs_create_link(&ctrl->ctrl_device.kobj,
> > +                             &tzdev->device.kobj, type);
> > +     if (ret)
> > +             goto device_unregister;
> > +
> > +     ret =3D sysfs_create_link(&tzdev->device.kobj,
> > +                             &ctrl->ctrl_device.kobj, "device");
> > +     if (ret)
> > +             goto remove_link;
> > +
> > +     return tzdev;
> > +
> > +remove_link:
> > +     sysfs_remove_link(&ctrl->ctrl_device.kobj, type);
> > +device_unregister:
> > +     thermal_zone_device_unregister(tzdev);
> > +
> > +     return ERR_PTR(ret);
> > +}
> > +
> > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +     int i;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
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
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev;
> > +
> nit:- a comment will be useful here.

OK.

 /*
 * All implemented temperature sensors report a non-zero value
 * in temperature sensor fields in the smart log page.
 */

> > +             if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> > +                     continue;
> > +             if (ctrl->tzdev[i])
> > +                     continue;
> > +
> > +             tzdev =3D nvme_thermal_zone_register(ctrl, i);
> > +             if (!IS_ERR(tzdev))
> > +                     ctrl->tzdev[i] =3D tzdev;
> > +     }
> > +
> > +free_log:
> > +     kfree(log);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_thermal_zones_register);
> > +
> > +void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev =3D ctrl->tzdev[i];
> > +
> > +             if (!tzdev)
> > +                     continue;
> > +
> > +             sysfs_remove_link(&tzdev->device.kobj, "device");
> > +             sysfs_remove_link(&ctrl->ctrl_device.kobj, tzdev->type);
> > +             thermal_zone_device_unregister(tzdev);
> > +
> > +             ctrl->tzdev[i] =3D NULL;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_thermal_zones_unregister);
> > +
> > +static void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)
> > +{
> > +     queue_work(nvme_wq, &ctrl->thermal_work);
> > +}
> > +
> > +static void nvme_thermal_work(struct work_struct *work)
> > +{
> > +     struct nvme_ctrl *ctrl =3D
> > +             container_of(work, struct nvme_ctrl, thermal_work);
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             if (ctrl->tzdev[i])
> > +                     thermal_notify_framework(ctrl->tzdev[i], 0);
> > +     }
> > +}
> > +
> > +static void nvme_thermal_init(struct nvme_ctrl *ctrl)
> > +{
> > +     INIT_WORK(&ctrl->thermal_work, nvme_thermal_work);
> > +}
> > +
> > +#else
> > +
> > +static void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)
> > +{
> > +}
> > +
> > +static void nvme_thermal_init(struct nvme_ctrl *ctrl)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_THERMAL */
> > +
> >  struct nvme_core_quirk_entry {
> >       /*
> >        * NVMe model and firmware strings are padded with spaces.  For
> > @@ -3630,6 +3978,14 @@ static void nvme_handle_aen_notice(struct nvme_c=
trl *ctrl, u32 result)
> >       }
> >  }
> >
> nit:- I think AEN modification code needs to be split into different patc=
h.

OK.

> > +static void nvme_handle_aen_smart(struct nvme_ctrl *ctrl, u32 result)
> > +{
> > +     u32 aer_smart_type =3D (result & 0xff00) >> 8;
> > +
> > +     if (aer_smart_type =3D=3D NVME_AER_SMART_TEMP_THRESH)
> > +             nvme_thermal_notify_framework(ctrl);
> > +}
> > +
> >  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
> >               volatile union nvme_result *res)
> >  {
> > @@ -3643,8 +3999,10 @@ void nvme_complete_async_event(struct nvme_ctrl =
*ctrl, __le16 status,
> >       case NVME_AER_NOTICE:
> >               nvme_handle_aen_notice(ctrl, result);
> >               break;
> > -     case NVME_AER_ERROR:
> >       case NVME_AER_SMART:
> > +             nvme_handle_aen_smart(ctrl, result);
> > +             /* fallthrough */
> > +     case NVME_AER_ERROR:
> >       case NVME_AER_CSS:
> >       case NVME_AER_VS:
> >               trace_nvme_async_event(ctrl, aer_type);
> > @@ -3776,6 +4134,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
> >       dev_pm_qos_update_user_latency_tolerance(ctrl->device,
> >               min(default_ps_max_latency_us, (unsigned long)S32_MAX));
> >
> > +     nvme_thermal_init(ctrl);
> > +
> >       return 0;
> >  out_free_name:
> >       kfree_const(ctrl->device->kobj.name);
> Also, definitions and data structures updates should go into the
> different patch prep patch.
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 7f6f1fc..ff7bd8f 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/sed-opal.h>
> >  #include <linux/fault-inject.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/thermal.h>
> >
> >  extern unsigned int nvme_io_timeout;
> >  #define NVME_IO_TIMEOUT      (nvme_io_timeout * HZ)
> > @@ -248,6 +249,11 @@ struct nvme_ctrl {
> >
> >       struct page *discard_page;
> >       unsigned long discard_page_busy;
> > +
> > +#ifdef CONFIG_THERMAL
> Add a macro here for tzdev[9] or refer to spec.

I'll add comment about which index of tzdev is corresponding to
which temperature sensor or composite temperature.

> > +     struct thermal_zone_device *tzdev[9];
> > +     struct work_struct thermal_work;
> > +#endif
> >  };
