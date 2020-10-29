Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2245429E470
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 08:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgJ2HYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgJ2HYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 03:24:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88827C08EADC
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 00:19:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so1588998pfa.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pe6/VmVqlNcMj2jI2o/REuBVuS5E1KvQtckugKCVKUc=;
        b=s82FEYC68+zzD8FSSWf6SEHKC5++Uiz5FUkYsgOP1E95IgEHJjAqkSLrRsn5VsYWld
         Gk2AbAiPxSpwGvDgKEQ2OWnVB2bn+DTc5srU4Qer2kLVTBfp7toNTYXlGtAxsJvndnUI
         uDpXK77zwrRBrcI9TRqA+d9wrrk82GSFf8rRAyWwdl/mU2JkY/HkpHDG5ClHt4gy8Lv0
         tuu3nl7gf3ISssA5zCCkaCLEHl8yEcyKXTCCu9ekE3dIDLT+op2WtjXI+bSEeAS93PLw
         NHTvhkpDLqW1P7i7d5+HpjrTeC3ud0fbEhotPDTVpVPuCkHkkmTj3azkH11fl6e91Euw
         pcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pe6/VmVqlNcMj2jI2o/REuBVuS5E1KvQtckugKCVKUc=;
        b=QUgJD9r3XK3jl+B/cyoPrVwKCmimBklwJBkO+vNM95qw7itkT7znrl18FZd4esyTIp
         qjx/BaLVdJWfpUDYp+K/nBX2f+UY5PS17BGjhKlTmfjmOMs2ypen26NFXZgGZuK7TEoo
         CO4lyxerhfzBsWLMOUBFao+R5x4lbLEFzxJFbdQhrt896zzIVlOTGtWNfhbT+tqkfnFW
         V2fv9Ya3/ITXKNtxNna2x1iNDZbSjRrFpLYOR3R9nla58ZmMONdic0u2q9vgb0+/JX8N
         8rAejqI7602Y878JNSsSRraQO1agVck8e3QF2KIpxLCkJ0mHgLMqWdl7bTDL55lsTRtd
         BD7A==
X-Gm-Message-State: AOAM530xBYQk9FNE/tSFMddCu5uvOAADszR9wYu1Dfay17BswNx8i5kQ
        4pAM5MfBOfKUJdzNalraBhAbdQ==
X-Google-Smtp-Source: ABdhPJwqtqs9MmS/4Ufv/n9LpA9a2MnzNHgzU00OWZDwe/lod9Y7IUdHYUJYG/Qh4BIae7EpZ1xw7g==
X-Received: by 2002:a17:90a:1102:: with SMTP id d2mr3130959pja.178.1603955995907;
        Thu, 29 Oct 2020 00:19:55 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ms10sm1741402pjb.46.2020.10.29.00.19.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 00:19:54 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:49:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhuguangqing83 <zhuguangqing83@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'zhuguangqing' <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the
 final cpufreq
Message-ID: <20201029071952.7yh5ncnxqxf62pjw@vireshk-i7>
References: <095901d6ad94$e48d5140$ada7f3c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095901d6ad94$e48d5140$ada7f3c0$@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Your mail client is screwing the "In-reply-to" field of the message
and that prevents it to appear properly in the thread in mailboxes of
other people, please fix that.

On 29-10-20, 09:43, zhuguangqing83 wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 0c5c61a095f6..bf7800e853d3 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -105,7 +105,6 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >         if (sg_policy->next_freq == next_freq)
> >                 return false;
> > 
> > -       sg_policy->next_freq = next_freq;
> >         sg_policy->last_freq_update_time = time;
> > 
> >         return true;
> 
> It's a little strange that sg_policy->next_freq and 
> sg_policy->last_freq_update_time are not updated at the same time.
> 
> > @@ -115,7 +114,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> >                               unsigned int next_freq)
> >  {
> >         if (sugov_update_next_freq(sg_policy, time, next_freq))
> > -               cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> > +               sg_policy->next_freq = cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> >  }
> > 
> 
> Great, it also takes into account the issue that 0 is returned by the
> driver's ->fast_switch() callback to indicate an error condition.

Yes but even my change wasn't good enough, more on it later.

> For policy->min/max may be not the real CPU frequency in OPPs, so

No, that can't happen. If userspace tries to set a value too large or
too small, we clamp that too to policy->max/min and so the below
problem shall never occur.

> next_freq got from get_next_freq() which is after clamping between
> policy->min and policy->max may be not the real CPU frequency in OPPs.
> In that case, if we use a real CPU frequency in OPPs returned from
> cpufreq_driver_fast_switch() to compare with next_freq,
> "if (sg_policy->next_freq == next_freq)" will never be satisfied, so we
> change the CPU frequency every time schedutil callback gets called from
> the scheduler. I see the current code in get_next_freq() as following,
> the issue mentioned above should not happen. Maybe it's just one of my
> unnecessary worries.

Coming back to my patch (and yours too), it only fixes the fast-switch
case and not the slow path which can also end up clamping the
frequency. And to be honest, even the drivers can have their own
clamping code in place, no one is stopping them too.

And we also need to do something about the cached_raw_freq as well, as
it will not be in sync with next_freq anymore.

Here is another attempt from me tackling this problem. The idea is to
check if the previous freq update went as expected or not. And if not,
we can't rely on next_freq or cached_raw_freq anymore. For this to
work properly, we need to make sure policy->cur isn't getting updated
at the same time when get_next_freq() is running. For that I have
given a different meaning to work_in_progress flag, which now creates
a lockless (kind of) critical section where we won't play with
next_freq while the cpufreq core is updating the frequency.

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0c5c61a095f6..8991cc31b011 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -121,13 +121,8 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
                                  unsigned int next_freq)
 {
-       if (!sugov_update_next_freq(sg_policy, time, next_freq))
-               return;
-
-       if (!sg_policy->work_in_progress) {
-               sg_policy->work_in_progress = true;
+       if (sugov_update_next_freq(sg_policy, time, next_freq))
                irq_work_queue(&sg_policy->irq_work);
-       }
 }
 
 /**
@@ -159,6 +154,15 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
        unsigned int freq = arch_scale_freq_invariant() ?
                                policy->cpuinfo.max_freq : policy->cur;
 
+       /*
+        * The previous frequency update didn't go as we expected it to be. Lets
+        * start again to make sure we don't miss any updates.
+        */
+       if (unlikely(policy->cur != sg_policy->next_freq)) {
+               sg_policy->next_freq = 0;
+               sg_policy->cached_raw_freq = 0;
+       }
+
        freq = map_util_freq(util, freq, max);
 
        if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
@@ -337,8 +341,14 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
        ignore_dl_rate_limit(sg_cpu, sg_policy);
 
+       if (!sg_policy->policy->fast_switch_enabled) {
+               raw_spin_lock(&sg_policy->update_lock);
+               if (sg_policy->work_in_progress)
+                       goto unlock;
+       }
+
        if (!sugov_should_update_freq(sg_policy, time))
-               return;
+               goto unlock;
 
        /* Limits may have changed, don't skip frequency update */
        busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
@@ -363,13 +373,14 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
         * concurrently on two different CPUs for the same target and it is not
         * necessary to acquire the lock in the fast switch case.
         */
-       if (sg_policy->policy->fast_switch_enabled) {
+       if (sg_policy->policy->fast_switch_enabled)
                sugov_fast_switch(sg_policy, time, next_f);
-       } else {
-               raw_spin_lock(&sg_policy->update_lock);
+       else
                sugov_deferred_update(sg_policy, time, next_f);
+
+unlock:
+       if (!sg_policy->policy->fast_switch_enabled)
                raw_spin_unlock(&sg_policy->update_lock);
-       }
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
@@ -405,6 +416,9 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
        raw_spin_lock(&sg_policy->update_lock);
 
+       if (sg_policy->work_in_progress)
+               goto unlock;
+
        sugov_iowait_boost(sg_cpu, time, flags);
        sg_cpu->last_update = time;
 
@@ -419,33 +433,30 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
                        sugov_deferred_update(sg_policy, time, next_f);
        }
 
+unlock:
        raw_spin_unlock(&sg_policy->update_lock);
 }
 
 static void sugov_work(struct kthread_work *work)
 {
        struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
-       unsigned int freq;
        unsigned long flags;
 
        /*
-        * Hold sg_policy->update_lock shortly to handle the case where:
-        * incase sg_policy->next_freq is read here, and then updated by
-        * sugov_deferred_update() just before work_in_progress is set to false
-        * here, we may miss queueing the new update.
-        *
-        * Note: If a work was queued after the update_lock is released,
-        * sugov_work() will just be called again by kthread_work code; and the
-        * request will be proceed before the sugov thread sleeps.
+        * Prevent the schedutil hook to run in parallel while we are updating
+        * the frequency here and accessing next_freq.
         */
        raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
-       freq = sg_policy->next_freq;
-       sg_policy->work_in_progress = false;
+       sg_policy->work_in_progress = true;
        raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
 
        mutex_lock(&sg_policy->work_lock);
-       __cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_L);
+       __cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq, CPUFREQ_RELATION_L);
        mutex_unlock(&sg_policy->work_lock);
+
+       raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
+       sg_policy->work_in_progress = false;
+       raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
 }
 
 static void sugov_irq_work(struct irq_work *irq_work)

-- 
viresh
