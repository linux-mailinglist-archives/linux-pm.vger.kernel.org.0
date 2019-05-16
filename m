Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8FD20CC1
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEPQRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 12:17:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41870 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfEPQRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 12:17:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so1856861plt.8
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iaFOYIFbVpbw+6XUgU61OzgNPZLuP3GZi6S4US8gUZo=;
        b=U9SJfZKAwgBiuX6ynF0cX7Ztrz4uQd60V16j6+t6o2XZMFmJmxEHfcqW7MkAbzkvam
         lwmOpr663XB8tdqjdgoUqM+kv1z7Yjiz983/noNMd9Y8nnEAnZGgioC6pxbt5Qu16btG
         xDUdZBMlxAj2xUfHztYg89vjqW5UV+T0rW9TV/pVkhRoU7aJ2o0AFtfgGYve/n8/FeiQ
         UKSmXfBlHkSFXk5bsyRxeTCfpKTJugdnDG11EvMbKPm9AUfL99pprQ0Q1lLCk4AqIM2Z
         JnTQ9aXK4SwMzxEz5ChubuCk+TyAm/qRvXk1WblMeemCqTrbZdC4aOiJ1dvBhj32QDFP
         w12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iaFOYIFbVpbw+6XUgU61OzgNPZLuP3GZi6S4US8gUZo=;
        b=Np70RFkFLZO24lxvTtFUwT1wdaYk4kfJEq4p2yDVNivCehMQXvIBTiOn4lPWEnvdKt
         9ZSX2y7aJpbg9jAhJUPtlMTTybBalf3yp82v1a6wifDd5BlS0/QKi3cKD1PWEHqfJXhi
         YnOpcf+TnYzoQdqZ4nDs+Eg5e+VQ2hq2/yvoEabztVC1+alLr9/NL8bgpfil6/4ZxYhS
         uEfzUkVJIVKVyo+vytyho28QejBd67BoaCwEtZn8p9cZYKXg8RBEI4sY6MZyapYfBgRQ
         5PCgB9TFY4EcyySIhk6tXDEJNMJvb/9DSNHPj2hT7dOO2OUXEzm1ctJvh+w7y3SdFu5L
         pDJQ==
X-Gm-Message-State: APjAAAWsMZP9cK0ewiKRoWNFl2a/WoEK2Ej4dJxbRP/jUsQuy0TdbBvr
        YFeJxigZ7RrZjdgWYzAmVCglf0ta0oU+7hSJ3r0=
X-Google-Smtp-Source: APXvYqx4BUpxgzgmHT9qlLYlac1CzS27MBcn84Mbe8OWzM0OWDiRVuA2zBw5YKsL5biCSNVqcsxJwCkptSUb1wMJvTo=
X-Received: by 2002:a17:902:b094:: with SMTP id p20mr29122022plr.164.1558023463210;
 Thu, 16 May 2019 09:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com> <20190516143212.GE24001@minwooim-desktop>
In-Reply-To: <20190516143212.GE24001@minwooim-desktop>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 17 May 2019 01:17:31 +0900
Message-ID: <CAC5umyjxxWzCgyMOS=Q7BBBJY+n6xD1dg49fQ0W5okPh58Z1Kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
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

2019=E5=B9=B45=E6=9C=8816=E6=97=A5(=E6=9C=A8) 23:32 Minwoo Im <minwoo.im.de=
v@gmail.com>:
>
> > +     if (sensor < 0 || sensor > 8)
> > +             return -EINVAL;
>
> Does we really need to check the negative case here ?  Am I missing
> something in this context ?  If we really want to check it in this
> level, can we check the invalid case in the following function?

The negative case should never happen, so it can be just removed.

> > +static struct thermal_zone_device *
> > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)
> > +{
> > +     struct thermal_zone_device *tzdev;
> > +     char type[THERMAL_NAME_LENGTH];
> > +     int ret;
> > +
> > +     snprintf(type, sizeof(type), "nvme_temp%d", sensor);
>
> Before preparing "nvme_temp%d", maybe we can make it sure here. :)
> What do you say?

The nvme_thermal_zone_register() is only called from
nvme_thermal_zones_register() which is defined just below, and it's very
clear that the value of 'sensor' is from 0 to ARRAY_SIZE(ctrl->tzdev) - 1.

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
> > +             if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> > +                     continue;
> > +             if (ctrl->tzdev[i])
> > +                     continue;
> > +
> > +             tzdev =3D nvme_thermal_zone_register(ctrl, i);
> > +             if (!IS_ERR(tzdev))
> > +                     ctrl->tzdev[i] =3D tzdev;
>
> Quenstion here. Are we okay not to print some warnings here in case
> of error returned?

I'm going to print warning in case of thermal_zone_device_register() error.
For sysfs_create_link() error, the warning is printed by the function
itself.
