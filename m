Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA42D4577
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgLIPc7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 10:32:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46767 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgLIPc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 10:32:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id k2so2074133oic.13;
        Wed, 09 Dec 2020 07:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymMWquIrotxyInQP6qyo10dYrPww4c4U8Yy+Xq4TdD8=;
        b=tuL1Bf01S9IhQiclq+Ptcjt6GywSl4vv+hz7wJnfFBvmUZWi+cOKpSpm7MgPkGt5sq
         oUHq54fL8QDwqgsGbADtqnasxNpZtaiqUXYxTADhnX421PlUmg7bjCyrzYuOt6GIA2ri
         41iD16OhJmBBCuj0Ox1ReG7n2vEPJ2pYoreW8VcB8FvQr0jN2lSI0lfu8Bwuqw+IMzN8
         HKhb7qD5lN0vcUITlJRMA+b2sR+TpFMLfD/xkvSYTUzCfMdeZ98LV/qLa7UK8X7XXnC3
         l/sM2YTQROR857ROw+kdiDK2qlskuj8h0aykUCGsWNjecck7bpnGFhpQQS4yaA9Nn2Xe
         Bpxw==
X-Gm-Message-State: AOAM533Deilv4+Ej9q70BoZcabHS0/hmW5KAQRrHasIminO9JDTROwoR
        FiR+VQ1FEMgnPiKemE+q370Wz0m0gFlSbTqYQTW3oKLB
X-Google-Smtp-Source: ABdhPJzHp+7AnGDlGTvZqgoXLhJzfyXNLy5rd4xz5GMBSNiDSLQF6wSWRQxHlmV3dy5oru7Ieanq6VyLnGp/tMuPNAA=
X-Received: by 2002:aca:5197:: with SMTP id f145mr2150312oib.71.1607527937662;
 Wed, 09 Dec 2020 07:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <1916732.tSaCp9PeQq@kreacher>
 <20201208085146.pzem6t3mt44xwxkm@vireshk-i7> <CAJZ5v0idoNOPU5-toOw+uTRvjJz60Ddc2xV7rMQeufY_EW58uQ@mail.gmail.com>
 <20201209051642.ddwgds4gznxt3lfn@vireshk-i7>
In-Reply-To: <20201209051642.ddwgds4gznxt3lfn@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Dec 2020 16:32:06 +0100
Message-ID: <CAJZ5v0iOvG0PNQDXN00oKCzyZmaF71UB+DJ+zHL5P3xRCAk1tQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] cpufreq: schedutil: Adjust utilization instead of frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 9, 2020 at 6:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-12-20, 18:01, Rafael J. Wysocki wrote:
> > On Tue, Dec 8, 2020 at 9:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 07-12-20, 17:29, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > When avoiding reduction of the frequency after the target CPU has
> > > > been busy since the previous frequency update, adjust the utilization
> > > > instead of adjusting the frequency, because doing so is more prudent
> > > > (it is done to counter a possible utilization deficit after all) and
> > > > it will allow some code to be shared after a subsequent change.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  kernel/sched/cpufreq_schedutil.c |   11 ++++-------
> > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > >
> > > > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > > > ===================================================================
> > > > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > > > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > > > @@ -437,7 +437,7 @@ static void sugov_update_single(struct u
> > > >  {
> > > >       struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> > > >       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> > > > -     unsigned int cached_freq = sg_policy->cached_raw_freq;
> > > > +     unsigned long prev_util = sg_cpu->util;
> > > >       unsigned int next_f;
> > > >
> > > >       sugov_iowait_boost(sg_cpu, time, flags);
> > > > @@ -451,17 +451,14 @@ static void sugov_update_single(struct u
> > > >       sugov_get_util(sg_cpu);
> > > >       sugov_iowait_apply(sg_cpu, time);
> > > >
> > > > -     next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
> > > >       /*
> > > >        * Do not reduce the frequency if the CPU has not been idle
> > > >        * recently, as the reduction is likely to be premature then.
> > > >        */
> > > > -     if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > > -             next_f = sg_policy->next_freq;
> > > > +     if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> > > > +             sg_cpu->util = prev_util;
> > > >
> > > > -             /* Restore cached freq as next_freq has changed */
> > > > -             sg_policy->cached_raw_freq = cached_freq;
> > > > -     }
> > > > +     next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
> > >
> > > I don't think we can replace freq comparison by util, or at least it will give
> > > us a different final frequency and the behavior is changed.
> > >
> > > Lets take an example, lets say current freq is 1 GHz and max is 1024.

Ah, so that's in the freq-dependent case.

In the freq-invariant case next_f doesn't depend on the current frequency.

> > > Round 1: Lets say util is 1000
> > >
> > > next_f = 1GHz * 1.25 * 1000/1024 = 1.2 GHz
> > >
> > > Round 2: Lets say util has come down to 900 here,
> > >
> > > before the patch:
> > >
> > > next_f = 1.2 GHz * 1.25 * 900/1024 = 1.31 GHz
> > >
> > > after the patch:
> > >
> > > next_f = 1.2 GHz * 1.25 * 1000/1024 = 1.45 GHz
> > >
> > > Or did I make a mistake here ?
> >
> > I think so, if my understanding is correct.
> >
> > Without the patch, next_f will be reset to the previous value
> > (sq_policy->next_freq) if the CPU has been busy and the (new) next_f
> > is less than that value.
> >
> > So the "new" next_f before the patch is 1.31 GHz, but because it is
> > less than the previous value (1.45 GHz), it will be reset to that
> > value, unless I'm missing something.
>
> The prev frequency here was 1.2 GHz (after Round 1). 1.45 GHz is the
> value we get after this patch, as we take the earlier utilization
> (1000) into account instead of 900.

So I have misunderstood your example.

In the non-invariant case (which is or shortly will be relevant for
everybody interested) cpuinfo.max_freq goes into the calculation
instead of the current frequency and the mapping between util and freq
is linear.  In the freq-dependent case it is not linear, of course.

So I guess the concern is that this changes the behavior in the
freq-dependent case which may not be desirable.

Fair enough, but I'm not sure if that is enough of a reason to avoid
sharing the code between the "perf" and "freq" paths.
