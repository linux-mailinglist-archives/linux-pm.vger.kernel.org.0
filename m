Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C472C9128
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 23:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgK3Wc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 17:32:58 -0500
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:35683 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730712AbgK3Wc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 17:32:57 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 32BA0FB5D0
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 22:32:04 +0000 (GMT)
Received: (qmail 23074 invoked from network); 30 Nov 2020 22:32:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Nov 2020 22:32:04 -0000
Date:   Mon, 30 Nov 2020 22:32:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Select polling interval based on a c-state with
 a longer target residency
Message-ID: <20201130223202.GT3371@techsingularity.net>
References: <20201130092241.GR3371@techsingularity.net>
 <CAJZ5v0h-ZBUMKqP5om7h67iMTe87GUf2Bw5dJ9tQN6MKwaTWzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h-ZBUMKqP5om7h67iMTe87GUf2Bw5dJ9tQN6MKwaTWzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 08:06:44PM +0100, Rafael J. Wysocki wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 526d65d8573a..5b8545022564 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -719,6 +719,24 @@
> >                         policy to use. This governor must be registered in the
> >                         kernel before the cpufreq driver probes.
> >
> > +       cpuidle.poll=
> > +                       [CPU_IDLE]
> > +                       Format: <int>
> > +                       Set the time in microseconds a CPU should poll in
> > +                       cpuidle for a new task before entering a sleep
> > +                       state. The default is determined by either the
> > +                       tick or the enabled c-state latencies. Tuning is
> > +                       not generally recommended but it may be needed
> > +                       for workloads that are both latency-sensitive
> > +                       and idling rapidly for short durations. Limiting
> > +                       c-states can be insufficient if the polling
> > +                       time is still too short, the application has no
> > +                       knowledge of /dev/cpu_dma_latency, there are
> > +                       multiple applications or the environment does
> > +                       not allow the installation of a userspace tool
> > +                       that controls cpu_dma_latency. This value may
> > +                       be ignored by the idle governor (e.g. haltpoll).
> 
> OK, we can do this, but I'd use a shorter different description here
> and a more detailed one in the admin-guide documentation.
> 
> Also this is about certain drivers only which support the "polling
> idle state" (the ACPI one and intel_idle only AFAICS).  So I'm not
> sure about the framework-level tunable here.
> 
> Moreover, to be precise, that value is the maximum time to do the
> polling (in one go) in the case when requesting any "physical" idle
> states is likely to hurt energy-efficiency or latency.  In particular,
> it doesn't mean that idle CPUs will do the idle polling every time.
> 

At first I was nodding along and thinking "sure". Then I started
thinking about what the configuration space then looks like and how a
user might reasonably interpret it. You were right during the review of
the first version, it's a mess because it's driver specific and difficult
to interpret even on a per-driver basis because there is no control of
when a rescheduling event may occur.

You suggest making poll=0 would be valid but that might be interpreted
as being equivalent to idle=poll on x86 which is not the same thing.
processor_idle and intel_idle would have understandable semantics if the
parameter was maxpoll but it's not as understandable for haltpoll.

Finally, the parameter partially ties us into the current
implementation. For example, the polling loop is based on clock time but
we know looking up the clock is costly in itself so it's very granular
based on the magic "check every 200 loops" logic meaning we can go over
the expected maxiumum polling inverval. If we ever changed that into a
calibration loop to estimate the number of loops then the polling interval
changes slightly even for the same parameter as we no longer depend on the
granularity of calling local_clock. If we ever decided to use adaptive
polling similar to haltpoll then the behaviour changes again resulting
in bugs because the driver.poll parameter means something new.

Using min_cstate was definitely a hazard because it showed up in both
microbenchmarks and real workloads but you were right, lets only
introduce a tunable when and if there is no other choice in the matter.

So, informally the following patch is the next candidate. I'm happy to
resend it as a separate mail if you prefer and think the patch is ok.

--8<--
cpuidle: Select polling interval based on a c-state with a longer target residency

It was noted that a few workloads that idle rapidly regressed when commit
36fcb4292473 ("cpuidle: use first valid target residency as poll time")
was merged. The workloads in question were heavy communicators that idle
rapidly and were impacted by the c-state exit latency as the active CPUs
were not polling at the time of wakeup. As they were not particularly
realistic workloads, it was not considered to be a major problem.

Unfortunately, a bug was reported for a real workload in a production
environment that relied on large numbers of threads operating in a worker
pool pattern. These threads would idle for periods of time longer than the
C1 target residency and so incurred the c-state exit latency penalty. The
application is very sensitive to wakeup latency and indirectly relying
on behaviour prior to commit on a37b969a61c1 ("cpuidle: poll_state: Add
time limit to poll_idle()") to poll for long enough to avoid the exit
latency cost.

The target residency of C1 is typically very short. On some x86 machines,
it can be as low as 2 microseconds. In poll_idle(), the clock is checked
every POLL_IDLE_RELAX_COUNT interations of cpu_relax() and even one
iteration of that loop can be over 1 microsecond so the polling interval is
very close to the granularity of what poll_idle() can detect. Furthermore,
a basic ping pong workload like perf bench pipe has a longer round-trip
time than the 2 microseconds meaning that the CPU will almost certainly
not be polling when the ping-pong completes.

This patch selects a polling interval based on an enabled c-state that
has an target residency longer than 10usec. If there is no enabled-cstate
then polling will be up to a TICK_NSEC/16 similar to what it was up until
kernel 4.20. Polling for a full tick is unlikely (rescheduling event)
and is much longer than the existing target residencies for a deep c-state.

As an example, consider a CPU with the following c-state information from
an Intel CPU;

	residency	exit_latency
C1	2		2
C1E	20		10
C3	100		33
C6	400		133

The polling interval selected is 20usec. If booted with
intel_idle.max_cstate=1 then the polling interval is 250usec as the deeper
c-states were not available.

On an AMD EPYC machine, the c-state information is more limited and
looks like

	residency	exit_latency
C1	2		1
C2	800		400

The polling interval selected is 250usec. While C2 was considered, the
polling interval was clamped by CPUIDLE_POLL_MAX.

Note that it is not expected that polling will be a universal win. As
well as potentially trading power for performance, the performance is not
guaranteed if the extra polling prevented a turbo state being reached.
Making it a tunable was considered but it's driver-specific, may be
overridden by a governor and is not a guaranteed polling interval making
it difficult to describe without knowledge of the implementation.

tbench4
			     vanilla		    polling
Hmean     1        497.89 (   0.00%)      543.15 *   9.09%*
Hmean     2        975.88 (   0.00%)     1059.73 *   8.59%*
Hmean     4       1953.97 (   0.00%)     2081.37 *   6.52%*
Hmean     8       3645.76 (   0.00%)     4052.95 *  11.17%*
Hmean     16      6882.21 (   0.00%)     6995.93 *   1.65%*
Hmean     32     10752.20 (   0.00%)    10731.53 *  -0.19%*
Hmean     64     12875.08 (   0.00%)    12478.13 *  -3.08%*
Hmean     128    21500.54 (   0.00%)    21098.60 *  -1.87%*
Hmean     256    21253.70 (   0.00%)    21027.18 *  -1.07%*
Hmean     320    20813.50 (   0.00%)    20580.64 *  -1.12%*

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/cpuidle/cpuidle.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 83af15f77f66..ef2ea1b12cd8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -368,6 +368,19 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
 		cpuidle_curr_governor->reflect(dev, index);
 }
 
+/*
+ * Min polling interval of 10usec is a guess. It is assuming that
+ * for most users, the time for a single ping-pong workload like
+ * perf bench pipe would generally complete within 10usec but
+ * this is hardware dependant. Actual time can be estimated with
+ *
+ * perf bench sched pipe -l 10000
+ *
+ * Run multiple times to avoid cpufreq effects.
+ */
+#define CPUIDLE_POLL_MIN 10000
+#define CPUIDLE_POLL_MAX (TICK_NSEC / 16)
+
 /**
  * cpuidle_poll_time - return amount of time to poll for,
  * governors can override dev->poll_limit_ns if necessary
@@ -382,15 +395,23 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 	int i;
 	u64 limit_ns;
 
+	BUILD_BUG_ON(CPUIDLE_POLL_MIN > CPUIDLE_POLL_MAX);
+
 	if (dev->poll_limit_ns)
 		return dev->poll_limit_ns;
 
-	limit_ns = TICK_NSEC;
+	limit_ns = CPUIDLE_POLL_MAX;
 	for (i = 1; i < drv->state_count; i++) {
+		u64 state_limit;
+
 		if (dev->states_usage[i].disable)
 			continue;
 
-		limit_ns = drv->states[i].target_residency_ns;
+		state_limit = drv->states[i].target_residency_ns;
+		if (state_limit < CPUIDLE_POLL_MIN)
+			continue;
+
+		limit_ns = min_t(u64, state_limit, CPUIDLE_POLL_MAX);
 		break;
 	}
 
