Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C55340097
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 09:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCRIDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhCRIDf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 04:03:35 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B72C06174A;
        Thu, 18 Mar 2021 01:03:34 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso4389740otd.8;
        Thu, 18 Mar 2021 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gj4OmdN5tx/5+tDZuwuPTYidKcyw8/yUcVPVnhwQIVE=;
        b=q1ki6sh1O5Qj9m2qmex0zXq5sjCeqvN6FjyK1HFxhzA583gUVH4Akb+ZPWZHsE8MDa
         Y8/Qcg1ARj/8r6LJWpmuPYUxqyzj/lCXkr8vhKLsZUM7xV/QdUuSIeSmPRo6lF9npSnz
         GBeI6pUkgAWU3u2OLUqTRQ2zcLKcIjQzJlvVbiuqFmUw3q5/qIrGj7pykviYnvzEWvap
         eXymyj6EuCu7TIld9rhegV6F2XDOpUvFYcjDkpnPHKRg93NTGSXhg6YpTvLPuWWo3gnV
         bbXU7IrJtKWUgdmekVMbb5xQ5eojq4Q7fkqh7hCiOe5hMMBef9KjZDLEoh/Ex27hDptk
         UHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gj4OmdN5tx/5+tDZuwuPTYidKcyw8/yUcVPVnhwQIVE=;
        b=JuhZGp+DdyHkGLPVesnDJ6IKHtUtlqPWR2HE1YOj0NjUgxrP9yS8e4v7EI4F+ozyyx
         2kv5JPOKVkcqCXlXAtbwU6bfE2WgaACwVI1faYwlVb0XSiqWpxfZ6XSRLl9E2v0uNQjR
         qom6Dqc3gX576yrIAxA7mz9jfbz9GiBufPQVVM0LXmGxkl+tRBDYof37pkXNzCchGP4h
         m3alnIsNblGsR0NdZCc9nrsncF81+Hk2XAZX6OSWsQNbuCowXok4IYRTtfDTSeTJPsOU
         lKELkoOI9t0+1Cbvu0nThujrWQy3G/XR0dmaPhvvLxBs3G/3WJMAsgh4V6ZKOyfyG26n
         uUaQ==
X-Gm-Message-State: AOAM533Oi2TJLcUyQ8y7zDi3Jyr5UbP1Nc+CHWEpdX6AUz640+smHOtY
        fNae6NJR55rI1mRl4BJhAazcXQD3VQJFe/zG318=
X-Google-Smtp-Source: ABdhPJyzUk4k5Kpwrfg3/mGnfb4AXTnNw16Pzp7nvYDVsBVynnJiNrUmd1QGZ+KgUnhOf/y8WRtj8JfjMeBgfMR38uY=
X-Received: by 2002:a05:6830:408a:: with SMTP id x10mr6494198ott.248.1616054614328;
 Thu, 18 Mar 2021 01:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com> <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
 <a546248b-3946-c781-94a9-30f0c92f88d2@gmail.com> <CGME20210310025703epcas1p10fdb324cc7ce1accfdc8f66315e8a93e@epcas1p1.samsung.com>
 <CAA+hA=QZbxE-aFh2UnH6wHBUStj8SAtW8C4SEZtGcxQwsOO=Aw@mail.gmail.com>
 <31be2267-8988-f162-f5a6-6e6389bbf1fb@samsung.com> <CAA+hA=S76yHTeL_yCDkv55iKpBLbtZc_cV8sjORheLxbSuenzA@mail.gmail.com>
 <b5a3ee55-0c71-a0ca-b03f-3b6790f3d2f4@samsung.com> <CAA+hA=Q0M0bTf0VLjNmf23HqFn4Unk0h4BN-mEQXb1LkZLV=NQ@mail.gmail.com>
 <d92b7660-a622-06f3-6e1f-03c99fdf0a55@gmail.com> <CAA+hA=T3A=FW-kCu=3jDTP+o3JpPYVB6VnphazXVkybGZCanaQ@mail.gmail.com>
In-Reply-To: <CAA+hA=T3A=FW-kCu=3jDTP+o3JpPYVB6VnphazXVkybGZCanaQ@mail.gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 18 Mar 2021 16:03:22 +0800
Message-ID: <CAA+hA=QOhUH19an+=p5womfp+oJRJPrFoVuLN4Ai0oezB8myNQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start monitor
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
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

Hi Chanwoo,

On Sat, Mar 13, 2021 at 2:45 PM Dong Aisheng <dongas86@gmail.com> wrote:
>
> On Sat, Mar 13, 2021 at 12:09 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
> >
> > On 21. 3. 12. =EC=98=A4=ED=9B=84 7:57, Dong Aisheng wrote:
> > > On Thu, Mar 11, 2021 at 2:54 PM Chanwoo Choi <cw00.choi@samsung.com> =
wrote:
> > >>
> > >> On 3/10/21 1:56 PM, Dong Aisheng wrote:
> > >>> On Wed, Mar 10, 2021 at 11:08 AM Chanwoo Choi <cw00.choi@samsung.co=
m> wrote:
> > >>>>
> > >>>> On 3/10/21 11:56 AM, Dong Aisheng wrote:
> > >>>>> On Wed, Mar 10, 2021 at 12:12 AM Chanwoo Choi <cwchoi00@gmail.com=
> wrote:
> > >>>>>>
> > >>>>>> On 21. 3. 10. =EC=98=A4=EC=A0=84 12:58, Chanwoo Choi wrote:
> > >>>>>>> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > >>>>>>>> The devfreq monitor depends on the device to provide load info=
rmation
> > >>>>>>>> by .get_dev_status() to calculate the next target freq.
> > >>>>>>>>
> > >>>>>>>> And this will cause changing governor to simple ondemand fail
> > >>>>>>>> if device can't support.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > >>>>>>>> ---
> > >>>>>>>>    drivers/devfreq/devfreq.c                 | 10 +++++++---
> > >>>>>>>>    drivers/devfreq/governor.h                |  2 +-
> > >>>>>>>>    drivers/devfreq/governor_simpleondemand.c |  3 +--
> > >>>>>>>>    3 files changed, 9 insertions(+), 6 deletions(-)
> > >>>>>>>>
> > >>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfr=
eq.c
> > >>>>>>>> index 7231fe6862a2..d1787b6c7d7c 100644
> > >>>>>>>> --- a/drivers/devfreq/devfreq.c
> > >>>>>>>> +++ b/drivers/devfreq/devfreq.c
> > >>>>>>>> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_=
struct
> > >>>>>>>> *work)
> > >>>>>>>>     * to be called from governor in response to DEVFREQ_GOV_ST=
ART
> > >>>>>>>>     * event when device is added to devfreq framework.
> > >>>>>>>>     */
> > >>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq)
> > >>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq)
> > >>>>>>>>    {
> > >>>>>>>>        if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRI=
VEN))
> > >>>>>>>> -        return;
> > >>>>>>>> +        return 0;
> > >>>>>>>> +
> > >>>>>>>> +    if (!devfreq->profile->get_dev_status)
> > >>>>>>>> +        return -EINVAL;
> > >>>>>>
> > >>>>>> Again, I think that get_dev_status is not used for all governors=
.
> > >>>>>> So that it cause the governor start fail. Don't check whether
> > >>>>>> .get_dev_status is NULL or not.
> > >>>>>>
> > >>>>>
> > >>>>> I'm not quite understand your point.
> > >>>>> it is used by governor_simpleondemand.c and tegra_devfreq_governo=
r.
> > >>>>> get_target_freq -> devfreq_update_stats -> get_dev_status
> > >>>>
> > >>>> The devfreq can add the new governor by anyone.
> > >>>> So these functions like devfreq_monitor_* have to support
> > >>>> the governors and also must support the governor to be added
> > >>>> in the future.
> > >>>
> > >>> Yes, but devfreq_monitor_* is only used by polling mode, right?
> > >>> The governor using it has to implement get_dev_status unless
> > >>> there's an exception in the future.
> > >>>
> > >>> Currently this patch wants to address the issue that user can switc=
h
> > >>> to ondemand governor (polling mode) by sysfs even devices does
> > >>> not support it (no get_dev_status implemented).
> > >>
> > >> As I commented, I'll fix this issue. If devfreq driver doesn't imple=
ment
> > >> the .get_dev_status, don't show it via available_governors. I think =
that
> > >> it is fundamental solution to fix this issue.
> > >
> > > Sounds good
> > >
> > >> So on this version,
> > >> don't add the this conditional statement on this function
> > >>
> > >
> > > Almost all this patch did is adding a checking for get_dev_status.
> > > So do you mean drop this patch?
> > > I wonder it's still a necessary checking to explicitly tell devfreq m=
onitor
> > > users that get_dev_status is needed during governor startup.
> >
> > I think that the it is enough to check .get_dev_status in
> > devfreq_update_stats. We have to check it on where it is used.
> >
>
> I think the drawback of only checking .get_dev_status in
> devfreq_update_stats is:
> 1. devfreq will still register successfully and ondemand governor starts =
ok
> 2. ondemand governor will still be shown in sysfs which is something
> you want to fix
> 3. devfreq will end up printing endless error messages in devfreq_monitor=
 worker
>     "dvfs failed with (%d) error" as the possible missing .get_dev_status
>
> So i wonder if you don't like changing the common devfreq_monitor_start i=
n order
> to make it look common for all governors, then we probably still need
> to fix it in
> ondemand governor in order to avoid the possible above issues.
>
> static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>                                 unsigned int event, void *data)
> {
>         switch (event) {
>         case DEVFREQ_GOV_START:
>                 if (!devfreq->profile->get_dev_status)
>                         return -EINVAL;
>
>                 return devfreq_monitor_start(devfreq);
> ...
> }
>
> How do you think?

Any feedback?

I'm waiting for your confirmation whether dropping this one,
then I can re-sent the series.

Regards
Aisheng

>
> Regards
> Aisheng
>
>
> > >
> > >> And on next version, please use the capital letter for first charact=
er
> > >> on patch title as following:
> > >>
> > >> - PM / devfreq: Check get_dev_status before start monitor
> > >>
> > >
> > > Okay to me.
> > > Thanks for the suggestion.
> > >
> > > Regards
> > > Aisheng
> > >
> > >>>
> > >>> Regards
> > >>> Aisheng
> > >>>
> > >>>>
> > >>>>>
> > >>>>> Without checking, device can switch to ondemand governor if it do=
es not support.
> > >>>>>
> > >>>>> Am i missed something?
> > >>>>>
> > >>>>> Regards
> > >>>>> Aisheng
> > >>>>>
> > >>>>>>>>        switch (devfreq->profile->timer) {
> > >>>>>>>>        case DEVFREQ_TIMER_DEFERRABLE:
> > >>>>>>>> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfre=
q *devfreq)
> > >>>>>>>>            INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> > >>>>>>>>            break;
> > >>>>>>>>        default:
> > >>>>>>>> -        return;
> > >>>>>>>> +        return -EINVAL;
> > >>>>>>>>        }
> > >>>>>>>>        if (devfreq->profile->polling_ms)
> > >>>>>>>>            queue_delayed_work(devfreq_wq, &devfreq->work,
> > >>>>>>>>                msecs_to_jiffies(devfreq->profile->polling_ms))=
;
> > >>>>>>>> +    return 0;
> > >>>>>>>>    }
> > >>>>>>>>    EXPORT_SYMBOL(devfreq_monitor_start);
> > >>>>>>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/gove=
rnor.h
> > >>>>>>>> index 5cee3f64fe2b..31af6d072a10 100644
> > >>>>>>>> --- a/drivers/devfreq/governor.h
> > >>>>>>>> +++ b/drivers/devfreq/governor.h
> > >>>>>>>> @@ -75,7 +75,7 @@ struct devfreq_governor {
> > >>>>>>>>                    unsigned int event, void *data);
> > >>>>>>>>    };
> > >>>>>>>> -void devfreq_monitor_start(struct devfreq *devfreq);
> > >>>>>>>> +int devfreq_monitor_start(struct devfreq *devfreq);
> > >>>>>>>>    void devfreq_monitor_stop(struct devfreq *devfreq);
> > >>>>>>>>    void devfreq_monitor_suspend(struct devfreq *devfreq);
> > >>>>>>>>    void devfreq_monitor_resume(struct devfreq *devfreq);
> > >>>>>>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
> > >>>>>>>> b/drivers/devfreq/governor_simpleondemand.c
> > >>>>>>>> index d57b82a2b570..ea287b57cbf3 100644
> > >>>>>>>> --- a/drivers/devfreq/governor_simpleondemand.c
> > >>>>>>>> +++ b/drivers/devfreq/governor_simpleondemand.c
> > >>>>>>>> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(s=
truct
> > >>>>>>>> devfreq *devfreq,
> > >>>>>>>>    {
> > >>>>>>>>        switch (event) {
> > >>>>>>>>        case DEVFREQ_GOV_START:
> > >>>>>>>> -        devfreq_monitor_start(devfreq);
> > >>>>>>>> -        break;
> > >>>>>>>> +        return devfreq_monitor_start(devfreq);
> > >>>>>>>>        case DEVFREQ_GOV_STOP:
> > >>>>>>>>            devfreq_monitor_stop(devfreq);
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> Need to handle the all points of devfreq_monitor_start() usage.
> > >>>>>>> please check the tegra30-devfreq.c for this update.
> > >>>>>>>
> > >>>>>>> $ grep -rn "devfreq_monitor_start" drivers/
> > >>>>>>> drivers/devfreq/governor_simpleondemand.c:92:
> > >>>>>>> devfreq_monitor_start(devfreq);
> > >>>>>>> drivers/devfreq/tegra30-devfreq.c:744:
> > >>>>>>> devfreq_monitor_start(devfreq);
> > >>>>>>> ......
> > >>>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> --
> > >>>>>> Best Regards,
> > >>>>>> Samsung Electronics
> > >>>>>> Chanwoo Choi
> > >>>>>
> > >>>>>
> > >>>>
> > >>>>
> > >>>> --
> > >>>> Best Regards,
> > >>>> Chanwoo Choi
> > >>>> Samsung Electronics
> > >>>
> > >>>
> > >>
> > >>
> > >> --
> > >> Best Regards,
> > >> Chanwoo Choi
> > >> Samsung Electronics
> >
> >
> > --
> > Best Regards,
> > Samsung Electronics
> > Chanwoo Choi
