Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F33BF80F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 12:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhGHKMQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 06:12:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhGHKMP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E03BBED1;
        Thu,  8 Jul 2021 03:09:33 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 745593F5A1;
        Thu,  8 Jul 2021 03:09:32 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v4 8/9] cpufreq: Add driver flag CPUFREQ_READ_ENERGY_MODEL
Date:   Thu,  8 Jul 2021 11:09:05 +0100
Message-Id: <1625738946-295849-9-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model has a 1:1 mapping between OPPs and performance states
(em_perf_state). If a CPUFreq driver registers an Energy Model, the
inefficiencies found by the latter can apply to CPUFreq.
CPUFREQ_READ_ENERGY_MODEL allows, during registration, to read those
inefficiencies and mark the freq-table accordingly.

If a driver that set CPUFREQ_READ_ENERGY_MODEL, doesn't use a custom
->target() callback, CPUFreq can handle skipping inefficient frequencies
on its own and will automatically enable the freq-table relation
CPUFREQ_RELATION_E.

If CPUFREQ_RELATION_E is enabled, CPUFreq will let the Energy Model know
inefficiencies shouldn't be taken into account for the energy estimation.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f8d01d083df0..cb8950da4a47 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/energy_model.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
@@ -1313,6 +1314,58 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
+static inline void
+cpufreq_read_inefficiencies_from_em(struct cpufreq_policy *policy,
+				    struct em_perf_domain *em_pd)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	struct em_perf_state *em_table;
+	bool found = false;
+	int i;
+
+	if (!(cpufreq_driver->flags & CPUFREQ_READ_ENERGY_MODEL))
+		return;
+
+	if (!em_pd) {
+		pr_warn("CPUFreq driver wants to read inefficiencies from the Energy Model but none found\n");
+		return;
+	}
+
+	em_table = em_pd->table;
+
+	for (i = 0; i < em_pd->nr_perf_states; i++) {
+		if (!(em_table[i].flags & EM_PERF_STATE_INEFFICIENT))
+			continue;
+
+		cpufreq_for_each_valid_entry(pos, table) {
+			if (pos->frequency == em_table[i].frequency) {
+				pos->flags |= CPUFREQ_INEFFICIENT_FREQ;
+				found = true;
+				break;
+			}
+		}
+	}
+
+	if (!found)
+		return;
+
+	/*
+	 * If the driver does not use a custom ->target() callback, we can
+	 * automatically enable CPUFREQ_RELATION_E, supported by the default
+	 * function cpufreq_frequency_table_target(). Otherwise, the driver
+	 * must set this flag itself.
+	 */
+	if (!cpufreq_driver->target)
+		policy->relation_efficient = true;
+
+	/*
+	 * With CPUFREQ_RELATION_E enabled, inefficient frequencies will be
+	 * skipped. Let know the Energy Model it can skip them too.
+	 */
+	if (policy->relation_efficient)
+		em_pd->flags |= EM_PERF_DOMAIN_SKIP_INEFFICIENCIES;
+}
+
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -1367,6 +1420,12 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
+		/*
+		 * Sync potential inefficiencies with the Energy Model if the
+		 * driver requested CPUFREQ_READ_ENERGY_MODEL.
+		 */
+		cpufreq_read_inefficiencies_from_em(policy, em_cpu_get(cpu));
+
 		ret = cpufreq_table_validate_and_sort(policy);
 		if (ret)
 			goto out_exit_policy;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0110408fcf2d..f5e94207094c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -440,6 +440,14 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
+/*
+ * Set by drivers which register an Energy Model and want to use the latter to
+ * populate the freq-table with inefficiency information. If the same driver
+ * is not implementing the ->target() callback, setting this flag will also
+ * automatically enable CPUFREQ_RELATION_E.
+ */
+#define CPUFREQ_READ_ENERGY_MODEL		BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.7.4

