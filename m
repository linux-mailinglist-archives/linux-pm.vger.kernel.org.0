Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1080454D74
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 19:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhKQS46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 13:56:58 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39853 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhKQS46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 13:56:58 -0500
Received: by mail-ot1-f42.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso6393780ots.6;
        Wed, 17 Nov 2021 10:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak1jmoEOOGOhOFuQWlERnmy75zezwY/WEmUoAvtFZ1I=;
        b=4961Gyl1UP9GXaADAl5Y+qliqzq/djmY70bpzxWX9gk/mhEz6APxZg/p3ninp+0G31
         7b0ZPnMjVJpA4XcM8zANhnMJ9dZIUHOS8ZavHNJH0C/tHOJ6g8uG5mVQ9Rcm4f0J+CfH
         2Dw/maFXHz6uX/RA6qgzA7Xhq1PAbi1sGjT/V6Mj1R1f/sfKhfVTQtwhkr0DS0YHlPeY
         9q3Vr+d6tUULZKQX/NY5otQSjIJXQYh5rXEmuJzg8AHNN8PBXo7YibKSUtHBTclJYGH9
         T/WGQb+JCfS38MhO7Bi+3ReKuHNjgzZlH16MX7CovAHE9w22zUA0pEYDfo4EZpLWPGgA
         g77w==
X-Gm-Message-State: AOAM533GaVF4HEiZLa7Oid3186efdcquDuPT88WC0Msqs2Gjik2e/yxv
        YVhyQOld087HVBPp4JoCqYOaWdVjJJiRkOJ1fRU=
X-Google-Smtp-Source: ABdhPJzIGHHnl8EoTZvUxHWYGTO/bN/uZEBx3VEccsmatzbLpcL0i+6UKJBZCjTmrJPNHIF81a/MlelW76M3M3+znjA=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr15779811otu.254.1637175238704;
 Wed, 17 Nov 2021 10:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20211117183709.1832925-1-john@metanate.com>
In-Reply-To: <20211117183709.1832925-1-john@metanate.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Nov 2021 19:53:47 +0100
Message-ID: <CAJZ5v0hgL6O6mCA4wf5NtmWi7kzA0Lyop4wH0TGDLMricdpiqA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: avoid priority inversion on PREEMPT_RT
To:     John Keeping <john@metanate.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 17, 2021 at 7:37 PM John Keeping <john@metanate.com> wrote:
>
> With PREEMPT_RT the cpu_relax() loops in rpm_suspend and rpm_resume can
> cause unbounded latency if they preempt an asynchronous suspend.  The
> main scenario where this can happen is when a realtime thread resumes a
> device while it is asynchronously suspending on a worker thread.
>
> I'm not convinced this can actually happen in the rpm_suspend case, or
> at least it's a lot less likely for a synchronous suspend to run at the
> same time as an asynchronous suspend, but both functions are updated
> here for symmetry.
>
> For devices setting power.irq_safe, it is possible that RPM functions
> will be called with a spinlock held (for example in
> pl330_issue_pending()).  This means a normal call to schedule() can't be
> used, but to avoid the priority inversion it is necessary to wait and
> schedule.  schedule_rtlock() is only available when CONFIG_PREEMPT_RT is
> defined, so even though the logic is correct without any preprocessor
> guards around schedule_rtlock(), they are necessary for compilation.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Changes since v1:
> - Use schedule_rtlock() instead of schedule() for PREEMPT_RT & irq_safe
> - Rewritten commit description
>
>  drivers/base/power/runtime.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index f3de7bfc7f5b..fdf461bfae8c 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -596,7 +596,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>                         goto out;
>                 }
>
> -               if (dev->power.irq_safe) {
> +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {

Please add a helper to avoid code duplication related to this (even
though there is a small amount of it).

>                         spin_unlock(&dev->power.lock);
>
>                         cpu_relax();
> @@ -614,7 +614,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>
>                         spin_unlock_irq(&dev->power.lock);
>
> -                       schedule();
> +#ifdef CONFIG_PREEMPT_RT
> +                       if (dev->power.irq_safe)
> +                               schedule_rtlock();
> +                       else
> +#endif

Same here, and please use the #ifdet inside the helper.

> +                               schedule();
>
>                         spin_lock_irq(&dev->power.lock);
>                 }
> @@ -779,7 +784,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>                         goto out;
>                 }
>
> -               if (dev->power.irq_safe) {
> +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                         spin_unlock(&dev->power.lock);
>
>                         cpu_relax();
> @@ -798,7 +803,12 @@ static int rpm_resume(struct device *dev, int rpmflags)
>
>                         spin_unlock_irq(&dev->power.lock);
>
> -                       schedule();
> +#ifdef CONFIG_PREEMPT_RT
> +                       if (dev->power.irq_safe)
> +                               schedule_rtlock();
> +                       else
> +#endif
> +                               schedule();
>
>                         spin_lock_irq(&dev->power.lock);
>                 }
> --
