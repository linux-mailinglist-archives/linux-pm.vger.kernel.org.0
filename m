Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9092C0385
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 11:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgKWKlZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 05:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKWKlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 05:41:24 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829DC061A4D
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 02:41:23 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so14553231pfu.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4UeX702/W/B+orq6/435ThFfL21LhW6NTckU122ScE=;
        b=x7op+jf5m//qfxOW3YREpxBAYH/LAYSElwklnA60y/QJvCAKLz/NT5Gq5EeVdcne4X
         wQqy39P0zj/yAmJYwWpP9zm9Ui9h2U+80q7Y7IOUfMl7u37/1+ylAp+5iTePZ15nDDgQ
         CanlLm6DlwykU5Vj64+s0JTcVFuTHLsEqmslOsc8NtfY3Uwql+e88Hbu/jmH/FXhGFJ2
         PpEVg9Xsgr/CGbD07d/N6FTQXuJsBjFMv7zkqIB2E9L5/NvgrECrj2re84UAr9KObFSn
         PuJf7A85Wfznjq6lZj6cAP0K6UfaqiT/9miXA1DsJ+3+0MrDf5rXCeJsAfrBVx1dHhlG
         wYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4UeX702/W/B+orq6/435ThFfL21LhW6NTckU122ScE=;
        b=ma+45LrEXKrpwBTP5r+2SOlKw9AVMTT48HE2IualaPmXFnZanGmb9fke4Q2oNAM534
         Kyfpf7u2mFfDLpp8XllrzYo6++bIIpz0pcX4fBrk6bfMxaWDXYSkjHmvFt0rFPyeo6zm
         7SInvzkRSKEuMelqzUddYrpNaa2UmQ035RL1IknvCF1Zd1ZuU42GNcBJ3vQcBEmeiGTH
         SOW+oFnr+DQxnyriuvQ/bagu+kkgvqZkwjkEjGK+qllyQbEHw8mmnpn6r8tjy+UmZhiI
         AcFRS2O+8p7iLX8FRqeFRPjW0KycMuh28YePaDTqjSJL0IeDYMQbIEyiJxn3QIddrUPb
         69WQ==
X-Gm-Message-State: AOAM530Q3ZMwoMzVe5oEBq0tjbWCFSuj81Vg4PGkp+OElD35RcUqHrJm
        kCq+dZ8IMmjoPewxeOCZ6f/MyA==
X-Google-Smtp-Source: ABdhPJwdLEHQdl8W4i1u7+hMZVMXYrB5kBrzOx5IexzNxzTI4QMz+m70VCABUQsOUqWTeKODK7DSFQ==
X-Received: by 2002:a17:90b:50e:: with SMTP id r14mr24081521pjz.193.1606128082567;
        Mon, 23 Nov 2020 02:41:22 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id o133sm11440537pfg.97.2020.11.23.02.41.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 02:41:21 -0800 (PST)
Date:   Mon, 23 Nov 2020 16:11:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Message-ID: <20201123104119.g46y6idk734pw7fl@vireshk-i7>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
 <be46b60a-0304-8fe0-53cf-3c179a8fd04a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be46b60a-0304-8fe0-53cf-3c179a8fd04a@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-11-20, 14:51, Lukasz Luba wrote:
> On 11/19/20 7:38 AM, Viresh Kumar wrote:
> > Scenario 1: The CPUs were mostly idle in the previous polling window of
> > the IPA governor as the tasks were sleeping and here are the details
> > from traces (load is in %):
> > 
> >   Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
> >   New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960
> > 
> > Here, the "Old" line gives the load and requested_power (dynamic_power
> > here) numbers calculated using the idle time based implementation, while
> > "New" is based on the CPU utilization from scheduler.
> > 
> > As can be clearly seen, the load and requested_power numbers are simply
> > incorrect in the idle time based approach and the numbers collected from
> > CPU's utilization are much closer to the reality.
> 
> It is contradicting to what you have put in 'Scenario 1' description,
> isn't it?

At least I didn't think so when I wrote this and am still not sure :)

> Frequency at 1.2GHz, 75% total_load, power 4W... I'd say if CPUs were
> mostly idle than 1.3W would better reflect that state.

The CPUs were idle because the tasks were sleeping, but once the tasks
resume to work, we need a frequency that matches the real load of the
tasks. This is exactly what schedutil would ask for as well as it uses
the same metric and so we should be looking to ask for the same power
budget..

> What was the IPA period in your setup?

It is 100 ms by default, though I remember that I tried with 10 ms as
well.

> It depends on your platform IPA period (e.g. 100ms) and your current
> runqueues state (at that sampling point in time). The PELT decay/rise
> period is different. I am not sure if you observe the system avg load
> for last e.g. 100ms looking at these signals. Maybe IPA period is too
> short/long and couldn't catch up with PELT signals?
> But we won't too short averaging, since 16ms is a display tick.
> 
> IMHO based on this result it looks like the util could lost older
> information from the past or didn't converge yet to this low load yet.
> 
> > 
> > Scenario 2: The CPUs were busy in the previous polling window of the IPA
> > governor:
> > 
> >   Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
> >   New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672
> > 
> > As can be seen, the idle time based load is 100% for all the CPUs as it
> > took only the last window into account, but in reality the CPUs aren't
> > that loaded as shown by the utilization numbers.
> 
> This is also odd. The ~88% of total_load, looks like started decaying or
> didn't converge yet to 100% or some task vanished?

They must have decayed a bit because of the idle period, so looks okay
that way.

-- 
viresh
