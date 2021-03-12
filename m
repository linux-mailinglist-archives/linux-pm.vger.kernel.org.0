Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1805338ACB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 11:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhCLK5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 05:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhCLK5T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 05:57:19 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5AC061574;
        Fri, 12 Mar 2021 02:57:19 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id o22so16677709oic.3;
        Fri, 12 Mar 2021 02:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Re/sVsmBKkgQS7T3jsEZ8uLYcWyloCgtQxS6quxCRa8=;
        b=WzR2cLUCq9W7AQs5i7c8ZW+dkW/V88JPEHTSLN+9/h1pReLWpshsk7raOvQ5KuQz0F
         rRcVEjIheaW8BVO5jffqGJs8vpPXJUGW2ZEayRd0UM8y/U3w6YlMIQRVHCOZt5z+7mHj
         SyENCSE0p+2Ku0PbJUNZGDSiDU8KFodVzEofoo3La0j4UarcrXiUbbwJAr1smp2vQRGM
         WPy7i8WaoPNLG+XXIcb1MKzjTmEqBKEmf6JZamBizEsiRKzlHScAwEJC1umHrbKwyHKq
         LkiDVUi9+qFssrZJeSfiBZt6lQCNlBKVRQxhOnJ5Y1CFxJcP+aUOjLmHk7qGEueGr6sI
         BIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Re/sVsmBKkgQS7T3jsEZ8uLYcWyloCgtQxS6quxCRa8=;
        b=O3Fmb3kWnw4me7dW2FtdWNw8raI8Yi3XTM0rDO0YFMmhtauJG1IioDJ2Z/s9JJeFjy
         HRR7G7YKXDbC1dDNO1ibSD6YarZt4Dnt360EvjFL+wDo1XmckAus7PcO4lTa8e0HBodD
         K/DbWZzP0NlUmsSZpMbhwx7M3ttjjPSN9odZZnQ+/5omIs8N/aYIianuQ8NZwqsjNWiz
         XhmVTNd6zz/PnDYStJS3yNgToBOtw7ps/7Az32Mn/lCzJ3xkB3UTOm76HmqQrCLbTFI4
         PbkN8NAdkmDA4U+Dh3omTqcLyryi5tbLNkcvv8UmdKWgLOvFDGaTSN3KKa0gYyJP/S9x
         T/8w==
X-Gm-Message-State: AOAM531Yy4Y01NO66KNutUgfGcjHlCApglMtfSm0kt6A4bNnCBKZnz2i
        O4ywT91/BfFqrejrsTmDfvyLC0I2sM5WDt3cMMM=
X-Google-Smtp-Source: ABdhPJz5Ixj8gOwOqP8ZLI2mb/Jxa1pBK/7L/I1Crrz11Uqdate3gpI/2mWpDU7wlr7hRKBzXZpN11joAEEKXrte6nU=
X-Received: by 2002:aca:ab86:: with SMTP id u128mr9636637oie.47.1615546638373;
 Fri, 12 Mar 2021 02:57:18 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com> <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
 <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com> <CGME20210310025703epcas1p10fdb324cc7ce1accfdc8f66315e8a93e@epcas1p1.samsung.com>
 <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
 <31be2267-8988-f162-f5a6-6e6389bbf1fb@samsung.com> <CAA+hA=S76yHTeL_yCDkv55iKpBLbtZc_cV8sjORheLxbSuenzA@mail.gmail.com>
 <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com>
In-Reply-To: <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Fri, 12 Mar 2021 18:57:14 +0800
Message-ID: <CAA+hA=Q0M0bTf0VLjNmf23HqFn4Unk0h4BN-mEQXb1LkZLV=NQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start monitor
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 11, 2021 at 2:54 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> On 3/10/21 1:56 PM, Dong Aisheng wrote:
> > On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.com> w=
rote:
> >>
> >> On 3/10/21 11:56 AM, Dong Aisheng wrote:
> >>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com> wr=
ote:
> >>>>
> >>>> On 21. 3. 10. =EC=98=A4=EC=A0=84 12:58, Chanwoo Choi wrote:
> >>>>> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> >>>>>> The devfreq monitor depends on the device to provide load informat=
ion
> >>>>>> by .get_dev_status() to calculate the next target freq.
> >>>>>>
> >>>>>> And this will cause changing governor to simple ondemand fail
> >>>>>> if device can't support.
> >>>>>>
> >>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>>>>> ---
> >>>>>>   drivers/devfreq/devfreq.c                 | 10 +++++++---
> >>>>>>   drivers/devfreq/governor.h                |  2 +-
> >>>>>>   drivers/devfreq/governor_simpleondemand.c |  3 +--
> >>>>>>   3 files changed, 9 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
> >>>>>> --- a/drivers/devfreq/devfreq.c
> >>>>>> +++ b/drivers/devfreq/devfreq.c
> >>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_stru=
ct
> >>>>>> *work)
> >>>>>>    * to be called from governor in response to DEVFREQ_GOV_START
> >>>>>>    * event when device is added to devfreq framework.
> >>>>>>    */
> >>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
> >>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
> >>>>>>   {
> >>>>>>       if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
> >>>>>> -        return;
> >>>>>> +        return 0;
> >>>>>> +
> >>>>>> +    if (!devfreq->profile->get_dev_status)
> >>>>>> +        return -EINVAL;
> >>>>
> >>>> Again, I think that get_dev_status is not used for all governors.
> >>>> So that it cause the governor start fail. Don't check whether
> >>>> .get_dev_status is NULL or not.
> >>>>
> >>>
> >>> I'm not quite understand your point.
> >>> it is used by governor_simpleondemand.c and tegra_devfreq_governor.
> >>> get_target_freq -> devfreq_update_stats -> get_dev_status
> >>
> >> The devfreq can add the new governor by anyone.
> >> So these functions like devfreq_monitor_* have to support
> >> the governors and also must support the governor to be added
> >> in the future.
> >
> > Yes, but devfreq_monitor_* is only used by polling mode, right?
> > The governor using it has to implement get_dev_status unless
> > there's an exception in the future.
> >
> > Currently this patch wants to address the issue that user can switch
> > to ondemand governor (polling mode) by sysfs even devices does
> > not support it (no get_dev_status implemented).
>
> As I commented, I'll fix this issue. If devfreq driver doesn't implement
> the .get_dev_status, don't show it via available_governors. I think that
> it is fundamental solution to fix this issue.

Sounds good

> So on this version,
> don't add the this conditional statement on this function
>

Almost all this patch did is adding a checking for get_dev_status.
So do you mean drop this patch?
I wonder it's still a necessary checking to explicitly tell devfreq monitor
users that get_dev_status is needed during governor startup.

> And on next version, please use the capital letter for first character
> on patch title as following:
>
> - PM / devfreq: Check get_dev_status before start monitor
>

Okay to me.
Thanks for the suggestion.

Regards
Aisheng

> >
> > Regards
> > Aisheng
> >
> >>
> >>>
> >>> Without checking, device can switch to ondemand governor if it does n=
ot support.
> >>>
> >>> Am i missed something?
> >>>
> >>> Regards
> >>> Aisheng
> >>>
> >>>>>>       switch (devfreq->profile->timer) {
> >>>>>>       case DEVFREQ_TIMER_DEFERRABLE:
> >>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *d=
evfreq)
> >>>>>>           INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> >>>>>>           break;
> >>>>>>       default:
> >>>>>> -        return;
> >>>>>> +        return -EINVAL;
> >>>>>>       }
> >>>>>>       if (devfreq->profile->polling_ms)
> >>>>>>           queue_delayed_work(devfreq_wq, &devfreq->work,
> >>>>>>               msecs_to_jiffies(devfreq->profile->polling_ms));
> >>>>>> +    return 0;
> >>>>>>   }
> >>>>>>   EXPORT_SYMBOL(devfreq_monitor_start);
> >>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor=
.h
> >>>>>> index 5cee3f64fe2b..31af6d072a10 100644
> >>>>>> --- a/drivers/devfreq/governor.h
> >>>>>> +++ b/drivers/devfreq/governor.h
> >>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
> >>>>>>                   unsigned int event, void *data);
> >>>>>>   };
> >>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
> >>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
> >>>>>>   void devfreq_monitor_stop(struct devfreq *devfreq);
> >>>>>>   void devfreq_monitor_suspend(struct devfreq *devfreq);
> >>>>>>   void devfreq_monitor_resume(struct devfreq *devfreq);
> >>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
> >>>>>> b/drivers/devfreq/governor_simpleondemand.c
> >>>>>> index d57b82a2b570..ea287b57cbf3 100644
> >>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
> >>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
> >>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struc=
t
> >>>>>> devfreq *devfreq,
> >>>>>>   {
> >>>>>>       switch (event) {
> >>>>>>       case DEVFREQ_GOV_START:
> >>>>>> -        devfreq_monitor_start(devfreq);
> >>>>>> -        break;
> >>>>>> +        return devfreq_monitor_start(devfreq);
> >>>>>>       case DEVFREQ_GOV_STOP:
> >>>>>>           devfreq_monitor_stop(devfreq);
> >>>>>>
> >>>>>
> >>>>> Need to handle the all points of devfreq_monitor_start() usage.
> >>>>> please check the tegra30-devfreq.c for this update.
> >>>>>
> >>>>> $ grep -rn "devfreq_monitor_start" drivers/
> >>>>> drivers/devfreq/governor_simpleondemand.c:92:
> >>>>> devfreq_monitor_start(devfreq);
> >>>>> drivers/devfreq/tegra30-devfreq.c:744:
> >>>>> devfreq_monitor_start(devfreq);
> >>>>> ......
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Best Regards,
> >>>> Samsung Electronics
> >>>> Chanwoo Choi
> >>>
> >>>
> >>
> >>
> >> --
> >> Best Regards,
> >> Chanwoo Choi
> >> Samsung Electronics
> >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
