Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0111739B790
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhFDLIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:08:18 -0400
Received: from foss.arm.com ([217.140.110.172]:36232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFDLIR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:08:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 113221477;
        Fri,  4 Jun 2021 04:06:31 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2E223F73D;
        Fri,  4 Jun 2021 04:06:29 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 5/6] cpufreq: Mark inefficient frequencies using the Energy Model
Date:   Fri,  4 Jun 2021 12:06:00 +0100
Message-Id: <1622804761-126737-6-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model has a 1:1 mapping between OPPs and performance states
(em_perf_state). We can then read which states are inefficient and use this
information to mark the cpufreq table.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7431f40a..34d344d 100644
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
@@ -1317,6 +1318,31 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
+static void cpufreq_inefficiencies_from_em(struct cpufreq_policy *policy,
+					   struct em_perf_domain *em_pd)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	struct em_perf_state *em_table;
+	int i;
+
+	if (!em_pd)
+		return;
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
+				break;
+			}
+		}
+	}
+}
+
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -1371,6 +1397,12 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
+		/*
+		 * Sync potential inefficiencies with an Energy Model that the
+		 * driver might have registered.
+		 */
+		cpufreq_inefficiencies_from_em(policy, em_cpu_get(cpu));
+
 		ret = cpufreq_table_validate_and_sort(policy);
 		if (ret)
 			goto out_exit_policy;
-- 
2.7.4

