Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82582333367
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 03:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCJC42 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 21:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhCJC4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 21:56:19 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7EC06174A;
        Tue,  9 Mar 2021 18:56:19 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r24so6878485otp.12;
        Tue, 09 Mar 2021 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ImQOXk1btyNKdUXhB/YcAtvvtT3m9HBuxTqsF+6S5Yk=;
        b=lnZxyk8qlWmJ5tcNGRtO+8lfQ7arKPHB0WKfMhuIOuItZZduFuI39OmNSxrjREfBr5
         VaZtgrtd/nuyRA+92tV3E2/opOKvzUOT4EtIl1vdf+mk4gy9a2MlSwjY4wykTJzF0p4S
         /pmmAQ3QJ3+1ZSJiAUKYPJbGqzD92f2UXw0HqnmovT7VuiVStIhpzTT6QBlF9PSepkSD
         lTfRHcTHeBnjhJcoGBvP30HUNvAEnd2J1tHviR1QxQ0qN7nVEdl5xFR9TXmz6O4cE4dj
         ldQ4Ipb2Dem7InLTK/jxzckFiO77zH9kIGG0Fl8EUIIPbt8KFa+752CH3b95JS09e+Aj
         vuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ImQOXk1btyNKdUXhB/YcAtvvtT3m9HBuxTqsF+6S5Yk=;
        b=EiFAY3fA9JzM+yK9tp97g2c50uvyLcWV/orBd5o630TPxF1REWCySyZQ7DNU1c5ihu
         pyyviA6N/IibTSXnUszWPhwGplm4hxgQZ8TlvcTtsDqj14zPBkrNgJn96o5ESfYjgEHn
         tjAl9nCep2fIvdw5e+aOzup+CUATajt9R0UqavYtw7StggYHeG/xfGH6L6EQHC3s0Hm0
         KIn9VJx5FJiB5MHGKHowjaYjtwOgnN0t2r/d5f+ZWspFKATp0HOzgFRIOPF6kkM8IyPp
         eqTgAyHgH0GHntQmRie+o4XLtDccM35+1q+BCvO+talDe7bU1gDjnuEbaKpXyRTqSfl1
         PTaw==
X-Gm-Message-State: AOAM533gyoMkUAYJkmarUDi38pOmoedUwYhEX2WZKYGboIF0SEy/87uT
        MYlupXu0S8BByA9xqdsrIO2UZWlCWzOApQnPqG8=
X-Google-Smtp-Source: ABdhPJxPzJlmKgxCWVwuKIQ8srdPkF699e+9SRVaK/qjO7BI3IDGnJociPKPUrEGW7DrMDMLhg79SffnR/yO3w/JZPU=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr1003934otk.118.1615344979122;
 Tue, 09 Mar 2021 18:56:19 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com> <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
 <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com>
In-Reply-To: <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 10:56:18 +0800
Message-ID: <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 10. =EC=98=A4=EC=A0=84 12:58, Chanwoo Choi wrote:
> > On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> >> The devfreq monitor depends on the device to provide load information
> >> by .get_dev_status() to calculate the next target freq.
> >>
> >> And this will cause changing governor to simple ondemand fail
> >> if device can't support.
> >>
> >> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >> ---
> >>   drivers/devfreq/devfreq.c                 | 10 +++++++---
> >>   drivers/devfreq/governor.h                |  2 +-
> >>   drivers/devfreq/governor_simpleondemand.c |  3 +--
> >>   3 files changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index 7231fe6862a2..d1787b6c7d7c 100644
> >> --- a/drivers/devfreq/devfreq.c
> >> +++ b/drivers/devfreq/devfreq.c
> >> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct
> >> *work)
> >>    * to be called from governor in response to DEVFREQ_GOV_START
> >>    * event when device is added to devfreq framework.
> >>    */
> >> -void devfreq_monitor_start(struct devfreq *devfreq)
> >> +int devfreq_monitor_start(struct devfreq *devfreq)
> >>   {
> >>       if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
> >> -        return;
> >> +        return 0;
> >> +
> >> +    if (!devfreq->profile->get_dev_status)
> >> +        return -EINVAL;
>
> Again, I think that get_dev_status is not used for all governors.
> So that it cause the governor start fail. Don't check whether
> .get_dev_status is NULL or not.
>

I'm not quite understand your point.
it is used by governor_simpleondemand.c and tegra_devfreq_governor.
get_target_freq -> devfreq_update_stats -> get_dev_status

Without checking, device can switch to ondemand governor if it does not sup=
port.

Am i missed something?

Regards
Aisheng

> >>       switch (devfreq->profile->timer) {
> >>       case DEVFREQ_TIMER_DEFERRABLE:
> >> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfr=
eq)
> >>           INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> >>           break;
> >>       default:
> >> -        return;
> >> +        return -EINVAL;
> >>       }
> >>       if (devfreq->profile->polling_ms)
> >>           queue_delayed_work(devfreq_wq, &devfreq->work,
> >>               msecs_to_jiffies(devfreq->profile->polling_ms));
> >> +    return 0;
> >>   }
> >>   EXPORT_SYMBOL(devfreq_monitor_start);
> >> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> >> index 5cee3f64fe2b..31af6d072a10 100644
> >> --- a/drivers/devfreq/governor.h
> >> +++ b/drivers/devfreq/governor.h
> >> @@ -75,7 +75,7 @@ struct devfreq_governor {
> >>                   unsigned int event, void *data);
> >>   };
> >> -void devfreq_monitor_start(struct devfreq *devfreq);
> >> +int devfreq_monitor_start(struct devfreq *devfreq);
> >>   void devfreq_monitor_stop(struct devfreq *devfreq);
> >>   void devfreq_monitor_suspend(struct devfreq *devfreq);
> >>   void devfreq_monitor_resume(struct devfreq *devfreq);
> >> diff --git a/drivers/devfreq/governor_simpleondemand.c
> >> b/drivers/devfreq/governor_simpleondemand.c
> >> index d57b82a2b570..ea287b57cbf3 100644
> >> --- a/drivers/devfreq/governor_simpleondemand.c
> >> +++ b/drivers/devfreq/governor_simpleondemand.c
> >> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct
> >> devfreq *devfreq,
> >>   {
> >>       switch (event) {
> >>       case DEVFREQ_GOV_START:
> >> -        devfreq_monitor_start(devfreq);
> >> -        break;
> >> +        return devfreq_monitor_start(devfreq);
> >>       case DEVFREQ_GOV_STOP:
> >>           devfreq_monitor_stop(devfreq);
> >>
> >
> > Need to handle the all points of devfreq_monitor_start() usage.
> > please check the tegra30-devfreq.c for this update.
> >
> > $ grep -rn "devfreq_monitor_start" drivers/
> > drivers/devfreq/governor_simpleondemand.c:92:
> > devfreq_monitor_start(devfreq);
> > drivers/devfreq/tegra30-devfreq.c:744:
> > devfreq_monitor_start(devfreq);
> > ......
> >
>
>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
