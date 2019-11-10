Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27181F6A42
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2019 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKJQt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 11:49:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37905 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKJQt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Nov 2019 11:49:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id a14so9502040oid.5;
        Sun, 10 Nov 2019 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hF4gcvRLoFI5GEISKxekVetVmnJbmxGGWorHkggFZtA=;
        b=sXVjINRN6dWhI1jhVw8iTzaoBt/EPUnV57oeUIVJaRdcEmnSNIDufKV0S0RCdGu0HH
         5J+mzPvPYN6SPsPphDDhY/Q8gjftn1NOgJDBMUOYKq4sVEegCq+PcXA3P7li3FpN6HJW
         zIgkm0CzkYGvNH524H2AsU/WDd/EUYnZFSqBU2yJABgRkl5Lw4PQjBngetigI2dBNMxk
         A3HUmb8ut/oPwQpK2JbBG9Y7uE3fcVcUS0XgKzPzdymyizsm4KmtfRW34o1Ox2E2T7MX
         IV5eeccJZeSgD0uU6mA4M8d0NGhC1BRXBTD5DbiTPLKRXjH4aGUFKtY4cmkFtBLq3/IM
         88wg==
X-Gm-Message-State: APjAAAW67e0RqwhcNv10TaUyWUMdBl0PIl4w4fQhspffBHVsEdolzWuF
        LKlpbjNiBjdjmcKqJeMiYUwV5CQ1xB+v/Rb0H7s=
X-Google-Smtp-Source: APXvYqwocqyArLhnCTnNgpL3WAP1SlQIayKttbriLtJ/Bn6+a1Gk2C0XMzoFr6MqDTM+6calLN3MF5baVVqrCEI7law=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr19566038oig.68.1573404565469;
 Sun, 10 Nov 2019 08:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20191030075141.1039-1-daniel.lezcano@linaro.org>
 <20191030075141.1039-2-daniel.lezcano@linaro.org> <143021538.HHUP3Pj7i7@kreacher>
 <9dfe3bd3-1903-4dc4-0605-27cc867d87ad@linaro.org> <CAJZ5v0hLZ9O=QtZ+ktc-_Dk7aJjgD9BRLyYKw1g9Ze2n8KZyVQ@mail.gmail.com>
 <59f10030-cef0-4d75-5135-9d0590385fda@linaro.org>
In-Reply-To: <59f10030-cef0-4d75-5135-9d0590385fda@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 10 Nov 2019 17:49:10 +0100
Message-ID: <CAJZ5v0hEYPbvbW6SErsd=uPsty9pC-4cLhCt2TiZx=JSVWLdsQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/3] cpuidle: play_idle: Specify play_idle with an idle state
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Fri, Nov 8, 2019 at 2:33 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 08/11/2019 11:56, Rafael J. Wysocki wrote:
> > On Fri, Nov 8, 2019 at 11:47 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 08/11/2019 02:20, Rafael J. Wysocki wrote:
> >>> On Wednesday, October 30, 2019 8:51:40 AM CET Daniel Lezcano wrote:
> >>>> Currently, the play_idle function does not allow to tell which idle
> >>>> state we want to go. Improve this by passing the idle state as
> >>>> parameter to the function.
> >>>>
> >>>> Export cpuidle_find_deepest_state() symbol as it is used from the
> >>>> intel_powerclamp driver as a module.
> >>>>
> >>>> There is no functional changes, the cpuidle state is the deepest one.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> ---
> >>>>   V6:
> >>>>    - Change variable name 'state' -> 'index':
> >>>>      https://lkml.org/lkml/2019/10/28/874
> >>>>   V4:
> >>>>    - Add EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state) for the
> >>>>      intel_powerclamp driver when this one is compiled as a module
> >>>>   V3:
> >>>>    - Add missing cpuidle.h header
> >>>> ---
> >>>>  drivers/cpuidle/cpuidle.c                | 1 +
> >>>>  drivers/powercap/idle_inject.c           | 4 +++-
> >>>>  drivers/thermal/intel/intel_powerclamp.c | 4 +++-
> >>>>  include/linux/cpu.h                      | 2 +-
> >>>>  kernel/sched/idle.c                      | 4 ++--
> >>>>  5 files changed, 10 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> >>>> index 18523ea6b11b..b871fc2e8e67 100644
> >>>> --- a/drivers/cpuidle/cpuidle.c
> >>>> +++ b/drivers/cpuidle/cpuidle.c
> >>>> @@ -126,6 +126,7 @@ int cpuidle_find_deepest_state(void)
> >>>>
> >>>>      return find_deepest_state(drv, dev, UINT_MAX, 0, false);
> >>>>  }
> >>>> +EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state);
> >>>
> >>> That doesn't appear to be really necessary to me.
> >>>
> >>>>
> >>>>  #ifdef CONFIG_SUSPEND
> >>>>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
> >>>> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> >>>> index cd1270614cc6..233c878cbf46 100644
> >>>> --- a/drivers/powercap/idle_inject.c
> >>>> +++ b/drivers/powercap/idle_inject.c
> >>>> @@ -38,6 +38,7 @@
> >>>>  #define pr_fmt(fmt) "ii_dev: " fmt
> >>>>
> >>>>  #include <linux/cpu.h>
> >>>> +#include <linux/cpuidle.h>
> >>>>  #include <linux/hrtimer.h>
> >>>>  #include <linux/kthread.h>
> >>>>  #include <linux/sched.h>
> >>>> @@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
> >>>>       */
> >>>>      iit->should_run = 0;
> >>>>
> >>>> -    play_idle(READ_ONCE(ii_dev->idle_duration_us));
> >>>> +    play_idle(READ_ONCE(ii_dev->idle_duration_us),
> >>>> +              cpuidle_find_deepest_state());
> >>>
> >>> The next patch changes this again and I'm not sure why this intermediate
> >>> change is useful.
> >>>
> >>>>  }
> >>>>
> >>>>  /**
> >>>> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> >>>> index 53216dcbe173..b55786c169ae 100644
> >>>> --- a/drivers/thermal/intel/intel_powerclamp.c
> >>>> +++ b/drivers/thermal/intel/intel_powerclamp.c
> >>>> @@ -29,6 +29,7 @@
> >>>>  #include <linux/delay.h>
> >>>>  #include <linux/kthread.h>
> >>>>  #include <linux/cpu.h>
> >>>> +#include <linux/cpuidle.h>
> >>>>  #include <linux/thermal.h>
> >>>>  #include <linux/slab.h>
> >>>>  #include <linux/tick.h>
> >>>> @@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
> >>>>      if (should_skip)
> >>>>              goto balance;
> >>>>
> >>>> -    play_idle(jiffies_to_usecs(w_data->duration_jiffies));
> >>>> +    play_idle(jiffies_to_usecs(w_data->duration_jiffies),
> >>>> +              cpuidle_find_deepest_state());
> >>>
> >>> I don't see a reason for changing the code here like this.
> >>>
> >>> What you really need is to have a way to set a limit on the idle
> >>> state exit latency for idle injection on ARM.
> >>
> >> Mmh, yes you are right. The idle state number is part of the internals
> >> of the cpuidle framework while the exit latency is an input (from user
> >> or kernel).
> >>
> >>> For that you can pass the exit latency limit to play_idle(), but then
> >>> you need to change powerclamp to pass UNIT_MAX or similar which is
> >>> ugly, or you can redefine cpuidle_use_deepest_state() to take the
> >>> exit latency limit as the arg (with 0 meaning use_deepest_state == false).
> >>
> >> Should it make sense to just get the resume latency in
> >> cpuidle_use_deepest_state() and pass the value to find_deepest_state()?
> >
> > Yes, I would change cpuidle_use_deepest_state() to take the max exit
> > latency as the arg (maybe with 0 meaning "don't use the deepest state
> > only any more").
>
> Why not simply ?
>
> int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev)
> {
>         int latency = cpuidle_governor_latency_req(dev->cpu);
>
>         return find_deepest_state(drv, dev, latency_req, 0, false);
> }

Because, AFAICS, that doesn't work for powerclamp.
