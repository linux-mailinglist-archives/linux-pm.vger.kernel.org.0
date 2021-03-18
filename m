Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA41A3403EB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 11:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCRKwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhCRKwC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 06:52:02 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1440C06174A;
        Thu, 18 Mar 2021 03:52:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso4762210otq.3;
        Thu, 18 Mar 2021 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=71whWkxb2bBJl6dByqv/ZV5tqOK3zTPTnTkWqrB5g3w=;
        b=bwqRZdymz0/7pp2mJALHV5sfACZV5MD6hI3FWQxE3BF6IysHTdb4GclYFwCDcw2N0m
         9+zScQaepoxgfYEAIWZFv+jpydiBUZbHN3SjvmNGxInpoViZ7bMNJ3ItJrGSLfblZCQr
         GacTqAB9kPg5QHqd7DhxLc8V7kvufWjA/5a7+Yj56BULmm4ES5isCP+dhmfJh7nj6OI6
         LtOCbA30JEgq7INg0oNsfsL4jjkYskAbFfg2OiIKMB7oiedSOwhanITuVunNFyiiJPG+
         mMN6sYCuRhG/r386j5wBmbul4zfojfcbU5rKO/KzMk4XhkroxMVtzASfQhP8XTBQfK+G
         LfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=71whWkxb2bBJl6dByqv/ZV5tqOK3zTPTnTkWqrB5g3w=;
        b=TjZLuR9TrLQyzNbJMS687T0dX0yU9hgXVzbeEHO72zy/kg1kNiqKYkn0197N0vgxfx
         P0KbymcJOyBZ7lX7/1BBjf+QIGOvNe+JsHswJCE1FH8yRLQNH8Hg8BWwJkTY/ohh/LCw
         luNLleUmLTP/MW7ZGf4+GXtKgQVXtyXKBKkDCoKmV6twDpjJXTqd6iPK9xaHWPJfz7Lo
         Kqb6FcSMFfrY1GleDrhSn5zSS0jaF6rIXhKerH4nm+5osgf8ZpavZnvlXbQgaFAK/OLk
         ft/xfWO0ynqfu87GyN6bWGzEN2eC0+0RdA7BzgcM1uNrx9IlZFrnKjhSaYA73MmoskzX
         fRDQ==
X-Gm-Message-State: AOAM530KwhitENYVytVxpOX7sFtrPBJz2cxqbThJIa3gSgaf3o4ftrmJ
        JzfOXXJMy/aI5IW13oz6Ao5lElDdJ89n9J+XgQY=
X-Google-Smtp-Source: ABdhPJzZm/M1FLDELbesc4FmZJp4A9Cn2Egz7cDKnWI7pFrnbAYKjQqJ1sqrKvXxLhnXfwpVOwgBFgJ0bjzN7d4gaig=
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr6778381otu.52.1616064722022;
 Thu, 18 Mar 2021 03:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com> <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
 <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com> <CGME20210310025703epcas1p10fdb324cc7ce1accfdc8f66315e8a93e@epcas1p1.samsung.com>
 <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
 <31be2267-8988-f162-f5a6-6e6389bbf1fb@samsung.com> <CAA+hA=S76yHTeL_yCDkv55iKpBLbtZc_cV8sjORheLxbSuenzA@mail.gmail.com>
 <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com> <CAA+hA=Q0M0bTf0VLjNmf23HqFn4Unk0h4BN-mEQXb1LkZLV=NQ@mail.gmail.com>
 <d92b7660-a622-06f3-6e1f-03c99fdf0a55@gmail.com> <CAA+hA=T3A=FW-kCu=3jDTP+o3JpPYVB6VnphazXVkybGZCanaQ@mail.gmail.com>
 <CAA+hA=QOhUH19an+=p5womfp+oJRJPrFoVuLN4Ai0oezB8myNQ@mail.gmail.com>
 <0e518145-5cae-63f1-c32f-e6207fdeae54@samsung.com> <4b5a0c61-2bab-8b00-621c-25f1244fee92@samsung.com>
In-Reply-To: <4b5a0c61-2bab-8b00-621c-25f1244fee92@samsung.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 18 Mar 2021 18:51:50 +0800
Message-ID: <CAA+hA=TwcaaNnb=JbpOiycsGeuuXp4Pf-Jn3=tazNvrLZpnc-g@mail.gmail.com>
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

On Thu, Mar 18, 2021 at 5:42 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> On 3/18/21 6:54 PM, Chanwoo Choi wrote:
> > On 3/18/21 5:03 PM, Dong Aisheng wrote:
> >> Hi Chanwoo,
> >>
> >> On Sat, Mar 13, 2021 at 2:45 PM Dong Aisheng <dongas86@gmail.com> wrot=
e:
> >>>
> >>> On Sat, Mar 13, 2021 at 12:09 AM Chanwoo Choi <cwchoi00@gmail.com> wr=
ote:
> >>>>
> >>>> On 21. 3. 12. =EC=98=A4=ED=9B=84 7:57, Dong Aisheng wrote:
> >>>>> On Thu, Mar 11, 2021 at 2:54 PM Chanwoo Choi <cw00.choi@samsung.com=
> wrote:
> >>>>>>
> >>>>>> On 3/10/21 1:56 PM, Dong Aisheng wrote:
> >>>>>>> On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.=
com> wrote:
> >>>>>>>>
> >>>>>>>> On 3/10/21 11:56 AM, Dong Aisheng wrote:
> >>>>>>>>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.c=
om> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 21. 3. 10. =EC=98=A4=EC=A0=84 12:58, Chanwoo Choi wrote:
> >>>>>>>>>>> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> >>>>>>>>>>>> The devfreq monitor depends on the device to provide load in=
formation
> >>>>>>>>>>>> by .get_dev_status() to calculate the next target freq.
> >>>>>>>>>>>>
> >>>>>>>>>>>> And this will cause changing governor to simple ondemand fai=
l
> >>>>>>>>>>>> if device can't support.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>    drivers/devfreq/devfreq.c                 | 10 +++++++---
> >>>>>>>>>>>>    drivers/devfreq/governor.h                |  2 +-
> >>>>>>>>>>>>    drivers/devfreq/governor_simpleondemand.c |  3 +--
> >>>>>>>>>>>>    3 files changed, 9 insertions(+), 6 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/dev=
freq.c
> >>>>>>>>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
> >>>>>>>>>>>> --- a/drivers/devfreq/devfreq.c
> >>>>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
> >>>>>>>>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct wor=
k_struct
> >>>>>>>>>>>> *work)
> >>>>>>>>>>>>     * to be called from governor in response to DEVFREQ_GOV_=
START
> >>>>>>>>>>>>     * event when device is added to devfreq framework.
> >>>>>>>>>>>>     */
> >>>>>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
> >>>>>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
> >>>>>>>>>>>>    {
> >>>>>>>>>>>>        if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_D=
RIVEN))
> >>>>>>>>>>>> -        return;
> >>>>>>>>>>>> +        return 0;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +    if (!devfreq->profile->get_dev_status)
> >>>>>>>>>>>> +        return -EINVAL;
> >>>>>>>>>>
> >>>>>>>>>> Again, I think that get_dev_status is not used for all governo=
rs.
> >>>>>>>>>> So that it cause the governor start fail. Don't check whether
> >>>>>>>>>> .get_dev_status is NULL or not.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I'm not quite understand your point.
> >>>>>>>>> it is used by governor_simpleondemand.c and tegra_devfreq_gover=
nor.
> >>>>>>>>> get_target_freq -> devfreq_update_stats -> get_dev_status
> >>>>>>>>
> >>>>>>>> The devfreq can add the new governor by anyone.
> >>>>>>>> So these functions like devfreq_monitor_* have to support
> >>>>>>>> the governors and also must support the governor to be added
> >>>>>>>> in the future.
> >>>>>>>
> >>>>>>> Yes, but devfreq_monitor_* is only used by polling mode, right?
> >>>>>>> The governor using it has to implement get_dev_status unless
> >>>>>>> there's an exception in the future.
> >>>>>>>
> >>>>>>> Currently this patch wants to address the issue that user can swi=
tch
> >>>>>>> to ondemand governor (polling mode) by sysfs even devices does
> >>>>>>> not support it (no get_dev_status implemented).
> >>>>>>
> >>>>>> As I commented, I'll fix this issue. If devfreq driver doesn't imp=
lement
> >>>>>> the .get_dev_status, don't show it via available_governors. I thin=
k that
> >>>>>> it is fundamental solution to fix this issue.
> >>>>>
> >>>>> Sounds good
> >>>>>
> >>>>>> So on this version,
> >>>>>> don't add the this conditional statement on this function
> >>>>>>
> >>>>>
> >>>>> Almost all this patch did is adding a checking for get_dev_status.
> >>>>> So do you mean drop this patch?
> >>>>> I wonder it's still a necessary checking to explicitly tell devfreq=
 monitor
> >>>>> users that get_dev_status is needed during governor startup.
> >>>>
> >>>> I think that the it is enough to check .get_dev_status in
> >>>> devfreq_update_stats. We have to check it on where it is used.
> >>>>
> >>>
> >>> I think the drawback of only checking .get_dev_status in
> >>> devfreq_update_stats is:
> >>> 1. devfreq will still register successfully and ondemand governor sta=
rts ok
> >>> 2. ondemand governor will still be shown in sysfs which is something
> >>> you want to fix
> >>> 3. devfreq will end up printing endless error messages in devfreq_mon=
itor worker
> >>>     "dvfs failed with (%d) error" as the possible missing .get_dev_st=
atus
> >
> > I think that devfreq_monitor_start have to handle only work instance.
> > This approach is too considering the deep check list.
> > I want to resolve this periodical error log with different solution.
> >
> > Actually, we have to reject the registration of devfreq device
> > when calling devfreq_add_device instead of checking .get_dev_status
> > in devfreq_monitor_start().
>
>
> I'll reject the registration of devfreq device if the mandatory
> function pointer of struct devfreq_dev_profile are not initialized.
> - .get_dev_status
>    If some governors like simple_ondemand, have to initialize it.
>    So, I need to add the new flag to specify this feature.
> - .target is mandatory for all devfreq devices. I'll check it.

Okay, thanks
Then i will drop this patch and resend series with your other comments
addressed.

Regards
Aisheng

>
> >
> >
> >>>
> >>> So i wonder if you don't like changing the common devfreq_monitor_sta=
rt in order
> >>> to make it look common for all governors, then we probably still need
> >>> to fix it in
> >>> ondemand governor in order to avoid the possible above issues.
> >>>
> >>> static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
> >>>                                 unsigned int event, void *data)
> >>> {
> >>>         switch (event) {
> >>>         case DEVFREQ_GOV_START:
> >>>                 if (!devfreq->profile->get_dev_status)
> >>>                         return -EINVAL;
> >>>
> >>>                 return devfreq_monitor_start(devfreq);
> >>> ...
> >>> }
> >>>
> >>> How do you think?
> >>
> >> Any feedback?
> >>
> >> I'm waiting for your confirmation whether dropping this one,
> >> then I can re-sent the series.
> >>
> >> Regards
> >> Aisheng
> >>
> >>>
> >>> Regards
> >>> Aisheng
> >>>
> >>>
> >>>>>
> >>>>>> And on next version, please use the capital letter for first chara=
cter
> >>>>>> on patch title as following:
> >>>>>>
> >>>>>> - PM / devfreq: Check get_dev_status before start monitor
> >>>>>>
> >>>>>
> >>>>> Okay to me.
> >>>>> Thanks for the suggestion.
> >>>>>
> >>>>> Regards
> >>>>> Aisheng
> >>>>>
> >>>>>>>
> >>>>>>> Regards
> >>>>>>> Aisheng
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Without checking, device can switch to ondemand governor if it =
does not support.
> >>>>>>>>>
> >>>>>>>>> Am i missed something?
> >>>>>>>>>
> >>>>>>>>> Regards
> >>>>>>>>> Aisheng
> >>>>>>>>>
> >>>>>>>>>>>>        switch (devfreq->profile->timer) {
> >>>>>>>>>>>>        case DEVFREQ_TIMER_DEFERRABLE:
> >>>>>>>>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devf=
req *devfreq)
> >>>>>>>>>>>>            INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor=
);
> >>>>>>>>>>>>            break;
> >>>>>>>>>>>>        default:
> >>>>>>>>>>>> -        return;
> >>>>>>>>>>>> +        return -EINVAL;
> >>>>>>>>>>>>        }
> >>>>>>>>>>>>        if (devfreq->profile->polling_ms)
> >>>>>>>>>>>>            queue_delayed_work(devfreq_wq, &devfreq->work,
> >>>>>>>>>>>>                msecs_to_jiffies(devfreq->profile->polling_ms=
));
> >>>>>>>>>>>> +    return 0;
> >>>>>>>>>>>>    }
> >>>>>>>>>>>>    EXPORT_SYMBOL(devfreq_monitor_start);
> >>>>>>>>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/go=
vernor.h
> >>>>>>>>>>>> index 5cee3f64fe2b..31af6d072a10 100644
> >>>>>>>>>>>> --- a/drivers/devfreq/governor.h
> >>>>>>>>>>>> +++ b/drivers/devfreq/governor.h
> >>>>>>>>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
> >>>>>>>>>>>>                    unsigned int event, void *data);
> >>>>>>>>>>>>    };
> >>>>>>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
> >>>>>>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
> >>>>>>>>>>>>    void devfreq_monitor_stop(struct devfreq *devfreq);
> >>>>>>>>>>>>    void devfreq_monitor_suspend(struct devfreq *devfreq);
> >>>>>>>>>>>>    void devfreq_monitor_resume(struct devfreq *devfreq);
> >>>>>>>>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
> >>>>>>>>>>>> b/drivers/devfreq/governor_simpleondemand.c
> >>>>>>>>>>>> index d57b82a2b570..ea287b57cbf3 100644
> >>>>>>>>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
> >>>>>>>>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
> >>>>>>>>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler=
(struct
> >>>>>>>>>>>> devfreq *devfreq,
> >>>>>>>>>>>>    {
> >>>>>>>>>>>>        switch (event) {
> >>>>>>>>>>>>        case DEVFREQ_GOV_START:
> >>>>>>>>>>>> -        devfreq_monitor_start(devfreq);
> >>>>>>>>>>>> -        break;
> >>>>>>>>>>>> +        return devfreq_monitor_start(devfreq);
> >>>>>>>>>>>>        case DEVFREQ_GOV_STOP:
> >>>>>>>>>>>>            devfreq_monitor_stop(devfreq);
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Need to handle the all points of devfreq_monitor_start() usag=
e.
> >>>>>>>>>>> please check the tegra30-devfreq.c for this update.
> >>>>>>>>>>>
> >>>>>>>>>>> $ grep -rn "devfreq_monitor_start" drivers/
> >>>>>>>>>>> drivers/devfreq/governor_simpleondemand.c:92:
> >>>>>>>>>>> devfreq_monitor_start(devfreq);
> >>>>>>>>>>> drivers/devfreq/tegra30-devfreq.c:744:
> >>>>>>>>>>> devfreq_monitor_start(devfreq);
> >>>>>>>>>>> ......
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> --
> >>>>>>>>>> Best Regards,
> >>>>>>>>>> Samsung Electronics
> >>>>>>>>>> Chanwoo Choi
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Best Regards,
> >>>>>>>> Chanwoo Choi
> >>>>>>>> Samsung Electronics
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Best Regards,
> >>>>>> Chanwoo Choi
> >>>>>> Samsung Electronics
> >>>>
> >>>>
> >>>> --
> >>>> Best Regards,
> >>>> Samsung Electronics
> >>>> Chanwoo Choi
> >>
> >>
> >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
