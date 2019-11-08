Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20345F451C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 11:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHK44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 05:56:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45800 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHK4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 05:56:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id r24so4800789otk.12;
        Fri, 08 Nov 2019 02:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYFPsIc27u29Yjz0g3atZHfF9HksP2WvNGtvLYXFt4s=;
        b=nnQVe2u52JrgdNm/ir/kYcrOLYo/Euc16m8pgOwvzIRxdjfxQ3PwUC60stiQTFxIRH
         blcZbhG31m7jiio653pZW4NlFRhIrGzHdgg5QzGXHNajrdWXgz4LWe9/giW/kE25iZeN
         LuPvh+pM4dAf8ZrbV/pXpYu/g4PH96cUiU5rR2TXVvGtguuuSi41LfLpOIT7ka6A1aCe
         mFflPsNf48OcvxiUQ3WIrKpoStjadugceP2ZCXPFmsA10O08gIfLWZN9FB+f7vC2EWkS
         u4k8iJOPcN9Dh/5rw1HGMiUkEEyQluvyEZFrSYrnzboqp2bf/py9fHWo5TnkKELQxpm7
         N3rQ==
X-Gm-Message-State: APjAAAUuqw4/n7DabOP3+H5DTATJJZ8+27u2yzOL47e4+cSmOp56V2Dt
        +yk+DbNi0P+Nv9fKNZEG60WSHTCPvlGb2eFqksI=
X-Google-Smtp-Source: APXvYqwzTm3wzOcGarzXjc0wFxFI7PdVtjXIwX5UA760FCYy/aDWzz6JWjT08ku65DSG1EKefuNwr1kUemHUEax+ySw=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr8033641otg.262.1573210614545;
 Fri, 08 Nov 2019 02:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20191030075141.1039-1-daniel.lezcano@linaro.org>
 <20191030075141.1039-2-daniel.lezcano@linaro.org> <143021538.HHUP3Pj7i7@kreacher>
 <9dfe3bd3-1903-4dc4-0605-27cc867d87ad@linaro.org>
In-Reply-To: <9dfe3bd3-1903-4dc4-0605-27cc867d87ad@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Nov 2019 11:56:43 +0100
Message-ID: <CAJZ5v0hLZ9O=QtZ+ktc-_Dk7aJjgD9BRLyYKw1g9Ze2n8KZyVQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/3] cpuidle: play_idle: Specify play_idle with an idle state
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 8, 2019 at 11:47 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 08/11/2019 02:20, Rafael J. Wysocki wrote:
> > On Wednesday, October 30, 2019 8:51:40 AM CET Daniel Lezcano wrote:
> >> Currently, the play_idle function does not allow to tell which idle
> >> state we want to go. Improve this by passing the idle state as
> >> parameter to the function.
> >>
> >> Export cpuidle_find_deepest_state() symbol as it is used from the
> >> intel_powerclamp driver as a module.
> >>
> >> There is no functional changes, the cpuidle state is the deepest one.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >>   V6:
> >>    - Change variable name 'state' -> 'index':
> >>      https://lkml.org/lkml/2019/10/28/874
> >>   V4:
> >>    - Add EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state) for the
> >>      intel_powerclamp driver when this one is compiled as a module
> >>   V3:
> >>    - Add missing cpuidle.h header
> >> ---
> >>  drivers/cpuidle/cpuidle.c                | 1 +
> >>  drivers/powercap/idle_inject.c           | 4 +++-
> >>  drivers/thermal/intel/intel_powerclamp.c | 4 +++-
> >>  include/linux/cpu.h                      | 2 +-
> >>  kernel/sched/idle.c                      | 4 ++--
> >>  5 files changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> >> index 18523ea6b11b..b871fc2e8e67 100644
> >> --- a/drivers/cpuidle/cpuidle.c
> >> +++ b/drivers/cpuidle/cpuidle.c
> >> @@ -126,6 +126,7 @@ int cpuidle_find_deepest_state(void)
> >>
> >>      return find_deepest_state(drv, dev, UINT_MAX, 0, false);
> >>  }
> >> +EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state);
> >
> > That doesn't appear to be really necessary to me.
> >
> >>
> >>  #ifdef CONFIG_SUSPEND
> >>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
> >> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> >> index cd1270614cc6..233c878cbf46 100644
> >> --- a/drivers/powercap/idle_inject.c
> >> +++ b/drivers/powercap/idle_inject.c
> >> @@ -38,6 +38,7 @@
> >>  #define pr_fmt(fmt) "ii_dev: " fmt
> >>
> >>  #include <linux/cpu.h>
> >> +#include <linux/cpuidle.h>
> >>  #include <linux/hrtimer.h>
> >>  #include <linux/kthread.h>
> >>  #include <linux/sched.h>
> >> @@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
> >>       */
> >>      iit->should_run = 0;
> >>
> >> -    play_idle(READ_ONCE(ii_dev->idle_duration_us));
> >> +    play_idle(READ_ONCE(ii_dev->idle_duration_us),
> >> +              cpuidle_find_deepest_state());
> >
> > The next patch changes this again and I'm not sure why this intermediate
> > change is useful.
> >
> >>  }
> >>
> >>  /**
> >> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> >> index 53216dcbe173..b55786c169ae 100644
> >> --- a/drivers/thermal/intel/intel_powerclamp.c
> >> +++ b/drivers/thermal/intel/intel_powerclamp.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/delay.h>
> >>  #include <linux/kthread.h>
> >>  #include <linux/cpu.h>
> >> +#include <linux/cpuidle.h>
> >>  #include <linux/thermal.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/tick.h>
> >> @@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
> >>      if (should_skip)
> >>              goto balance;
> >>
> >> -    play_idle(jiffies_to_usecs(w_data->duration_jiffies));
> >> +    play_idle(jiffies_to_usecs(w_data->duration_jiffies),
> >> +              cpuidle_find_deepest_state());
> >
> > I don't see a reason for changing the code here like this.
> >
> > What you really need is to have a way to set a limit on the idle
> > state exit latency for idle injection on ARM.
>
> Mmh, yes you are right. The idle state number is part of the internals
> of the cpuidle framework while the exit latency is an input (from user
> or kernel).
>
> > For that you can pass the exit latency limit to play_idle(), but then
> > you need to change powerclamp to pass UNIT_MAX or similar which is
> > ugly, or you can redefine cpuidle_use_deepest_state() to take the
> > exit latency limit as the arg (with 0 meaning use_deepest_state == false).
>
> Should it make sense to just get the resume latency in
> cpuidle_use_deepest_state() and pass the value to find_deepest_state()?

Yes, I would change cpuidle_use_deepest_state() to take the max exit
latency as the arg (maybe with 0 meaning "don't use the deepest state
only any more").

> It is the only code path where the constraint is not taken into account
> AFAICT.
>
> With this simple change, we can manage everything from the pm_qos API
> then and this series is no longer needed.

OK
