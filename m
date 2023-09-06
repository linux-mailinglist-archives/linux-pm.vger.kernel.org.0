Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EBA794530
	for <lists+linux-pm@lfdr.de>; Wed,  6 Sep 2023 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjIFVik (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Sep 2023 17:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244249AbjIFVij (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2023 17:38:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B275619B5
        for <linux-pm@vger.kernel.org>; Wed,  6 Sep 2023 14:38:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40061928e5aso3366715e9.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Sep 2023 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694036313; x=1694641113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJZV82og6dNwHNKZnRHLld1kf6lJ+a1RGYkDUR7aMyc=;
        b=Xt40x1diXygLWD32CT9e65o9f5Y1NKZdiad+vl7QciXaCrY6hmGRCMwIhDASRnhvxM
         tTs56LVAHJ+EHSAb3+Ko8cy+KS/i05dS6nfyPTCb728I/1mpfhI2/fZCQ0DlMxYCprOF
         gRONPxG5xq2sdKZCSIIP5qahNPw/HEKmRyCgLllCFJmfJfc/r1X70fEeUz8scG2xTxDV
         MZSaEqYtbjirqod2tVbD/Zi6WuOQOxY0U5Qq4nbKP3tqd0m3DRj+HoDNaQf5N/jSGuSw
         jVI/uGT61dlYFlrgLNnxsckjd+yJQsHzq3IdrZTOVyixGEm0rdYrtHQp0p+cPkvu6nEF
         R03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036313; x=1694641113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJZV82og6dNwHNKZnRHLld1kf6lJ+a1RGYkDUR7aMyc=;
        b=P7vdd2/zDWuQlcClIOXYaqPoFgytaI9bq1s1/3pNEXbwqHnFWAiMtGZIpLJvgJXUq/
         bViLgZIdEHPkwarXN5vnudmsG0zRHNajLIBUuTEmdrSjuvWPH0dRf+FlHXjoPKHXVYNw
         heztIX8aJCbiUcSkIdj0bNnbXosbOavsA0mdkmMun5tL/ZZ9+XsYkWwHSMyfcbCexqlP
         PlDtxvl6AUMcp8DPOiDHmrQKAnN5No1V8PwYZqC+zTNhDghDZmmtKWdNo8lenZUkiVty
         glCHkbrKWwZuD7ZaGukhhp3xnWsuE7LPwntHNWHoG277h34Rfo+KZfDUgvgQIa1uYtz4
         j3zg==
X-Gm-Message-State: AOJu0YyPp5adnnfVIQSyHcJyf1ycrCbiV8tKdVuJTFjY1FgwBsOcdE+w
        q7VUWv7se/DJbjx6dn03451g1A==
X-Google-Smtp-Source: AGHT+IFFuKkwXgNv775Mwx1qi280sV224DQ/VFsoEDaBTPqnbixemSJM2VfOSLRFQCSCqx0Afdpw5g==
X-Received: by 2002:adf:f9d0:0:b0:319:8979:8fcc with SMTP id w16-20020adff9d0000000b0031989798fccmr3008470wrr.70.1694036313213;
        Wed, 06 Sep 2023 14:38:33 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4012000000b0031c79de4d8bsm21512603wrp.106.2023.09.06.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:38:32 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:38:31 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 2/7] sched/pelt: Add a new function to approximate
 runtime to reach given util
Message-ID: <20230906213831.jclswjplxeim2oy4@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-3-qyousef@layalina.io>
 <bad29fb0-c734-853b-492b-ce2d01a293c5@arm.com>
 <16dcf2b6-6921-10c7-ae75-a9f8015a9c85@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16dcf2b6-6921-10c7-ae75-a9f8015a9c85@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/06/23 22:44, Dietmar Eggemann wrote:
> On 06/09/2023 14:56, Dietmar Eggemann wrote:
> > On 28/08/2023 01:31, Qais Yousef wrote:
> >> It is basically the ramp-up time from 0 to a given value. Will be used
> >> later to implement new tunable to control response time  for schedutil.
> >>
> >> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> >> ---
> >>  kernel/sched/pelt.c  | 21 +++++++++++++++++++++
> >>  kernel/sched/sched.h |  1 +
> >>  2 files changed, 22 insertions(+)
> >>
> >> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> >> index 50322005a0ae..f673b9ab92dc 100644
> >> --- a/kernel/sched/pelt.c
> >> +++ b/kernel/sched/pelt.c
> >> @@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
> >>  
> >>  	return sa.util_avg;
> >>  }
> >> +
> >> +/*
> >> + * Approximate the required amount of runtime in ms required to reach @util.
> >> + */
> >> +u64 approximate_runtime(unsigned long util)
> >> +{
> >> +	struct sched_avg sa = {};
> >> +	u64 delta = 1024; // period = 1024 = ~1ms
> >> +	u64 runtime = 0;
> >> +
> >> +	if (unlikely(!util))
> >> +		return runtime;
> >> +
> >> +	while (sa.util_avg < util) {
> >> +		accumulate_sum(delta, &sa, 0, 0, 1);
> >> +		___update_load_avg(&sa, 0);
> >> +		runtime++;
> >> +	}
> >> +
> >> +	return runtime;
> >> +}
> > 
> > S_n = S_inv * (1 - 0.5^(t/hl))
> > 
> > t = hl * ln(1 - Sn/S_inv)/ln(0.5)
> > 
> > (1) for a little CPU (capacity_orig = 446)
> > 
> > t = 32ms * ln(1 - 446/1024)/ln(0.5)
> > 
> > t = 26ms
> > 
> > (2) for a big CPU (capacity = 1023 (*instead of 1024 since ln(0) not
> >     defined
> > 
> > t = 32ms * ln(1 - 1023/1024)/ln(0.5)
> > 
> > t = 320ms
> 
> Forgot half of what I wanted to ask:
> 
> And you want to be able to have a schedutil interface:
> 
> /sys/devices/system/cpu/cpufreq/policy*/schedutil/response_time_ms
> 
> in which by default we have 26ms for a CPU with the capacity_orig of 446.

Note that this *is* the default. I'm just exposing it not really changing it :)

It is actually much less than that if you take into account the current 25%
headroom.

> 
> I.e. you want to have a time-based interface there? Which the user can
> overwrite, say with 52ms and this then will lower the return value of
> get_next_freq() so the system will respond slower?
> 
> And the time based interface is more intuitive than staying in the
> capacity world of [0-1024]?

Yes this is exactly how I am defining the interface :-) I think this is generic
and will give users what they need and hopefully should stand the test of time.

The slow down aspect has a limitation though as I highlight in the cover
letter. I haven't figured out how to resolve it yet, or worth the effort.
If anyone has thoughts on that that'd be useful to learn about. It should be
fixable though.

Generally perf first is not always the desired outcome. Power and thermal play
bigger roles in a lot of systems today and I can see even sever market pays
more attention to them now.

Hence I didn't see why I should limit it to improving perf only and disregard
that there are situations where the system might be more concerned about power
or thermals and this could allow more fine tuning than limiting max frequencies
abruptly. They just get harder to reach so in average we get different
residencies (for same workload), but freqs are still reachable. There will be
a perf hit of course, but that's userspace problem to decide if it's worth it
or not.

Generally I am a big advocate of userspace to take the leap and be smarter
about what it needs and when. Fixing everything automagically has its appeal
but I don't think this is sustainable anymore.


Thanks!

--
Qais Yousef
