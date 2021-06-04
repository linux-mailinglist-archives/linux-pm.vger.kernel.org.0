Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA87339B791
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFDLIT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:08:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhFDLIS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:08:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C8A147A;
        Fri,  4 Jun 2021 04:06:32 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 448C03F73D;
        Fri,  4 Jun 2021 04:06:31 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 6/6] PM / EM: Skip inefficient states
Date:   Fri,  4 Jun 2021 12:06:01 +0100
Message-Id: <1622804761-126737-7-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that Schedutil can leverage the inefficiency identification from the
Energy Model, we can skip inefficient states when estimating the energy
consumption.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 2531325..d20f6afe 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -98,6 +98,36 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
+ * em_pd_get_efficient_state() - Get an efficient performance state from the EM
+ * @pd   : Performance domain for which we want an efficient frequency
+ * @freq : Frequency to map with the EM
+ *
+ * It is called from the scheduler code quite frequently and as a consequence
+ * doesn't implement any check.
+ *
+ * Return: An efficient performance state, high enough to meet @freq
+ * requirement.
+ */
+static inline
+struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
+						unsigned long freq)
+{
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		ps = &pd->table[i];
+		if (ps->frequency >= freq) {
+			if (ps->flags & EM_PERF_STATE_INEFFICIENT)
+				continue;
+			break;
+		}
+	}
+
+	return ps;
+}
+
+/**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
 		performance domain
  * @pd		: performance domain for which energy has to be estimated
@@ -116,7 +146,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
-	int i, cpu;
+	int cpu;
 
 	if (!sum_util)
 		return 0;
@@ -135,11 +165,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	for (i = 0; i < pd->nr_perf_states; i++) {
-		ps = &pd->table[i];
-		if (ps->frequency >= freq)
-			break;
-	}
+	ps = em_pd_get_efficient_state(pd, freq);
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
-- 
2.7.4

