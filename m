Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5877C3335B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfFCPUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 11:20:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41671 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfFCPUb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 11:20:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so1650678pgg.8
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2019 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+s/wJ4ZBt8nmKn36qbF2lnyqicBE+YKaBbz8WxaNO8=;
        b=aFzlHpYnvJXVA6d+n+VXppRnSf/l/VfQJFkaYbYS4jlPoamW+hLcQuGEW5JJ3oXN9p
         nDrf5ArrqB1zooH3IMx7+QExhHMBJ5iE1BGsgoT7eV0Y20cFQ+6c5P14OjqdEHT4Ls75
         fHm+cjH7a8KrmhxT7TEJEVmXi2XG4ru1hTy60aR4xv9WIe2hA9HQPIQgM6nozM8ayIdN
         Hj8nJC3OwAuN0aqBvLZoS2YxMMYWb6sodvhMSDl0V/XKWcc2fNDpMVv68l0fFk9tcHmh
         1S5J/KI0St9fzYwF/gs73CPtdbCuCM2rUnUZuj2ux3/6391hNd31Gt/LhWMQxT4jqgOU
         BydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V+s/wJ4ZBt8nmKn36qbF2lnyqicBE+YKaBbz8WxaNO8=;
        b=b56t50rDVu895TKJLQWQhGOiqoJQa0qUyrCG2EZhjjpbho6W+E/s7LDSp/JRV0Jn65
         siV3jBt/DTGPqy0arpWBQhYdDKHMp0tcObXXv0QKgddMNXfVs0bOltQRIcumTKN4BwNh
         w3xaMbVB4l3jwW/X9ZeQnKcQthZgKLUNvJkQ+uRExCfomdf698l7TXnzwVwgrWd8mOYj
         cTXS0Rz7lntG/SxfWXPBWpNhx1E5mTll5BPmtqVLEwCLGeMk6C8UNismPBAnLpOKPhOz
         GiOleFEDjcpJJcKgpObjRjYQAeo5e53kDphbWEj/B0Moe5L59QdzxkSEJ+vSdAz1dPBB
         W64Q==
X-Gm-Message-State: APjAAAW3JoiFEz9UZJgEeDYCXRPViwu5/gYFVqEUwZpFtSWNzlRf7Pb3
        8Dm2vsqhqhQXrE9WAroGQZGIrTHn37V/pR8tdHc=
X-Google-Smtp-Source: APXvYqzQR9/udvAKSwXg54NOk2aqdam7tOLm6WksKtI2XctncK8mQbDCkCko4w+pVHJyo7Nk/aObxqzW0WPMNjVOcKc=
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr9485973pjb.115.1559575230833;
 Mon, 03 Jun 2019 08:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com> <20190603023617.GA8567@localhost.localdomain>
In-Reply-To: <20190603023617.GA8567@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 4 Jun 2019 00:20:19 +0900
Message-ID: <CAC5umyj9V0sTD-ZsK6Q684wPdMpJGs434vDtZDm6a8gwoz3D7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
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

2019=E5=B9=B46=E6=9C=883=E6=97=A5(=E6=9C=88) 11:36 Eduardo Valentin <edubez=
val@gmail.com>:
>
> Hey Mita,
>
> On Mon, May 27, 2019 at 01:29:02AM +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART =
/
> > Health log page (the composite temperature and temperature sensor 1 thr=
ough
> > temperature sensor 8).
> >
> > This provides these temperatures via thermal zone devices.
> >
> > Once the controller is identified, the thermal zone devices are created=
 for
> > all implemented temperature sensors including the composite temperature=
.
> >
> > /sys/class/thermal/thermal_zone[0-*]:
> >     |---type: 'nvme<instance>-temp<sensor>'
> >     |---temp: Temperature
> >     |---trip_point_0_temp: Over temperature threshold
> >
> > The thermal_zone[0-*] contains a 'device' symlink to the corresponding =
nvme
> > device.
> >
> > On the other hand, the following symlinks to the thermal zone devices a=
re
> > created in the nvme device sysfs directory.
> >
> > - temp0: Composite temperature
> > - temp1: Temperature sensor 1
> > ...
> > - temp8: Temperature sensor 8
> >
>
> These questions on V2 are still unanswered:
> a. Can we get a more descriptive string into tz->type?

As I said in the other thread, the NVMe spec only says a controller
reports the composite temperature and temperature sensor 1 through 8.
What temperature sensor N means is vendor specific.

> b. Can these APIs support DT probing too?

OK. I can try, but I don't have arm or arm64 boards with PCIe for
testing with of-thermal.  So it'll be untested.

> > +static struct thermal_zone_params nvme_tz_params =3D {
> > +     .governor_name =3D "user_space",
>
> Also,
>
> Was there any particular reason why defaulting to user_space here?

I only tested with the user_space governor.  There is no cooling device
to bind with this.

> > +     .no_hwmon =3D true,
> > +};
> > +
> > +static struct thermal_zone_device *
> > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor=
)
> > +{
> > +     struct thermal_zone_device *tzdev;
> > +     char name[THERMAL_NAME_LENGTH];
> > +     int ret;
> > +
> > +     snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sen=
sor);
> > +
> > +     tzdev =3D thermal_zone_device_register(name, 1, 1, ctrl, &nvme_tz=
_ops,
> > +                                          &nvme_tz_params, 0, 0);
> > +     if (IS_ERR(tzdev)) {
> > +             dev_err(ctrl->device,
> > +                     "Failed to register thermal zone device: %ld\n",
> > +                     PTR_ERR(tzdev));
> > +             return tzdev;
> > +     }
> > +
> > +     snprintf(name, sizeof(name), "temp%d", sensor);
> > +     ret =3D sysfs_create_link(&ctrl->ctrl_device.kobj, &tzdev->device=
.kobj,
> > +                             name);
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
> > +     sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> > +device_unregister:
> > +     thermal_zone_device_unregister(tzdev);
> > +
> > +     return ERR_PTR(ret);
> > +}
> > +
> > +/**
> > + * nvme_thermal_zones_register() - register nvme thermal zone devices
> > + * @ctrl: controller instance
> > + *
> > + * This function creates up to nine thermal zone devices for all imple=
mented
> > + * temperature sensors including the composite temperature.
> > + * Each thermal zone device provides a single trip point temperature t=
hat is
> > + * associated with an over temperature threshold.
> > + */
> > +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +     int i;
> > +
> > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> > +     if (!log)
> > +             return 0; /* non-fatal error */
>
> I am not sure about this API design here. I would leave the error
> handling and judging if this is fatal or not to the caller.
> I mean, if I ask to register a nvme thermal zone and I get
> a 0 as response, I would assume the thermal zone exists from
> now on, right?

This routine is designed to return error code only when we're unable to
communicate with the device at all (i.e. nvme_submit_sync_cmd returns a
negative value).

We don't want to abandon device initialization just due to thermal zone
failures.  Because thermal zone device isn't mandatory to manage the
controllers, and the device like qemu doesn't provide smart log (according
to Keith).

> > +
> > +     ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > +                        log, sizeof(*log), 0);
> > +     if (ret) {
> > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", re=
t);
> > +             /* If the device provided a response, then it's non-fatal=
 */
> > +             if (ret > 0)
> > +                     ret =3D 0;
> > +             goto free_log;
>
> Once again, hiding errors is never a strategy that scales..
>
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev;
> > +             int temp;
> > +
> > +             if (i)
> > +                     temp =3D le16_to_cpu(log->temp_sensor[i - 1]);
> > +             else
> > +                     temp =3D get_unaligned_le16(log->temperature);
> > +
> > +             /*
> > +              * All implemented temperature sensors report a non-zero =
value
> > +              * in temperature sensor fields in the smart log page.
> > +              */
> > +             if (!temp)
> > +                     continue;
> > +             if (ctrl->tzdev[i])
> > +                     continue;
> > +
> > +             tzdev =3D nvme_thermal_zone_register(ctrl, i);
> > +             if (!IS_ERR(tzdev))
> > +                     ctrl->tzdev[i] =3D tzdev;
>
> Here again, I would not hide errors, the API should propagate errors
> if something goes wrong.
>
> > +     }
> > +
> > +free_log:
> > +     kfree(log);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devi=
ces
> > + * @ctrl: controller instance
> > + *
> > + * This function removes the registered thermal zone devices and symli=
nks.
> > + */
> > +static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > +             struct thermal_zone_device *tzdev =3D ctrl->tzdev[i];
> > +             char name[20];
> > +
> > +             if (!tzdev)
> > +                     continue;
> > +
> > +             sysfs_remove_link(&tzdev->device.kobj, "device");
> > +
> > +             snprintf(name, sizeof(name), "temp%d", i);
> > +             sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> > +
> > +             thermal_zone_device_unregister(tzdev);
> > +
> > +             ctrl->tzdev[i] =3D NULL;
> > +     }
> > +}
> > +
> > +#else
> > +
> > +static inline int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctr=
l)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_THERMAL */
> > +
> >  struct nvme_core_quirk_entry {
> >       /*
> >        * NVMe model and firmware strings are padded with spaces.  For
> > @@ -2754,6 +3037,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >       if (ret < 0)
> >               return ret;
> >
> > +     ret =3D nvme_thermal_zones_register(ctrl);
> > +     if (ret < 0)
> > +             return ret;
>
>
> I would definitely keep this code the way it is here in
> nvme_init_identify(), but if I read this right, your
> nvme_thermal_zones_register() will never return < 0, and therefore this
> condition is never met.

The nvme_get_log() can return a negative value.  Only in this case,
nvme_thermal_zones_register() returns error and abandon the device
initialization.
