Return-Path: <linux-pm+bounces-16748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4E9B6965
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE94281B02
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC1215030;
	Wed, 30 Oct 2024 16:40:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E682144CF;
	Wed, 30 Oct 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306429; cv=none; b=k3njjqi7NH4l95i1/zKMKaBPvmExuTosxxCCUQPIvk2ppX8uGbMExc6REU1YKs4AUyO3erv5IRJ7LhjmpxS2Hq5ZUjGjoz5tahXzzswM+1g67rSo2ttuHdkemNbxprNmGG7oSwyJlgPTzwlxpR68jJTFS4KDxX8lNNWMkXf6foQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306429; c=relaxed/simple;
	bh=5KrAospsbAOZPGWb/UyCS2WHmRRqVpc6zmP08j26Stc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI/tPfBVmC3OR11MY7Dm0pbBYIaXg2mRMMXpmwWnLzdYE8DOD2GalofllLQlJSiyQwZVTfBesVB0PEtf916JzuNygaVlQK6bJqbrm9kccR2lN+4DB91mLvtJ+bKflVnDpBf3pyEY8vwfl9Kg/zskNVDHdGV+ZWQyql9x4i+RSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1928911FB;
	Wed, 30 Oct 2024 09:40:55 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC7EE3F528;
	Wed, 30 Oct 2024 09:40:23 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rafael@kernel.org
Subject: [PATCH v3 1/1] PM: EM: Add min/max available performance state limits
Date: Wed, 30 Oct 2024 16:39:51 +0000
Message-ID: <20241030164126.1263793-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241030164126.1263793-1-lukasz.luba@arm.com>
References: <20241030164126.1263793-1-lukasz.luba@arm.com>
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
 include/linux/energy_model.h | 29 ++++++++++++++------
 kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1ff52020cf757..752e0b2975820 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -55,6 +55,8 @@ struct em_perf_table {
  * struct em_perf_domain - Performance domain
  * @em_table:		Pointer to the runtime modifiable em_perf_table
  * @nr_perf_states:	Number of performance states
+ * @min_perf_state:	Minimum allowed Performance State index
+ * @max_perf_state:	Maximum allowed Performance State index
  * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
  *			for performance reasons to avoid potential cache
@@ -70,6 +72,8 @@ struct em_perf_table {
 struct em_perf_domain {
 	struct em_perf_table __rcu *em_table;
 	int nr_perf_states;
+	int min_perf_state;
+	int max_perf_state;
 	unsigned long flags;
 	unsigned long cpus[];
 };
@@ -173,13 +177,14 @@ void em_table_free(struct em_perf_table __rcu *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
+int em_update_performance_limits(struct em_perf_domain *pd,
+		unsigned long freq_min_khz, unsigned long freq_max_khz);
 
 /**
  * em_pd_get_efficient_state() - Get an efficient performance state from the EM
  * @table:		List of performance states, in ascending order
- * @nr_perf_states:	Number of performance states
+ * @pd:			performance domain for which this must be done
  * @max_util:		Max utilization to map with the EM
- * @pd_flags:		Performance Domain flags
  *
  * It is called from the scheduler code quite frequently and as a consequence
  * doesn't implement any check.
@@ -188,13 +193,16 @@ int em_dev_update_chip_binning(struct device *dev);
  * requirement.
  */
 static inline int
-em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
-			  unsigned long max_util, unsigned long pd_flags)
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
 {
+	unsigned long pd_flags = pd->flags;
+	int min_ps = pd->min_perf_state;
+	int max_ps = pd->max_perf_state;
 	struct em_perf_state *ps;
 	int i;
 
-	for (i = 0; i < nr_perf_states; i++) {
+	for (i = min_ps; i <= max_ps; i++) {
 		ps = &table[i];
 		if (ps->performance >= max_util) {
 			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
@@ -204,7 +212,7 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
 		}
 	}
 
-	return nr_perf_states - 1;
+	return max_ps;
 }
 
 /**
@@ -253,8 +261,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * requested performance.
 	 */
 	em_table = rcu_dereference(pd->em_table);
-	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
-				      max_util, pd->flags);
+	i = em_pd_get_efficient_state(em_table->state, pd, max_util);
 	ps = &em_table->state[i];
 
 	/*
@@ -391,6 +398,12 @@ static inline int em_dev_update_chip_binning(struct device *dev)
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
index 927cc55ba0b3d..d07faf42eace6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -628,6 +628,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 		goto unlock;
 
 	dev->em_pd->flags |= flags;
+	dev->em_pd->min_perf_state = 0;
+	dev->em_pd->max_perf_state = nr_states - 1;
 
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
+	pd->min_perf_state = min_ps;
+	pd->max_perf_state = max_ps;
+	mutex_unlock(&em_pd_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(em_update_performance_limits);
-- 
2.46.0


