Return-Path: <linux-pm+bounces-25575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D88A90B19
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21C1188E41E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BB221736;
	Wed, 16 Apr 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dxDpQa7w"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63421E0AC;
	Wed, 16 Apr 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827176; cv=none; b=u9c1BhlbrH3I6kXGFRo58opIcafeSGoePnMZG2NaFj/gQLiS09XM1RT7RNCwQ4vdM+ST7IaoAD0u5cafxL2QNPi7yChejNje6FeVASYP1Ibk+yVcjuWLRz6DFdlI37svfaoHeNRfpLQozRbOxcvjHtib3qbqLtDN3IAVo9SYnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827176; c=relaxed/simple;
	bh=FgHh7VtbPEhLa72u6hjHDx4ZGxyelJ9DLtrpta/YYro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyjluD1epNBPDO7UJ0GryN72//2yKY79Re9SSliAvS0ME/alf1f/i49KZ6pKsvjhtoxKDQ3H9XGb120jbuzm2LTRO/K/JvsW4G6i3MjT4ijoKAnz5wh3amDl2RLbH+tDhGhI5W0EGOGz7b5tKMI9Vys2UubKevxC3A6O43BlWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dxDpQa7w; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8DA29662714;
	Wed, 16 Apr 2025 20:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827172;
	bh=FgHh7VtbPEhLa72u6hjHDx4ZGxyelJ9DLtrpta/YYro=;
	h=From:Subject:Date;
	b=dxDpQa7wbGW85hnPUNCe0kyezgWo1LrhJGTW+d8jko03QgsdVxYVurlb7QjZWGklE
	 8x1V5K/n7xNOHemSubIoZL+cuv3uO/hEoOm3T40OIcjnzBWqpd5vA7HOYRxTHc8uIU
	 wh/qZ2zPF5psa3yIWO2oXyXmJSF8zDd5w4M2+4TMLZR4utPAXSHnj7ORTDTcH3nV+X
	 q9Y0Wv5YtKjS8r83FEpe61yGYQsAT8+tZ87zkpTsu0Cpx2Kx7f5srNLd0LwfqiVup5
	 Km5Z5Qj+o8t0rPDwh2rjr4zJWx2CAmuPnb8oyHQNygqG3io06jcy91zhjV/euz8ujT
	 lbHnioculyxcQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [RFT][PATCH v1 2/8] cpufreq/sched: Move cpufreq-specific EAS checks to
 cpufreq
Date: Wed, 16 Apr 2025 19:59:12 +0200
Message-ID: <6039220.MhkbZ0Pkbq@rjwysocki.net>
In-Reply-To: <3344336.aeNJFYEL58@rjwysocki.net>
References: <3344336.aeNJFYEL58@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Doing cpufreq-specific EAS checks that require accessing policy
internals directly from sched_is_eas_possible() is a bit unfortunate,
so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
into that new function and make sched_is_eas_possible() call it.

While at it, address a possible race between the EAS governor check
and governor change by doing the former under the policy rwsem.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.3 -> v1
     * Add a new helper called cpufreq_policy_is_good_for_eas() which is
       properly synchronized with governor changes.
     * Slightly modify debug messages.

This patch is regarded as a cleanup for 6.16.

---
 drivers/cpufreq/cpufreq.c |   32 ++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    2 ++
 kernel/sched/topology.c   |   25 +++++--------------------
 3 files changed, 39 insertions(+), 20 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3041,6 +3041,38 @@
 
 	return 0;
 }
+
+static bool cpufreq_policy_is_good_for_eas(unsigned int cpu)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy) {
+		pr_debug("cpufreq policy not set for CPU: %d", cpu);
+		return false;
+	}
+
+	guard(cpufreq_policy_read)(policy);
+
+	return sugov_is_governor(policy);
+}
+
+bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
+{
+	unsigned int cpu;
+
+	/* Do not attempt EAS if schedutil is not being used. */
+	for_each_cpu(cpu, cpu_mask) {
+		if (!cpufreq_policy_is_good_for_eas(cpu)) {
+			pr_debug("rd %*pbl: schedutil is mandatory for EAS\n",
+				 cpumask_pr_args(cpu_mask));
+			return false;
+		}
+	}
+
+	return true;
+}
+
 module_param(off, int, 0444);
 module_param_string(default_governor, default_governor, CPUFREQ_NAME_LEN, 0444);
 core_initcall(cpufreq_core_init);
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1212,6 +1212,8 @@
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
 
+bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask);
+
 static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
 {
 	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -212,8 +212,6 @@
 static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 {
 	bool any_asym_capacity = false;
-	struct cpufreq_policy *policy;
-	bool policy_is_ready;
 	int i;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
@@ -248,25 +246,12 @@
 		return false;
 	}
 
-	/* Do not attempt EAS if schedutil is not being used. */
-	for_each_cpu(i, cpu_mask) {
-		policy = cpufreq_cpu_get(i);
-		if (!policy) {
-			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
-					cpumask_pr_args(cpu_mask), i);
-			}
-			return false;
-		}
-		policy_is_ready = sugov_is_governor(policy);
-		cpufreq_cpu_put(policy);
-		if (!policy_is_ready) {
-			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
-					cpumask_pr_args(cpu_mask));
-			}
-			return false;
+	if (!cpufreq_ready_for_eas(cpu_mask)) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS: cpufreq is not ready",
+				cpumask_pr_args(cpu_mask));
 		}
+		return false;
 	}
 
 	return true;




