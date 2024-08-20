Return-Path: <linux-pm+bounces-12570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11865958C4F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90E0285407
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69E1C463A;
	Tue, 20 Aug 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1LzhH+1Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5191C378A
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171728; cv=none; b=P1LZ+51xxa3DgoPjkl6ctX4m0Sn+R9mNk1DUjxih/R/FFzW/7XFnOxv2FHutJ7zH8LoO9ioadXX98LQ7eZesiWm0d+bIpxq72T6eYL9cFHID0lSgkf9iKLd5CPLDe4bngdB/G6RaYcWXJK5zsHgZvBKDia4+5DaCydPHMZv9CP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171728; c=relaxed/simple;
	bh=tgYyWJNFjQme0TMeNdmbWnROtVj9eTJRm8pByyeiq9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGoJyq91PSMgL5vLO2IjxPZz2iqaigiiSYxVyPakGO5oTQ3/accJJfWLb6Yy8qxdwpmKY5EEJ/hvHHfmgdssX9GaI9qqmDXdF2aAMrkjiAW7mKqOgbZW5tqr7DvMPP0Q4cElpuj/Px0GYC5OZre+AuKUUtnMbbJIU7q2KFRdCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=1LzhH+1Z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3f163e379so10992911fa.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171722; x=1724776522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnyuo1aGTE5JLvwJSoqPF/e83EBO8SWfb0UwiymD/r8=;
        b=1LzhH+1ZQWYEG0T9WKKxRjlxjwI1DixubVZuDM68kOGY9SbrW/L+0Qt0YOagX+VT02
         8FTzWCt3EiLhQh3gvezxNoHAptgaBXX5K6aMec5FiJqS+CLLGmMgq92IbG51tzXgVKXm
         9AmmI9R69cQYu+cFGEpUcpcb7DsgDEqZsxFRvD7FkZGNf/VuOUR9n6Z5xVIqShTFQpQs
         l4OrL2047I9YKhOWczNebbIbzlHMpVVU8MVyV0I62MtCYBS1maOkC5Jzq5mmyB2WC2zG
         +NRHBx2lQBChqmgqswTGyPkzbCYCtFAGoPRf0hxgfqNdCuZGxIsdjG8K4s79htcjv3Bn
         bFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171722; x=1724776522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnyuo1aGTE5JLvwJSoqPF/e83EBO8SWfb0UwiymD/r8=;
        b=l+hQ0JBcov3aFrl/YYLp7A97uEZFATX20yjefVsxeKkYFyo4Qws6E8w5q175twTOhZ
         ejFNHNUwog2c2D3ESN4wwg1uwwuw/pcDn89tixfI99iI0ZwSdfCgb28HQ6lKdbQ0+xSQ
         i3/RyBWezcQBDXx78ASdomzwO0N7GGdbUKxDN5iYIdtCbRBnMpoMwbfuMRQf3pHwx/K0
         yKiYurx6BtYdN5P69GhdQT72MYGx0mA52iqjmTWz74lnyLc0S5FciPQg8LTKGKaMnTRw
         3UpdJnWTChkubxIc5vyq9ZAq3CyQ100Y26NYMVYwWjoCQjtzl5ip9lbINEn0rHLDybsC
         ie/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNAOzDQNGLb7eIlijma1z30XlZwRZhMiZcGKRAl+MdFrXvw690B2AHHmxhubqhvUNkzmxf7go6fQaYgxYmdW46GzbXcXULmDg=
X-Gm-Message-State: AOJu0Ywm5hcMpzMmIa0bSn6lNgaGHRXPd4yVRsE+DeQpdq3Ce2xhtMUs
	uZKyrmIWvRQ+CZxf0WAKv9UAXL11ofUK1HwPXc2T1aS3EucBLS7zviLIF4o5Irg=
X-Google-Smtp-Source: AGHT+IFyy57O8ICffhFQegIIFct0J1HR2fD4S7+D4GtgQH4PdLNsbpsWoXm759jhmaZ/Fqu9rrA55w==
X-Received: by 2002:a2e:84a:0:b0:2f3:ee58:eaf with SMTP id 38308e7fff4ca-2f3ee580f92mr20700721fa.23.1724171721872;
        Tue, 20 Aug 2024 09:35:21 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:21 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 06/16] sched/schedutil: Add a new tunable to dictate response time
Date: Tue, 20 Aug 2024 17:35:02 +0100
Message-Id: <20240820163512.1096301-7-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new tunable, response_time_ms,  allow us to speed up or slow down
the response time of the policy to meet the perf, power and thermal
characteristic desired by the user/sysadmin. There's no single universal
trade-off that we can apply for all systems even if they use the same
SoC. The form factor of the system, the dominant use case, and in case
of battery powered systems, the size of the battery and presence or
absence of active cooling can play a big role on what would be best to
use.

The new tunable provides sensible defaults, but yet gives the power to
control the response time to the user/sysadmin, if they wish to.

This tunable is applied before we apply the DVFS headroom.

The default behavior of applying 1.25 headroom can be re-instated easily
now. But we continue to keep the min required headroom to overcome
hardware limitation in its speed to change DVFS. And any additional
headroom to speed things up must be applied by userspace to match their
expectation for best perf/watt as it dictates a type of policy that will
be better for some systems, but worse for others.

There's a whitespace clean up included in sugov_start().

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 Documentation/admin-guide/pm/cpufreq.rst |  17 +++-
 drivers/cpufreq/cpufreq.c                |   4 +-
 include/linux/cpufreq.h                  |   3 +
 kernel/sched/cpufreq_schedutil.c         | 115 ++++++++++++++++++++++-
 4 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 6adb7988e0eb..fa0d602a920e 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -417,7 +417,7 @@ is passed by the scheduler to the governor callback which causes the frequency
 to go up to the allowed maximum immediately and then draw back to the value
 returned by the above formula over time.
 
-This governor exposes only one tunable:
+This governor exposes two tunables:
 
 ``rate_limit_us``
 	Minimum time (in microseconds) that has to pass between two consecutive
@@ -427,6 +427,21 @@ This governor exposes only one tunable:
 	The purpose of this tunable is to reduce the scheduler context overhead
 	of the governor which might be excessive without it.
 
+``respone_time_ms``
+	Amount of time (in milliseconds) required to ramp the policy from
+	lowest to highest frequency. Can be decreased to speed up the
+	responsiveness of the system, or increased to slow the system down in
+	hope to save power. The best perf/watt will depend on the system
+	characteristics and the dominant workload you expect to run. For
+	userspace that has smart context on the type of workload running (like
+	in Android), one can tune this to suite the demand of that workload.
+
+	Note that when slowing the response down, you can end up effectively
+	chopping off the top frequencies for that policy as the util is capped
+	to 1024. On HMP systems this chopping effect will only occur on the
+	biggest core whose capacity is 1024. Don't rely on this behavior as
+	this is a limitation that can hopefully be improved in the future.
+
 This governor generally is regarded as a replacement for the older `ondemand`_
 and `conservative`_ governors (described below), as it is simpler and more
 tightly integrated with the CPU scheduler, its overhead in terms of CPU context
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..5dc44c3694fe 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -533,8 +533,8 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
-static unsigned int __resolve_freq(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+unsigned int __resolve_freq(struct cpufreq_policy *policy,
+			    unsigned int target_freq, unsigned int relation)
 {
 	unsigned int idx;
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..c14ffdcd8933 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -622,6 +622,9 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 int __cpufreq_driver_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation);
+unsigned int __resolve_freq(struct cpufreq_policy *policy,
+			    unsigned int target_freq,
+			    unsigned int relation);
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq);
 unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 303b0ab227e7..94e35b7c972d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -8,9 +8,12 @@
 
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
+
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
 	unsigned int		rate_limit_us;
+	unsigned int		response_time_ms;
 };
 
 struct sugov_policy {
@@ -22,6 +25,7 @@ struct sugov_policy {
 	raw_spinlock_t		update_lock;
 	u64			last_freq_update_time;
 	s64			freq_update_delay_ns;
+	unsigned int		freq_response_time_ms;
 	unsigned int		next_freq;
 	unsigned int		cached_raw_freq;
 
@@ -59,6 +63,70 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
+{
+	int cpu = cpumask_first(sg_policy->policy->cpus);
+	unsigned long cap = arch_scale_cpu_capacity(cpu);
+	unsigned int max_freq, sec_max_freq;
+
+	max_freq = sg_policy->policy->cpuinfo.max_freq;
+	sec_max_freq = __resolve_freq(sg_policy->policy,
+				      max_freq - 1,
+				      CPUFREQ_RELATION_H);
+
+	/*
+	 * We will request max_freq as soon as util crosses the capacity at
+	 * second highest frequency. So effectively our response time is the
+	 * util at which we cross the cap@2nd_highest_freq.
+	 */
+	cap = sec_max_freq * cap / max_freq;
+
+	return approximate_runtime(cap + 1);
+}
+
+static inline void sugov_update_response_time_mult(struct sugov_policy *sg_policy)
+{
+	unsigned long mult;
+	int cpu;
+
+	if (unlikely(!sg_policy->freq_response_time_ms))
+		sg_policy->freq_response_time_ms = sugov_calc_freq_response_ms(sg_policy);
+
+	mult = sg_policy->freq_response_time_ms * SCHED_CAPACITY_SCALE;
+	mult /=	sg_policy->tunables->response_time_ms;
+
+	if (SCHED_WARN_ON(!mult))
+		mult = SCHED_CAPACITY_SCALE;
+
+	for_each_cpu(cpu, sg_policy->policy->cpus)
+		per_cpu(response_time_mult, cpu) = mult;
+}
+
+/*
+ * Shrink or expand how long it takes to reach the maximum performance of the
+ * policy.
+ *
+ * sg_policy->freq_response_time_ms is a constant value defined by PELT
+ * HALFLIFE and the capacity of the policy (assuming HMP systems).
+ *
+ * sg_policy->tunables->response_time_ms is a user defined response time. By
+ * setting it lower than sg_policy->freq_response_time_ms, the system will
+ * respond faster to changes in util, which will result in reaching maximum
+ * performance point quicker. By setting it higher, it'll slow down the amount
+ * of time required to reach the maximum OPP.
+ *
+ * This should be applied when selecting the frequency.
+ */
+static inline unsigned long
+sugov_apply_response_time(unsigned long util, int cpu)
+{
+	unsigned long mult;
+
+	mult = per_cpu(response_time_mult, cpu) * util;
+
+	return mult >> SCHED_CAPACITY_SHIFT;
+}
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -215,7 +283,10 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max)
 {
-	/* Add dvfs headroom to actual utilization */
+	/*
+	 * Speed up/slow down response timee first then apply DVFS headroom.
+	 */
+	actual = sugov_apply_response_time(actual, cpu);
 	actual = sugov_apply_dvfs_headroom(actual, cpu);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
@@ -614,8 +685,42 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 
 static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
 
+static ssize_t response_time_ms_show(struct gov_attr_set *attr_set, char *buf)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+
+	return sprintf(buf, "%u\n", tunables->response_time_ms);
+}
+
+static ssize_t
+response_time_ms_store(struct gov_attr_set *attr_set, const char *buf, size_t count)
+{
+	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
+	struct sugov_policy *sg_policy;
+	unsigned int response_time_ms;
+
+	if (kstrtouint(buf, 10, &response_time_ms))
+		return -EINVAL;
+
+	/* XXX need special handling for high values? */
+
+	tunables->response_time_ms = response_time_ms;
+
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+		if (sg_policy->tunables == tunables) {
+			sugov_update_response_time_mult(sg_policy);
+			break;
+		}
+	}
+
+	return count;
+}
+
+static struct governor_attr response_time_ms = __ATTR_RW(response_time_ms);
+
 static struct attribute *sugov_attrs[] = {
 	&rate_limit_us.attr,
+	&response_time_ms.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(sugov);
@@ -803,11 +908,13 @@ static int sugov_init(struct cpufreq_policy *policy)
 		goto stop_kthread;
 	}
 
-	tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
-
 	policy->governor_data = sg_policy;
 	sg_policy->tunables = tunables;
 
+	tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
+	tunables->response_time_ms = sugov_calc_freq_response_ms(sg_policy);
+	sugov_update_response_time_mult(sg_policy);
+
 	ret = kobject_init_and_add(&tunables->attr_set.kobj, &sugov_tunables_ktype,
 				   get_governor_parent_kobj(policy), "%s",
 				   schedutil_gov.name);
@@ -867,7 +974,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
 	unsigned int cpu;
 
-	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
+	sg_policy->freq_update_delay_ns		= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
-- 
2.34.1


