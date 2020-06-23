Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925E205592
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbgFWPNY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 11:13:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39169 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 11:13:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id 18so2275993otv.6;
        Tue, 23 Jun 2020 08:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti2WHwyTcE0aMHiiYFzjueBDRVS+U4KlIbhFdN8VMXU=;
        b=iGmgqjDqcPQ82a4Z7uTO6IuW8wo/9tpJ9xvYQ/eJm7eBGTxNBYDDRlU+APNWHhrJAa
         2E55B7iDqQReeL6ab0bNvymycfVOIX6g4s3iZbBNigEIWd98z7u2mrjS7M7W2UBBxxQw
         U0q99z86joOwQX+q3tKcsTRcUyd3yooP10Tfj2AN3M1Kmu28U8t3Fj2g421YOydzMswn
         VXpUQtS2grAMcSKHuMKgMImok5/rHiAG2Z/do2JK8AIEvT0HQzCXqjFC41Q8+C03iHXa
         aB+omhvPxcBNbzwDnWEKt7qwgAMGaFG78ygbaX9K0y6vIN9sqVYzDPafSMYumAJ9ZFjR
         BrtQ==
X-Gm-Message-State: AOAM531OAdM1A4UtOqSr1uIbq5jNqJmo3I+ru5VvPsJuf8n99jSJ/OkQ
        VgCXb/GO7YTUrhoonTK9K0iMbka5ry9VkHqGTjHyuA==
X-Google-Smtp-Source: ABdhPJxVeEE74i8IgwTMNzoIpveKPQnYy9Uo13cXX+uwcXAFRqBXo+ELImH9t7I4+XNHDbLIlUBdHsBdOKiF4/JVsdw=
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr18171827oto.167.1592925202721;
 Tue, 23 Jun 2020 08:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592892767.git.yu.c.chen@intel.com> <55caab9c03a0d6c3c0a1f45294d6c274b73c954b.1592892767.git.yu.c.chen@intel.com>
In-Reply-To: <55caab9c03a0d6c3c0a1f45294d6c274b73c954b.1592892767.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Jun 2020 17:13:11 +0200
Message-ID: <CAJZ5v0gJqPX55HvGb7dn8dV5jr3-MPNQHTRbsYCN47zp07VhsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2][v3] PM / s2idle: Clear _TIF_POLLING_NRFLAG before
 suspend to idle
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 23, 2020 at 8:30 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Suspend to idle was found to not work on Goldmont CPU recently.
> And the issue was triggered due to:
>
> 1. On Goldmont the CPU in idle can only be woken up via IPIs,
>    not POLLING mode:
>    Commit 08e237fa56a1 ("x86/cpu: Add workaround for MONITOR
>    instruction erratum on Goldmont based CPUs")
> 2. When the CPU is entering suspend to idle process, the
>    _TIF_POLLING_NRFLAG is kept on, due to cpuidle_enter_s2idle()
>    doesn't properly match call_cpuidle().
> 3. Commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
>    makes use of _TIF_POLLING_NRFLAG to avoid sending IPIs to
>    idle CPUs.
> 4. As a result, some IPIs related functions might not work
>    well during suspend to idle on Goldmont. For example, one
>    suspected victim:
>    tick_unfreeze() -> timekeeping_resume() -> hrtimers_resume()
>    -> clock_was_set() -> on_each_cpu() might wait forever,
>    because the IPIs will not be sent to the CPUs which are
>    sleeping with _TIF_POLLING_NRFLAG set, and Goldmont CPU
>    could not be woken up by only setting _TIF_NEED_RESCHED
>    on the monitor address.
>
> Clear the _TIF_POLLING_NRFLAG flag before entering suspend to idle,
> and let the driver's enter_s2idle() to decide whether to set
> _TIF_POLLING_NRFLAG or not. So that to avoid the scenario described
> above and keep the context consistent with before.
>
> Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Applied (based on the previous discussion) with some subject and
changelog edits.

Thanks!

> ---
> v2: According to Peter's review, v1 is racy, if someone already
>     set TIF_NEED_RESCHED this patch just clear POLLING and go to sleep.
>     Check TIF_NEED_RESCHED before entering suspend to idle and
>     adjust the naming to be consistent with call_cpuidle().
>
> v3: According to Rafael, it would be better to do the simplest fix
>    first and then do the cleanup on top of it.
> ---
>  drivers/cpuidle/cpuidle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c149d9e20dfd..e092789187c6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -13,6 +13,7 @@
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/idle.h>
>  #include <linux/notifier.h>
>  #include <linux/pm_qos.h>
>  #include <linux/cpu.h>
> @@ -186,7 +187,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>          * be frozen safely.
>          */
>         index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> -       if (index > 0)
> +       if (index > 0 && !current_clr_polling_and_test())
>                 enter_s2idle_proper(drv, dev, index);
>
>         return index;
> --
> 2.17.1
>
