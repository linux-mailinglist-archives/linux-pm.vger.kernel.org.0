Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3C2C5A79
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbgKZRZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:25:02 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:58093 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404312AbgKZRZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:25:02 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2020 12:25:00 EST
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 919C81C4444
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 17:18:26 +0000 (GMT)
Received: (qmail 18254 invoked from network); 26 Nov 2020 17:18:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2020 17:18:26 -0000
Date:   Thu, 26 Nov 2020 17:18:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] cpuidle: Allow configuration of the polling interval before
 cpuidle enters a c-state
Message-ID: <20201126171824.GK3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It was noted that a few workloads that idle rapidly regressed when commit
36fcb4292473 ("cpuidle: use first valid target residency as poll time")
was merged. The workloads in question were heavy communicators that idle
rapidly and were impacted by the c-state exit latency as the active CPUs
were not polling at the time of wakeup. As they were not particularly
realistic workloads, it was not considered to be a major problem.

Unfortunately, a bug was then reported for a real workload in a production
environment that relied on large numbers of threads operating in a worker
pool pattern. These threads would idle for periods of time slightly
longer than the C1 exit latency and so incurred the c-state exit latency.
The application is sensitive to wakeup latency and appears to indirectly
rely on behaviour prior to commit on a37b969a61c1 ("cpuidle: poll_state:
Add time limit to poll_idle()") to poll for long enough to avoid the exit
latency cost.

The current behaviour favours power consumption over wakeup latency
and it is reasonable behaviour but it should be tunable. In theory
applications could use /dev/cpu_dma_latency but not all applications
are aware of cpu_dma_latency. Similarly, a tool could be installed
that opens cpu_dma_latency for the whole system but such a tool is not
always available, is not always known to the sysadmin or the tool can have
unexpected side-effects if it tunes more than cpu_dma_latency. In practice,
it is more common for sysadmins to try idle=poll (which is x86 specific)
or try disabling c-states and hope for the best.

This patch makes it straight-forward to configure how long a CPU should
poll before entering a c-state. By default, there is no behaviour change.
At build time a decision can be made to favour performance over power
by default even if that potentially impacts turbo boosting for workloads
that are sensitive to wakeup latency. In the event the kernel default is
not suitable, the kernel command line can be used as a substitute for
implementing cpu_dma_latency support in an application or requiring an
additional tool to be installed.

Note that it is not expected that tuning for longer polling times will be a
universal win. For example, extra polling might prevent a turbo state being
used or prevent hyperthread resources being released to an SMT sibling.

By default, nothing has changed but here is an example of tbench4
comparing the default "poll based on the min cstate" vs "poll based on
the max cstate"

tbench4
			  min-cstate		 max-cstate
Hmean     1        512.88 (   0.00%)      566.74 *  10.50%*
Hmean     2        999.47 (   0.00%)     1090.01 *   9.06%*
Hmean     4       1960.83 (   0.00%)     2106.62 *   7.44%*
Hmean     8       3828.61 (   0.00%)     4097.93 *   7.03%*
Hmean     16      6899.44 (   0.00%)     7120.38 *   3.20%*
Hmean     32     10718.38 (   0.00%)    10672.44 *  -0.43%*
Hmean     64     12672.21 (   0.00%)    12608.15 *  -0.51%*
Hmean     128    20744.83 (   0.00%)    21147.02 *   1.94%*
Hmean     256    20646.60 (   0.00%)    20608.48 *  -0.18%*
Hmean     320    20892.89 (   0.00%)    20831.99 *  -0.29%*

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 Documentation/admin-guide/kernel-parameters.txt | 25 +++++++++
 drivers/cpuidle/Kconfig                         | 57 +++++++++++++++++++++
 drivers/cpuidle/cpuidle.c                       | 67 +++++++++++++++++++++++--
 include/linux/moduleparam.h                     |  5 ++
 kernel/params.c                                 |  1 +
 5 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..382126781b0e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -719,6 +719,31 @@
 			policy to use. This governor must be registered in the
 			kernel before the cpufreq driver probes.
 
+	cpuidle.poll=
+			[CPU_IDLE]
+			Format: <int>
+			Set the time in microseconds a CPU should poll
+			in cpuidle for a new task before entering
+			a sleep state. The default is usually fine
+			but may need to be tuned for workloads that
+			are both latency-sensitive and idles rapidly
+			for short durations. Limiting c-states can
+			be insufficient if the polling time is still
+			too short, the application has no knowledge
+			of /dev/cpu_dma_latency, there are multiple
+			applications or the environment does not allow
+			the installation of a userspace tool that controls
+			cpu_dma_latency.
+
+			-1: default, poll based on the shallowest enabled c-state
+			-2: poll based on the deepest enabled c-state. If no
+			    c-states are enabled then poll based on the tick
+			-3: poll up until a tick would force a resched event
+			>0: poll for a fixed duration in nanoseconds. Poll
+			    range is limited. The lowest bound is the
+			    shallowest enabled c-state.  The maximum
+			    bound is based on the tick
+
 	cpu_init_udelay=N
 			[X86] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd66f02..7c9d2073db85 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -47,6 +47,63 @@ config CPU_IDLE_GOV_HALTPOLL
 config DT_IDLE_STATES
 	bool
 
+choice
+	prompt "CPU Idle default polling interval before entering an idle state"
+	default CPUIDLE_DEFAULT_POLL_MINCSTATE
+	help
+	  CPU Idle polls briefly waiting for a new task to be runnable. This
+	  setting determines what the default polling interval is. Lower
+	  polling intervals will optimise for power consumption while higher
+	  intervals will favour wakeup latency in cases where a task is
+	  queued before the CPU enters a c-state. If c-states are unavailable
+	  at runtime, polling will poll for up to a tick.
+
+	config CPUIDLE_DEFAULT_POLL_MINCSTATE
+		bool "interval mincstate"
+	help
+	  Polling interval will be the same as the shallowest enabled c-state
+	  e.g. C1 exit latency
+
+	config CPUIDLE_DEFAULT_POLL_MAXCSTATE
+		bool "interval maxcstate"
+	help
+	  Polling interval will be the same as the deepest enabled c-state
+	  e.g. C3 exit latency
+
+	config CPUIDLE_DEFAULT_POLL_TICK
+		bool "interval tick"
+	help
+	  Polling interval will be up to a tick interval or until the idle
+	  task needs to reschedule. e.g. a kernel with HZ of 250 could
+	  potentially poll up to 4ms.
+
+	config CPUIDLE_DEFAULT_POLL_FIXED
+		bool "interval fixed"
+	help
+	  Polling can be specified as a fixed interval regardless of
+	  c-states. This option is only useful in the case where there
+	  is a known class of applications that have a fixed latency
+	  that is not necessarily related to the underlying c-state
+	  capabilities and there is a need for the polling interval
+	  to be be hardware invariant.
+endchoice
+
+config CPUIDLE_DEFAULT_POOL_FIXED_INTERVAL
+	depends on CPUIDLE_DEFAULT_POLL_FIXED
+	int "Default polling inverval for CPU Idle"
+	default 2
+	help
+	  This is the fixed interval used for cpuidle polling if
+	  CPUIDLE_DEFAULT_POLL_FIXED is selected.
+
+config CPUIDLE_DEFAULT_POLL
+	int
+	default -1 if CPUIDLE_DEFAULT_POLL_MINCSTATE
+	default -2 if CPUIDLE_DEFAULT_POLL_MAXCSTATE
+	default -3 if CPUIDLE_DEFAULT_POLL_TICK
+	default CPUIDLE_DEFAULT_POOL_FIXED_INTERVAL if CPUIDLE_DEFAULT_POLL_FIXED
+
+
 menu "ARM CPU Idle Drivers"
 depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 83af15f77f66..32a745bb7eb8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -368,6 +368,25 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
 		cpuidle_curr_governor->reflect(dev, index);
 }
 
+static struct kernel_param_ops poll_param_ops = {
+	.set =          param_set_llong,
+	.get =          param_get_llong,
+};
+
+/* Poll based on the shallowest enabled cstate */
+#define CPUIDLE_POLL_MINCSTATE	-1
+
+/* Poll based on the deepest enabled cstate */
+#define CPUIDLE_POLL_MAXCSTATE	-2
+
+/* Poll up to when a tick forces a resched event */
+#define CPUIDLE_POLL_TICK	-3
+
+/* Sanity check to guard against future options */
+#define CPUIDLE_POLL_BOUND	CPUIDLE_POLL_TICK
+
+static long long param_poll = CONFIG_CPUIDLE_DEFAULT_POLL;
+
 /**
  * cpuidle_poll_time - return amount of time to poll for,
  * governors can override dev->poll_limit_ns if necessary
@@ -380,21 +399,60 @@ u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 		      struct cpuidle_device *dev)
 {
 	int i;
-	u64 limit_ns;
+	u64 min_limit_ns, max_limit_ns;
 
 	if (dev->poll_limit_ns)
 		return dev->poll_limit_ns;
 
-	limit_ns = TICK_NSEC;
+	/* Sanitise param_poll. */
+	param_poll = clamp_t(int, param_poll, CPUIDLE_POLL_BOUND, TICK_NSEC);
+	if (param_poll > 0)
+		param_poll *= NSEC_PER_USEC;
+
+	/* Find the min and max exit latencies for c-states */
+	max_limit_ns = 0;
+	min_limit_ns = TICK_NSEC;
 	for (i = 1; i < drv->state_count; i++) {
+		u64 state_limit;
+
 		if (dev->states_usage[i].disable)
 			continue;
 
-		limit_ns = drv->states[i].target_residency_ns;
+		state_limit = drv->states[i].target_residency_ns;
+		min_limit_ns = min_t(u64, min_limit_ns, state_limit);
+		max_limit_ns = max_t(u64, max_limit_ns, state_limit);
+	}
+
+	/* Select a polling interval */
+	switch (param_poll) {
+	case CPUIDLE_POLL_MINCSTATE:
+		dev->poll_limit_ns = min_limit_ns;
+		break;
+	case CPUIDLE_POLL_MAXCSTATE:
+		/* If there are no enabled c-states, use the tick interval */
+		if (!max_limit_ns)
+			max_limit_ns = TICK_NSEC;
+
+		dev->poll_limit_ns = max_limit_ns;
+		break;
+	case CPUIDLE_POLL_TICK:
+		dev->poll_limit_ns = TICK_NSEC;
+		break;
+	default:
+		/* If there are no enabled c-states, make sure param_poll is used */
+		if (!max_limit_ns)
+			min_limit_ns = 1;
+
+		dev->poll_limit_ns = clamp_t(u64, param_poll, min_limit_ns, TICK_NSEC);
 		break;
 	}
 
-	dev->poll_limit_ns = limit_ns;
+
+	/*
+	 * Polling parameter reported as usec to match the values reported
+	 * for c-cstate exit latencies in sysfs.
+	 */
+	param_poll = dev->poll_limit_ns / NSEC_PER_USEC;;
 
 	return dev->poll_limit_ns;
 }
@@ -755,4 +813,5 @@ static int __init cpuidle_init(void)
 
 module_param(off, int, 0444);
 module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
+module_param_cb(poll, &poll_param_ops, &param_poll, 0444);
 core_initcall(cpuidle_init);
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 6388eb9734a5..418cf714580d 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -438,6 +438,11 @@ extern int param_set_long(const char *val, const struct kernel_param *kp);
 extern int param_get_long(char *buffer, const struct kernel_param *kp);
 #define param_check_long(name, p) __param_check(name, p, long)
 
+extern const struct kernel_param_ops param_ops_llong;
+extern int param_set_llong(const char *val, const struct kernel_param *kp);
+extern int param_get_llong(char *buffer, const struct kernel_param *kp);
+#define param_check_llong(name, p) __param_check(name, p, long long)
+
 extern const struct kernel_param_ops param_ops_ulong;
 extern int param_set_ulong(const char *val, const struct kernel_param *kp);
 extern int param_get_ulong(char *buffer, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 164d79330849..a2b0e5b1b26b 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -239,6 +239,7 @@ STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",		kstrtou16);
 STANDARD_PARAM_DEF(int,		int,			"%i",		kstrtoint);
 STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",		kstrtouint);
 STANDARD_PARAM_DEF(long,	long,			"%li",		kstrtol);
+STANDARD_PARAM_DEF(llong,	long long,		"%lli",		kstrtoll);
 STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",		kstrtoul);
 STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",		kstrtoull);
 STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", 	kstrtouint);
