Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2677CB0000
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfIKP2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 11:28:18 -0400
Received: from cmta20.telus.net ([209.171.16.93]:56058 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbfIKP2S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Sep 2019 11:28:18 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 84XQitur0N5I984XRiixps; Wed, 11 Sep 2019 09:28:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1568215696; bh=v8D2rPDU6PdahQ7RbfiTlvx14rI/YQMUQ6aVGSWEsds=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Z5rICbGyxouZCk7pl+VXHF5V2VQFRPnYCy/8JLdjTCsr5zUexssJFGGINN5MgENtz
         SINtOytS9ZMXenDgTSDq/tdN+lTy4bww65CgAdwTVJ2rn07uGvsXMLywtRmR5JjFMY
         UGBKc+xgA8NwfJ9zxKuQyOVCSSahBEUCqYfMwcPoSnxUmh7NE5vYh9pC6GKOLVUwBo
         IhOl/Qrf7edmQXxejEtdsVweW+uX6EAaiTTkiRDmXBMIZABaNncaI1QTZCo//8PM3i
         2BlPNdhizuQMdxQt5APX+TykLC134Pg4onOrlHjG6Da0qj1uUFfTttJSnUFyhS2X62
         eQ38mol6XwkbQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=gu6fZOg2AAAA:8 a=FGbulvE0AAAA:8 a=lz9DfVNvIZjJZHtdJwsA:9
 a=4aULQiveDT1Hf3i8:21 a=N-1LwnyJXRtWHCc1:21 a=CjuIK1q_8ugA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=svzTaB3SJmTkU8mK-ULk:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mgorman@techsingularity.net>,
        <matt@codeblueprint.co.uk>, <viresh.kumar@linaro.org>,
        <juri.lelli@redhat.com>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <qperret@qperret.net>,
        <dietmar.eggemann@arm.com>, <srinivas.pandruvada@linux.intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <bp@suse.de>, <lenb@kernel.org>, <rjw@rjwysocki.net>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz> <20190909024216.5942-2-ggherdovich@suse.cz>
In-Reply-To: <20190909024216.5942-2-ggherdovich@suse.cz>
Subject: RE: [PATCH 1/2] x86,sched: Add support for frequency invariance
Date:   Wed, 11 Sep 2019 08:28:07 -0700
Message-ID: <000e01d568b5$87de9be0$979bd3a0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVmt5+Zhvy5aOFESi2j+LaB1JUY0wArmRMw
X-CMAE-Envelope: MS4wfLn9q8fvJWxdYWagctKLazWVoq84PNjCJrHkNLQQCrAL1YSaFoTAeWY5+AaNzvJ3QaIO24ToTvPLH8F2RnuoI2HH+v1YC3cIlduhfXyH1iZu7Lt/YC06
 VvJJbszIsoV9VihEQiinA/Sk1UX5nIoz9zGSjIfwDMYkCd6vuH/4fIkdoEhJJ+mwQQ/NhTVO9Riuu0VqWjUnkfn4XqB5vG35ZSDQK7D7bR3vh/M75IQYpa1h
 i8Fsk3kovxWCz+oYQ5KW5bGnm6Id4Iqm4TWL9ObNC898DO9tkxvqd9j5nbVmKIYdIyATLTBndJoAL0a2XW4oHTZZ/IhyJWgnjgmlaDvHbC7pO0ZWhKY6K86D
 3PrG+DTgvQ0KnoifbndshZJW9EOEghx0hLTfoOHmralUip3uFVXxzyO9mT2zOyFxCh7z0UUCHYwCSpcxypwX9z+N/ylWRIVVIW0YahKfSlr/Fq9NsJfO43u8
 9qSU7WI7+zi0K53VkEcQnKE/ibjdOz7M0ccv43g6fWxY26/C0ws21S5mlm6Dus0+9Oqma98w+2MBJMHWLf++3ccNnvNP0x039xEu6irESYWwVwbP86uf3QOf
 rHPEgGsH4L/EnZzV+h1f9GD7kZU8uWVATgB29qMrCYPybboSoRUVlYngwE4rLKaQhMBJ2VJHo+e1SVHCI8O/z18FxxtsBT5g1LJVtGjkca6iwcQ9mK5f1uSl
 K+8GdNxQU/EJ98qEIuaXgvFf5FFjwtJZrk/x6GiiMv0IrdEpeGsPO40sEqjaQhzSNxrv7LHFGks=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Giovanni,

Thank you for the great detail and test results you provided.

On 2019.09.08.07:42 Giovanni Gherdovich wrote:

... [snip]...

> The test we call "gitsource" (running the git unit test suite, a long-running
> single-threaded shell script) appears rather spectacular in this table (gains
> of 30-50% depending on the machine). It is to be noted, however, that
> gitsource has no adjustable parameters (such as the number of jobs in
> kernbench, which we average over in order to get a single-number summary
> score) and is exactly the kind of low-parallelism workload that benefits the
> most from this patch. When looking at the detailed tables of kernbench or
> tbench4, at low process or client counts one can see similar numbers.

I think the "gitsource" test, is the one I learned about here two years
ago, [1]. It is an extremely good (best I know of) example of single
threaded, high PID consumption (about 400 / second average, my computer
[3]), performance issues on a multi CPU computer. I.E., this:

Dountil the list of tasks is finished:
   Start the next task in the list of stuff to do.
   Wait for it to finish
Enduntil

The problem with the test is its run to run variability, which was from
all the disk I/O, as far as I could determine. At the time,
I studied this to death [2], and made a more repeatable test, without
any disk I/O.

While the challenges with this work flow have tended to be focused
on the CPU frequency scaling driver, I have always considered
the root issue here to be a scheduling issue. Excerpt from my notes
[2]:

> The issue is that performance is much much better if the system is
> forced to use only 1 CPU rather than relying on the defaults where
> the CPU scheduler decides what to do.
> The scheduler seems to not realize that the current CPU has just
> become free, and assigns the new task to a new CPU. Thus the load
> on any one CPU is so low that it doesn't ramp up the CPU frequency.
> It would be better if somehow the scheduler knew that the current
> active CPU was now able to take on the new task, overall resulting
> on one fully loaded CPU at the highest CPU frequency.

I do not know if such is practical, and I didn't re-visit the issue.

Anyway these are my results:

Kernel: 5.3-rc8 and + these patches
Processor: i7-2600K

This is important, at least for the performance governor numbers:

cpu6: MSR_TURBO_RATIO_LIMIT: 0x23242526
35 * 100.0 = 3500.0 MHz max turbo 4 active cores
36 * 100.0 = 3600.0 MHz max turbo 3 active cores
37 * 100.0 = 3700.0 MHz max turbo 2 active cores
38 * 100.0 = 3800.0 MHz max turbo 1 active cores

For reference against which all other results are compared
is the forced CPU affinity test run. i.e.:

taskset -c 3 test_script.

Mode		Governor		degradation	Power		Bzy_MHz
Reference	perf 1 CPU		1.00		reference	3798
-		performance 	1.2		6% worse	3618
passive	ondemand		2.3
active	powersave		2.6
passive	schedutil		2.7				1600
passive	schedutil-4C	1.68				2515

Where degradation ratio is the time to execute / the reference time for
the same conditions. The test runs over a wide range of processes per
second, and the worst ratio has been selected for the above table.
I have yet to write up this experiment, but the graphs that will
eventually be used are at [4] and [5] (same data presented two
different ways).

The energy for the performance cases is worth more detail, as it
is being wasted with CPUs waking up and going to sleep, and can be
observed in the IRQ column of turbostat output:

$ sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 60
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
12.52   3798    81407   49      22.17   0.12 <<< Forced to CPU 3 only
12.52   3798    81139   51      22.18   0.12
12.52   3798    81036   51      22.20   0.12
11.43   3704    267644  48      21.16   0.12 <<< Change over
12.56   3618    490994  48      23.43   0.12 <<< Let the scheduler decide
12.56   3620    491336  47      23.50   0.12
12.56   3619    491607  47      23.50   0.12
12.56   3619    491512  48      23.52   0.12
12.56   3619    490806  47      23.51   0.12
12.56   3618    491356  49      23.48   0.12
12.56   3618    491035  48      23.51   0.12
12.56   3618    491121  48      23.46   0.12

Note also the busy megahertz column, where other active cores
(constantly waking and sleeping as we rotate through which
CPUs are used) are limiting the highest frequency.

... Doug

[1] https://marc.info/?l=linux-kernel&m=149181369622980&w=2
[2] http://www.smythies.com/~doug/linux/single-threaded/index.html
[3] http://www.smythies.com/~doug/linux/single-threaded/pids_per_second2.png
[4] http://www.smythies.com/~doug/linux/single-threaded/gg-pidps.png
[5] http://www.smythies.com/~doug/linux/single-threaded/gg-loops.png


