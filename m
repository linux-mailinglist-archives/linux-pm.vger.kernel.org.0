Return-Path: <linux-pm+bounces-23650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38840A5724E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2BD7A74E7
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007612561D4;
	Fri,  7 Mar 2025 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="p7f9spbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD624DFEF;
	Fri,  7 Mar 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376571; cv=none; b=Npb0j1FTFyRvIJksFs5gqJ/vjforUMJfDMkO2mTlmC83ZNRW1kyuins1BQfIfKGn88bQQ22ylwXwKo1AXtk/0Y3ZTYdritR0rZ4MTJj+yp2t93jS7Y6d3VtyaZ9wx89HXjh0Cz1YoOm+ocVVBlE3qGAwzMVCFmY3Z88JYRGb82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376571; c=relaxed/simple;
	bh=mBw2XwgaWgmKzoEZRR2bvaPE7UQBL16C6NnCX0Wta5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXZYz/1qy2Gl32wdSVLdiuffATNOCM4YUZMzKWAik5TurPl7/J86LEFA7iVKr3Rc6qewcbJbeZMxyQUTP8m3OUN+13GpBiGq/hZ81pP//CZZSEbZWmAUSrhI8caiRzXSTbS5FU6Tu/bSgax5TQxEktWgYcnXIFpBj/1SpvOJfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=p7f9spbx; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 6dc80f473847aa41; Fri, 7 Mar 2025 20:42:42 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8E5279A0BFB;
	Fri,  7 Mar 2025 20:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376562;
	bh=mBw2XwgaWgmKzoEZRR2bvaPE7UQBL16C6NnCX0Wta5Q=;
	h=From:Subject:Date;
	b=p7f9spbxinN3tlcyX+fbdZT9357V0mnqQRDMHhNXDRfILK7aNirP5tnpOBgppm9j+
	 O3pL8OKx8HzHCrPKuhk1g+hgj+P6q9ygG2W6829OY53u8WtlKuaNqY61oKo3eMnW5U
	 bK7OrX1Dze0eXzTD+RFYJc/I5+nFr24WbN1oAmVkuJnvDpvNcSo8wy8LeXqpc/f4/d
	 Y/mmLO9N4tokHhEK01s8+0lnPWAprZ/ha+pdbqHg9wkqislxrgD4x+yT+YLZbXHUN0
	 AmupJomE3F2WgGkzN9JBwkeQ1d+lRnjSJCEnHDNDbqARczdk0MUpAM5vCyOr4B+1ae
	 nZovTD+Hlawag==
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
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject:
 [RFC][PATCH v0.3 4/6] PM: EM: Move CPU capacity check to
 em_adjust_new_capacity()
Date: Fri, 07 Mar 2025 20:17:19 +0100
Message-ID: <2667366.Lt9SDvczpP@rjwysocki.net>
In-Reply-To: <22640172.EfDdHjke4D@rjwysocki.net>
References: <22640172.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

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




