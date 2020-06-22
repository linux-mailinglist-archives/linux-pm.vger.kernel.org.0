Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42D203C58
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgFVQTr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 12:19:47 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:41069 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgFVQTr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 12:19:47 -0400
Received: by mail-oo1-f65.google.com with SMTP id y45so3470008ooi.8;
        Mon, 22 Jun 2020 09:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Uo7tLE8Ng0ljtCXTtGcEJjxCELargRdsGzsyXemCgs=;
        b=M7FCNXrYOqADFhXb+HDsMyqQDdUL7Rvl0WJZD5MP3UCiqTlV3YxTBO5tJ+O0QdH9Sq
         KBAnm3p5HwWtyfzVaDnPd1tt5m1/phfq+pwVQEhCNa93TyIiRNUsL/xA3QBZ0p5YezTN
         c0GbD0yHz6Yk4fGzcuxH36tk4zIVreAfB96qKwe+w5fJy/OhOA5EYGzT52XW8u3AG3hf
         xrJfigNYyqrbljdbfNYv66abAHbuJxe8f14GdhusfOdGSTMVOojUMW3v+bMH4tHrNR7k
         NzdwqG7fBHzjIO4SvpVik6QqPhUTSWswTAWphPd+N3EFAc0VH1ZFAK1TfHaOxLmdmlFD
         dMyQ==
X-Gm-Message-State: AOAM530xajK5zX5/hvrcycpl36yuntaPbs5DViwwLVsqps6nO3/tx3qx
        OMbaKsFjYoNwMsQBLFhwXFY8Un16wQXV0bpD917DlpDQ
X-Google-Smtp-Source: ABdhPJyJzMY+Ig5hfxqT84WrgEl4O2KCn/CA1QUseO7PZisUGMIMg9J9c1cy446Z1L7TJd1n36X5db7QuPeGS55+Gmc=
X-Received: by 2002:a4a:5744:: with SMTP id u65mr14858682ooa.1.1592842786408;
 Mon, 22 Jun 2020 09:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200616040442.21515-1-yu.c.chen@intel.com>
In-Reply-To: <20200616040442.21515-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jun 2020 18:19:35 +0200
Message-ID: <CAJZ5v0gBVBAjdCOXsM-Fa-iAkuv2JMi2mVkG5w7ADcg9dWencA@mail.gmail.com>
Subject: Re: [PATCH][v2] PM / s2idle: Clear _TIF_POLLING_NRFLAG before suspend
 to idle
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 16, 2020 at 6:03 AM Chen Yu <yu.c.chen@intel.com> wrote:
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
> I don't find a way in Ubuntu to update the firmware of Goldmont
> and check if the issue was gone, a fix patch would do no harm.
> Clear the _TIF_POLLING_NRFLAG flag before entering suspend to idle,
> and let the driver's enter_s2idle() to decide whether to set
> _TIF_POLLING_NRFLAG or not. So that to avoid the scenario described
> above and keep the context consistent with before. Also adjust
> the naming to be consistent with call_cpuidle().
>
> Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Peter, any more comments here?

> ---
> v2: According to Peter's review, v1 is racy, if someone already
>     set TIF_NEED_RESCHED this patch just clear POLLING and go to sleep.
>     Check TIF_NEED_RESCHED before entering suspend to idle and
>     adjust the naming to be consistent with call_cpuidle().
> --
>  drivers/cpuidle/cpuidle.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c149d9e20dfd..b003767abebd 100644
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
> @@ -133,8 +134,8 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  }
>
>  #ifdef CONFIG_SUSPEND
> -static void enter_s2idle_proper(struct cpuidle_driver *drv,
> -                               struct cpuidle_device *dev, int index)
> +static void s2idle_enter(struct cpuidle_driver *drv,
> +                        struct cpuidle_device *dev, int index)
>  {
>         ktime_t time_start, time_end;
>
> @@ -168,6 +169,15 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
>         dev->states_usage[index].s2idle_usage++;
>  }
>
> +static int call_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> +                      int index)
> +{
> +       if (!current_clr_polling_and_test())
> +               s2idle_enter(drv, dev, index);
> +
> +       return index;

Is the value returned here used at all?

> +}
> +
>  /**
>   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
>   * @drv: cpuidle driver for the given CPU.
> @@ -187,7 +197,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>          */
>         index = find_deepest_state(drv, dev, U64_MAX, 0, true);
>         if (index > 0)
> -               enter_s2idle_proper(drv, dev, index);
> +               call_s2idle(drv, dev, index);

I'm wondering why this can't be

    if (index > 0 && !current_clr_polling_and_test())
            enter_s2idle_proper(drv, dev, index);

>         return index;
>  }
> --
