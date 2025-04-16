Return-Path: <linux-pm+bounces-25573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA1A90B14
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D717E7A66E2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4322206B6;
	Wed, 16 Apr 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="O08rCwsn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2C21CFEA;
	Wed, 16 Apr 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827175; cv=none; b=VEMnTICPuZpsdw496eesGR2YBampjUUhDlbNwuBeV59/VybGwK/GCYFLsBqvhbL2GTiVv2j3Mm5EZ+dwqQLr8kkcbrNICL8nHLD2vu6oEP61wiA6iaIs5mcxoTsgoMA4DUczRNhRT0gyNAnOBOmBxx/gENKg0lYkorQQbw48O1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827175; c=relaxed/simple;
	bh=FTOuMPjeTUHaacx8ul/ZKRVujZeYC6eVmnz2zMxqLEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu8EZr+bcKcu9s8zYAZXvFhEwr5VdBOKwcFyLT+qqifLOfVwHgZV8iSXbgDzClTvFLr0mGuKjceLZiGW+nv3edHWvOSxWSs50yj42zAs+P3uMl7/VtyFhl6Sxx7cGPNeEA75wNOiD5+Q/0rRea+r80XtWfhktxXgTR9TXiqN2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=O08rCwsn; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 988E7662718;
	Wed, 16 Apr 2025 20:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827170;
	bh=FTOuMPjeTUHaacx8ul/ZKRVujZeYC6eVmnz2zMxqLEM=;
	h=From:Subject:Date;
	b=O08rCwsnw+VV+pxjDr81KbTxjsg9lO8K1MInKwmc1/IadA5zTtJfEQo9BjjvZ1xor
	 nBuTYB0Qtm+YbNfUl8uLGL9Jump3XfN2tgm0xCTkou9CPYBueub5NkwcSVgTWQLfVr
	 LpSREu/xdBtPjPL2/Q2s+C8W4dWEUfHpMPxndUFo2JG9ei1C3tLKVfkENlgF8Y96Ph
	 syUscB/z9AFtMfmJdOyIr2LVGCR2FKGKnzHD0ycj/Q5bsWO4bZ1oDpu+5iR0yz5Yo3
	 mhxTKFyQNvLViekIRDcJFeiNutxaqZGqtvdMTL7MemPiDMXqeikOCmTwrVVx3ypVtb
	 UcgnhCtFOHOpA==
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
 [RFT][PATCH v1 4/8] PM: EM: Move CPU capacity check to
 em_adjust_new_capacity()
Date: Wed, 16 Apr 2025 20:04:23 +0200
Message-ID: <1921260.CQOukoFCf9@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
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
---

v0.3 -> v1:
     * Added R-by from Lukasz.

---
 kernel/power/energy_model.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -721,10 +721,24 @@
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
@@ -740,9 +754,6 @@
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	struct em_perf_state *table;
-	struct em_perf_domain *pd;
-	unsigned long cpu_capacity;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
@@ -753,7 +764,7 @@
 	/* Check if CPUs capacity has changed than update EM */
 	for_each_possible_cpu(cpu) {
 		struct cpufreq_policy *policy;
-		unsigned long em_max_perf;
+		struct em_perf_domain *pd;
 		struct device *dev;
 
 		if (cpumask_test_cpu(cpu, cpu_done_mask))
@@ -776,24 +787,7 @@
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




