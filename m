Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8D7333357
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 03:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhCJCvk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 21:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhCJCvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 21:51:24 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45915C06174A;
        Tue,  9 Mar 2021 18:51:13 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e45so14967028ote.9;
        Tue, 09 Mar 2021 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JniFH/3k/PYbYXG0TKByd1M1CyWaZyyt4TIuDk3c8vA=;
        b=IHrbJ0mjhMEjkgOXf49n9ndKRJL1sm8noxNHpJHDYbpFUIYQtxseLmU/Dndadsi89h
         Umrr/npmmoQER33ePi+3IoiHG4aQ3gmizN3dOulTzaOhfAS5mMY+dcsJLg3tqigwLQdt
         44DOfiNMRNVWoLcz1+WFMLaJ3RWyt9SYdO1ajwP50IrhnHV0TaC5rpqe1NmUfpaNRdLm
         f7fNMoImtW6Gupb09Ua8I7HhKSLNi5CJYHfdVF41/Rf8crp7M26FTsifsGtr8E2L5dat
         rEm35UsiRn2xUIzxomNwP/X2GiScQNBUoHLBcJAFwDmADi4vGO6cFq19VZKlHFpP/0Xu
         X1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JniFH/3k/PYbYXG0TKByd1M1CyWaZyyt4TIuDk3c8vA=;
        b=P2Srbh7h1/mIhxrYuEEZGg7yNXlB9PfDrJhEz0c4HFm0g4pmfa/q0g/xMucaQUEkg9
         238j+Xj5So9HdrHQVHzsyZ99BxBdk8sqELGrdlzLUi7be9SF83xn/BzWtfjoxaQ1+L0n
         KsMzalTxi4SyzDZDfOYArTkdYUJsAYcb8Wj4fcL4hmaMI4hviEckjHQgIsYmLmLdzOLh
         ylfy04SSJ04HhNriG/iOOpnUT6tplBHBBqs50tKEODa4fHdfW4O3bmUEZ/x+UqRddMFC
         uymTtRMDoY2C6Yn1NzaVNE9s5r6IhfUO+3X89vH5Gqx06kA8De0S7AN0XWzH8SpdkoKC
         DdXg==
X-Gm-Message-State: AOAM5338Yc722bN1X1U+az1qXPZGTqEPLSXnyWjwiq/I3Ayffi5SH+y/
        Vs7e3JJv4xlas1HCcsZ7Ezw9mB0Tj7L9Z2dyyIo=
X-Google-Smtp-Source: ABdhPJyZ1asGGJjLJfX11lxrwv4ZPQiQ77qJFFu8hargl6jeehotVLUEkKj/pv/IORnOVJLkzbtcwe47d5w5WnkNe4k=
X-Received: by 2002:a9d:6c8b:: with SMTP id c11mr1028652otr.52.1615344672621;
 Tue, 09 Mar 2021 18:51:12 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com> <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
In-Reply-To: <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 10:51:12 +0800
Message-ID: <CAA+hA=SAtQnFb3zUXzc_jfk=GnWe2Z2K0gAFXh4fnnCC9mP+ag@mail.gmail.com>
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start monitor
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 9, 2021 at 11:58 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > The devfreq monitor depends on the device to provide load information
> > by .get_dev_status() to calculate the next target freq.
> >
> > And this will cause changing governor to simple ondemand fail
> > if device can't support.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/devfreq.c                 | 10 +++++++---
> >   drivers/devfreq/governor.h                |  2 +-
> >   drivers/devfreq/governor_simpleondemand.c |  3 +--
> >   3 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 7231fe6862a2..d1787b6c7d7c 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct *w=
ork)
> >    * to be called from governor in response to DEVFREQ_GOV_START
> >    * event when device is added to devfreq framework.
> >    */
> > -void devfreq_monitor_start(struct devfreq *devfreq)
> > +int devfreq_monitor_start(struct devfreq *devfreq)
> >   {
> >       if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
> > -             return;
> > +             return 0;
> > +
> > +     if (!devfreq->profile->get_dev_status)
> > +             return -EINVAL;
> >
> >       switch (devfreq->profile->timer) {
> >       case DEVFREQ_TIMER_DEFERRABLE:
> > @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfre=
q)
> >               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> >               break;
> >       default:
> > -             return;
> > +             return -EINVAL;
> >       }
> >
> >       if (devfreq->profile->polling_ms)
> >               queue_delayed_work(devfreq_wq, &devfreq->work,
> >                       msecs_to_jiffies(devfreq->profile->polling_ms));
> > +     return 0;
> >   }
> >   EXPORT_SYMBOL(devfreq_monitor_start);
> >
> > diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> > index 5cee3f64fe2b..31af6d072a10 100644
> > --- a/drivers/devfreq/governor.h
> > +++ b/drivers/devfreq/governor.h
> > @@ -75,7 +75,7 @@ struct devfreq_governor {
> >                               unsigned int event, void *data);
> >   };
> >
> > -void devfreq_monitor_start(struct devfreq *devfreq);
> > +int devfreq_monitor_start(struct devfreq *devfreq);
> >   void devfreq_monitor_stop(struct devfreq *devfreq);
> >   void devfreq_monitor_suspend(struct devfreq *devfreq);
> >   void devfreq_monitor_resume(struct devfreq *devfreq);
> > diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfre=
q/governor_simpleondemand.c
> > index d57b82a2b570..ea287b57cbf3 100644
> > --- a/drivers/devfreq/governor_simpleondemand.c
> > +++ b/drivers/devfreq/governor_simpleondemand.c
> > @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct dev=
freq *devfreq,
> >   {
> >       switch (event) {
> >       case DEVFREQ_GOV_START:
> > -             devfreq_monitor_start(devfreq);
> > -             break;
> > +             return devfreq_monitor_start(devfreq);
> >
> >       case DEVFREQ_GOV_STOP:
> >               devfreq_monitor_stop(devfreq);
> >
>
> Need to handle the all points of devfreq_monitor_start() usage.
> please check the tegra30-devfreq.c for this update.
>
> $ grep -rn "devfreq_monitor_start" drivers/
> drivers/devfreq/governor_simpleondemand.c:92:
> devfreq_monitor_start(devfreq);
> drivers/devfreq/tegra30-devfreq.c:744:          devfreq_monitor_start(dev=
freq);

I can add error check for tegra in the next versions.
Thanks

Regards
Aisheng

> ......
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
