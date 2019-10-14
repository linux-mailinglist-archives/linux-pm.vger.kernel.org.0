Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799E6D6685
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfJNPu1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 11:50:27 -0400
Received: from foss.arm.com ([217.140.110.172]:47468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbfJNPu1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 11:50:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7854428;
        Mon, 14 Oct 2019 08:50:26 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 060BA3F718;
        Mon, 14 Oct 2019 08:50:24 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
Date:   Mon, 14 Oct 2019 16:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 10/14/19 3:53 PM, Peter Zijlstra wrote:
> On Fri, Oct 11, 2019 at 02:44:54PM +0100, Douglas RAILLARD wrote:
>> This has been ligthly tested with a rtapp task ramping from 10% to 75%
>> utilisation on a big core. Results are improved by fast ramp-up
>> EWMA [1], since it greatly reduces the oscillation in frequency at first
>> idle when ramping up.
>>
>> [1] [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
>>      Message-ID: <20190620150555.15717-1-patrick.bellasi@arm.com>
>>      https://lore.kernel.org/lkml/20190620150555.15717-1-patrick.bellasi@arm.com/
> 
> 
> I don't really see anything fundamentally weird here. Any actual numbers
> or other means of quantifying the improvement these patches bring?
> 

I posted some numbers based on a similar experiment on the v2 of that series that
are still applicable:

TL;DR the rt-app negative slack is divided by 1.75 by this series, with an
increase of 3% in total energy consumption. There is a burst every 0.6s, and
the average power consumption increase is proportional to the average number
of bursts.


The workload is an rt-app task ramping up from 5% to 75% util in one big step,
pinned on a big core. The whole cycle is 0.6s long (0.3s at 5% followed by 0.3s at 75%).
This cycle is repeated 20 times and the average of boosting is taken.

The test device is a Google Pixel 3 (Qcom Snapdragon 845) phone.
It has a lot more OPPs than a hikey 960, so gradations in boosting
are better reflected on frequency selection.

avg slack (higher=better):
     Average time between task sleep and its next periodic activation.
     See rt-app doc: https://github.com/scheduler-tools/rt-app/blob/9a50d76f726d7c325c82ac8c7ed9ed70e1c97937/doc/tutorial.txt#L631

avg negative slack (lower in absolute value=better):
     Same as avg slack, but only taking into account negative values.
     Negative slack means a task activation did not have enough time to complete before the next
     periodic activation fired, which is what we want to avoid.

boost energy overhead (lower=better):
     Extra power consumption induced by ramp boost, assuming continuous OPP space (infinite number of OPP)
     and single-CPU policies. In practice, fixed number of OPP decrease this value, and more CPU per policy increases it,
     since boost(policy) = max(boost(cpu) foreach cpu of policy)).

Without ramp boost:
+--------------------+--------------------+
|avg slack (us)      |avg negative slack  |
|                    |(us)                |
+--------------------+--------------------+
|6598.72             |-10217.13           |
|6595.49             |-10200.13           |
|6613.72             |-10401.06           |
|6600.29             |-9860.872           |
|6605.53             |-10057.64           |
|6612.05             |-10267.50           |
|6599.01             |-9939.60            |
|6593.79             |-9445.633           |
|6613.56             |-10276.75           |
|6595.44             |-9751.770           |
+--------------------+--------------------+
|average                                  |
+--------------------+--------------------+
|6602.76             |-10041.81           |
+--------------------+--------------------+


With ramp boost enabled:
+--------------------+--------------------+--------------------+
|boost energy        |avg slack (us)      |avg negative slack  |
|overhead (%)        |                    |(us)                |
+--------------------+--------------------+--------------------+
|3.05                |7148.93             |-5664.26            |
|3.04                |7144.69             |-5667.77            |
|3.05                |7149.05             |-5698.31            |
|2.97                |7126.71             |-6040.23            |
|3.02                |7140.28             |-5826.78            |
|3.03                |7135.11             |-5749.62            |
|3.05                |7140.24             |-5750.0             |
|3.05                |7144.84             |-5667.04            |
|3.07                |7157.30             |-5656.65            |
|3.06                |7154.65             |-5653.76            |
+--------------------+--------------------+--------------------+
|average                                                       |
+--------------------+--------------------+--------------------+
|3.039000            |7144.18             |-5737.44            |
+--------------------+--------------------+--------------------+


The negative slack is due to missed activations while the utilization signals
increase during the big utilization step. Ramp boost is designed to boost frequency during
that phase, which materializes in 1.75 less negative slack, for an extra power
consumption under 3%.


Regards,
Douglas
