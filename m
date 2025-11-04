Return-Path: <linux-pm+bounces-37383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA05C32B54
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 19:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0464E2893
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57333BBBC;
	Tue,  4 Nov 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxK/pcKI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F52CCC5
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282336; cv=none; b=iB1pjNwM93gjrsQtbKvZyhhC+978dBge7YSiduewSTgpt8t8nB8ETPBhRfcj/HiuKwQWERY02K3GI1b/3rfyWF2rtOtCSukVD6ATZOnEBeYT+BXI0DH/sxdho9/3b/AEymoK7evw5oG/cSNqHyHZztSHEmRVIlwBRwJG1NoTucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282336; c=relaxed/simple;
	bh=avC7b+3xiPbCx+s77oGh8yEmaxeXEduSTSnIsjlfEQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+rXXsjSbzIOFf6+p8bgBFl/6np3Plf8Asa3dn+gWeALhPWioirHD9ihgP8o0wHhwvOwLbDhXyfS7yi0rnF+lu6yDbGCUN4uCgSGlDilA+hMnwIqrbjVAigupxVhpnFE6AQgB0O4R+q2Hv8gfA6DqWyp3tbsynLmY4qb4HZGYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxK/pcKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A0C116D0
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762282336;
	bh=avC7b+3xiPbCx+s77oGh8yEmaxeXEduSTSnIsjlfEQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AxK/pcKIRnApjUYcl9uil8u3IzRqoE4eIqXMKvqs00oBl61yF10y7png9OBT3aQRN
	 quGmpeKzG1kZc3Hs1dD2W84tNn1iQcthnI8hOwNdiKhgXCg8T1SHkpOATmmjSsNaF/
	 NKtTK5bTRMiAjR2rYpdtwZce0IeTLyAaegp3BHnpTlKgtwpgKc2IdPGyhViACPP6Th
	 qkXp3BGbjbEoRn2bTXD+5eHpgFG8NDbIzkaqVKRgzpEO5jzGjE5zuR64AwPb8Y+3Q6
	 TaY/OHM0VIrC01fDZw+NnfzlG+im1VN/v7mTAanuyzXyn1yl112Axyr25usFruvQIa
	 1TeX9oTseAduA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-656b32a0cc4so240626eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 10:52:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFoNGl8UCENiNi6RG3ElYVZZqsTPnv0BAGC/531cKofAEJ3CkUMW7/sfa5E8HJhy9byZLG2mGBSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/up+67X/1xJl0hvITOTgrhAtptO4jlRro1YTqnDV+XK9eblr
	vb+2HsM/6btzglq8ElHHr+KFMd/q/t2abn7+DQ8O45h5+zu4fwJ+JE0blSSjUN+1muRVBoJAd21
	2/3vEeP9Bk4M+DBmzB1hVnV9XoTukPYs=
X-Google-Smtp-Source: AGHT+IH8D6yx0YUpcs7+ZieKnEh+aQ2mXyltMfZKUXcnlQjaLiwp59/SbD+G7DQKCQ+46we2g8i41BTrb6VJJRqKgr4=
X-Received: by 2002:a05:6808:21aa:b0:44e:c106:8192 with SMTP id
 5614622812f47-44fed318ce3mr176398b6e.11.1762282335291; Tue, 04 Nov 2025
 10:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030210110.298612-1-wusamuel@google.com>
In-Reply-To: <20251030210110.298612-1-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 19:52:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQW4WMiFEqSUNK7drgYfAsIRfAIBn5ujpwJwEx4UZpZGSny_GdVggcv3o
Message-ID: <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:01=E2=80=AFPM Samuel Wu <wusamuel@google.com> wr=
ote:
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
> filesystem sync stage. Furthermore, in the case of the back-to-back
> sleeps, a subsequent filesystem sync is needed to ensure the latest
> files are synced right before sleep. If necessary, a subsequent sleep's
> filesystem sync will be queued, and will only start when the previous
> sleep's filesystem sync has finished. While waiting for the previous
> sleep's filesystem sync to finish, the subsequent sleep will still abort
> early if a wakeup event is triggered, solving the original issue of
> filesystem sync blocking abort.
>
> [1]: https://lpc.events/event/18/contributions/1845/
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
> Changes in v6:
> - Use spin_lock_irq() in thread context
> - Use dedicated ordered workqueue for sync work items
> - Use a counter instead of two bools for synchronization
> - Queue fs_sync if it's not already pending on workqueue
> - pm_wakeup_clear(0) is prequisite to this feature, so move it within fun=
ction
> - Updated commit text for motive of back-to-back fs syncs
> - Tighter lock/unlock around setup, checks, and loop
> - Fix function definitions for CONFIG_PM_SLEEP=3Dn
> - v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-wusamuel@=
google.com/
>
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
>  kernel/power/main.c         | 81 +++++++++++++++++++++++++++++++++++++
>  kernel/power/suspend.c      |  4 +-
>  5 files changed, 100 insertions(+), 2 deletions(-)
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
> index b02876f1ae38..4795f55f9cbe 100644
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
> +static inline void pm_stop_waiting_for_fs_sync(void) {}
> +static inline int pm_sleep_fs_sync(void) { return 0; }
>
>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 53166ef86ba4..1874fde4b4f3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -820,7 +820,10 @@ int hibernate(void)
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
> index a6cbc3f4347a..23ca87a172a4 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
>  {
>         return pm_suspend_in_progress() || hibernation_in_progress();
>  }
> +
> +static int pm_sleep_fs_syncs_queued;
> +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> +static struct workqueue_struct *pm_fs_sync_wq;
> +
> +static int __init pm_start_fs_sync_workqueue(void)
> +{
> +       pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync_wq", 0);
> +
> +       return pm_fs_sync_wq ? 0 : -ENOMEM;
> +}
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

Apart from the kernel test robot reports,
pm_stop_waiting_for_fs_sync() has become slightly too heavy for
calling it from wakeup_source_activate().

Waking up the suspend process from there should be sufficient.  The
completion is not necessary for that in principle.

