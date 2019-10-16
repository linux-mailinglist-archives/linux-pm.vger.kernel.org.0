Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A33D97AA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfJPQlb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 12:41:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36699 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389155AbfJPQlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 12:41:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so3511107wmc.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FlNDkU9LJr0xxxuiAt/Gkp/wNTI/dRwGsITKJxGBYVM=;
        b=koGYZnSgbZ5dy+xp4rwaEXp1t5FieORai3VdLE/nrENQpmJb5s8GO0Gf6i7yTurYHC
         9v9GgsJ6vfCAHjeqkfP4P9POMO8VxgP6zMFzK4gRnD60NxE60UKw2f91Egjzp3dXSgBJ
         Lr46GfbiZowSAk+2CmYbaABKklKGqAG+lJtiUnp9vuiiSeDxloIf69+pAPiH/JGE/7gI
         4RJZp1wJE8NJcTj4nKHA0W4qSyov9IAF1cVmBedaW9ELLv3gaRx1Z3kOhR+WdvD7t22v
         Sr+hnu4257BNn6Kr1f+9xA9ChCoNzK+ljezX+EJO8ZAqxi2rN9BCxNBekYYiSUQC0wOW
         x6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FlNDkU9LJr0xxxuiAt/Gkp/wNTI/dRwGsITKJxGBYVM=;
        b=aeSgRr4Zr5q/mgbpjNoZTKL4Z9pteLlWLwz0TjdunnwJfJCiST84m7LsGwafgv1Y5N
         GsYL8M57WaWxHmTvvWd88GG45bl1fwl75WljG0WPf51wtNyPpK3RC4qx4eYR1+2tG3N+
         XnU6bf8UFxU9qCcvqVXSJby4ieYuZ9dbuHIkPH/0POC4QiVoSSa/Jk8MWodoVSc7u4Hg
         db0jIg8Fbi0Pt0SKqU5g4nAfbeznBvhnusYfrpowJTnZ0e8eG1jvnpB6tjgljUNjyttK
         Hr7tZ3LDFlYEUXrhiWHTjc7jc6uSPr1Zb5PI7IpGYRmjZsFAyhgWhWRRsHLuvVnlmoHX
         aHUg==
X-Gm-Message-State: APjAAAU2cf85ukCpZaC90K8bdhzBEFbQfnBGLnkH+/mAMgSzCRScttRr
        teXPjjo3mxAtyKsgU8we+3heoA==
X-Google-Smtp-Source: APXvYqzdCEIQsc5yY//wpY1dx8EDNhY87uT+SgLLb+ZN9pLNQYySWfYY0mw10APjTDIyh+Yco19jag==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr4464703wmc.9.1571244087439;
        Wed, 16 Oct 2019 09:41:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:75dd:9b83:7d04:b72e? ([2a01:e34:ed2f:f020:75dd:9b83:7d04:b72e])
        by smtp.googlemail.com with ESMTPSA id a3sm5014964wmc.3.2019.10.16.09.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:41:26 -0700 (PDT)
Subject: Re: [PATCH V4 1/3] cpuidle: play_idle: Make play_idle more flexible
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191004083205.29302-1-daniel.lezcano@linaro.org>
 <CAPDyKFo4WE4trWhxcxDcp1S+uPb6OJBY=-+fYht9k_4DpuQrNQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <762e7966-a276-cca2-7baa-fa22c26f25f3@linaro.org>
Date:   Wed, 16 Oct 2019 18:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo4WE4trWhxcxDcp1S+uPb6OJBY=-+fYht9k_4DpuQrNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2019 15:06, Ulf Hansson wrote:
> On Fri, 4 Oct 2019 at 10:32, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The play_idle function has two users, the intel powerclamp and the
>> idle_injection.
>>
>> The idle injection cooling device uses the function via the
>> idle_injection powercap's APIs. Unfortunately, play_idle is currently
>> limited by the idle state depth: by default the deepest idle state is
>> selected. On the ARM[64] platforms, most of the time it is the cluster
>> idle state, the exit latency and the residency can be very high. That
>> reduces the scope of the idle injection usage because the impact on
>> the performances can be very significant.
>>
>> If the idle injection cycles can be done with a shallow state like a
>> retention state, the cooling effect would eventually give similar
>> results than the cpufreq cooling device.
>>
>> In order to prepare the function to receive an idle state parameter,
>> let's replace the 'use_deepest_state' boolean field with 'use_state'
>> and use this value to enter the specific idle state.
>>
>> The current code keeps the default behavior which is go to the deepest
>> idle state.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
>>  include/linux/cpuidle.h   | 13 ++++++-------
>>  kernel/sched/idle.c       | 10 +++++-----
>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 0895b988fa92..f8b54f277589 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -99,31 +99,31 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>>  }
>>
>>  /**
>> - * cpuidle_use_deepest_state - Set/clear governor override flag.
>> - * @enable: New value of the flag.
>> + * cpuidle_use_state - Force the cpuidle framework to enter an idle state.
>> + * @state: An integer for an idle state
>>   *
>> - * Set/unset the current CPU to use the deepest idle state (override governors
>> - * going forward if set).
>> + * Specify an idle state the cpuidle framework must step in and bypass
>> + * the idle state selection process.
>>   */
>> -void cpuidle_use_deepest_state(bool enable)
>> +void cpuidle_use_state(int state)
>>  {
>>         struct cpuidle_device *dev;
>>
>>         preempt_disable();
>>         dev = cpuidle_get_device();
>>         if (dev)
>> -               dev->use_deepest_state = enable;
>> +               dev->use_state = state;
>>         preempt_enable();
>>  }
>>
>>  /**
>>   * cpuidle_find_deepest_state - Find the deepest available idle state.
>> - * @drv: cpuidle driver for the given CPU.
>> - * @dev: cpuidle device for the given CPU.
>>   */
>> -int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>> -                              struct cpuidle_device *dev)
>> +int cpuidle_find_deepest_state(void)
>>  {
>> +       struct cpuidle_device *dev = cpuidle_get_device();
>> +       struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>> +
>>         return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>>  }
>>
>> @@ -554,6 +554,7 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>>  static void __cpuidle_device_init(struct cpuidle_device *dev)
>>  {
>>         memset(dev->states_usage, 0, sizeof(dev->states_usage));
>> +       dev->use_state = CPUIDLE_STATE_NOUSE;
>>         dev->last_residency = 0;
>>         dev->next_hrtimer = 0;
>>  }
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 2dc4c6b19c25..ba0751b26e37 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -15,6 +15,7 @@
>>  #include <linux/list.h>
>>  #include <linux/hrtimer.h>
>>
>> +#define CPUIDLE_STATE_NOUSE    -1
>>  #define CPUIDLE_STATE_MAX      10
>>  #define CPUIDLE_NAME_LEN       16
>>  #define CPUIDLE_DESC_LEN       32
>> @@ -80,11 +81,11 @@ struct cpuidle_driver_kobj;
>>  struct cpuidle_device {
>>         unsigned int            registered:1;
>>         unsigned int            enabled:1;
>> -       unsigned int            use_deepest_state:1;
>>         unsigned int            poll_time_limit:1;
>>         unsigned int            cpu;
>>         ktime_t                 next_hrtimer;
>>
>> +       int                     use_state;
>>         int                     last_state_idx;
>>         int                     last_residency;
>>         u64                     poll_limit_ns;
>> @@ -203,19 +204,17 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>>  #endif
>>
>>  #ifdef CONFIG_CPU_IDLE
>> -extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>> -                                     struct cpuidle_device *dev);
>> +extern int cpuidle_find_deepest_state(void);
>>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>>                                 struct cpuidle_device *dev);
>> -extern void cpuidle_use_deepest_state(bool enable);
>> +extern void cpuidle_use_state(int state);
>>  #else
>> -static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>> -                                            struct cpuidle_device *dev)
>> +static inline int cpuidle_find_deepest_state(void)
>>  {return -ENODEV; }
>>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>>                                        struct cpuidle_device *dev)
>>  {return -ENODEV; }
>> -static inline void cpuidle_use_deepest_state(bool enable)
>> +static inline void cpuidle_use_state(int state)
>>  {
>>  }
>>  #endif
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index b98283fc6914..17da9cb309e1 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -165,7 +165,8 @@ static void cpuidle_idle_call(void)
>>          * until a proper wakeup interrupt happens.
>>          */
>>
>> -       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
>> +       if (idle_should_enter_s2idle() ||
>> +           dev->use_state != CPUIDLE_STATE_NOUSE) {
>>                 if (idle_should_enter_s2idle()) {
>>                         rcu_idle_enter();
>>
>> @@ -181,8 +182,7 @@ static void cpuidle_idle_call(void)
>>                 tick_nohz_idle_stop_tick();
>>                 rcu_idle_enter();
>>
>> -               next_state = cpuidle_find_deepest_state(drv, dev);
>> -               call_cpuidle(drv, dev, next_state);
>> +               call_cpuidle(drv, dev, dev->use_state);
> 
> This doesn't look correct to me.
> 
> More precisely, in the s2idle case, we always pick the deepest state.
> But from the change above, we would invoke call_cpuidle() with
> CPUIDLE_STATE_NOUSE, right!?

There is the condition 'if (idle_should_enter_s2idle())' which gives
another path.

But that is true if the call fails with a negative or zero value for the
entered state we fallback to call_cpuidle with CPUIDLE_STATE_NOUSE. This
context does not appear in the patch.

Perhaps, something like (on top of this patch):

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6bcea3c06ebe..fc7f5216b579 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -177,12 +177,15 @@ static void cpuidle_idle_call(void)
                        }

                        rcu_idle_exit();
+                       next_state = cpuidle_find_deepest_state();
+               } else {
+                       next_state = dev->use_state;
                }

                tick_nohz_idle_stop_tick();
                rcu_idle_enter();

-               call_cpuidle(drv, dev, dev->use_state);
+               call_cpuidle(drv, dev, next_state);
        } else {
                bool stop_tick = true;



> 
>>         } else {
>>                 bool stop_tick = true;
>>
>> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>>         rcu_sleep_check();
>>         preempt_disable();
>>         current->flags |= PF_IDLE;
>> -       cpuidle_use_deepest_state(true);
>> +       cpuidle_use_state(cpuidle_find_deepest_state());
>>
>>         it.done = 0;
>>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> @@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
>>         while (!READ_ONCE(it.done))
>>                 do_idle();
>>
>> -       cpuidle_use_deepest_state(false);
>> +       cpuidle_use_state(CPUIDLE_STATE_NOUSE);
>>         current->flags &= ~PF_IDLE;
>>
>>         preempt_fold_need_resched();
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

