Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C790E21A40
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfEQPDc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 11:03:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45810 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfEQPDc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 11:03:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so3803848pfm.12
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2019 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bpa5IRDaWH9sXJl/aEabEY9DCe09+HD4zaqj2HKoED8=;
        b=qOOESBdbzJt4KK3Ne509sVUKzDyae5zngU3OXXam4J631XY5LrwePBA/4laJd2jrIV
         apNoUPg7rVFXU1RXij1pbAtEetN+gMNKRzQGQED1OcTqnJPoOOEfatnpaq4zzYaJdwug
         +63prhEIbWU2GbXA0JhX6J1zqCiCT55hfIlOyXM+OW8UvJbU9MR2gaCp2sZB0JcUGj1t
         D/OuBQKgzb7c4ku8eR0D3UDv4/ZmYkFNT3Xi4DA+4wj4L37lOR84zSJJqrZu5hNAMYzM
         p1m5FyfASdz4fAu2XsthdMuUE4cQYXYKM6gSGFjGj/y/fn+U6GELyXKGPQb+qDqvui1V
         xp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bpa5IRDaWH9sXJl/aEabEY9DCe09+HD4zaqj2HKoED8=;
        b=D+/BWgmiiq9Obcg8BdQyt4US8PIcatLRy8mUA8hA6XUAkdaNRj+7uQ4zmRJV2jxfNg
         kHaNIc7DPj+IlJe6ha79uABayX5yYdh30+4YwnWdZs9NNPu+pkU+IrEUMYe8acmCJq78
         Pay9GqYFlqnmrwa6T79NEAB2Y5BSvfqwgN6vaLKsFxnV/AaUm/nZbq8SWEV5bpeD4Yqh
         M0VBaFMyspYSbBB73a+2pYmaqkZiax2NX0R78vpvIO7OSUYgZOF98gRD/Ppi+2pc+YoA
         1PwHnYuAGhLaK5GnJcG77Z1ht5uIvTd5mogq469xF2pwiIrlBZpAKyNH/4/3CDSOlrqT
         qbLg==
X-Gm-Message-State: APjAAAVR+pEpoMzOTrq8124tzIZ62tnBp2LtBzbJXKF5h2i6rptN9TfH
        IdvO3yUy5Q/qo7euvk1nM1CNDEaNXN2h2oyKZTk=
X-Google-Smtp-Source: APXvYqxbmoC59Lg6EZ84spXFCvkj8Jqc2HY+TahDcuSMkoc+sFn/JGYToPgSG+m/Ka+WutC5oobDuf0/a+MtHVApHtg=
X-Received: by 2002:aa7:9e51:: with SMTP id z17mr60518630pfq.212.1558105409847;
 Fri, 17 May 2019 08:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com> <dcb16af2-acb9-eff1-a2f9-ff8154381723@intel.com>
In-Reply-To: <dcb16af2-acb9-eff1-a2f9-ff8154381723@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 18 May 2019 00:03:18 +0900
Message-ID: <CAC5umyin1HBpvFRv4RsvWmccysimhcHbP7bs12EcZ5-KZ4PwgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
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

2019=E5=B9=B45=E6=9C=8817=E6=97=A5(=E9=87=91) 6:25 Heitke, Kenneth <kenneth=
.heitke@intel.com>:
>
>
>
> On 5/15/2019 9:17 AM, Akinobu Mita wrote:
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
> >      |---temp: Temperature
> >      |---trip_point_0_temp: Over temperature threshold
> >      |---trip_point_0_hyst: Under temperature threshold
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
> >   drivers/nvme/host/core.c | 368 ++++++++++++++++++++++++++++++++++++++=
++++++++-
> >   drivers/nvme/host/nvme.h |  24 ++++
> >   include/linux/nvme.h     |   4 +
> >   3 files changed, 392 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 172551b..a915c6b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > +
> > +static int nvme_tz_type_to_sensor(const char *type)
> > +{
> > +     int sensor;
> > +
> > +     if (sscanf(type, "nvme_temp%d", &sensor) !=3D 1)
> > +             return -EINVAL;
> > +
> > +     if (sensor < 0 || sensor > 8)
> > +             return -EINVAL;
> > +
> > +     return sensor;
> > +}
>
> I know this has been discussed but it bothers me that this can return a
> negative (error code) but then the callers of this function don't check
> for errors. If you can prevent the error conditions, can 'sensor' be
> treated as unsigned?

Sounds good.
