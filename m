Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A089415AC67
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBLPxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 10:53:12 -0500
Received: from foss.arm.com ([217.140.110.172]:34472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBLPxM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 10:53:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AD72328;
        Wed, 12 Feb 2020 07:53:11 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7BEF3F68F;
        Wed, 12 Feb 2020 07:53:09 -0800 (PST)
Subject: Re: Suspect broken frequency transitions on SDM845
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <eb8c48fb-c9b1-79c1-21b3-cd41ea37e2c6@arm.com>
Message-ID: <c46e07df-b01a-4ff5-19c7-9b70063f1665@arm.com>
Date:   Wed, 12 Feb 2020 15:53:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eb8c48fb-c9b1-79c1-21b3-cd41ea37e2c6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/02/2020 12:53, Valentin Schneider wrote:
> We've been getting some sporadic failures on the big CPUs of a Pixel3
> running mainline [1], here is an example of a correct run (CPU4):
> 
> | frequency (kHz) | sysbench events |
> |-----------------+-----------------|
> |          825600 |             236 |
> |         1286400 |             369 |
> |         1689600 |             483 |
> |         2092800 |             600 |
> |         2476800 |             711 |
> 
> and here is a failed one (still CPU4):
> 
> | frequency (kHz) | sysbench events |
> |-----------------+-----------------|
> |          825600 |             234 |
> |         1286400 |             369 |
> |         1689600 |             449 |
> |         2092800 |             600 |
> |         2476800 |             355 |
> 
> 
> We've encountered something like this in the past with the exact same
> test on h960 [2] but it is much harder to reproduce reliably this time
> around.
> 
> I haven't found much time to dig into this; I did get a run of ~100 
> iterations with about ~15 failures, but nothing cpufreq related showed up in
> dmesg. I briefly suspected fast-switch, but it's only used by schedutil, so
> in this test I would expect the frequency transition to be complete before we
> even try to start executing sysbench.
> 

I've been adding some more debug stuff in that test case following some of
Lukasz' recommendations, and I still don't find anything that would
explain what I'm seeing.

The raw output of the test is:

        CPU0:
            300000: 61
            576000: 114
            825600: 172
            1056000: 221
            1324800: 278
            1612800: 339
        CPU4:
            825600: 236
            1286400: 368
            1689600: 479
            2092800: 420 <---}
            2476800: 339 <---} Both of these are not monotonically increasing...


/sys/kernel/debug/clk/clk_summary doesn't seem to include CPU clocks, or
doesn't get updated because I see no diff from one frequency to another
(even between lowest & highest tested frequency)


/sys/devices/system/cpu/cpu*/cpufreq/stats/time_in_state does get updated,
and seems to hint that I am getting the frequency I'm asking for:

  [2020-02-12 14:48:21,706] 2476800 39544
  [2020-02-12 14:48:23,929] 2476800 39745

There's about ~10% (200ms) missing here, but that shouldn't lead to about
half the expected performance (I get ~710 "score" out of that 2.477GHz freq
on non-failing runs).


I also made sure to read back
  /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
and I do see the value I've asked for.


Finally, I also probed the thermal state via
  /sys/class/thermal/cooling_device*/cur_state
and they are *always* 0 (i.e., no throttling) right after finishing the
execution of the benchmark, which should be close to the "hottest" point.


So AFAICT there is nothing on the cpufreq side that hints at a slow or
unsuccessful frequency transition. Can FW mess about frequencies without
notifying the kernel?

> If anyone has the time and will to look into this, that would be much
> appreciated.
> 
> [1]: https://git.linaro.org/people/amit.pundir/linux.git/log/?h=blueline-mainline-tracking
> [2]: https://lore.kernel.org/lkml/d3ede0ab-b635-344c-faba-a9b1531b7f05@arm.com/
> 
> Cheers,
> Valentin
> 
