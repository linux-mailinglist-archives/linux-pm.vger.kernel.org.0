Return-Path: <linux-pm+bounces-35603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06375BAE50E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187563243F8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE55233721;
	Tue, 30 Sep 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTpNr6ro"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72726AA94
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257011; cv=none; b=MM6RZAHHgObd3RQP/73CN1n47j6vbzEFrNbPXhdQmlqNaHpaI4qW6NtcJZWfEDYCz19PHT0NyhS1DD8e/6e5sF0UJFecHDlDv9h0qfhsYjUpBRe3ZiqdFJytCdhO+xB3uZ/4Ztdphxe89EtNU93z1T0Y681YvYHGxMmW7mmzL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257011; c=relaxed/simple;
	bh=2fprUro17ie4PWIC19iF6b3Q4lDTyuS1p+GZtbylDuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ks3iNZiCJ85QGZfiz6LVEtdIekKaqCXTzxKYl9R+ylAC5eM85ciRI9fLOBoR/ysR+FOkYNiI/iiVWHBbGRdtUZXNPXSIXmCsqciXk8gAjcckQY78SLFlyTZXy1UDDIgmElRhfTbc0P/4DMEifTlz4qot8+NN3oF+RZcKr7JnP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTpNr6ro; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e44f22f15so448205766b.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759257007; x=1759861807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azc7KtpOmq9KDMPymszDCWdQCW8aPtYjtZWF1NvbqVw=;
        b=NTpNr6roz5c07/YhgskGXEXo0KVr2vR84PxLvVGO256TLL5+kjqM9ChQVW34A5AQJr
         FlBQ+bjRxvaTEg8/oV3LwLG0UFsC6s1U3npxziIkkPIW9b88MmjFdOypoy7YIt1liuN2
         PeOSnIIxTDhMY9tKQauI6NR6t4UZcId+3KOrx3d6amrUM5A1RL98qRUnkVPZqEQa0LM3
         lbDO7VAxA8zToleRms48eQyTNijFYslfOo8pjLlL4kp9ThbDNBXmboqamA51cG2bT6hO
         HJ1GWlTfdYLvZkwn1eRFVkFt0Dmkw9wzFgCm4bnnhBtTDRDIHFHzI7S2YcQY4zWh6M5P
         XUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759257007; x=1759861807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azc7KtpOmq9KDMPymszDCWdQCW8aPtYjtZWF1NvbqVw=;
        b=rqlj6mf3PB+e1IWzaVdOVKrWLFV+W4O9VLCGloQRTtuQ1+XRk1A6Gw3f81ygSggW2Q
         rHN67431w4keLmcXw/onjpYvBMHnCrpzoww5Ltzqgcv9jKYSBTN/l5Z9s9E3UnT6obz0
         58HvFxUimGYlKv+I7y3zvIZl0mVVcqDgkaPRo7g11crgcBKjnLIf3/ecAXrHHhs1/0/w
         Wf9x0DotGoHap+p7F/ffX2Kf0rJNcaeBdDr3Bkn7k5rNyyfej524mQdeIcJgJCHm41sn
         NBh5xeSnHpA3n2Pl9NtCTxk1014a9oFtUZ3zcr6lUMfLkFHjgaTeGNrNWMX5SiV63aC3
         GOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUezQfNuEl/emQiJB+QOLm8VAZGbxq4knyK+uNUWorP+j6Xvf+iVx8sgG9Xs9zlCvumGK4BJaryFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbC+WLj2vsrqM4gq0gIGlkQLcSfCSGvlptOoVeJLJW+cXjc62A
	t/8YEDkmmK+gSSykdWIUSmlneDgGfzl2kGT1WURBy8mSfIz+1Q3mthU5XVi5CWE/3hTh+J18s1R
	eWyPKaO6AfzH0tAxcRVtnvFdwRIbq9meaDtwdDcCxLOtMR0gvwwg4FNqKdK4=
X-Gm-Gg: ASbGncvtnJncwGcGF0ocrChlkX4AUjAvSKCYPywVOhcXoa5HaEJ13YW/ZHYjWqiiGAu
	WTk3qS7/B2o5VWV9HYzqU75tlYWeYkp7yfrv72Q2VwwkWlwplLiuIxuiIvYPOg7mhS8nNaEkP4U
	QQoLlCNBQtXt/wyHKny2+CLvDPQFvo1my204T5uHfnYSLkr4o0H6xKKFLNofPR7zLFSln4Afkku
	Ah7Ux53OXdSMvIPPeI5rZ51V+BiUfzewn/HezdM+c0yhAUdzlLfz28vA/Awah50+A==
X-Google-Smtp-Source: AGHT+IFqyjh3mPi6+6FMhbJxPgb4CS8XWaueZwWZ7jmSqYonihtdGx0W4eJbXZ1PgK6LIyQhWOzkc1AMKLrRUFaUZ4k=
X-Received: by 2002:a17:907:3f07:b0:b3d:656b:9088 with SMTP id
 a640c23a62f3a-b46e76d4513mr79822066b.54.1759257006426; Tue, 30 Sep 2025
 11:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com>
In-Reply-To: <20250911185314.2377124-1-wusamuel@google.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 30 Sep 2025 11:29:55 -0700
X-Gm-Features: AS18NWCN3wIoqj5C8qOe4_WKtiqUobJBhX36tYVcGEANfyeWSp89LsVfvj9OYv0
Message-ID: <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Just a friendly ping on this patch. Please let me know if there's any
feedback or if you'd like me to make any changes.

Thanks,
Sam

On Thu, Sep 11, 2025 at 11:53=E2=80=AFAM Samuel Wu <wusamuel@google.com> wr=
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
> 2.51.0.384.g4c02a37b29-goog
>

