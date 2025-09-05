Return-Path: <linux-pm+bounces-34020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C5CB4639C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772CA1C873E2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6982773DD;
	Fri,  5 Sep 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvcd5qri"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D611B0437;
	Fri,  5 Sep 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100457; cv=none; b=tJ8ZBbmZJ92fnSt2YWIIdcP9XfC19aEfLCaB9DH9rm722BvjzjNRXo+EfS9x+HR4EpsEOq6yD86HU36rgnxktePWmBEJTzTxS5/VqnnJjp1Y3Lo3TM3RxwHdbWqlOsl/nmsDfd8v01XcuQburun9jHgfX/eyu6bGDCmIQQXZVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100457; c=relaxed/simple;
	bh=Z8QX9n/dsGKb/tqO5URTgea7AAk4/TjAmFpDZYddtCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKkB5Z6D3mKS1TDMs3DUZ02uCYY3yy4csVV6MqUYvlXhUdhWPnRg0QuP7N8vbCWt/bs+1oOKcPD5ZAoTQ5RRfr7WlSIQLxhlySHORptWe5BN/GFnnvGZkpMZTzzKVwPE6DOtKu41Hfe2jwg7EIHgQSzXTKhhr9hGC4zDjav14fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvcd5qri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC46C4CEF1;
	Fri,  5 Sep 2025 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100457;
	bh=Z8QX9n/dsGKb/tqO5URTgea7AAk4/TjAmFpDZYddtCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mvcd5qriJWpAtdXhjO+xzy9io3jkLumyXEgxbjG+rBRB7pScqdEj+HT7C3NXMyNRm
	 /1NIg+L+1A5h1ESPdJVkTk2+rRP8bcpzyzstVeymKrHSr8HX30jYyQBWT5yVyw4KnW
	 0YvJvckUCS8OLG9L3zbx34jHRYTFiOXPrc4ghg9gvNhL2ZBD7d1zRdORihrZmi9ocW
	 6zUC9On7cvE/OFnpzyEyta8FUZNzFpE0wMJTOdCmmNcBJ9XDBlCC1+AbmPS0xyjejx
	 ybVyN7gmT1h0gOR1Wv+edFTNBoTgF0GnBxwu8hexW6Y5C7o1S2AqY5q5PSp+r0amMy
	 UGd77yHdwE5yg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca79c2so1121978a34.3;
        Fri, 05 Sep 2025 12:27:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOhe8s/5eWmu+shyzJCeKARv6Y0/PQxP+0QutqDljOq/yFojee7GzjGx9Ym03F+MUTp5xjOYHAuaejjLs=@vger.kernel.org, AJvYcCWscwe4g5BkyRRPJhqVtrDYxiPbbr5VKBjNvPSaQ7g6te/zy/LA4F6zkefxP+HbkJm76RsXp0u2Coo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCQj6piUlvsjLQFouD/I1xoEeBtiz9JqAYIFUIgk4dNcVDnPf
	gRqiVJRzz4CINFu9zA+1FAjdrMFEygiRgr2aJtan5mbpFARMv9jMVSZeWyKzyq1MAc+KQlo2dBb
	m856O4vUAUs6WhUM7Nger40faeYVRxGs=
X-Google-Smtp-Source: AGHT+IGkRQ228H5M+MG75EB/Si0QkzzOr2+o2U6vwBjn/zXj2aS3+W20Zca0b4PWtyRUwqhish6cM0k1U8EXCkl8LME=
X-Received: by 2002:a05:6830:2691:b0:74a:c2f4:c99a with SMTP id
 46e09a7af769-74ac2f4d3f7mr838608a34.5.1757100456748; Fri, 05 Sep 2025
 12:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905024702.1214-1-tuhaowen@uniontech.com> <20250905092433.15257-1-tuhaowen@uniontech.com>
In-Reply-To: <20250905092433.15257-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 21:27:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBRy=CvZiWQQaorvc-zT+kkaB6+S2TErGmkaPAGmHLOQ@mail.gmail.com>
X-Gm-Features: Ac12FXxGpUmImVh5dQa7ZRkJOVjauIxt_CJtMK6TGxg5TqDdHwzT0WaCf_ijOIo
Message-ID: <CAJZ5v0jBRy=CvZiWQQaorvc-zT+kkaB6+S2TErGmkaPAGmHLOQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Add configurable sync timeout for suspend and hibernation
To: tuhaowen <tuhaowen@uniontech.com>
Cc: len.brown@intel.com, pavel@kernel.org, rafael@kernel.org, 
	huangbibo@uniontech.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Saravana Kannan <saravanak@google.com>, 
	Samuel Wu <wusamuel@google.com>, "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:25=E2=80=AFAM tuhaowen <tuhaowen@uniontech.com> w=
rote:
>
> When large file operations are in progress during system suspend or
> hibernation, the ksys_sync() call can hang for extended periods,
> leading to unresponsive system behavior. Users copying large files
> to USB drives may experience black screen hangs when attempting to
> suspend, requiring forced power cycles.
>
> This patch introduces a unified sync timeout mechanism for both
> suspend-to-RAM (S3) and hibernation (S4) to prevent indefinite
> hangs while maintaining data integrity.
>
> Key features:
> - Configurable timeout via sysfs interface
> - Default behavior unchanged (timeout disabled by default)
> - Unified implementation for both suspend and hibernation paths
> - Graceful fallback to direct sync on thread creation failure
>
> Sysfs interface:
> - /sys/power/sleep_sync_timeout: Runtime configuration (0-600000ms)
>
> When timeout is enabled and exceeded, the sync operation is aborted
> and suspend/hibernation fails gracefully with -ETIMEDOUT, preventing
> system hangs.
>
> Implementation creates a separate kthread for sync operations when
> timeout is enabled, allowing the main suspend path to maintain
> control and abort if necessary.
>
> Compared to [PATCH v3 0/3] PM: Support aborting suspend during
> filesystem sync (see: https://lore.kernel.org/linux-pm/20250821004237.
> 2712312-1-wusamuel@google.com/), this patch addresses scenarios where
> there may be no wakeup event, but the sync operation is excessively
> slow (e.g., due to slow or faulty storage). By introducing a configurable
> timeout, it proactively prevents indefinite hangs and improves user
> experience in a wider range of real-world cases. The implementation
> is also simpler and gives users or system integrators more flexibility
> to tune behavior for different devices and requirements. Additionally,
> the ksys_sync_helper_timeout() interface is designed as a reusable
> generic function that other kernel subsystems can leverage when they
> need sync operations with timeout control, promoting code reuse and
> reducing maintenance overhead across the kernel.

You need to talk to the authors of the series mentioned above (now
CCed) and come up with a common approach.  I have no strong preference
and I'm not going to choose one over the other unless I'm told by
everybody interested that this is the way to go.

I personally think that syncing filesystems during system suspend, in
contrast with hibernation, is rather pointless and hibernation users
can be expected to be sufficiently patient.

There's already /sys/power/sync_on_suspend, so why not use it to
disable the sync on suspend altogether?

> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
> Changes in v2:
> - Unified timeout logic in kernel/power/main.c
> - Removed duplicate code from suspend.c and hibernate.c
> - Added sysfs interface for runtime configuration
> - Changed default to 0 (disabled) for backward compatibility
> - Increased maximum timeout to 10 minutes
> - Simplified parameter control (removed separate enable flag)
> ---
>  include/linux/suspend.h  |  3 ++
>  kernel/power/hibernate.c |  4 +-
>  kernel/power/main.c      | 82 ++++++++++++++++++++++++++++++++++++++++
>  kernel/power/suspend.c   |  6 ++-
>  4 files changed, 93 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3f..976c8f8a1 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -439,6 +439,8 @@ void restore_processor_state(void);
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
>  extern void ksys_sync_helper(void);
> +extern int ksys_sync_helper_timeout(unsigned int timeout_ms);
> +extern unsigned int sync_timeout_ms;
>  extern void pm_report_hw_sleep_time(u64 t);
>  extern void pm_report_max_hw_sleep(u64 t);
>
> @@ -486,6 +488,7 @@ static inline void pm_report_hw_sleep_time(u64 t) {};
>  static inline void pm_report_max_hw_sleep(u64 t) {};
>
>  static inline void ksys_sync_helper(void) {}
> +static inline int ksys_sync_helper_timeout(unsigned int timeout_ms) { re=
turn 0; }
>
>  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 23c0f4e6c..2678181a5 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -777,7 +777,9 @@ int hibernate(void)
>         if (error)
>                 goto Restore;
>
> -       ksys_sync_helper();
> +       error =3D ksys_sync_helper_timeout(sync_timeout_ms);
> +       if (error)
> +               goto Exit;
>
>         error =3D freeze_processes();
>         if (error)
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6254814d4..3912f221a 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -17,10 +17,21 @@
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
> +#include <linux/jiffies.h>
>
>  #include "power.h"
>
>  #ifdef CONFIG_PM_SLEEP
> +/* Sync timeout parameters */
> +unsigned int sync_timeout_ms;
> +EXPORT_SYMBOL_GPL(sync_timeout_ms);
> +
> +/* Sync timeout implementation */
> +static struct completion sync_completion;
> +static struct task_struct *sync_task;
> +
>  /*
>   * The following functions are used by the suspend/hibernate code to tem=
porarily
>   * change gfp_allowed_mask in order to avoid using I/O during memory all=
ocations
> @@ -79,6 +90,45 @@ void ksys_sync_helper(void)
>  }
>  EXPORT_SYMBOL_GPL(ksys_sync_helper);
>
> +static int sync_thread_func(void *data)
> +{
> +       ksys_sync_helper();
> +       complete(&sync_completion);
> +       return 0;
> +}
> +
> +int ksys_sync_helper_timeout(unsigned int timeout_ms)
> +{
> +       unsigned long timeout_jiffies;
> +
> +       /* If timeout is 0, use regular sync without timeout */
> +       if (timeout_ms =3D=3D 0) {
> +               ksys_sync_helper();
> +               return 0;
> +       }
> +
> +       init_completion(&sync_completion);
> +       sync_task =3D kthread_run(sync_thread_func, NULL, "sync_timeout")=
;
> +       if (IS_ERR(sync_task)) {
> +               pr_warn("%s: Failed to create sync thread, performing syn=
c directly\n",
> +                       __func__);
> +               ksys_sync_helper();
> +               return 0;
> +       }
> +
> +       timeout_jiffies =3D msecs_to_jiffies(timeout_ms);
> +       if (!wait_for_completion_timeout(&sync_completion, timeout_jiffie=
s)) {
> +               pr_warn("%s: Sync operation timed out after %u ms, aborti=
ng\n",
> +                       __func__, timeout_ms);
> +               kthread_stop(sync_task);
> +               return -ETIMEDOUT;
> +       }
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(ksys_sync_helper_timeout);
> +
> +
> +
>  /* Routines for PM-transition notifications */
>
>  static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
> @@ -240,6 +290,37 @@ static ssize_t sync_on_suspend_store(struct kobject =
*kobj,
>  }
>
>  power_attr(sync_on_suspend);
> +
> +/*
> + * sleep_sync_timeout: configure sync timeout during suspend/hibernation=
.
> + *
> + * show() returns the current sync timeout in milliseconds.
> + * store() accepts timeout value in milliseconds. 0 disables timeout.
> + */
> +static ssize_t sleep_sync_timeout_show(struct kobject *kobj,
> +                                struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%u\n", sync_timeout_ms);
> +}
> +
> +static ssize_t sleep_sync_timeout_store(struct kobject *kobj,
> +                                 struct kobj_attribute *attr,
> +                                 const char *buf, size_t n)
> +{
> +       unsigned long val;
> +
> +       if (kstrtoul(buf, 10, &val))
> +               return -EINVAL;
> +
> +       /* Allow any reasonable timeout value */
> +       if (val > 600000) /* Max 10 minutes */
> +               return -EINVAL;
> +
> +       sync_timeout_ms =3D val;
> +       return n;
> +}
> +
> +power_attr(sleep_sync_timeout);
>  #endif /* CONFIG_SUSPEND */
>
>  #ifdef CONFIG_PM_SLEEP_DEBUG
> @@ -974,6 +1055,7 @@ static struct attribute * g[] =3D {
>  #ifdef CONFIG_SUSPEND
>         &mem_sleep_attr.attr,
>         &sync_on_suspend_attr.attr,
> +       &sleep_sync_timeout_attr.attr,
>  #endif
>  #ifdef CONFIG_PM_AUTOSLEEP
>         &autosleep_attr.attr,
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8eaec4ab1..4f8015a75 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -585,8 +585,12 @@ static int enter_state(suspend_state_t state)
>
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -               ksys_sync_helper();
> +               error =3D ksys_sync_helper_timeout(sync_timeout_ms);
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +               if (error) {
> +                       pr_err("PM: Sync timeout, aborting suspend\n");
> +                       goto Unlock;
> +               }
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> --
> 2.20.1
>

