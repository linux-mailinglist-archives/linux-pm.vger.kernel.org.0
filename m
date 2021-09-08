Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41788403B2C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhIHOGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 10:06:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351755AbhIHOGx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 10:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC181042;
        Wed,  8 Sep 2021 07:05:45 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEFE53F766;
        Wed,  8 Sep 2021 07:05:43 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v7 2/9] PM / EM: Mark inefficient states
Date:   Wed,  8 Sep 2021 15:05:23 +0100
Message-Id: <1631109930-290049-3-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some SoCs, such as the sd855 have OPPs within the same performance domain,
whose cost is higher than others with a higher frequency. Even though
those OPPs are interesting from a cooling perspective, it makes no sense
to use them when the device can run at full capacity. Those OPPs handicap
the performance domain, when choosing the most energy-efficient CPU and
are wasting energy. They are inefficient.

Hence, add support for such OPPs to the Energy Model. The table can now
be read skipping inefficient performance states (and by extension,
inefficient OPPs).

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1834752c5617..629f5f63a7d7 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -17,13 +17,25 @@
  *		device). It can be a total power: static and dynamic.
  * @cost:	The cost coefficient associated with this level, used during
  *		energy calculation. Equal to: power * max_frequency / frequency
+ * @flags:	see "em_perf_state flags" description below.
  */
 struct em_perf_state {
 	unsigned long frequency;
 	unsigned long power;
 	unsigned long cost;
+	unsigned long flags;
 };
 
+/*
+ * em_perf_state flags:
+ *
+ * EM_PERF_STATE_INEFFICIENT: The performance state is inefficient. There is
+ * in this em_perf_domain, another performance state with a higher frequency
+ * but a lower or equal power cost. Such inefficient states are ignored when
+ * using em_pd_get_efficient_*() functions.
+ */
+#define EM_PERF_STATE_INEFFICIENT BIT(0)
+
 /**
  * em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 97e62469a6b3..6d8438347535 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -2,7 +2,7 @@
 /*
  * Energy Model of devices
  *
- * Copyright (c) 2018-2020, Arm ltd.
+ * Copyright (c) 2018-2021, Arm ltd.
  * Written by: Quentin Perret, Arm ltd.
  * Improvements provided by: Lukasz Luba, Arm ltd.
  */
@@ -42,6 +42,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
 	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
 	debugfs_create_ulong("power", 0444, d, &ps->power);
 	debugfs_create_ulong("cost", 0444, d, &ps->cost);
+	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
 }
 
 static int em_debug_cpus_show(struct seq_file *s, void *unused)
@@ -162,6 +163,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].cost = div64_u64(fmax * power_res,
 					  table[i].frequency);
 		if (table[i].cost >= prev_cost) {
+			table[i].flags = EM_PERF_STATE_INEFFICIENT;
 			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
 				table[i].frequency);
 		} else {
-- 
2.7.4

