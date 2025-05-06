Return-Path: <linux-pm+bounces-26749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59315AACEEF
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BE14C86AB
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12171A8F89;
	Tue,  6 May 2025 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="k7nXfe5O"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0D4315A;
	Tue,  6 May 2025 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564583; cv=none; b=VnlOBFOcfZ3T737lnZ5CnnP61EGVrVcgBrmkaxfs71i7GVfoYL+9t2ICfGawO8ZNzY2s/UO2enE1PPRoou0Ofozr6XCJ2ZeRwJrG0Xc9ljmyburQeajFSTjyhXCDqK/DuvztNco7CX8YRoT/0iAVnPvneiZVu+ixqymeR4C50cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564583; c=relaxed/simple;
	bh=raciEXRGFp7vWTdWj4Z8pA6U8LOVElBqW1XxDfFBQRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUpMESidPDGITfe33nuGDw/zoJLAnS76SOEGPv1M0B6I3QqcxhMAiHfLHERnzwNhZp3VGAG9Nw+CSbBSIdMJ3l+1LTSrOf0Lkl9HLwE30oLexiUXaYaVbNbXyUKkKJR5KZzYOEVMeMYh/9gY23IJc3HTMf/XlICsH5HdztaVcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=k7nXfe5O; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 73066666BB0;
	Tue,  6 May 2025 22:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564575;
	bh=raciEXRGFp7vWTdWj4Z8pA6U8LOVElBqW1XxDfFBQRM=;
	h=From:Subject:Date;
	b=k7nXfe5OSgXMv/a4SIBlxqWvbQvWHXBGk9pg0Aaa+RMQUqq+DY+n+tcdvv4CcI+TP
	 tsVnjeBRkPbV4bfxy2BHNRBPNybBfqIJPCJKhfbSD1RiYpogaI7a0jpBfHCyg+1oua
	 FxVrovPalzKLFMeACxg0fop09NfvLJxBMfWm5EhWz5WoDV2regdyxASS8y/nhrnQfZ
	 IIFvDcRNWEbwyVP23vD0MK83QtVqM2BSuD28HzPrTdGAy2LwtYFLlts3kwkyqULsD9
	 4K94sy0t+0nXQRfd0IRTKnK66hABGDNP+wG4pZKqh51ZlQBbkTH/+8RU5geJQN7yV0
	 3e3P90acpNlgg==
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
 [PATCH v2 3/7] PM: EM: Move CPU capacity check to em_adjust_new_capacity()
Date: Tue, 06 May 2025 22:39:35 +0200
Message-ID: <7810787.EvYhyI6sBW@rjwysocki.net>
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

Move the check of the CPU capacity currently stored in the energy model
against the arch_scale_cpu_capacity() value to em_adjust_new_capacity()
so it will be done regardless of where the latter is called from.

This will be useful when a new em_adjust_new_capacity() caller is added
subsequently.

While at it, move the pd local variable declaration in
em_check_capacity_update() into the loop in which it is used.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

v1 -> v2: Pick up tags

---
 kernel/power/energy_model.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -725,10 +725,24 @@
  * Adjustment of CPU performance values after boot, when all CPUs capacites
  * are correctly calculated.
  */
-static void em_adjust_new_capacity(struct device *dev,
+static void em_adjust_new_capacity(unsigned int cpu, struct device *dev,
 				   struct em_perf_domain *pd)
 {
+	unsigned long cpu_capacity = arch_scale_cpu_capacity(cpu);
 	struct em_perf_table *em_table;
+	struct em_perf_state *table;
+	unsigned long em_max_perf;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
+	em_max_perf = table[pd->nr_perf_states - 1].performance;
+	rcu_read_unlock();
+
+	if (em_max_perf == cpu_capacity)
+		return;
+
+	pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n", cpu,
+		 cpu_capacity, em_max_perf);
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -744,9 +758,6 @@
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	struct em_perf_state *table;
-	struct em_perf_domain *pd;
-	unsigned long cpu_capacity;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
@@ -757,7 +768,7 @@
 	/* Check if CPUs capacity has changed than update EM */
 	for_each_possible_cpu(cpu) {
 		struct cpufreq_policy *policy;
-		unsigned long em_max_perf;
+		struct em_perf_domain *pd;
 		struct device *dev;
 
 		if (cpumask_test_cpu(cpu, cpu_done_mask))
@@ -780,24 +791,7 @@
 		cpumask_or(cpu_done_mask, cpu_done_mask,
 			   em_span_cpus(pd));
 
-		cpu_capacity = arch_scale_cpu_capacity(cpu);
-
-		rcu_read_lock();
-		table = em_perf_state_from_pd(pd);
-		em_max_perf = table[pd->nr_perf_states - 1].performance;
-		rcu_read_unlock();
-
-		/*
-		 * Check if the CPU capacity has been adjusted during boot
-		 * and trigger the update for new performance values.
-		 */
-		if (em_max_perf == cpu_capacity)
-			continue;
-
-		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
-			 cpu, cpu_capacity, em_max_perf);
-
-		em_adjust_new_capacity(dev, pd);
+		em_adjust_new_capacity(cpu, dev, pd);
 	}
 
 	free_cpumask_var(cpu_done_mask);




