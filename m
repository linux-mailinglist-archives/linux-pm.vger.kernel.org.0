Return-Path: <linux-pm+bounces-30762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C7B037FD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D5F3BA991
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097982343C2;
	Mon, 14 Jul 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvkax10m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6211233723;
	Mon, 14 Jul 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478185; cv=none; b=b/TXs3DSADCi07UdJ/Q0VHhzatH2AC7CfMSWJJ+7e31lxuzviG7fORa24RWisj2HPUpXqCaJyoeSQnwn1YOLDBtffCgw7pMFdAxWsdJrXE1fP7g3JSmyHmgZYl+WCdunugQkZz7TeYN8DvMID9Apwn9V0OA6YYrz7p6CNBAq91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478185; c=relaxed/simple;
	bh=3R4hBblRAjDJwYFq1ZJFkuy2r1uvrtk59qFFdU7msaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbELYB8qqySwyMg4H3Q78QWKtHCEBPDHwD+9XRO1EpPxAggFHEiOn09hjwGgHcPvVGInYgxIOD4+hPqbDIGs4cYq04kBeKZBqFWKq4c/zA35K62Ty/MXKpEpJIydI6DapB6DPg/g71tUbqeuh/Waazme4cvu3Ke3VMige57AG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvkax10m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BC6C4CEF7;
	Mon, 14 Jul 2025 07:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752478184;
	bh=3R4hBblRAjDJwYFq1ZJFkuy2r1uvrtk59qFFdU7msaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pvkax10miz8lCHurIzNB/OiktlCQ6TGz/IwrO3oKdQuYupX3a9FxVGZBQgj9wH3Vw
	 IBmpnXxYTl6+U7bMzf8rFDa7hwKib2LzAsuoevqwC4HssS7qjjqzsW2R6KsV3ySXPO
	 iFp+36QQCsEZArKXMGtTwhIUiLz47oDsPMYxdKkC/QGL7C59XWMHSM1MObjjsyHPUT
	 vpx9LSLxfusWxQ28Qa/3dRhfz9PlYRaXKW7rYgDfso4rTJNPIM6RrN7Tx+YyqeJcjW
	 nji9dovZV86h0Bc4phGHxF/uB6lejva12oTVos39j5rcm2eVLz3roUPeS/XA+Ig2GU
	 KLm4ggzO9IKFg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-611998766c0so1877973eaf.1;
        Mon, 14 Jul 2025 00:29:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBp8RT+WkICnteNUcTyQhPZQY6cIOeKW/rCHLaJpmWG29OV8MBXmTo21Dzzw2MC6fuiDtRre2zc64/DMI=@vger.kernel.org, AJvYcCXPBdU4Atb5sdiqgitXInF5EQms6b0Pbb7rtclNujocayNP5+EHZq2eHvs81gmAvbgC19+ruAHqxTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhVVOgvn2Oxrjhig97uSskkGWPA5EDRXNIzEJNB3ITa+Cjzcl
	YqO1iBnEuxldZgU9HcEYxJuSO2xwbIG0qz896TtFj4nsw3QZdKihCVmVD9pw8twJq7p+NWmZO8h
	gvAT7wT7g/jUTpdvbOzYk2xuwQfvfeGo=
X-Google-Smtp-Source: AGHT+IGqNNob6ac5P3t+2ODl2G5OzOiHGbAaE4DnInSNhrCwz4VALA5Jtx9MReaFTC8wZVUzGCQxZUR7cFwJuA1wCm8=
X-Received: by 2002:a05:6820:1e8b:b0:611:bdaa:5b01 with SMTP id
 006d021491bc7-613e5fe0d17mr8817549eaf.6.1752478183694; Mon, 14 Jul 2025
 00:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
 <4677865.LvFx2qVVIh@rjwysocki.net> <ae6d65f7-990a-4145-9865-63f23518405c@linaro.org>
In-Reply-To: <ae6d65f7-990a-4145-9865-63f23518405c@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Jul 2025 09:29:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hatwNn_Qh7n7wjDyXDZK=L4vkB+aotZRfn4Zi21sGKxw@mail.gmail.com>
X-Gm-Features: Ac12FXy-IcEvMln2fxRJDe3ab5PV9UMldxH3rz0ZnxK2CkxLtcP4eQ7PPTMbJpE
Message-ID: <CAJZ5v0hatwNn_Qh7n7wjDyXDZK=L4vkB+aotZRfn4Zi21sGKxw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
	William McVicker <willmcvicker@google.com>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:09=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 7/12/25 8:54 AM, Rafael J. Wysocki wrote:
> > On Friday, July 11, 2025 3:54:00 PM CEST Rafael J. Wysocki wrote:
> >> On Fri, Jul 11, 2025 at 3:38=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>>
> >>> On Fri, Jul 11, 2025 at 3:08=E2=80=AFPM Tudor Ambarus <tudor.ambarus@=
linaro.org> wrote:
> >>>>
> >>>>
> >>>> Hi, Rafael,
> >>>>
> >>>> On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> According to [1], the handling of device suspend and resume, and
> >>>>> particularly the latter, involves unnecessary overhead related to
> >>>>> starting new async work items for devices that cannot make progress
> >>>>> right away because they have to wait for other devices.
> >>>>>
> >>>>> To reduce this problem in the resume path, use the observation that
> >>>>> starting the async resume of the children of a device after resumin=
g
> >>>>> the parent is likely to produce less scheduling and memory manageme=
nt
> >>>>> noise than starting it upfront while at the same time it should not
> >>>>> increase the resume duration substantially.
> >>>>>
> >>>>> Accordingly, modify the code to start the async resume of the devic=
e's
> >>>>> children when the processing of the parent has been completed in ea=
ch
> >>>>> stage of device resume and only start async resume upfront for devi=
ces
> >>>>> without parents.
> >>>>>
> >>>>> Also make it check if a given device can be resumed asynchronously
> >>>>> before starting the synchronous resume of it in case it will have t=
o
> >>>>> wait for another that is already resuming asynchronously.
> >>>>>
> >>>>> In addition to making the async resume of devices more friendly to
> >>>>> systems with relatively less computing resources, this change is al=
so
> >>>>> preliminary for analogous changes in the suspend path.
> >>>>>
> >>>>> On the systems where it has been tested, this change by itself does
> >>>>> not affect the overall system resume duration in a measurable way.
> >>>>>
> >>>>> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-sar=
avanak@google.com/ [1]
> >>>>> Suggested-by: Saravana Kannan <saravanak@google.com>
> >>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> I'd like to let you know of a suspend crash that I'm dealing with
> >>>> when using the OOT pixel6 drivers on top of v6.16-rc4.
> >>>
> >>> Well, thanks, but there's not much I can do about it.
> >>>
> >>> It is also better to start a new thread in such cases than to reply t=
o
> >>> a patch submission.
> >>>
> >>>> Similar to what Jon reported, everything gets back to normal if
> >>>> I disable pm_async or if I revert the following patches:
> >>>> 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
> >>>> aa7a9275ab81 PM: sleep: Suspend async parents after suspending child=
ren
> >>>> 0cbef962ce1f PM: sleep: Resume children after resuming the parent
> >>>>
> >>>> I also reverted their fixes when testing:
> >>>> 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
> >>>> d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-co=
mplete devices
> >>>> 079e8889ad13 PM: sleep: Fix list splicing in device suspend error pa=
ths
> >>>>
> >>>> It seems that the hang happens in dpm_suspend() at
> >>>> async_synchronize_full() time after a driver fails to suspend.
> >>>> The phone then naturally resets with an APC watchdog.
> >>>>
> >>>> [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend becau=
se eeprom-m24c64x is in use!
> >>>> [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): pl=
atform_pm_suspend returns -16
> >>>> [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend re=
turned -16 after 1596 usecs
> >>>> [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: err=
or -16
> >>>> [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, lis=
t_empty(&dpm_prepared_list)? 1
> >>>> [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchron=
ize_full
> >>>>
> >>>> The extra prints are because of:
> >>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >>>> index d9d4fc58bc5a..3efe538c2ec2 100644
> >>>> --- a/drivers/base/power/main.c
> >>>> +++ b/drivers/base/power/main.c
> >>>> @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
> >>>>                         break;
> >>>>                 }
> >>>>         }
> >>>> +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepare=
d_list)? %d\n",
> >>>> +              __func__, list_empty(&dpm_prepared_list));
> >>>>
> >>>>         mutex_unlock(&dpm_list_mtx);
> >>>>
> >>>> +       pr_err("tudor: %s: before async_synchronize_full\n", __func_=
_);
> >>>>         async_synchronize_full();
> >>>> +       pr_err("tudor: %s: after async_synchronize_full();\n", __fun=
c__);
> >>>> +
> >>>>         if (!error)
> >>>>                 error =3D async_error;
> >>>>
> >>>> The synchronous suspend works because its strict, one-by-one orderin=
g
> >>>> ensures that device dependencies are met and that no device is suspe=
nded
> >>>> while another is still using it. The asynchronous suspend fails beca=
use
> >>>> it creates a race condition where the lwis-eeprom-m24c64x is called =
for
> >>>> suspension before the process using it has been suspended, leading t=
o a
> >>>> fatal "device busy" error. Should the failure of a device suspend be
> >>>> fatal?
> >>>
> >>> It shouldn't in principle, but it depends on what exactly is involved=
 and how.
> >>>
> >>> It looks like something is blocking on power.completion somewhere.
> >>> I'll check the code, maybe a complete() is missing in an error path o=
r
> >>> similar.
> >>
> >> It doesn't look like anything is missing in the core, so the suspend
> >> failure seems to be triggering a deadlock of some sort.
> >
> > Well, I'm taking this back.
> >
> > The following scenario definitely can happen:
> >
> > 1. Device A is async and it depends on device B that is sync.
> > 2. Async suspend is scheduled for A before the processing of B is start=
ed.
> > 3. A is waiting for B.
> > 4. In the meantime, an unrelated device fails to suspend and returns an=
 error.
> > 5. The processing of B doesn't start at all and its power.completion is=
 not
> >    updated.
> > 6. A is still waiting for B when async_synchronize_full() is called.
> > 7. Deadlock ensues.
> >
> > If this is what happens in your case, the (untested) patch below should=
 help
> > (unless I messed it up, that is).
>
> Thanks, Rafael.
>
> I added few prints (see updated patch below) to figure out whether
> complete_all(&dev->power.completion) is called in my case, and it seems
> it's not, I still get the APC watchdog:
>
> [  724.361425][ T8468] lwis-i2c eeprom@2: PM: calling platform_pm_suspend=
 @ 8468, parent: platform
> [  724.361751][ T8468] lwis lwis-eeprom-m24c64x: Can't suspend because ee=
prom-m24c64x is in use!
> [  724.362098][ T8468] lwis-i2c eeprom@2: PM: dpm_run_callback(): platfor=
m_pm_suspend returns -16
> [  724.362427][ T8468] lwis-i2c eeprom@2: PM: platform_pm_suspend returne=
d -16 after 679 usecs
> [  724.362750][ T8468] lwis-i2c eeprom@2: PM: failed to suspend: error -1=
6
> [  724.362999][ T8468] PM: tudor: dpm_async_suspend_complete_all: enter
> [  724.363242][ T8468] PM: tudor: dpm_suspend: before async_synchronize_f=
ull

Well, this most likely happens because ->

>
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index d9d4fc58bc5a..0e186bc38a00 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1281,6 +1281,27 @@ static void dpm_async_suspend_parent(struct device=
 *dev, async_func_t func)
>                 dpm_async_with_cleanup(dev->parent, func);
>  }
>
> +static void dpm_async_suspend_complete_all(struct list_head *device_list=
)
> +{
> +       struct device *dev;
> +
> +
> +       pr_err("tudor: %s: enter\n", __func__);
> +       guard(mutex)(&async_wip_mtx);
> +
> +       list_for_each_entry_reverse(dev, device_list, power.entry) {
> +               /*
> +                * In case the device is being waited for and async proce=
ssing
> +                * has not started for it yet, let the waiters make progr=
ess.
> +                */
> +               pr_err("tudor: %s: in device list\n", __func__);
> +               if (!dev->power.work_in_progress) {
> +                       pr_err("tudor: %s: call complete_all\n", __func__=
);
> +                       complete_all(&dev->power.completion);
> +               }
> +       }
> +}
> +
>  /**
>   * resume_event - Return a "resume" message for given "suspend" sleep st=
ate.
>   * @sleep_state: PM message representing a sleep state.
> @@ -1459,6 +1480,7 @@ static int dpm_noirq_suspend_devices(pm_message_t s=
tate)
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_late_early_li=
st);
>                         /*
>                          * Move all devices to the target list to resume =
them
>                          * properly.
> @@ -1663,6 +1685,7 @@ int dpm_suspend_late(pm_message_t state)
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_late_early_li=
st);
>                         /*
>                          * Move all devices to the target list to resume =
them
>                          * properly.
> @@ -1959,6 +1982,7 @@ int dpm_suspend(pm_message_t state)
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_late_early_li=
st);

-> There is a bug here which is not present in the patch I've sent.

It should be

        dpm_async_suspend_complete_all(&dpm_prepared_list);

It is also there in dpm_noirq_suspend_devices() above, but it probably
doesn't matter.

>                         /*
>                          * Move all devices to the target list to resume =
them
>                          * properly.
> @@ -1970,9 +1994,12 @@ int dpm_suspend(pm_message_t state)
>
>         mutex_unlock(&dpm_list_mtx);
>
> +       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
>         async_synchronize_full();
>         if (!error)
>                 error =3D async_error;
> +       pr_err("tudor: %s: after async_synchronize_full();\n", __func__);
> +
>
>         if (error)
>                 dpm_save_failed_step(SUSPEND_SUSPEND);

