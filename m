Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6969A2D3076
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgLHRCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:02:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40467 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHRCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 12:02:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id j12so16398632ota.7;
        Tue, 08 Dec 2020 09:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RajU3uwgAd7bwD7A9tKo/oGE/C6JtCOc7M0lTHPU6Mk=;
        b=HkqzFVIBse80rqulgd1kBjFuIZpFJGJvOKm3fpgcs5Iz/MDUluyK07uNA5t0zm3IBr
         kUD22IChd1Vl6Dlpx4she2WLLWafIx9SyQquVDXMHiMf5iPGg8Fs0RsqB5oI4Ql/oZ+T
         XnCHCv6J1TOeQiPCwvDYw6IJc2r+Vr/mE0oeO5/02hX/hM5GybWsOd1GAbf6IKkLO9My
         cJmqNcEV3hbe/aKhf6LZyb0ttadWu+kHE1isRyyqCovTy8vkcYhKc4O2u6IT/gjsLRu0
         z1vJhXNRIZcO4I9bIaVjYAU6niHN1ewGpjkUTYAVLL4/Yl2vxEBoQlPo5xqE3eb57FZx
         6Zhg==
X-Gm-Message-State: AOAM5331H593LG7++H/yK3gNhYNHEkWk6oyImkC/lhKXjOJ8zUJ9pwT1
        xHPrgsjqn/lr85T6F9GeRJw+fKu0NF2f2FmLiCE=
X-Google-Smtp-Source: ABdhPJzJNXwZPFUkiJ/CuZJhq2ez8MJ/yF5sFGoy0KvPjKYNWV3Az/MgLMLn9+mAgt0BTpH2syUSGsxJltE1hjI0kFw=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr10568795otn.321.1607446916017;
 Tue, 08 Dec 2020 09:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <1916732.tSaCp9PeQq@kreacher> <20201208085146.pzem6t3mt44xwxkm@vireshk-i7>
In-Reply-To: <20201208085146.pzem6t3mt44xwxkm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 18:01:44 +0100
Message-ID: <CAJZ5v0idoNOPU5-toOw+uTRvjJz60Ddc2xV7rMQeufY_EW58uQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] cpufreq: schedutil: Adjust utilization instead of frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Dec 8, 2020 at 9:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-12-20, 17:29, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When avoiding reduction of the frequency after the target CPU has
> > been busy since the previous frequency update, adjust the utilization
> > instead of adjusting the frequency, because doing so is more prudent
> > (it is done to counter a possible utilization deficit after all) and
> > it will allow some code to be shared after a subsequent change.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c |   11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -437,7 +437,7 @@ static void sugov_update_single(struct u
> >  {
> >       struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> >       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> > -     unsigned int cached_freq = sg_policy->cached_raw_freq;
> > +     unsigned long prev_util = sg_cpu->util;
> >       unsigned int next_f;
> >
> >       sugov_iowait_boost(sg_cpu, time, flags);
> > @@ -451,17 +451,14 @@ static void sugov_update_single(struct u
> >       sugov_get_util(sg_cpu);
> >       sugov_iowait_apply(sg_cpu, time);
> >
> > -     next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
> >       /*
> >        * Do not reduce the frequency if the CPU has not been idle
> >        * recently, as the reduction is likely to be premature then.
> >        */
> > -     if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > -             next_f = sg_policy->next_freq;
> > +     if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> > +             sg_cpu->util = prev_util;
> >
> > -             /* Restore cached freq as next_freq has changed */
> > -             sg_policy->cached_raw_freq = cached_freq;
> > -     }
> > +     next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
>
> I don't think we can replace freq comparison by util, or at least it will give
> us a different final frequency and the behavior is changed.
>
> Lets take an example, lets say current freq is 1 GHz and max is 1024.
>
> Round 1: Lets say util is 1000
>
> next_f = 1GHz * 1.25 * 1000/1024 = 1.2 GHz
>
> Round 2: Lets say util has come down to 900 here,
>
> before the patch:
>
> next_f = 1.2 GHz * 1.25 * 900/1024 = 1.31 GHz
>
> after the patch:
>
> next_f = 1.2 GHz * 1.25 * 1000/1024 = 1.45 GHz
>
> Or did I make a mistake here ?

I think so, if my understanding is correct.

Without the patch, next_f will be reset to the previous value
(sq_policy->next_freq) if the CPU has been busy and the (new) next_f
is less than that value.

So the "new" next_f before the patch is 1.31 GHz, but because it is
less than the previous value (1.45 GHz), it will be reset to that
value, unless I'm missing something.

Overall, the patch doesn't change the logic AFAICS and because the
util->freq mapping is linear, all of the inequalities map exactly from
one to the other (both ways).
