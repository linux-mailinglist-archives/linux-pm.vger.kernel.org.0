Return-Path: <linux-pm+bounces-26751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFDAACEF4
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29110982625
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC21DFE12;
	Tue,  6 May 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="iyTzWkl4"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CA1AAA1C;
	Tue,  6 May 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564585; cv=none; b=I5tNzHyIPtgKsq/4kV+eiRgNR5P0+p627qoKFTWpUCotZuTy2uMz7MqwnzhFcRlBTIIwMadUCKqMXhGXd3e+32/zmqRXj5xsJpvnzyYmuZNTVhnlS4Os0PZaWJeaSay97QpEwCpnvAfg4ihkk3C0ReN2aaFNLkIdT0Ttv9FHiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564585; c=relaxed/simple;
	bh=bIAJgFCW8p08FPTyn9O3V5PiHuLVTgOdO4RQCZpYtv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEp4MptxV9KwApf+dzx5whgY2vAmcAi4VpHOl/cV9hrKJHF70yZetqveZ/kexKwTIXTK+/J9mCBloy4eQuyM3L6tbkubgZuNBs2ZNHtP/sC63x9GPbl1WAF2qmdTllJULddTrosBUsNLibYq9NmSVflJMd6jgty592+CtLmruE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=iyTzWkl4; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5D23A666BB1;
	Tue,  6 May 2025 22:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564576;
	bh=bIAJgFCW8p08FPTyn9O3V5PiHuLVTgOdO4RQCZpYtv4=;
	h=From:Subject:Date;
	b=iyTzWkl4CTpTmcF/G7V9n0KxYEsreSgGCafu+3ME4NLfbJd5ogHyDuuKgI7QZu2S2
	 HySAg3dD58r2daxnN1819hSnxRmU17mlbIbS0gdK3JtDFQNM99g3Rbst+EUiwOHJFQ
	 WfnL556wPZWLnb/YWmt4SRL9PYIulckyGLtT9zGI27Bc4lxAuBsB0O9dRcliqQC8OF
	 oEDrvgjOFBXn9SAWvAhp47Tao8WREfMT94L7gn8V+I68zRQlkrhh708SeC8TRuLUxg
	 MaCmIOmV5SdLZZMnJauIoT6HN6NA//SPnB9G7vC84RWS5mh3rWE0dxp1wBPiDBSIS8
	 Dfm/vBSsdsGJQ==
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
 [PATCH v2 2/7] cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq
Date: Tue, 06 May 2025 22:37:15 +0200
Message-ID: <2317800.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Doing cpufreq-specific EAS checks that require accessing policy
internals directly from sched_is_eas_possible() is a bit unfortunate,
so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
into that new function and make sched_is_eas_possible() call it.

While at it, address a possible race between the EAS governor check
and governor change by doing the former under the policy rwsem.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

v1 -> v2:
   * Add missing newline characters in two places (Christian).
   * Pick up tags.

---
 drivers/cpufreq/cpufreq.c |   32 ++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    2 ++
 kernel/sched/topology.c   |   25 +++++--------------------
 3 files changed, 39 insertions(+), 20 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3056,6 +3056,38 @@
 
 	return 0;
 }
+
+static bool cpufreq_policy_is_good_for_eas(unsigned int cpu)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy) {
+		pr_debug("cpufreq policy not set for CPU: %d\n", cpu);
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
@@ -1237,6 +1237,8 @@
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
+			pr_info("rd %*pbl: Checking EAS: cpufreq is not ready\n",
+				cpumask_pr_args(cpu_mask));
 		}
+		return false;
 	}
 
 	return true;




