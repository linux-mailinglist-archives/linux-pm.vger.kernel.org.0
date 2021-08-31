Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E93FC598
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbhHaKZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 06:25:34 -0400
Received: from foss.arm.com ([217.140.110.172]:52890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240908AbhHaKZd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 06:25:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D43A11D4;
        Tue, 31 Aug 2021 03:24:38 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3309F3F5A1;
        Tue, 31 Aug 2021 03:24:37 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v6 3/7] PM / EM: Extend em_perf_domain with a flag field
Date:   Tue, 31 Aug 2021 11:24:09 +0100
Message-Id: <1630405453-275784-4-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Merge the current "milliwatts" option into a "flag" field. This intends to
prepare the extension of this structure for inefficient states support in
the Energy Model.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 629f5f63a7d7..ac2f7d0ab946 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -40,8 +40,7 @@ struct em_perf_state {
  * em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
  * @nr_perf_states:	Number of performance states
- * @milliwatts:		Flag indicating the power values are in milli-Watts
- *			or some other scale.
+ * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
  *			for performance reasons to avoid potential cache
  *			misses during energy calculations in the scheduler
@@ -56,10 +55,18 @@ struct em_perf_state {
 struct em_perf_domain {
 	struct em_perf_state *table;
 	int nr_perf_states;
-	int milliwatts;
+	unsigned long flags;
 	unsigned long cpus[];
 };
 
+/*
+ *  em_perf_domain flags:
+ *
+ *  EM_PERF_DOMAIN_MILLIWATTS: The power values are in milli-Watts or some
+ *  other scale.
+ */
+#define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
+
 #define em_span_cpus(em) (to_cpumask((em)->cpus))
 
 #ifdef CONFIG_ENERGY_MODEL
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 6d8438347535..3a7d1573b214 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -56,7 +56,8 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
 static int em_debug_units_show(struct seq_file *s, void *unused)
 {
 	struct em_perf_domain *pd = s->private;
-	char *units = pd->milliwatts ? "milliWatts" : "bogoWatts";
+	char *units = (pd->flags & EM_PERF_DOMAIN_MILLIWATTS) ?
+		"milliWatts" : "bogoWatts";
 
 	seq_printf(s, "%s\n", units);
 
@@ -330,7 +331,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	if (ret)
 		goto unlock;
 
-	dev->em_pd->milliwatts = milliwatts;
+	if (milliwatts)
+		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
-- 
2.7.4

