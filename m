Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F255304
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfFYPOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 11:14:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34236 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbfFYPOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 11:14:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so9009144plt.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AiypwnEqHIwqKwf+R3e2H+Rvy6WR//fHScn0AOjLw3I=;
        b=NDRmLkfny2mQ3nvxayJ7eaEca9oIVcQ4nQ9M3VhZUBTSbB/iY1QTCI1dx6mMj8u0Bz
         GdZELXPDhuKZH2+sZYF5dyN9exNwRjBrm65bzwcppCIxdUnt+9fcoFqdQ3/6sNRchzd2
         iFKJGz2TeYxUrPJodB8FS74kHzVdkpGNLOmGQHedvXs9pTDjDPaGznEbGWpoUAG8EbSh
         mYuowhQfT9sU8mSw2EAwmvyd0rcrxP7k5uWfEqGCVbLzudvBeWNFbjFXcUxqRDeCAeQZ
         EWoJKM6OvuCLeUsyGoVSox+tJKlpr2HfVuDfJIOr/c+s6VTUh8J2DL5GAH/MSQnmTbzY
         06GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AiypwnEqHIwqKwf+R3e2H+Rvy6WR//fHScn0AOjLw3I=;
        b=Y2joNvGwkR6I5eAJbLSbb2hPAYwoFfF3fDUMgywUbOLmhumVT40C8u6SjvSMz+/O5t
         sHMj0h+5gpXuavi3iVm2w63DWUoBvoHdpGOEB18zrNx7l9dlPc3PVrjaC4oi+cMPYdAJ
         k0jwSM1dWT8Pkaq4/3jhBh5dsipqRe/EN80BUh+qlbyeYsloyHlkrsxSon8QUD3eUa+L
         DjG55OUjW4trfM2C//H62e7VDH0L9nYLJFkYPYyYxTIPB77C8EEd7B4YPSPi7NtaK/Sg
         2sWL7dMWVMLj5DfvtbPv5ly2OshDQvfw1MjwJfuQ0GcVr3gGGOdYkIOBcqfpMcV95BCc
         U9QQ==
X-Gm-Message-State: APjAAAWJolzkw66Rx9yEnmCbiknfVwKjba89YAncJtiyoGcOl89gVjci
        ZB7qFPgbxAK7pdyqjbZvE7SDJYG3xB8W4hK6fdo=
X-Google-Smtp-Source: APXvYqxHoaMUX/D0YohPi1Xl3zaWAzEpC1/isJE3gtRb272DLi5OhqgbMLNNI2L1/AiIEoLCMUMZ2MQEPuZIw3j7p1c=
X-Received: by 2002:a17:902:e082:: with SMTP id cb2mr35643359plb.274.1561475683402;
 Tue, 25 Jun 2019 08:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
 <1560439238-4054-4-git-send-email-akinobu.mita@gmail.com> <1561473887.19713.6.camel@intel.com>
In-Reply-To: <1561473887.19713.6.camel@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 26 Jun 2019 00:14:32 +0900
Message-ID: <CAC5umyj6tyCH9GM4bPE30JYoKN57HCvjdM89h8eyAcZWspCm6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] nvme: notify thermal framework when temperature
 threshold events occur
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
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

2019=E5=B9=B46=E6=9C=8825=E6=97=A5(=E7=81=AB) 23:44 Zhang Rui <rui.zhang@in=
tel.com>:
>
> On =E4=BA=94, 2019-06-14 at 00:20 +0900, Akinobu Mita wrote:
> > The NVMe controller supports the temperature threshold feature
> > (Feature
> > Identifier 04h) that enables to configure the asynchronous event
> > request
> > command to complete when the temperature is crossed its corresponding
> > temperature threshold.
> >
> > This enables the reporting of asynchronous events from the controller
> > when
> > the temperature reached or exceeded a temperature threshold.
> > In the case of the temperature threshold conditions, this notifies
> > the
> > thermal framework.
> >
> > The main purpose of this is to turn on a fan when overheated without
> > polling the device for the smart log that could prevent the lower
> > power
> > state transitions.
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> > Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> > Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> > * v4
> > - support DT thermal zone device.
> > - use bitmap to iterate over implemented sensors
> >
> >  drivers/nvme/host/core.c    | 14 ++++++++++++++
> >  drivers/nvme/host/nvme.h    |  5 +++++
> >  drivers/nvme/host/thermal.c | 12 ++++++++++++
> >  include/linux/nvme.h        |  7 +++++++
> >  4 files changed, 38 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 4be339b..44dadbb 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1186,6 +1186,9 @@ static void nvme_enable_aen(struct nvme_ctrl
> > *ctrl)
> >       u32 result, supported_aens =3D ctrl->oaes &
> > NVME_AEN_SUPPORTED;
> >       int status;
> >
> > +     if (IS_ENABLED(CONFIG_THERMAL))
> > +             supported_aens |=3D NVME_SMART_CRIT_TEMPERATURE;
> > +
> >       if (!supported_aens)
> >               return;
> >
> > @@ -3561,6 +3564,16 @@ void nvme_remove_namespaces(struct nvme_ctrl
> > *ctrl)
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
> >
> > +static void nvme_handle_aen_smart(struct nvme_ctrl *ctrl, u32
> > result)
> > +{
> > +     u32 aer_type =3D result & NVME_AER_TYPE_MASK;
> > +     u32 aer_info =3D (result >> NVME_AER_INFO_SHIFT) &
> > NVME_AER_INFO_MASK;
> > +
> > +     if (aer_type =3D=3D NVME_AER_SMART &&
> > +         aer_info =3D=3D NVME_AER_SMART_TEMP_THRESH)
> > +             nvme_thermal_notify_framework(ctrl);
> > +}
> > +
> >  static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
> >  {
> >       char *envp[2] =3D { NULL, NULL };
> > @@ -3582,6 +3595,7 @@ static void nvme_async_event_work(struct
> > work_struct *work)
> >       struct nvme_ctrl *ctrl =3D
> >               container_of(work, struct nvme_ctrl,
> > async_event_work);
> >
> > +     nvme_handle_aen_smart(ctrl, ctrl->aen_result);
> >       nvme_aen_uevent(ctrl);
> >       ctrl->ops->submit_async_event(ctrl);
> >  }
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index a9c63ea..40325b6 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -605,6 +605,7 @@ static inline struct nvme_ns
> > *nvme_get_ns_from_dev(struct device *dev)
> >
> >  int nvme_thermal_zones_register(struct nvme_ctrl *ctrl);
> >  void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl);
> > +void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl);
> >
> >  #else
> >
> > @@ -617,6 +618,10 @@ static inline void
> > nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> >  {
> >  }
> >
> > +static inline void nvme_thermal_notify_framework(struct nvme_ctrl
> > *ctrl)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_THERMAL */
> >
> >  #endif /* _NVME_H */
> > diff --git a/drivers/nvme/host/thermal.c
> > b/drivers/nvme/host/thermal.c
> > index 18d0e4c..b5e835d 100644
> > --- a/drivers/nvme/host/thermal.c
> > +++ b/drivers/nvme/host/thermal.c
> > @@ -309,3 +309,15 @@ void nvme_thermal_zones_unregister(struct
> > nvme_ctrl *ctrl)
> >               __clear_bit(i, ctrl->tz_enabled);
> >       }
> >  }
> > +
> > +void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)
> > +{
> > +     int i;
> > +
> > +     for_each_set_bit(i, ctrl->tz_enabled, ARRAY_SIZE(ctrl->tz))
> > {
> > +             if (ctrl->tz[i].dev)
> > +                     thermal_notify_framework(ctrl->tz[i].dev,
> > 0);
>
> I'd prefer to use thermal_zone_device_update() here to notify the
> thermal framework.
> thermal_notify_framework() will be removed sometime later.

You are right.

I got my ROCKPro64 board and just started testing with pwm-fan cooling
device.  And then I also noticed that using thermal_notify_framework()
is insufficient when polling-delay is zero (i.e. interrupt driven thermal
zone).
