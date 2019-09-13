Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0ACB26EF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfIMU6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 16:58:36 -0400
Received: from cmta16.telus.net ([209.171.16.89]:37888 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfIMU6f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Sep 2019 16:58:35 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 8seAiDyQhFXoi8seBiUxnH; Fri, 13 Sep 2019 14:58:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1568408312; bh=JFZiZ8GywZn4EntghOB1nQTSaxuHLighS4niCi6IdzU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=ZQ0oQi7O9SVl3Y0pXISANC3alP2PMgqdD2BxYaWcBNnGppUQ5boXbhQ3D9elT+VZT
         C/+LGFJW9znC/uhcRM4bBK//pI6mFEBL6UrkOGFEKRt8o1ZybKk5JmEUd1rID/m2ND
         NZkVZ2oYT1w4GJ/krpOkRJooh/ANJDDI8eMrY4QgX2o6MvLCHme8Th5EIU/WMd8LDI
         gnc7skW8Fw3KcEgWxQfmz4M2zLr1t/w4JcZPlbASn/nJD4OnP1QUqo+OlCuWGMqBZm
         aNcwT07Bdp5oOQ4UFmvKfI/q0uI+R6UlWrpbpACV+FT1n1iKOVCbs6DU7bhn/T9okZ
         Y7zbe41LIAzbw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=HoEI5HbS c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=gu6fZOg2AAAA:8 a=FGbulvE0AAAA:8 a=kMzJ0VUsHSJ4pOcj8RsA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=tA1zSrZllMrc5sIv:21 a=4Q3CTht2G7KouQuB:21
 a=CjuIK1q_8ugA:10 a=wC6wFTFn8J8A:10 a=-MXCNWVgZdEA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=svzTaB3SJmTkU8mK-ULk:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mgorman@techsingularity.net>,
        <matt@codeblueprint.co.uk>, <viresh.kumar@linaro.org>,
        <juri.lelli@redhat.com>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <qperret@qperret.net>,
        <dietmar.eggemann@arm.com>, <srinivas.pandruvada@linux.intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <bp@suse.de>, <lenb@kernel.org>, <rjw@rjwysocki.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz> <20190909024216.5942-2-ggherdovich@suse.cz> <000e01d568b5$87de9be0$979bd3a0$@net>
In-Reply-To: <000e01d568b5$87de9be0$979bd3a0$@net>
Subject: RE: [PATCH 1/2] x86,sched: Add support for frequency invariance
Date:   Fri, 13 Sep 2019 13:58:25 -0700
Message-ID: <000301d56a76$0022e630$0068b290$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVmt5+Zhvy5aOFESi2j+LaB1JUY0wArmRMwAMJIfyA=
X-CMAE-Envelope: MS4wfFcQ3m5YsQFKxTfs2VdGW7p5LBTbIe3iaIda3JlqseEHsaiZ98yR4mo9wbhnq1CTtjVlxfWV/R/r32mmZUHMv4OpfBSvfmdKEybZtZKUDSItmN7ruMiH
 /hen019PMxi51aI4CnrUKCW0catcWUlW7QRatWhmYXbrRiV+qCt7suM1ZAERDm28Ch+iC05RMHaywhjMFYvrhtXRa/3qe6ZvYsCdFG8zZtVi1EKpXhjRwofp
 4U6Sll/hytA1+WHahT3eqPN7b5Zau5029eiWih59ZqQNEf8JZCTkIr26KsBx/kvuYtU66hY7+yLZKEVA7nsgNGpLBRnhXkHWfdi6MAjW+6pMmpFHzlGCwxUB
 U9LRTYab+xSF8i3G0R6B14tfiEiaqtKCFOEudNiXGUtjV610GUgjEvoNJlH7ZTtfNpZtAZpfI12KMe0C+gRc9YilT10e69E2oUwEF1h4N8du3HP6hcwBTsGf
 pIGWBxLgre8x3TwWgdYrea3OCAC604n1Ohahk7tatpkyeGWH5pj3XcBVK6aMHwXJKgsVlm3oD8HTVyFnGdWzz5ZaresPkYsH45jzqQSPWM2RxymlElU8+neX
 Xxn+1hLVJMi7LSiLueA9g5xgk6SCAtYMUxMmhQxt62dXlLLrhS/G16VynfNYSci7zZy23BWNA7aHYLAjSsz0UV/SiqyVV1rVZo+cUCZGfsVszOdJ2oT4AXIC
 r1VIVJVLQI7A5iD8tUiNgTQCun/3djIS/ocAaAQjkaZV5sk2kCfFTA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.09.11 08:28 Doug Smythies wrote:

> Hi Giovanni,
>
> Thank you for the great detail and test results you provided.
>
> On 2019.09.08.07:42 Giovanni Gherdovich wrote:
>
> ... [snip]...
>
>> The test we call "gitsource" (running the git unit test suite, a long-running
>> single-threaded shell script) appears rather spectacular in this table (gains
>> of 30-50% depending on the machine). It is to be noted, however, that
>> gitsource has no adjustable parameters (such as the number of jobs in
>> kernbench, which we average over in order to get a single-number summary
>> score) and is exactly the kind of low-parallelism workload that benefits the
>> most from this patch. When looking at the detailed tables of kernbench or
>> tbench4, at low process or client counts one can see similar numbers.
>
> I think the "gitsource" test, is the one I learned about here two years
> ago, [1]. It is an extremely good (best I know of) example of single
> threaded, high PID consumption (about 400 / second average, my computer
> [3]), performance issues on a multi CPU computer. I.E., this:
>
> Dountil the list of tasks is finished:
>    Start the next task in the list of stuff to do.
> Enduntil
>
> The problem with the test is its run to run variability, which was from
> all the disk I/O, as far as I could determine.

I forgot, also some memory caching. I always toss out the first test,
then do it 5 more times. If I do not do much stuff with my hard disk
in between tests, it is repeatable enough.

I did the "make test" method and, presenting the numbers your way,
got that 4C took 0.69 times as long as the unpatched schedutil.
Your numbers were same or better (copied below, lower is better):
80x-BROADWELL-NUMA:	0.49
8x-SKYLAKE-UMA:		0.55
48x-HASWELL-NUMA:		0.69

> At the time,
> I studied this to death [2], and made a more repeatable test, without
> any disk I/O.
>
> While the challenges with this work flow have tended to be focused
> on the CPU frequency scaling driver, I have always considered
> the root issue here to be a scheduling issue. Excerpt from my notes
> [2]:
>
>> The issue is that performance is much much better if the system is
>> forced to use only 1 CPU rather than relying on the defaults where
>> the CPU scheduler decides what to do.
>> The scheduler seems to not realize that the current CPU has just
>> become free, and assigns the new task to a new CPU. Thus the load
>> on any one CPU is so low that it doesn't ramp up the CPU frequency.
>> It would be better if somehow the scheduler knew that the current
>> active CPU was now able to take on the new task, overall resulting
>> on one fully loaded CPU at the highest CPU frequency.
>
> I do not know if such is practical, and I didn't re-visit the issue.
>
> Anyway these are my results:
>
> Kernel: 5.3-rc8 and + these patches
> Processor: i7-2600K
>
> This is important, at least for the performance governor numbers:
>
> cpu6: MSR_TURBO_RATIO_LIMIT: 0x23242526
> 35 * 100.0 = 3500.0 MHz max turbo 4 active cores
> 36 * 100.0 = 3600.0 MHz max turbo 3 active cores
> 37 * 100.0 = 3700.0 MHz max turbo 2 active cores
> 38 * 100.0 = 3800.0 MHz max turbo 1 active cores
>
> For reference against which all other results are compared
> is the forced CPU affinity test run. i.e.:
>
> taskset -c 3 test_script.
>
> Mode		Governor		degradation	Power		Bzy_MHz
> Reference	perf 1 CPU		1.00		reference	3798
> -		performance 	1.2		6% worse	3618
> passive	ondemand		2.3
> active	powersave		2.6
> passive	schedutil		2.7				1600
> passive	schedutil-4C	1.68				2515
>
> Where degradation ratio is the time to execute / the reference time for
> the same conditions. The test runs over a wide range of processes per
> second, and the worst ratio has been selected for the above table.
> I have yet to write up this experiment, but the graphs that will
> eventually be used are at [4] and [5] (same data presented two
> different ways).

The experiment write up is at [6], however I wanted more data
from the lower tasks per second region, and so I re-did it, [7].
In the limit as sequential tasks per second goes to 0, the
differences should diminish and I wanted to clearly observe this.

Excerpt:
> Conclusion: the schedutil governor improves from the worst 
> governor to (mostly) second only to the performance governor
> for unforced CPU affinity execution.

> The energy for the performance cases is worth more detail, as it
> is being wasted with CPUs waking up and going to sleep, and can be
> observed in the IRQ column of turbostat output:
>
> $ sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 60
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 12.52   3798    81407   49      22.17   0.12 <<< Forced to CPU 3 only
> 12.52   3798    81139   51      22.18   0.12
> 12.52   3798    81036   51      22.20   0.12
> 11.43   3704    267644  48      21.16   0.12 <<< Change over
> 12.56   3618    490994  48      23.43   0.12 <<< Let the scheduler decide
> 12.56   3620    491336  47      23.50   0.12
> 12.56   3619    491607  47      23.50   0.12
> 12.56   3619    491512  48      23.52   0.12
> 12.56   3619    490806  47      23.51   0.12
> 12.56   3618    491356  49      23.48   0.12
> 12.56   3618    491035  48      23.51   0.12
> 12.56   3618    491121  48      23.46   0.12
> 
> Note also the busy megahertz column, where other active cores
> (constantly waking and sleeping as we rotate through which
> CPUs are used) are limiting the highest frequency.

I looked at the power and idle statistics for this forced verses
unforced CPU affinity scenario in more detail, [8].
(which isn't really part of this patch sets concern.)

Just an additional note:

>> +-------------------------------------------------------------------------+
>> | 3. EFFECTS ON THE SCHEDUTIL FREQUENCY GOVERNOR
>> +-------------------------------------------------------------------------+
>> 
>> Once an architecture implements a frequency scale-invariant utilization (the
>> PELT signal util_avg), schedutil switches its frequency selection formula from
>>
>>    freq_next = 1.25 * freq_curr * util            [non-invariant util signal]
>>
>> to
>>
>>    freq_next = 1.25 * freq_max * util             [invariant util signal]
>>
>> where, in the second formula, freq_max is set to the 1C turbo frequency (max
>> turbo). The advantage of the second formula, whose usage we unlock with this
>> patch, is that freq_next doesn't depend on the current frequency in an
>> iterative fashion, but can jump to any frequency in a single update. This
>> absence of feedback in the formula makes it quicker to react to utilization
>> changes and more robust against pathological instabilities.
>>
>> Compare it to the update formula of intel_pstate/powersave:
>>
>>    freq_next = 1.25 * freq_max * Busy%
>>
>> where again freq_max is 1C turbo and Busy% is the percentage of time not spent
>> idling (calculated with delta_MPERF / delta_TSC);

Note that the delta_MPERF / delta_TSC method includes idle state 0 and the old
method of utilization does not (at least not last time I investigated, which was
awhile ago (and I can not find my notes)).

... Doug

> [1] https://marc.info/?l=linux-kernel&m=149181369622980&w=2
> [2] http://www.smythies.com/~doug/linux/single-threaded/index.html
> [3] http://www.smythies.com/~doug/linux/single-threaded/pids_per_second2.png
> [4] http://www.smythies.com/~doug/linux/single-threaded/gg-pidps.png
> [5] http://www.smythies.com/~doug/linux/single-threaded/gg-loops.png

[6] http://www.smythies.com/~doug/linux/single-threaded/k53rc8gg.html
[7] http://www.smythies.com/~doug/linux/single-threaded/k53rc8gg2.html
[8] http://www.smythies.com/~doug/linux/single-threaded/idle01/index.html


