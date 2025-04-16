Return-Path: <linux-pm+bounces-25576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B166A90B1D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868053BD907
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D05221F01;
	Wed, 16 Apr 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YbwT+bgR"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C422155E;
	Wed, 16 Apr 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827177; cv=none; b=WvMYoOVzQhoEwGyVYlw6oGwtFrSWtqhKZ/obYMqoteiBzOGzMMEC14Jq/ricKyfypHvmCfV/pGbYE1CvpTN5DKizAmQ2LWKHrztsotVN28777m/B61x4jwFte5H24rs1uFVfien9j7A5Z78vVKUXaLFUpEhrGEDYzaFFV+9vcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827177; c=relaxed/simple;
	bh=iQKshVydollss9hMFH/JZu600SfS0P7cj3iiIysqwAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RY8DpAFcuCAx26Pz1fPXtMMaAoVcCv+cG3FGpv8KBKIE5cPka0KFj0D4fYDq2KcETbZczdwMZLshX3gaahUV61Q8+a3F7hFvPYWlisYG1aOMCyHt1Gu98eiWBAG7aPqJiFMmRIPJXri+TunrLBIsJOZUS2sPBobxKFfkYxzBr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YbwT+bgR; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8450E662715;
	Wed, 16 Apr 2025 20:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827173;
	bh=iQKshVydollss9hMFH/JZu600SfS0P7cj3iiIysqwAQ=;
	h=From:Subject:Date;
	b=YbwT+bgRt/bKqpCoFLZViC9RyILIuDQLDJaTHohcgWXixwvNydqMC3dRQh4Re05ej
	 Pm9RM+J/cMiK1yC6gzaJNCsK39BTAveURC5xedn2q7xnGFLIcOco335vFv9wH1FfMH
	 SGAcJ3RMi2uewl1Al6EEOvI3gCjb3ZbhtdGjwUT0PTJlWIMc0on9rejifzmL4CP7Ln
	 QstDDHaMTUFGryCd27t55PrhSYdpAGtMtEsSl4D2rUV1yypF46PVzR2E89r0bqMr07
	 aPl7+mGCL8/Hm07ghtYbOokJsUd87en2zDxkROacjHMjHj/08lvleS+KZ6gfkZKlLV
	 a3Iydd89oX0Xg==
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
 [RFT][PATCH v1 1/8] cpufreq/sched: schedutil: Add helper for governor checks
Date: Wed, 16 Apr 2025 19:48:16 +0200
Message-ID: <10640940.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a helper for checking if schedutil is the current governor for
a given cpufreq policy and use it in sched_is_eas_possible() to avoid
accessing cpufreq policy internals directly from there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v0.3 -> v1
     * Change the name of the new function to sugov_is_governor().

This patch is regarded as a cleanup for 6.16.

---
 include/linux/cpufreq.h          |    9 +++++++++
 kernel/sched/cpufreq_schedutil.c |    9 +++++++--
 kernel/sched/sched.h             |    2 --
 kernel/sched/topology.c          |    6 +++---
 4 files changed, 19 insertions(+), 7 deletions(-)

--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -650,6 +650,15 @@
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+bool sugov_is_governor(struct cpufreq_policy *policy);
+#else
+static inline bool sugov_is_governor(struct cpufreq_policy *policy)
+{
+	return false;
+}
+#endif
+
 static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 {
 	if (policy->max < policy->cur)
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -630,7 +630,7 @@
 
 /********************** cpufreq governor interface *********************/
 
-struct cpufreq_governor schedutil_gov;
+static struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 {
@@ -909,7 +909,7 @@
 	WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
-struct cpufreq_governor schedutil_gov = {
+static struct cpufreq_governor schedutil_gov = {
 	.name			= "schedutil",
 	.owner			= THIS_MODULE,
 	.flags			= CPUFREQ_GOV_DYNAMIC_SWITCHING,
@@ -927,4 +927,9 @@
 }
 #endif
 
+bool sugov_is_governor(struct cpufreq_policy *policy)
+{
+	return policy->governor == &schedutil_gov;
+}
+
 cpufreq_governor_init(schedutil_gov);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3509,8 +3509,6 @@
 	return static_branch_unlikely(&sched_energy_present);
 }
 
-extern struct cpufreq_governor schedutil_gov;
-
 #else /* ! (CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 #define perf_domain_span(pd) NULL
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -213,7 +213,7 @@
 {
 	bool any_asym_capacity = false;
 	struct cpufreq_policy *policy;
-	struct cpufreq_governor *gov;
+	bool policy_is_ready;
 	int i;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
@@ -258,9 +258,9 @@
 			}
 			return false;
 		}
-		gov = policy->governor;
+		policy_is_ready = sugov_is_governor(policy);
 		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
+		if (!policy_is_ready) {
 			if (sched_debug()) {
 				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
 					cpumask_pr_args(cpu_mask));




