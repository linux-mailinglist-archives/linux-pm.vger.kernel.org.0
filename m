Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEC2D106B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 13:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgLGMR7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 07:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgLGMRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 07:17:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02FFC0613D1
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 04:17:08 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b26so9739237pfi.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 04:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PwLZYHwCCF3paOBJPS1BhWHdD5X4EpiAe0X9vEiR5i4=;
        b=FfsAEx4C8auc6kFouD16ppQeJreiSK9Bmf2UUOL/SaDDjzQKESgY+RuwwJ2+dfgOT4
         5lqc5wNWxR9KKRYejM6SRgIvp9TWNZqptadCRNYzRGvquJdyn3ybXZCSVQwVJU1xGQWu
         W4dZqWghKPeyE9rICjckbH937pjD1VPgGfRR7uv9ljvqkvJBEZ8EHV8LAgMUaCx8hIXM
         MkUFKSb36jNxaEHowKTL0BLsLMqGNPY4yME1lUPB5zQf74N7y3v4/EO9VWjAIO1KQ3ke
         JZ4Les6/HzxlOYG6gFm52sCOymPyC4XMlmUK0tY3GCU45AdNoNChDAFj/id4696OiDHS
         3tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PwLZYHwCCF3paOBJPS1BhWHdD5X4EpiAe0X9vEiR5i4=;
        b=tvvwH9nhWofUbcn712aObvLFvZQj1t1hCgnOw+e/S/bSQBz1vjnbi4tXnJriggX++p
         ciozAfU34GXdVugvWzfuMZuVEzYGG0WFdfeYJGF4HWXxQBWtXethFg9jGWpCTHoQ3ZO1
         7afQLKYG8wAio87vRe4oC9JobELhLJ7fkuMOCZ+1hJdW/k/IFoDlhSJBxy8eaXO3M+YT
         B7BPH+m8qi/cMyHlDpmOl5zNpA2bcWz1CM3mXrtOQGjCw69r3Dx60KdHMNCxKwwYyJaP
         wYMbsSuJCAjLSd2hwY+h+FfC41botzhInMA5uKs7WwVuCpJkGEzKeufpIV3+JdZjX+p0
         fuTw==
X-Gm-Message-State: AOAM5312lK35zdWGFPFPoQ+ahAUNI1fyGD5+58kI4MMkuuALO3sm6VZO
        4nXTbgjkyu1zCjYbgMgx7QIaMw==
X-Google-Smtp-Source: ABdhPJyRRXk2sNCSSIrQgDr+mFrwOEQ9P+q7ugFF/wx5Ny7KT55tTvF+j/CNyLSls6MMIMHO6H3F6g==
X-Received: by 2002:a63:931a:: with SMTP id b26mr535035pge.55.1607343428387;
        Mon, 07 Dec 2020 04:17:08 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id s21sm11523469pgk.52.2020.12.07.04.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 04:17:07 -0800 (PST)
Date:   Mon, 7 Dec 2020 17:47:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 3/3] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Message-ID: <20201207121704.hpyw3ij3wvb5s7os@vireshk-i7>
References: <cover.1606198885.git.viresh.kumar@linaro.org>
 <c0d7c796be7df6ac0102d8c2701fc6b541d2ff7d.1606198885.git.viresh.kumar@linaro.org>
 <95991789-0308-76a9-735b-01ef620031b9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95991789-0308-76a9-735b-01ef620031b9@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-12-20, 12:54, Dietmar Eggemann wrote:
> On 24/11/2020 07:26, Viresh Kumar wrote:
> > Several parts of the kernel are already using the effective CPU
> > utilization (as seen by the scheduler) to get the current load on the
> > CPU, do the same here instead of depending on the idle time of the CPU,
> > which isn't that accurate comparatively.
> > 
> > This is also the right thing to do as it makes the cpufreq governor
> > (schedutil) align better with the cpufreq_cooling driver, as the power
> > requested by cpufreq_cooling governor will exactly match the next
> > frequency requested by the schedutil governor since they are both using
> > the same metric to calculate load.
> > 
> > This was tested on ARM Hikey6220 platform with hackbench, sysbench and
> > schbench. None of them showed any regression or significant
> > improvements. Schbench is the most important ones out of these as it
> > creates the scenario where the utilization numbers provide a better
> > estimate of the future.
> > 
> > Scenario 1: The CPUs were mostly idle in the previous polling window of
> > the IPA governor as the tasks were sleeping and here are the details
> > from traces (load is in %):
> > 
> >  Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
> >  New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960
> 
> When I ran schbench (-t 16 -r 5) on hikey960 I get multiple (~50)
> instances of ~80ms task activity phase and then ~20ms idle phase on all
> CPUs.
> 
> So I assume that scenario 1 is at the beginning (but you mentioned the
> task were sleeping?)

I am not able to find the exact values I used, but I did something
like this to create a scenario where the old computations shall find
the CPU as idle in the last IPA window:

- schbench -m 2 -t 4 -s 25000 -c 20000 -r 60

- sampling rate of IPA to 10 ms

With this IPA wakes up many times and finds the CPUs to have been idle
in the last IPA window (i.e. 10ms).

> and scenario 2 is somewhere in the middle of the
> testrun?

This also happens all the time, as there will be cases when the IPA
runs and finds the CPUs to be always running in last 10 ms.

> IMHO, the util-based approach delivers really better results at the
> beginning and at the end of the entire testrun.
> During the testrun, the util-based and the idle-based approach deliver
> similar results.
> 
> It's a little bit tricky to compare test results since the IPA sampling
> rate is 100ms and the load values you get depend on how the workload
> pattern and the IPA sampling align.

Right.

> > Here, the "Old" line gives the load and requested_power (dynamic_power
> > here) numbers calculated using the idle time based implementation, while
> > "New" is based on the CPU utilization from scheduler.
> > 
> > As can be clearly seen, the load and requested_power numbers are simply
> > incorrect in the idle time based approach and the numbers collected from
> > CPU's utilization are much closer to the reality.
> 
> I assume the IPA sampling is done after ~50ms of the first task activity
> phase.
> 
> > Scenario 2: The CPUs were busy in the previous polling window of the IPA
> > governor:
> > 
> >  Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
> >  New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672
> > 
> > As can be seen, the idle time based load is 100% for all the CPUs as it
> > took only the last window into account, but in reality the CPUs aren't
> > that loaded as shown by the utilization numbers.
> 
> Is this an IPA sampling at the end of the ~20ms idle phase?

This is during the phase where the CPUs were fully busy for the last
period.

-- 
viresh
