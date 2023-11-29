Return-Path: <linux-pm+bounces-450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B67FD4FE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACDC28342C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8251C288;
	Wed, 29 Nov 2023 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A89A4210D;
	Wed, 29 Nov 2023 03:08:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9616C2F4;
	Wed, 29 Nov 2023 03:09:18 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 088573F5A1;
	Wed, 29 Nov 2023 03:08:28 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com
Subject: [PATCH v5 11/23] PM: EM: Add API for updating the runtime modifiable EM
Date: Wed, 29 Nov 2023 11:08:41 +0000
Message-Id: <20231129110853.94344-12-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add API function em_dev_update_perf_domain() which allows to safely
change the EM. The concurrent modifiers are protected by the mutex
to serialize them. Removal of the old memory is asynchronous and
handled by the RCU mechanisms.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h |  8 +++++++
 kernel/power/energy_model.c  | 46 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index e785211828fe..520a8c8ad849 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -183,6 +183,8 @@ struct em_data_callback {
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
@@ -379,6 +381,12 @@ struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
 	return NULL;
 }
 static inline void em_free_table(struct em_perf_table __rcu *table) {}
+static inline
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 489a358b9a00..614891fde8df 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -221,6 +221,52 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
 	return 0;
 }
 
+/**
+ * em_dev_update_perf_domain() - Update runtime EM table for a device
+ * @dev		: Device for which the EM is to be updated
+ * @table	: The new EM table that is going to used from now
+ *
+ * Update EM runtime modifiable table for the @dev using the privided @table.
+ *
+ * This function uses mutex to serialize writers, so it must not be called
+ * from non-sleeping context.
+ *
+ * Return 0 on success or a proper error in case of failure.
+ */
+int em_dev_update_perf_domain(struct device *dev,
+			      struct em_perf_table __rcu *new_table)
+{
+	struct em_perf_table __rcu *old_table;
+	struct em_perf_domain *pd;
+
+	/*
+	 * The lock serializes update and unregister code paths. When the
+	 * EM has been unregistered in the meantime, we should capture that
+	 * when entering this critical section. It also makes sure that
+	 * two concurrent updates will be serialized.
+	 */
+	mutex_lock(&em_pd_mutex);
+
+	if (!dev || !dev->em_pd) {
+		mutex_unlock(&em_pd_mutex);
+		return -EINVAL;
+	}
+	pd = dev->em_pd;
+
+	em_inc_usage(new_table);
+
+	old_table = pd->runtime_table;
+	rcu_assign_pointer(pd->runtime_table, new_table);
+
+	em_cpufreq_update_efficiencies(dev, new_table->state);
+
+	em_dec_usage(old_table);
+
+	mutex_unlock(&em_pd_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
+
 static int em_create_runtime_table(struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *runtime_table;
-- 
2.25.1


