Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975CB38ED4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfFGPVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 11:21:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33282 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbfFGPVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 11:21:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1404314pfq.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oNhcytXWveMc1nWQXL0zsbU1lBhZzb+MlCG0A16RJKo=;
        b=eyvoLvzghHynrn1+OQBDCBIUIXbaDiLRNd6cJpHLPzTozwEPK/5GseynaQHAuy2d+w
         7miYvVloGp+LAE+ZVtQ8ej/BQdN8fmlJoOTgg//bX1gIkCILKVpGO1UlDKYh+XOECT1I
         WffQCHdhCw8pOfTgWsq9HCStKSwR28LHSFPXGMtR686QKZp/3hr69MSMzS1d0hOTSb5T
         KVmL34DnGXZBjYRMVZame93Z+7vfWMRVjqwc9S8TDq72G/Qi6rN8UTCy+5oIJOvYXgS6
         A6Tmem6DWhwYpPLLqJg4pU8s783e9UaPvK781Lh3Cqu3B9PW0xbmlcPegYUTyWVFH8U3
         sYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oNhcytXWveMc1nWQXL0zsbU1lBhZzb+MlCG0A16RJKo=;
        b=reRLXx3xa+CuKMf3qYGiEAxDGSVw3/LoqYSXk+/qosqSvWYxv/QLm34NHO0WhRZh61
         3b6R7JBeqOI9lNlg1IoNRKOjY1nUbZEisDyaL8Hap3nqh7RrRNW7WjTXADRfY3BEgLPp
         pzagMHQklGXBooqhZFhv3zLzglqwt+41Y562cPTNVifVw23d/B4FXXUplWNN5abuLjVC
         FwRlREdueHBDs3zXMdGxPhwaWTD2Cn3RbtgHgpDU3qkVF/YsU0f/Yj/Z3rmLfGzX+xvT
         yfHQK0FiMRBZ/Q4zNoDN35RFXnwDzUOw0eDf1Ti7CNy6OWrurz4f+se5e0B19ikVXkDG
         6Siw==
X-Gm-Message-State: APjAAAXorZ285GLOM587SRkbFmMoVyaE7tl8NKCfkIvVXrsFMFjVz7FZ
        CT4eKVQtFJ2VLKSV+S7UrDFFWGjSA4BB7ZuH+Io=
X-Google-Smtp-Source: APXvYqyHReH6jcihT1B/TsQx30br/y2rARxpg6BevwsP0DcCGDuoBVi8+DSDP3nR9p9TTOsyioNYygZN1uyO4rZzDwQ=
X-Received: by 2002:a62:585:: with SMTP id 127mr57713584pff.231.1559920883371;
 Fri, 07 Jun 2019 08:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190603023617.GA8567@localhost.localdomain> <CAC5umyj9V0sTD-ZsK6Q684wPdMpJGs434vDtZDm6a8gwoz3D7Q@mail.gmail.com>
 <20190606040506.GA1913@localhost.localdomain>
In-Reply-To: <20190606040506.GA1913@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 8 Jun 2019 00:21:12 +0900
Message-ID: <CAC5umyhx-Ger4ZGcEu+mDNxgPPBCBEROhAEODAKqSv_p9QRw4g@mail.gmail.com>
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

2019=E5=B9=B46=E6=9C=886=E6=97=A5(=E6=9C=A8) 13:05 Eduardo Valentin <edubez=
val@gmail.com>:

> > > > +static struct thermal_zone_params nvme_tz_params =3D {
> > > > +     .governor_name =3D "user_space",
> > >
> > > Also,
> > >
> > > Was there any particular reason why defaulting to user_space here?
> >
> > I only tested with the user_space governor.  There is no cooling device
> > to bind with this.
> >
>
> hmmm.. I see. But was there any particular reason to pick the thermal
> subsystem here if you do not have any cooling? Or is there any specific
> cooling that can be written in future?
>
> If no cooling is expected, why not a simple hwmon?

For example, we can use USB port powered cooling fan with USB hub that
supports per-port power switching.  It can be turned on and off by user
space tool.

> > > > +     .no_hwmon =3D true,
> > > > +};
> > > > +
> > > > +static struct thermal_zone_device *
> > > > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int se=
nsor)
> > > > +{
> > > > +     struct thermal_zone_device *tzdev;
> > > > +     char name[THERMAL_NAME_LENGTH];
> > > > +     int ret;
> > > > +
> > > > +     snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance,=
 sensor);
> > > > +
> > > > +     tzdev =3D thermal_zone_device_register(name, 1, 1, ctrl, &nvm=
e_tz_ops,
> > > > +                                          &nvme_tz_params, 0, 0);
> > > > +     if (IS_ERR(tzdev)) {
> > > > +             dev_err(ctrl->device,
> > > > +                     "Failed to register thermal zone device: %ld\=
n",
> > > > +                     PTR_ERR(tzdev));
> > > > +             return tzdev;
> > > > +     }
> > > > +
> > > > +     snprintf(name, sizeof(name), "temp%d", sensor);
> > > > +     ret =3D sysfs_create_link(&ctrl->ctrl_device.kobj, &tzdev->de=
vice.kobj,
> > > > +                             name);
> > > > +     if (ret)
> > > > +             goto device_unregister;
> > > > +
> > > > +     ret =3D sysfs_create_link(&tzdev->device.kobj,
> > > > +                             &ctrl->ctrl_device.kobj, "device");
> > > > +     if (ret)
> > > > +             goto remove_link;
> > > > +
> > > > +     return tzdev;
> > > > +
> > > > +remove_link:
> > > > +     sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> > > > +device_unregister:
> > > > +     thermal_zone_device_unregister(tzdev);
> > > > +
> > > > +     return ERR_PTR(ret);
> > > > +}
> > > > +
> > > > +/**
> > > > + * nvme_thermal_zones_register() - register nvme thermal zone devi=
ces
> > > > + * @ctrl: controller instance
> > > > + *
> > > > + * This function creates up to nine thermal zone devices for all i=
mplemented
> > > > + * temperature sensors including the composite temperature.
> > > > + * Each thermal zone device provides a single trip point temperatu=
re that is
> > > > + * associated with an over temperature threshold.
> > > > + */
> > > > +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > > +{
> > > > +     struct nvme_smart_log *log;
> > > > +     int ret;
> > > > +     int i;
> > > > +
> > > > +     log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> > > > +     if (!log)
> > > > +             return 0; /* non-fatal error */
> > >
> > > I am not sure about this API design here. I would leave the error
> > > handling and judging if this is fatal or not to the caller.
> > > I mean, if I ask to register a nvme thermal zone and I get
> > > a 0 as response, I would assume the thermal zone exists from
> > > now on, right?
> >
> > This routine is designed to return error code only when we're unable to
> > communicate with the device at all (i.e. nvme_submit_sync_cmd returns a
> > negative value).
> >
> > We don't want to abandon device initialization just due to thermal zone
> > failures.  Because thermal zone device isn't mandatory to manage the
> > controllers, and the device like qemu doesn't provide smart log (accord=
ing
> > to Keith).
>
> That is fair.. it is just really weird to continue your business when
> the kernel cannot even allocate memory for you..

Right.  The system is not unlikely to continue working properly when under
page size allocation with GFP_KERNEL is failed, unless fault injection for
allocation is enabled.
