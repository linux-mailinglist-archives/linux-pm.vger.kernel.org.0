Return-Path: <linux-pm+bounces-33883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DBB4464B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581F17A8960
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23827270EA3;
	Thu,  4 Sep 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoGv6uoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F326FA77;
	Thu,  4 Sep 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013766; cv=none; b=cCSCTQuShhL6310X08IJ7eg6qaby6T7Xa0dZjDWpqVCglhY+CvMYp4GAUYvh+GOjJ4GvsUsRHST42i4qstQ7Kxh7HCgB/08LABWC+XENceAV+zL7Lgcp1upPGh2+a8AVS2PgPr99pyJP1gvTpoZtCcsdxK+rzo7qCB3fps7b6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013766; c=relaxed/simple;
	bh=imgzl0GpQeVKzCfE6gEydUMdd8vUQh8ZoAbbRZHrOIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYxqIAGQA76JIGqiM1eJolnXiFaFdUxlEddYyZIP6b9kwk43ma8yBb23uwWPV7C9TzUOxusCHu3+wUZhTLocvFMdQIBm4YMe+FByEkG/bGB68H/JBP+1xI2veyycYkZfV4vp9RLWtTYVcNwKgj+GL9uFD2ey20D4BWQQbcTBW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoGv6uoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B31C4CEF1;
	Thu,  4 Sep 2025 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757013765;
	bh=imgzl0GpQeVKzCfE6gEydUMdd8vUQh8ZoAbbRZHrOIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IoGv6uoKDBKz8ANaamyJD5zu6WaZAhb2Y16Pblw7Vli3SZUcEtQG7HmYYukRhMUNT
	 t0DOJ98uF+u4Fh2lBMZaTBuM/sjyPIHFyIs8Yb1OTHZUQ2AbhLd4Zi4SYkYWbeLipJ
	 31MktMIcdBjtw5+IMka6o/h9acVJyZW8t5Lw0rUS5eharqt7PsLQm+D+79SNhY7aHr
	 6FZ0k8Lj18yv04gmwsy07a1xqqeGO+WZcB+JVarIl54On+fjGn5vJZdnVqIHx3pi1L
	 gFIvqOsJNtd76JuTtnckpIZgDbUMlIOHTCiDvp3benPMFcY1byXWsDl1xZna6E81vH
	 jghVxUEChF2JA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7452b1964f3so1245364a34.1;
        Thu, 04 Sep 2025 12:22:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZnYeB5AFtwdPAF7G7nfIUyIdWIiizrGe/55/Ne16BqypzhFkWmwiD7zikYehJEZj16AfO8XnQzzZtNoU=@vger.kernel.org, AJvYcCWAfJp7TZFnNtljlsATuXTvX7Sz99LTY6P9qOLkMv+CyzS50DcBArqEHto6kWcxHPmelnpe9nVj3VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQ1J6O83fXNlfgOBOFbTQ2fv7AfQLrklT5/Snl8JLrlNxHOJ6
	/gioxQKNq/XfnGMrvYXfZKfPq6kos8QqiH+je9WOblQTZmbYjhiNbLdAMDCpYZ69ZmcXdQWe98s
	iPJ6bEaT8Ku+y09JDbnQ231LbuSNOVGY=
X-Google-Smtp-Source: AGHT+IFM6/sFS2mDHgcgGHNCL5AfMV/YnqE7nabBNO4T+RFOnFZpdIDqxdpg5dmE8uao54dDSL/JuHHbJcgEB3CZEzk=
X-Received: by 2002:a05:6830:7304:b0:741:9157:7179 with SMTP id
 46e09a7af769-74569e7c487mr11159896a34.21.1757013764701; Thu, 04 Sep 2025
 12:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-3-wusamuel@google.com>
In-Reply-To: <20250821004237.2712312-3-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 21:22:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com>
X-Gm-Features: Ac12FXyH503CzaOByxRl6IPdz5TqiTIxw3NRpUc4ttnpacQxKdlz6_C-_7Mm36Y
Message-ID: <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:43=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> At the start of suspend, filesystems will sync to save the current state
> of the device. However, the long tail of the filesystem sync can take
> upwards of 25 seconds. If during this filesystem sync there is some
> wakeup or abort signal, it will not be processed until the sync is
> complete; from a user's perspective, this looks like the device is
> unresponsive to any form of input.
>
> This patch adds functionality to handle a suspend abort signal when in
> the filesystem sync phase of suspend. This topic was first discussed by
> Saravana Kannan at LPC 2024 [1], where the general consensus was to
> allow filesystem sync on a parallel thread.
>
> [1]: https://lpc.events/event/18/contributions/1845/
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>

The idea is fine with me, but I have comments on the implementation.

First off, I'm not sure how the split of patch [3/3] from this one
helps because that patch adds mandatory functionality.  Patch [2/3]
cannot be applied without patch [3/3], so as far as I'm concerned, it
is not applicable at all.

> ---
>  drivers/base/power/wakeup.c |  8 +++++++
>  include/linux/suspend.h     |  2 ++
>  kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..af4cf3e6ba44 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_sou=
rce *ws)
>
>         /* Increment the counter of events in progress. */
>         cec =3D atomic_inc_return(&combined_event_count);
> +       /*
> +        * wakeup_source_activate() aborts suspend only if events_check_e=
nabled
> +        * is set (see pm_wakeup_pending()). Similarly, abort suspend dur=
ing
> +        * fs_sync only if events_check_enabled is set.
> +        */
> +       if (events_check_enabled)
> +               suspend_abort_fs_sync();
>
>         trace_wakeup_source_activate(ws->name, cec);
>  }
> @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  void pm_system_wakeup(void)
>  {
>         atomic_inc(&pm_abort_suspend);
> +       suspend_abort_fs_sync();
>         s2idle_wake();
>  }
>  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 317ae31e89b3..68d2e8a7eeb1 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
>
>  extern int pm_suspend(suspend_state_t state);
>  extern bool sync_on_suspend_enabled;
> +extern void suspend_abort_fs_sync(void);
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> @@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(void) { r=
eturn false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops)=
 {}
>  static inline void s2idle_wake(void) {}
> +static inline void suspend_abort_fs_sync(void) {}
>  #endif /* !CONFIG_SUSPEND */
>
>  static inline bool pm_suspend_in_progress(void)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 4bb4686c1c08..edacd2a4143b 100644
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
> @@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
>  }
>  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
>
> +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> +
> +/**
> + * suspend_abort_fs_sync - Abort fs_sync to abort suspend early

This name is kind of misleading because the function doesn't abort
fs_sync.  It aborts suspend while fs_sync is in progress.

The fs_sync is continuing and needs to be waited for to complete, at
least in subsequent suspend/hibernate cycles.

Does system shutdown need to wait for it too?

> + *
> + * This function aborts the fs_sync stage of suspend so that suspend its=
elf can
> + * be aborted early.
> + */
> +void suspend_abort_fs_sync(void)
> +{
> +       complete(&suspend_fs_sync_complete);
> +}
> +
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
>         unsigned int sleep_flags;
> @@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
>         local_irq_enable();
>  }
>
> +static void sync_filesystems_fn(struct work_struct *work)
> +{
> +       ksys_sync_helper();
> +       complete(&suspend_fs_sync_complete);
> +}
> +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> +
> +/**
> + * suspend_fs_sync_with_abort - Trigger fs_sync with ability to abort
> + *
> + * Return 0 on successful file system sync, otherwise returns -EBUSY if =
file
> + * system sync was aborted.
> + */
> +static int suspend_fs_sync_with_abort(void)

The "with_abort" part is not needed in this name and I'd prefer
pm_sleep_ to be used instead of suspend_

> +{
> +       reinit_completion(&suspend_fs_sync_complete);
> +       schedule_work(&sync_filesystems);

If you used a dedicated workqueue for this, waiting for the previously
scheduled filesystems sync would be as simple as calling
flush_workqueue(pm_fs_sync_wq);

> +       /*
> +        * Completion is triggered by fs_sync finishing or a suspend abor=
t
> +        * signal, whichever comes first
> +        */
> +       wait_for_completion(&suspend_fs_sync_complete);
> +       if (pm_wakeup_pending())
> +               return -EBUSY;
> +
> +       return 0;
> +}
> +
>  /**
>   * suspend_enter - Make the system enter the given sleep state.
>   * @state: System sleep state to enter.
> @@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
>         if (state =3D=3D PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> +       pm_wakeup_clear(0);
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -               ksys_sync_helper();
> +               error =3D suspend_fs_sync_with_abort();

The same thing would also be useful for hibernation.  Is there any
reason for not doing it there?

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

