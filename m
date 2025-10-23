Return-Path: <linux-pm+bounces-36760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA83C03369
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 21:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407D01A6012D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C134B697;
	Thu, 23 Oct 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utGkHyZg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C17274FFD
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248634; cv=none; b=OV7kuzRsLNstHYufWPMtvDBBAyNE5otdwaMU4H7qXNousaJi1iv2+GaBv9O2G1I7cweH0+4/Z9QGk6TcaPyzCgPTKVfkpzyN5Z9zNpPU3HuCnl4evzlpJBVeqFNh8rhxOVGt/5SZw0+8Ppa8wxq8gxFSF/labo1w6JqyeZEqLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248634; c=relaxed/simple;
	bh=yfg9AWL9wGxOd/1dxStLCQQ4YVBSCNAfIYcp1q1d/nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vf5nhVwihcb34jpGj1SuDaQW5eqkfZvkLeACTZKp9l2bxrZMRuG/QcIPkkU3UsjH5ldBmm4JkMWHfmcTNmSC+Uq268wZwJYv3LJTY4EPZSG+ybbMnDOTkgsfSyD+KSGkYJRIS36WBh/7nmPuew9l5M5oQ5XGEp8yjP8BeNPpAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utGkHyZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D35C116B1
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761248634;
	bh=yfg9AWL9wGxOd/1dxStLCQQ4YVBSCNAfIYcp1q1d/nQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=utGkHyZgfrqmoUojTQa33NTfFKzM89lHnEooR3AFNYFvDq7wdPZOQGnt09ZsmeQTr
	 HreQYYxaI32WYL6pJfTsND9HWSXxFmznzMPDizCxB30n8dxV3y1fYe4n0DKtKu2/eQ
	 eFxGnhaZKn4izMWa5d4nbRApdBw7B6G7y8I1vRFrJVQocNqs/nQ3ZsivVqVPCzZija
	 pbH0VdEbhsSq372kMLOIahZpszcnlEWfPQzjZWXrL+iy29aRry/OwT5nIfYhFTArZe
	 ZVapNnSEkyehMdtQsDgvvmu9I8siTXagjVNshmLAYdw3e3BDdy+v2qsAi/MDP7Pt/U
	 Znx/o+m0+SK/Q==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4445c606626so361245b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 12:43:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/MqPyeD0BuCmaQA6SsUZlgiW8KYC/l3eSY8yoBg07NLmtqyG945oN63JK2UwTyZpbY3cf0k23Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oVRqmi+6QTu0B4cGQkEG1sAjle4HrqtIcMzZw4ozA6nAMCBk
	f/fk/vIGja2p69r3E9CPLfMlaUUMwMEmg10/DoIx8ArcboWbWgs1/YHYLLf1ECEAMctrGEK47Ty
	sTuKn2cxeWwIFGGLHa97BNw7ofa9+9v8=
X-Google-Smtp-Source: AGHT+IFG5oyWxy+zrxDrirg9KK0X9AIkfWwJdMjTKQ1xCh4JYegXUoDz7qA89sp2mRelO8mc1ZmBepDTQr6kons/T/0=
X-Received: by 2002:a05:6808:4489:b0:441:bd1f:58c3 with SMTP id
 5614622812f47-443a3137afemr11642864b6e.53.1761248633251; Thu, 23 Oct 2025
 12:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com>
In-Reply-To: <20251017233907.2305303-1-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 21:43:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
X-Gm-Features: AS18NWCVD6C2OL7DzZWK4U1tNrNEr0wgYfnxbuUrCjcN-g41DISYupFUjldHi7c
Message-ID: <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 1:39=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> At the start of suspend and hibernate, filesystems will sync to save the
> current state of the device. However, the long tail of the filesystem
> sync can take upwards of 25 seconds. If during this filesystem sync
> there is some wakeup or abort signal, it will not be processed until the
> sync is complete; from a user's perspective, this looks like the device
> is unresponsive to any form of input.
>
> This patch adds functionality to handle a sleep abort signal when in
> the filesystem sync phase of suspend or hibernate. This topic was first
> discussed by Saravana Kannan at LPC 2024 [1], where the general
> consensus was to allow filesystem sync on a parallel thread. In case of
> abort, the suspend process will stop waiting on an in-progress
> filesystem sync, and continue by aborting suspend before the filesystem
> sync is complete.
>
> Additionally, there is extra care needed to account for back-to-back
> sleeps while maintaining functionality to immediately abort during the
> filesystem sync stage. This patch handles this by serializing the
> sequence with an invariant; a subsequent sleep's filesystem sync
> operation will only start when the previous sleep's filesystem sync has
> finished. While waiting for the previous sleep's filesystem sync to
> finish, the subsequent sleep will still abort early if a wakeup event is
> triggered, solving the original issue of filesystem sync blocking abort.

It would be good to spell out the rationale for starting another
filesystem sync when suspend starts while the previous sync is still
in progress.

> [1]: https://lpc.events/event/18/contributions/1845/
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
> Changes in v5:
> - Update spin_lock() to spin_lock_irqsave() since abort can be in IRQ con=
text
> - Updated changelog description to be more precise regarding continuing a=
bort
>   sleep before fs_sync() is complete
> - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_sync()
> - Simplify from a goto to do-while in pm_sleep_fs_sync()
> - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wusamuel@=
google.com
>
> Changes in v4:
> - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> - Squashed patches 2/3 and 3/3 from v3 into this single patch
> - Added abort during fs_sync functionality to hibernate in addition to su=
spend
> - Moved variables and functions for abort from power/suspend.c to power/m=
ain.c
> - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamuel@=
google.com/
>
> Changes in v3:
> - Split v2 patch into 3 patches
> - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) conditio=
n
> - Updated documentation and comments within kernel/power/suspend.c
> - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamuel@=
google.com/
>
> Changes in v2:
> - Added documentation for suspend_abort_fs_sync()
> - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration stat=
ic
> - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamuel@=
google.com
>
>  drivers/base/power/wakeup.c |  8 ++++
>  include/linux/suspend.h     |  4 ++
>  kernel/power/hibernate.c    |  5 ++-
>  kernel/power/main.c         | 75 +++++++++++++++++++++++++++++++++++++
>  kernel/power/suspend.c      |  7 +++-
>  5 files changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..689c16b08b38 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_sou=
rce *ws)
>
>         /* Increment the counter of events in progress. */
>         cec =3D atomic_inc_return(&combined_event_count);
> +       /*
> +        * wakeup_source_activate() aborts sleep only if events_check_ena=
bled
> +        * is set (see pm_wakeup_pending()). Similarly, abort sleep durin=
g
> +        * fs_sync only if events_check_enabled is set.
> +        */
> +       if (events_check_enabled)
> +               pm_stop_waiting_for_fs_sync();
>
>         trace_wakeup_source_activate(ws->name, cec);
>  }
> @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  void pm_system_wakeup(void)
>  {
>         atomic_inc(&pm_abort_suspend);
> +       pm_stop_waiting_for_fs_sync();
>         s2idle_wake();
>  }
>  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index b02876f1ae38..dc6829b3836f 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -450,6 +450,8 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern void pm_stop_waiting_for_fs_sync(void);
> +extern int pm_sleep_fs_sync(void);
>  extern void pm_report_hw_sleep_time(u64 t);
>  extern void pm_report_max_hw_sleep(u64 t);
>  void pm_restrict_gfp_mask(void);
> @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void) {}
>  static inline void pm_restore_gfp_mask(void) {}
>
>  static inline void ksys_sync_helper(void) {}
> +static inline pm_stop_waiting_for_fs_sync(void) {}
> +static inline int pm_sleep_fs_sync(void) {}
>
>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 14e85ff23551..9c8db4b3c114 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -824,7 +824,10 @@ int hibernate(void)
>         if (error)
>                 goto Restore;
>
> -       ksys_sync_helper();
> +       error =3D pm_sleep_fs_sync();
> +       if (error)
> +               goto Restore;
> +
>         if (filesystem_freeze_enabled)
>                 filesystems_freeze();
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 3cf2d7e72567..81a53d833358 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -570,6 +570,81 @@ bool pm_sleep_transition_in_progress(void)
>  {
>         return pm_suspend_in_progress() || hibernation_in_progress();
>  }
> +
> +static bool pm_sleep_fs_sync_queued;
> +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> +
> +/**
> + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep early
> + *
> + * This function causes the suspend process to stop waiting on an in-pro=
gress
> + * filesystem sync, such that the suspend process can be aborted before =
the
> + * filesystem sync is complete.
> + */
> +void pm_stop_waiting_for_fs_sync(void)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> +       complete(&pm_sleep_fs_sync_complete);
> +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> +}
> +
> +static void sync_filesystems_fn(struct work_struct *work)
> +{
> +       unsigned long flags;
> +
> +       ksys_sync_helper();
> +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> +       pm_sleep_fs_sync_queued =3D false;
> +       complete(&pm_sleep_fs_sync_complete);
> +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> +}
> +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> +
> +/**
> + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> + *
> + * Return 0 on successful file system sync, otherwise returns -EBUSY if =
file
> + * system sync was aborted.
> + */
> +int pm_sleep_fs_sync(void)
> +{
> +       bool need_pm_sleep_fs_sync_requeue;
> +       unsigned long flags;
> +
> +       do {
> +               spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> +               reinit_completion(&pm_sleep_fs_sync_complete);
> +               /*
> +                * Handle the case where a sleep immediately follows a pr=
evious
> +                * sleep that was aborted during fs_sync. In this case, w=
ait for
> +                * the previous filesystem sync to finish. Then do anothe=
r
> +                * filesystem sync so any subsequent filesystem changes a=
re
> +                * synced before sleeping.
> +                */
> +               if (pm_sleep_fs_sync_queued) {
> +                       need_pm_sleep_fs_sync_requeue =3D true;
> +               } else {
> +                       need_pm_sleep_fs_sync_requeue =3D false;
> +                       pm_sleep_fs_sync_queued =3D true;
> +                       schedule_work(&sync_filesystems);
> +               }
> +               spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> +
> +               /*
> +                * Completion is triggered by fs_sync finishing or an abo=
rt sleep
> +                * signal, whichever comes first
> +                */
> +               wait_for_completion(&pm_sleep_fs_sync_complete);
> +               if (pm_wakeup_pending())
> +                       return -EBUSY;
> +       } while (need_pm_sleep_fs_sync_requeue);
> +
> +       return 0;
> +}

If I'm not mistaken, the mechanism by which one more sync is started
right after completing the previous one (that was in progress when
suspend started) can be designed differently.

1. Use a dedicated ordered workqueue for the sync work items.
2. Use a counter instead of the two boolean vars for synchronization.
3. In pm_sleep_fs_sync(), if the counter is less than 2, increment the
counter and queue up a sync work item.
4. In sync_filesystems_fn(), decrement the counter.

