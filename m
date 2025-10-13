Return-Path: <linux-pm+bounces-35989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6533FBD5AAE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F195420A5F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33BD2D29CF;
	Mon, 13 Oct 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIQVVXRD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5A1E3DED
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379358; cv=none; b=O8CRahHPRV7D7wAWhbVveCZB5JrNI4FlK0SdxpDZ76zq7zsdsaPq8F1vxuZ7HEjzRLLzaKKbVpKMM7+9ua2oZiptZ5XEniRxWv4Mgvv5iddxEExQyniJbt9HLPn4zTx2UWskpQFfAmOmgZYmoEU+VTnjn7+35o6tyNCotRW8ZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379358; c=relaxed/simple;
	bh=39Bihwuyj0kswX1uR6OagctOFpu74iCGgBrVRRbmDJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPn+boF+LzifVD8j4Nbb1v3SeNRWa8xXvd7v1VXWQ/u8nD3Ez+lColfg9pNIPOgRX2KANVMSr6i2eys7ZSAWSQqArMoNZagHcqfuo3Tr7ho+3TSvJyTERXp0IFjiUkMvwwpUNl/3Bex5qeO+yyvd1zcFxK9x65jNCRk5NdffDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIQVVXRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D476DC4CEF8
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760379357;
	bh=39Bihwuyj0kswX1uR6OagctOFpu74iCGgBrVRRbmDJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eIQVVXRDBel8FQMSm10IHmpq/ZhPl5uaaF2Ir5xCSZS5Sb4oEURjNLOtePgPvaG7u
	 VChKyxKyanpLldm2xW8aTNCIsgz7anTRLcqV5o82nzLxlnQPtZZwglzzcD4kiUNkF5
	 MO3uqSBHowva5OdxRaD5P6wYgJusvvum9cLJBI1nr/If906O42fUEoTtKLMvfe9mqb
	 2kLPcY86D3mIK1kzLpA6cjXs/OpypvapKklnen06xb3Y+66/wptLXf5AZlGr6B7pns
	 id9P2nR9SGVjorxGWRJmgQGJES2Oqms9MrslHNisyeJNDGc8BV1QtRuPxZExIw+b4b
	 PJ2T8cQZqJ9aA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65033a46f05so463857eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:15:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4VzMEXyqLds54MiiX6jYSUvCUgXrAdomwcMI72x5EYUnvt013aD/qNORL0UawFb5XhrMDsLQJuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw968+KfvBFJXA9pBs72uVFehghaSGGNEvFSEzp5TLSB1dHeM1v
	RLNd9UOC1+B3HVOAVPKan4pazPSlvnzMM9M9ZnEo0tfT8zBcK7RqJMAndyKVZnELEj4Ank6TO6N
	q0mvTP2Z2NCZjOJxWoMIACbRDJK9H8WM=
X-Google-Smtp-Source: AGHT+IHU3clNmooNydVRjInZF1BupdgXjUJnrtX4kBqj8XAYJvGTUDLXKHtexjaguf39DKVwmvsuV0hWZmyDHp8PmLE=
X-Received: by 2002:a05:6808:120d:b0:439:a7bf:4b2 with SMTP id
 5614622812f47-4417b3bef54mr9619078b6e.39.1760379357099; Mon, 13 Oct 2025
 11:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com>
In-Reply-To: <20250911185314.2377124-1-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:15:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
X-Gm-Features: AS18NWCkAwMVs1H0ICC_862a4NLrQDCgYdqYvsqaQhxiR6nJbaEKMwBHVlwUbcg
Message-ID: <CAJZ5v0hwgNt3+stLDpdVbrpDfomEaQ26KikUDFN2QjBpNMgbfQ@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:53=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
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
> discussed specifically for suspend by Saravana Kannan at LPC 2024 [1],
> where the general consensus was to allow filesystem sync on a parallel
> thread. The same logic applies to both suspend and hibernate code paths.
>
> There is extra care needed to account for back-to-back sleeps while
> still maintaining functionality to immediately abort during the
> filesystem sync stage.
>
> This patch handles this by serializing the filesystem sync sequence with
> an invariant; a subsequent sleep's filesystem sync operation will only
> start when the previous sleep's filesystem sync has finished. While
> waiting for the previous sleep's filesystem sync to finish, the
> subsequent sleep will still abort early if a wakeup event is triggered,
> solving the original issue of filesystem sync blocking abort.
>
> [1]: https://lpc.events/event/18/contributions/1845/
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
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
>  drivers/base/power/wakeup.c |  8 +++++
>  include/linux/suspend.h     |  4 +++
>  kernel/power/hibernate.c    |  5 ++-
>  kernel/power/main.c         | 70 +++++++++++++++++++++++++++++++++++++
>  kernel/power/suspend.c      |  7 ++--
>  5 files changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..daf07ab7ac3f 100644
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
> +               abort_sleep_during_fs_sync();
>
>         trace_wakeup_source_activate(ws->name, cec);
>  }
> @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  void pm_system_wakeup(void)
>  {
>         atomic_inc(&pm_abort_suspend);
> +       abort_sleep_during_fs_sync();
>         s2idle_wake();
>  }
>  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 317ae31e89b3..c961bdb00bb6 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -444,6 +444,8 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern void abort_sleep_during_fs_sync(void);
> +extern int pm_sleep_fs_sync(void);
>  extern void pm_report_hw_sleep_time(u64 t);
>  extern void pm_report_max_hw_sleep(u64 t);
>  void pm_restrict_gfp_mask(void);
> @@ -499,6 +501,8 @@ static inline void pm_restrict_gfp_mask(void) {}
>  static inline void pm_restore_gfp_mask(void) {}
>
>  static inline void ksys_sync_helper(void) {}
> +static inline abort_sleep_during_fs_sync(void) {}
> +static inline int pm_sleep_fs_sync(void) {}
>
>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2f66ab453823..651dcd768644 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -811,7 +811,10 @@ int hibernate(void)
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
> index 3cf2d7e72567..38b1de295cfe 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -570,6 +570,76 @@ bool pm_sleep_transition_in_progress(void)
>  {
>         return pm_suspend_in_progress() || hibernation_in_progress();
>  }
> +
> +static bool pm_sleep_fs_sync_queued;
> +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> +
> +/**
> + * abort_sleep_during_fs_sync - Abort fs_sync to abort sleep early
> + *
> + * This function aborts the fs_sync stage of suspend/hibernate so that
> + * suspend/hibernate itself can be aborted early.

This changelog needs to be more precise IMV.

I'd actually call the function something like
pm_stop_waiting_for_fs_sync() and I'd say in the changelog that the
functions causes a suspend process to stop waiting on an fs sync in
progress and continue so that it can be aborted before the fs sync is
complete.

> + */
> +void abort_sleep_during_fs_sync(void)
> +{
> +       spin_lock(&pm_sleep_fs_sync_lock);
> +       complete(&pm_sleep_fs_sync_complete);
> +       spin_unlock(&pm_sleep_fs_sync_lock);
> +}
> +
> +static void sync_filesystems_fn(struct work_struct *work)
> +{
> +       ksys_sync_helper();
> +
> +       spin_lock(&pm_sleep_fs_sync_lock);
> +       pm_sleep_fs_sync_queued =3D false;
> +       complete(&pm_sleep_fs_sync_complete);
> +       spin_unlock(&pm_sleep_fs_sync_lock);
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
> +
> +Start_fs_sync:
> +       spin_lock(&pm_sleep_fs_sync_lock);
> +       reinit_completion(&pm_sleep_fs_sync_complete);
> +       /*
> +        * Handle the case where a sleep immediately follows a previous s=
leep
> +        * that was aborted during fs_sync. In this case, wait for the pr=
evious
> +        * filesystem sync to finish. Then do another filesystem sync so =
any
> +        * subsequent filesystem changes are synced before sleeping.

Is the extra sync really necessary?

Some files may still be updated after it is complete and before all
tasks are frozen.

> +        */
> +       if (pm_sleep_fs_sync_queued) {
> +               need_pm_sleep_fs_sync_requeue =3D true;
> +       } else {
> +               need_pm_sleep_fs_sync_requeue =3D false;
> +               pm_sleep_fs_sync_queued =3D true;
> +               schedule_work(&sync_filesystems);
> +       }
> +       spin_unlock(&pm_sleep_fs_sync_lock);
> +
> +       /*
> +        * Completion is triggered by fs_sync finishing or an abort sleep
> +        * signal, whichever comes first
> +        */
> +       wait_for_completion(&pm_sleep_fs_sync_complete);
> +       if (pm_wakeup_pending())
> +               return -EBUSY;
> +       if (need_pm_sleep_fs_sync_requeue)
> +               goto Start_fs_sync;

Wouldn't a do { .. } while () work here instead of the goto?

> +
> +       return 0;
> +}
> +
>  #endif /* CONFIG_PM_SLEEP */
>
>  #ifdef CONFIG_PM_SLEEP_DEBUG
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 4bb4686c1c08..c019a4396c1f 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -31,6 +31,7 @@
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
>  #include <linux/fs.h>
> +#include <linux/workqueue.h>
>
>  #include "power.h"
>
> @@ -588,14 +589,16 @@ static int enter_state(suspend_state_t state)
>         if (state =3D=3D PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> +       pm_wakeup_clear(0);
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -               ksys_sync_helper();
> +               error =3D pm_sleep_fs_sync();
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +               if (error)
> +                       goto Unlock;
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> -       pm_wakeup_clear(0);
>         pm_suspend_clear_flags();
>         error =3D suspend_prepare(state);
>         if (error)
> --

