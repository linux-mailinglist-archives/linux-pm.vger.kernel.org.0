Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120A9584361
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiG1PmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiG1PmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B068DF0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:05 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:42:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vryeFXUNOFO6mJt0LGlv+NtoD9DTyqMeYsobXRtJLRc=;
        b=PWDJjeoOobMIqz3/uYo119Inv7LiV1TNeUJjT9TDWaUBv8sv2wteAwPO7GYYJ9e65PftNS
        47ZIstqnG2w3xc44F1iaSZj81or+e0RnYgNq8v2mzCgGw9Qv1tfMCdFEsnTck183zp9v6K
        7LMR0+R2gnh+/afg2dTjftNo8iiPSrQ1pKNwGE40QFu2Em0cqXq8Sxhws1PNkeTnFUCOXo
        NPUNtZFzornsk4KpUAqiSVFWxX8kbrtqWXyLvaVEY7wIuKnpSHL8bfUbgaxUFpQyByBh8B
        QCJwJ1ZbMqOYRfm1De7lre8m5Ug9d/Zib/PrL2Pkv81F2dP7grI4xKDbD2qdjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vryeFXUNOFO6mJt0LGlv+NtoD9DTyqMeYsobXRtJLRc=;
        b=Gd7j3dIreIX4ki+ISPzUJQmXo+rSsoqzd1sQLbsZn5bRtegnLORxjPPbF6HzMWMxo9fVDh
        hOcMzX1JmXk6zuDQ==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/cpufreq_cooling : Refactor
 thermal_power_cpu_get_power tracing
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220613124327.30766-3-lukasz.luba@arm.com>
References: <20220613124327.30766-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <165902292308.15455.4030664271160735353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3f7ced7ac9af43fbc0b886aa9ef4397a5fa4b6e1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3f7ced7ac9af43fbc0b886aa9ef4397a5fa4b6e1
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 13 Jun 2022 13:43:25 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:42 +02:00

drivers/thermal/cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing

Simplify the thermal_power_cpu_get_power trace event by removing
complicated cpumask and variable length array. Now the tools parsing trace
output don't have to hassle to get this power data. The simplified format
version uses 'policy->cpu'. Remove also the 'load' information completely
since there is very little value of it in this trace event. To get the
CPUs' load (or utilization) there are other dedicated trace hooks in the
kernel. This patch also simplifies and speeds-up the main cooling code
when that trace event is enabled.

Rename the trace event to avoid confusion of tools which parse the trace
file.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20220613124327.30766-3-lukasz.luba@arm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 18 +-----------------
 include/trace/events/thermal.h    | 28 ++++++++--------------------
 2 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index ad8b86f..492a67e 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -216,16 +216,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	u32 total_load = 0;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
-	u32 *load_cpu = NULL;
 
 	freq = cpufreq_quick_get(policy->cpu);
 
-	if (trace_thermal_power_cpu_get_power_enabled()) {
-		u32 ncpus = cpumask_weight(policy->related_cpus);
-
-		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
-	}
-
 	for_each_cpu(cpu, policy->related_cpus) {
 		u32 load;
 
@@ -235,22 +228,13 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 			load = 0;
 
 		total_load += load;
-		if (load_cpu)
-			load_cpu[i] = load;
-
-		i++;
 	}
 
 	cpufreq_cdev->last_load = total_load;
 
 	*power = get_dynamic_power(cpufreq_cdev, freq);
 
-	if (load_cpu) {
-		trace_thermal_power_cpu_get_power(policy->related_cpus, freq,
-						  load_cpu, i, *power);
-
-		kfree(load_cpu);
-	}
+	trace_thermal_power_cpu_get_power_simple(policy->cpu, *power);
 
 	return 0;
 }
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 8a5f048..e58bf30 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -92,34 +92,22 @@ TRACE_EVENT(thermal_zone_trip,
 );
 
 #ifdef CONFIG_CPU_THERMAL
-TRACE_EVENT(thermal_power_cpu_get_power,
-	TP_PROTO(const struct cpumask *cpus, unsigned long freq, u32 *load,
-		size_t load_len, u32 dynamic_power),
+TRACE_EVENT(thermal_power_cpu_get_power_simple,
+	TP_PROTO(int cpu, u32 power),
 
-	TP_ARGS(cpus, freq, load, load_len, dynamic_power),
+	TP_ARGS(cpu, power),
 
 	TP_STRUCT__entry(
-		__bitmask(cpumask, num_possible_cpus())
-		__field(unsigned long, freq          )
-		__dynamic_array(u32,   load, load_len)
-		__field(size_t,        load_len      )
-		__field(u32,           dynamic_power )
+		__field(int, cpu)
+		__field(u32, power)
 	),
 
 	TP_fast_assign(
-		__assign_bitmask(cpumask, cpumask_bits(cpus),
-				num_possible_cpus());
-		__entry->freq = freq;
-		memcpy(__get_dynamic_array(load), load,
-			load_len * sizeof(*load));
-		__entry->load_len = load_len;
-		__entry->dynamic_power = dynamic_power;
+		__entry->cpu = cpu;
+		__entry->power = power;
 	),
 
-	TP_printk("cpus=%s freq=%lu load={%s} dynamic_power=%d",
-		__get_bitmask(cpumask), __entry->freq,
-		__print_array(__get_dynamic_array(load), __entry->load_len, 4),
-		__entry->dynamic_power)
+	TP_printk("cpu=%d power=%u", __entry->cpu, __entry->power)
 );
 
 TRACE_EVENT(thermal_power_cpu_limit,
