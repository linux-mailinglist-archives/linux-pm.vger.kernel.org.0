Return-Path: <linux-pm+bounces-32665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF0B2D0A6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 02:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26B31BC76E3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 00:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A913A3F7;
	Wed, 20 Aug 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1iutjie"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04711E573
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649387; cv=none; b=bAr6qkrR9vYF/6wwocuNZC1JFh4BJB/OXBeaD9vzgfgi7bUHn8wfCivYkZNohEVsPTPhE2569RgfiGa7EQMlL3tQBF+VKno8RYqUrWJqgRM3E0oTjwDjzcqBinhX18VXAt491VmXwNPT56vdtk/A2itDLv20nyfwsuijgT22e2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649387; c=relaxed/simple;
	bh=OPus0vxolO/VNPHiO1/7rlNF53uJLn7GHPKb0g58/7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4FkhCWGMVqwSTAqzLfsoisyFFPhZhqVd9feYr17HzHVgeh5CkuaAlBpL3WVLX6zKfVBgYNNYIqQGrDl5UCC/22fRKpgW1BN/j+ljGP9WAb7Cl9sexE4IUg6h5yziTq8SezPn4jQLLgPCWziYWW1izLQbNkPcRsvkeqjKLqtaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1iutjie; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-50f8bf6a9d7so1555059137.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755649384; x=1756254184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkNKxOXnA841VLAMrQlOelYaWXKqV98Qjy3zwkF4W3M=;
        b=p1iutjie7kjgKXYeADIp/CzOwxd6SX70C1KvZ16edRMtMM/UkDsGpU0lDNUM/0NAm4
         IqpY2/AR0B045oTHoyPV+dar2f0/C5NUi/RahqomsSPin1nBX8jbC96/g2dMcsROi9rR
         0TVwsy/FoCQGpDx/NnAgnReO5D06b2UCAh6XYq5psLLJhmtIG2y4PbGJjtXnlgEJj/pA
         dpkZE/6HpMD66uCQ2VGO2itdC9TAYDVRvNAFFGmhIWVVL68lthtpmCcafJ5SWSmJtf+K
         DFe4SCKNGKmgIDXihNDeQNy7UHCD6XISXluPhQ0fQjKC0ZRsj64ecaqPGlJjizzgsPYL
         kfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755649384; x=1756254184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkNKxOXnA841VLAMrQlOelYaWXKqV98Qjy3zwkF4W3M=;
        b=CvnuVctJzRA1n521fk9ABBYANVCUzlsK1rDU3CioTpLVUQfbrojw3ykcucvTqMatPs
         82HAg3Fg/b7dizmqzmEk3gH9eZqgC7BgIZRgjNwkmxQZ1RfDC2Aym7SeVumYD2fKK+Y/
         cam8el5GEZVLF93M5nK+oAUKyEptxVQhKcrWZF1wb7/Ak/MWV4i0Ae0aVv5Lq9yw1D3B
         Njbwtk0tWkFz7FZIBnP+OI7uKkrKenVBSxdmhV2YTDa/SeH08z8cPu4ymOriIVcsR6oe
         0vSwWAVh+LmdZL1g+W83d9ua9aKU+AwXcL0gjW+Hjk+P/8NZd+Iw5NXr8s+YkH8W69L8
         Q1OA==
X-Forwarded-Encrypted: i=1; AJvYcCWP9Fb/cGZETBO2bTWX99uzXyUb5suP9t4nA6DrA0Rjt1pCnmE8hXHnYzRS5CkGc+UgdylACUy3Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwAmZ4xfGgBm08oADjqOBxz/mBhkgTeUOqXdiDtAcBBOUDFKK
	SnQB+K3ntp++lvF1lpmLeGkRUBoUnOp8/P6YKY/uiFZRx5Ynee+Xnnv9O6BXv1eEtWu2Yb98cKC
	LINCidbBwaplLZDtG797bksSo7uB7EuhXlJKcqbmN
X-Gm-Gg: ASbGncvNwd9e1Eg8IGjKXyn6kWb9un8tJhQvGBi7+CjM2ZTAOzSemtTGK7OnVSsoogs
	h0uv3p+rwCDLUj/I1DejuYJi/jsz2Zjg+KogY353rYm0+zQtugf7hhks5VAyJWtISP0roUrxxPo
	Mta+tqUC/PpmCn4jtLy5dMqXIKhyvUxGcd74Dj5yCCHJBI+rzywkr07texfhq4iBQIiLRE0pI6G
	44ZKF9FoShpikBdRFmQ0uBnXzyVlcI46jj3EIpi9xQw
X-Google-Smtp-Source: AGHT+IGjzLS8qrGqTNmWR/LP41AI9LYDaBlQgEH3L2uRs/VsdSKupwuZAvKUcAAlAGI81m3e1PctwYa6uF3YdOKe5R8=
X-Received: by 2002:a05:6102:f0f:b0:4f9:69a9:4ec5 with SMTP id
 ada2fe7eead31-51a5119926cmr306457137.27.1755649384211; Tue, 19 Aug 2025
 17:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815004635.3684650-1-wusamuel@google.com>
In-Reply-To: <20250815004635.3684650-1-wusamuel@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 19 Aug 2025 17:22:26 -0700
X-Gm-Features: Ac12FXwhP-z57JIwvojaaiXAYO85iOpjGt6ehTHSMwEQC65wital8z3QRsCM3Rw
Message-ID: <CAGETcx_2cH6vyAUx3Zb=2GDCp_WK4A=JpF+8DXc0iLFT9S21Hg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Support aborting suspend during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:46=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
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

Minor comments on documentation. The code itself seems good to me.

> ---
>  drivers/base/power/wakeup.c |  8 ++++
>  include/linux/suspend.h     |  3 ++
>  kernel/power/process.c      |  1 -
>  kernel/power/suspend.c      | 85 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 95 insertions(+), 2 deletions(-)
>
> v1 -> v2:
> - Added documentation for suspend_abort_fs_sync()
> - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration stat=
ic
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..304368c3a55f 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_sou=
rce *ws)
>
>         /* Increment the counter of events in progress. */
>         cec =3D atomic_inc_return(&combined_event_count);
> +       /*
> +        * To maintain the same behavior as pm_wakeup_pending(),
> +        * aborting suspend will only happen if events_check_enabled. Sim=
ilarly,
> +        * the abort during fs_sync needs the same check.
> +        */

Maybe something like this would be clearer?
wakeup source active aborts suspend only if events_check_enabled is
set (See pm_wakeup_pending()). Similarly, it should abort fs_sync only
if events_check_enabled is set.

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
> index 317ae31e89b3..21b1ea275c79 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -276,6 +276,8 @@ extern void arch_suspend_enable_irqs(void);
>
>  extern int pm_suspend(suspend_state_t state);
>  extern bool sync_on_suspend_enabled;
> +
> +extern void suspend_abort_fs_sync(void);
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> @@ -296,6 +298,7 @@ static inline bool idle_should_enter_s2idle(void) { r=
eturn false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops)=
 {}
>  static inline void s2idle_wake(void) {}
> +static inline void suspend_abort_fs_sync(void) {}
>  #endif /* !CONFIG_SUSPEND */
>
>  static inline bool pm_suspend_in_progress(void)
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index dc0dfc349f22..8ff68ebaa1e0 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -132,7 +132,6 @@ int freeze_processes(void)
>         if (!pm_freezing)
>                 static_branch_inc(&freezer_active);
>
> -       pm_wakeup_clear(0);
>         pm_freezing =3D true;
>         error =3D try_to_freeze_tasks(true);
>         if (!error)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b4ca17c2fecf..dc37ab942bcb 100644
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
> @@ -74,6 +75,21 @@ bool pm_suspend_default_s2idle(void)
>  }
>  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
>
> +static bool suspend_fs_sync_queued;
> +static DEFINE_SPINLOCK(suspend_fs_sync_lock);
> +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> +
> +/**
> + * Triggers the completion that aborts suspend. This completion will onl=
y have
> + * an effect if called during filesystems sync step of suspend.
> + */

This is explaining the implementation of the function. It's better to
explain the semantics of the API.

For example (please feel free to rewrite it):

/* suspend_abort_fs_sync - Abort fs_sync to abort suspend early
*
* This function aborts the fs_sync stage of suspend so that suspend
itself can be aborted early.
*/

> +void suspend_abort_fs_sync(void)
> +{
> +       spin_lock(&suspend_fs_sync_lock);
> +       complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
> +}
> +
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
>         unsigned int sleep_flags;
> @@ -403,6 +419,71 @@ void __weak arch_suspend_enable_irqs(void)
>         local_irq_enable();
>  }
>
> +static void sync_filesystems_fn(struct work_struct *work)
> +{
> +       ksys_sync_helper();
> +
> +       spin_lock(&suspend_fs_sync_lock);
> +       suspend_fs_sync_queued =3D false;
> +       complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
> +}
> +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> +
> +/**
> + * suspend_fs_sync_with_abort- Start filesystem sync and handle potentia=
l aborts
> + *
> + * Starts filesystem sync in a workqueue, while the main thread uses a
> + * completion to wait for either the filesystem sync to finish or for a =
wakeup
> + * event. In the case of filesystem sync finishing and triggering the
> + * completion, the suspend path continues as normal. If the complete is =
due to a
> + * wakeup or abort signal, the code jumps to the suspend abort path whil=
e the
> + * filesystem sync finishes in the background.

This is again talking about implementation. Not great for a function
doc. It's better to have these next to the implementation.

> + *
> + * An aborted suspend that is followed by another suspend is a potential
> + * scenario that complicates the sequence. This patch handles this by

Don't talk about a specific patch in an inline comment. This will be
here long after your patch is merged.

> + * serializing any filesystem sync; a subsequent suspend's filesystem sy=
nc
> + * operation will only start when the previous suspend's filesystem sync=
 has
> + * finished. Even while waiting for the previous suspend's filesystem sy=
nc to
> + * finish, the subsequent suspend will still break early if a wakeup com=
pletion
> + * is triggered, solving the original issue of filesystem sync blocking =
abort.

Most of the context of this comment is already explained below. I
don't think this function needs a function doc. But if you must, a
simple semantic documentation should be enough:

/* suspend_fs_sync_with_abort -- Tigger fs_sync with ability to abort.

This function initiates a file system sync with the ability to abort.

Return 0 on successful file system sync.
Or -EBUSY if file system sync was aborted
*/

> + */
> +static int suspend_fs_sync_with_abort(void)
> +{
> +       bool need_suspend_fs_sync_requeue;
> +
> +       pm_wakeup_clear(0);
> +Start_fs_sync:
> +       spin_lock(&suspend_fs_sync_lock);
> +       reinit_completion(&suspend_fs_sync_complete);
> +       /*
> +        * Handle the case where a suspend immediately follows a previous
> +        * suspend that was aborted during fs_sync. In this case, seriali=
ze

In this case, wait for the previous file system sync to finish. Then
do another file system sync so any subsequent changes to the file
systems are synced before suspending.

Assuming you address these non-functional comments:
Reviewed-by: Saravana Kannan <saravanak@google.com>

Thanks,
Saravana

> +        * fs_sync by only starting fs_sync of the subsequent suspend whe=
n the
> +        * fs_sync of the previous suspend has finished.
> +        */
> +       if (suspend_fs_sync_queued) {
> +               need_suspend_fs_sync_requeue =3D true;
> +       } else {
> +               need_suspend_fs_sync_requeue =3D false;
> +               suspend_fs_sync_queued =3D true;
> +               schedule_work(&sync_filesystems);
> +       }
> +       spin_unlock(&suspend_fs_sync_lock);
> +
> +       /*
> +        * Completion is triggered by fs_sync finishing or a suspend abor=
t
> +        * signal, whichever comes first
> +        */
> +       wait_for_completion(&suspend_fs_sync_complete);
> +       if (pm_wakeup_pending())
> +               return -EBUSY;
> +       if (need_suspend_fs_sync_requeue)
> +               goto Start_fs_sync;
> +
> +       return 0;
> +}
> +
>  /**
>   * suspend_enter - Make the system enter the given sleep state.
>   * @state: System sleep state to enter.
> @@ -590,8 +671,10 @@ static int enter_state(suspend_state_t state)
>
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -               ksys_sync_helper();
> +               error =3D suspend_fs_sync_with_abort();
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +               if (error)
> +                       goto Unlock;
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> --
> 2.51.0.rc1.167.g924127e9c0-goog
>

