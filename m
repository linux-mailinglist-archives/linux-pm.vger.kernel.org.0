Return-Path: <linux-pm+bounces-16652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733B9B45E6
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34BE1F23581
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9F2040A9;
	Tue, 29 Oct 2024 09:43:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303A81E04A9;
	Tue, 29 Oct 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195037; cv=none; b=oi3nmUTde4gLZVPgdgxJjKbebnVBIvvvazK0dq9PCZI8z+jn41/0ZcZf5ghWAi0ge/yQNXYrEaDauWGYL57XqJwHK5Do4YtS8ML5imNKJV1I8c0dP83At6l41n1M5GUnhdFb/QWeEVsiNbsoVwuLJW3DlLpPsAGhN3LgzyYL2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195037; c=relaxed/simple;
	bh=teihSoOif/nbeNISr36/tEFxGotTMWumKYmVCjxDxDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijNqKB0T/aQTQ0j0o4QA8UV7/o1YZaPCxtvFSfIgZh/Ak7BJvDoPf5/anSwwDaDfSPB1T1wZrWMJoaBGOMLgEcLsBinOS8JZAnp3Zie4GxLNRj+Km0fE11z0b7ZjNvWn1HNdWesI5anT/itwUi9W/KjTKJQstinFLpvXUfckCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E1091575;
	Tue, 29 Oct 2024 02:44:23 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.57.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 774593F528;
	Tue, 29 Oct 2024 02:43:52 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rafael@kernel.org
Subject: [PATCH v2 1/1] PM: EM: Add min/max available performance state limits
Date: Tue, 29 Oct 2024 09:43:29 +0000
Message-ID: <20241029094452.495439-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029094452.495439-1-lukasz.luba@arm.com>
References: <20241029094452.495439-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some devices there are HW dependencies for shared frequency and voltage
between devices. It will impact Energy Aware Scheduler (EAS) decision,
where CPUs share the voltage & frequency domain with other CPUs or devices
e.g.
- Mid CPUs + Big CPU
- Little CPU + L3 cache in DSU
- some other device + Little CPUs

Detailed explanation of one example:
When the L3 cache frequency is increased, the affected Little CPUs might
run at higher voltage and frequency. That higher voltage causes higher CPU
power and thus more energy is used for running the tasks. This is
important for background running tasks, which try to run on energy
efficient CPUs.

Therefore, add performance state limits which are applied for the device
(in this case CPU). This is important on SoCs with HW dependencies
mentioned above so that the Energy Aware Scheduler (EAS) does not use
performance states outside the valid min-max range for energy calculation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 24 ++++++++++++++---
 kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1ff52020cf757..e83bf230e18d1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -55,6 +55,8 @@ struct em_perf_table {
  * struct em_perf_domain - Performance domain
  * @em_table:		Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
+ * @min_ps:		Minimum allowed Performance State index
+ * @max_ps:		Maximum allowed Performance State index
  * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
  *			for performance reasons to avoid potential cache
@@ -70,6 +72,8 @@ struct em_perf_table {
 struct em_perf_domain {
 	struct em_perf_table __rcu *em_table;
 	int nr_perf_states;
+	int min_ps;
+	int max_ps;
 	unsigned long flags;
 	unsigned long cpus[];
 };
@@ -173,6 +177,8 @@ void em_table_free(struct em_perf_table __rcu *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
@@ -180,6 +186,8 @@ int em_dev_update_chip_binning(struct device *dev);
  * @nr_perf_states:	Number of performance states
  * @max_util:		Max utilization to map with the EM
  * @pd_flags:		Performance Domain flags
+ * @min_ps:		Minimum allowed Performance State index
+ * @max_ps:		Maximum allowed Performance State index
  *
  * It is called from the scheduler code quite frequently and as a consequence
  * doesn't implement any check.
@@ -189,12 +197,13 @@ int em_dev_update_chip_binning(struct device *dev);
  */
 static inline int
 em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
-			  unsigned long max_util, unsigned long pd_flags)
+			  unsigned long max_util, unsigned long pd_flags,
+			  int min_ps, int max_ps)
 {
 	struct em_perf_state *ps;
 	int i;
 
-	for (i = 0; i < nr_perf_states; i++) {
+	for (i = min_ps; i <= max_ps; i++) {
 		ps = &table[i];
 		if (ps->performance >= max_util) {
 			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
@@ -204,7 +213,7 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
 		}
 	}
 
-	return nr_perf_states - 1;
+	return max_ps;
 }
 
 /**
@@ -254,7 +263,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	em_table = rcu_dereference(pd->em_table);
 	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
-				      max_util, pd->flags);
+				      max_util, pd->flags, pd->min_ps,
+				      pd->max_ps);
 	ps = &em_table->state[i];
 
 	/*
@@ -391,6 +401,12 @@ static inline int em_dev_update_chip_binning(struct device *dev)
 {
 	return -EINVAL;
 }
+static inline
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 927cc55ba0b3d..436c2b8fdf9eb 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -628,6 +628,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 		goto unlock;
 
 	dev->em_pd->flags |= flags;
+	dev->em_pd->min_ps = 0;
+	dev->em_pd->max_ps = nr_states - 1;
 
 	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
 
@@ -856,3 +858,53 @@ int em_dev_update_chip_binning(struct device *dev)
 	return em_recalc_and_update(dev, pd, em_table);
 }
 EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
+
+
+/**
+ * em_update_performance_limits() - Update Energy Model with performance
+ *				limits information.
+ * @pd			: Performance Domain with EM that has to be updated.
+ * @freq_min_khz	: New minimum allowed frequency for this device.
+ * @freq_max_khz	: New maximum allowed frequency for this device.
+ *
+ * This function allows to update the EM with information about available
+ * performance levels. It takes the minimum and maximum frequency in kHz
+ * and does internal translation to performance levels.
+ * Returns 0 on success or -EINVAL when failed.
+ */
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz)
+{
+	struct em_perf_state *table;
+	int min_ps = -1;
+	int max_ps = -1;
+	int i;
+
+	if (!pd)
+		return -EINVAL;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		if (freq_min_khz == table[i].frequency)
+			min_ps = i;
+		if (freq_max_khz == table[i].frequency)
+			max_ps = i;
+	}
+	rcu_read_unlock();
+
+	/* Only update when both are found and sane */
+	if (min_ps < 0 || max_ps < 0 || max_ps < min_ps)
+		return -EINVAL;
+
+
+	/* Guard simultaneous updates and make them atomic */
+	mutex_lock(&em_pd_mutex);
+	pd->min_ps = min_ps;
+	pd->max_ps = max_ps;
+	mutex_unlock(&em_pd_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(em_update_performance_limits);
-- 
2.46.0


