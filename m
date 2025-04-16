Return-Path: <linux-pm+bounces-25572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C942A90B12
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAB3460498
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFAB21D3E6;
	Wed, 16 Apr 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ne+C/Xkq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AC21B1BC;
	Wed, 16 Apr 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827174; cv=none; b=d0h4TvGZvxveDbkh0Ef1zfKM2yBDVD5fkYBnkUbP2zyvCEG/X4gt0g8hDKO3rfAS1Ms3qfstTxwOjasSTq2WDw3kcPSDH/mEByVeJXULHsg4tXi4G0Pr7EcRRuOJ00fr2HBq90j8lWi2Y2unlJE4iLkQk7N+Tq79xe6URmrPdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827174; c=relaxed/simple;
	bh=ORPobRSIjW5dpK/qm7vNZhGebo2cfHQSp0/z/ui7sjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwgYDzLP4JgcjUjV6VAJ27AOfxC27l2/20XBf+Ht3aQf/BcJsxDr2Ac6l9KPHxfdYeRX8PM/tv/bh+dmjFn/5xEMC52SxDRKdqKCsrzMQsXKaJfdXdHShQvSdzpgvX83mJL2Nq3DwOWhwvJGBQeBBaTOt30RsoXNvGtXz5Al/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ne+C/Xkq; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 90CA0662717;
	Wed, 16 Apr 2025 20:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744827169;
	bh=ORPobRSIjW5dpK/qm7vNZhGebo2cfHQSp0/z/ui7sjc=;
	h=From:Subject:Date;
	b=Ne+C/XkqjvJOc0z1k1fivTG0oR7pQsYZruHoBEGjYqG6Bygm+aAZBoptS8pb/AErX
	 0aZ9pZegKWbvObEPUSilLkJCbBgI1b/glb6S38kBdSqwApDXg9zrxdzcrpOVg4lNAg
	 6V24dgutuj/9ghdl87fCvO/o9Msv8x/KlwmENIQLmspwyoWJEBXBYEV+EEieO4YMyv
	 bmcAwkUYRfIqaliqqe7JOs6yXed76M58zgdloTLURmzt0v5s7BDeJVe8iv9Tuszzzi
	 /5l7cEbuErVfCY/dglIGsrThxJGP6033gEJG1R2AZnraxZbKd4VVXoMm7BakJdtn3E
	 UDqCEOUIWIghw==
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
Subject: [RFT][PATCH v1 5/8] PM: EM: Introduce em_adjust_cpu_capacity()
Date: Wed, 16 Apr 2025 20:06:16 +0200
Message-ID: <2649447.Lt9SDvczpP@rjwysocki.net>
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

Add a function for updating the Energy Model for a CPU after its
capacity has changed, which subsequently will be used by the
intel_pstate driver.

An EM_PERF_DOMAIN_ARTIFICIAL check is added to em_adjust_new_capacity()
to prevent it from calling em_compute_costs() for an "artificial" perf
domain with a NULL cb parameter which would cause it to crash.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

v0.3 -> v1:
     * Added R-by from Lukasz.

---
 include/linux/energy_model.h |    2 ++
 kernel/power/energy_model.c  |   28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -179,6 +179,7 @@
 int em_dev_update_chip_binning(struct device *dev);
 int em_update_performance_limits(struct em_perf_domain *pd,
 		unsigned long freq_min_khz, unsigned long freq_max_khz);
+void em_adjust_cpu_capacity(unsigned int cpu);
 void em_rebuild_sched_domains(void);
 
 /**
@@ -405,6 +406,7 @@
 {
 	return -EINVAL;
 }
+static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
 static inline void em_rebuild_sched_domains(void) {}
 #endif
 
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -698,10 +698,12 @@
 {
 	int ret;
 
-	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
-			       pd->flags);
-	if (ret)
-		goto free_em_table;
+	if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
+		ret = em_compute_costs(dev, em_table->state, NULL,
+				       pd->nr_perf_states, pd->flags);
+		if (ret)
+			goto free_em_table;
+	}
 
 	ret = em_dev_update_perf_domain(dev, em_table);
 	if (ret)
@@ -751,6 +753,24 @@
 	em_recalc_and_update(dev, pd, em_table);
 }
 
+/**
+ * em_adjust_cpu_capacity() - Adjust the EM for a CPU after a capacity update.
+ * @cpu: Target CPU.
+ *
+ * Adjust the existing EM for @cpu after a capacity update under the assumption
+ * that the capacity has been updated in the same way for all of the CPUs in
+ * the same perf domain.
+ */
+void em_adjust_cpu_capacity(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	struct em_perf_domain *pd;
+
+	pd = em_pd_get(dev);
+	if (pd)
+		em_adjust_new_capacity(cpu, dev, pd);
+}
+
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;




