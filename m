Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67A145AE4
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVRgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:36:11 -0500
Received: from foss.arm.com ([217.140.110.172]:58982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRgK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:36:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E65781007;
        Wed, 22 Jan 2020 09:36:09 -0800 (PST)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 978323F6C4;
        Wed, 22 Jan 2020 09:36:08 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     douglas.raillard@arm.com, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4 1/6] PM: Introduce em_pd_get_higher_freq()
Date:   Wed, 22 Jan 2020 17:35:33 +0000
Message-Id: <20200122173538.1142069-2-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

em_pd_get_higher_freq() returns a frequency greater or equal to the
provided one while taking into account a given cost margin. It also
skips inefficient OPPs that have a higher cost than another one with a
higher frequency (ordering OPPs by cost or efficiency leads to the same
result within a given CPU).

The efficiency of an OPP is measured as efficiency=capacity/power.  OPPs
with the same efficiency are assumed to be equivalent, since they will
consume as much energy for a given amount of work to do. That may take
more or less time depending on the frequency, but will consume the same
energy.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 include/linux/energy_model.h | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index d249b88a4d5a..8855e6892724 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -159,6 +159,56 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 	return pd->nr_cap_states;
 }
 
+#define EM_COST_MARGIN_SCALE 1024U
+
+/**
+ * em_pd_get_higher_freq() - Get the highest frequency that does not exceed the
+ * given cost margin compared to min_freq
+ * @pd		: performance domain for which this must be done
+ * @min_freq	: minimum frequency to return
+ * @cost_margin : allowed cost margin on the EM_COST_MARGIN_SCALE scale. The
+ * maximum value of the scale maps to the highest cost in that perf domain.
+ *
+ * Return: the chosen frequency, guaranteed to be at least as high as min_freq.
+ */
+static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
+	unsigned long min_freq, unsigned long cost_margin)
+{
+	unsigned long max_cost;
+	unsigned long max_allowed_cost = 0;
+	struct em_cap_state *cs;
+	int i;
+
+	if (!pd)
+		return min_freq;
+
+	max_cost = pd->table[pd->nr_cap_states - 1].cost;
+	cost_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;
+
+	/* Compute the maximum allowed cost */
+	for (i = 0; i < pd->nr_cap_states; i++) {
+		cs = &pd->table[i];
+		if (cs->frequency >= min_freq) {
+			max_allowed_cost = cs->cost + cost_margin;
+			break;
+		}
+	}
+
+	/* Find the highest frequency that will not exceed the cost margin */
+	for (i = pd->nr_cap_states-1; i >= 0; i--) {
+		cs = &pd->table[i];
+		if (cs->cost <= max_allowed_cost)
+			return cs->frequency;
+	}
+
+	/*
+	 * min_freq can be higher than the highest available frequency since
+	 * map_util_freq() will multiply the minimum frequency by some amount.
+	 * This can allow it to be higher than the maximum achievable frequency.
+	 */
+	return min_freq;
+}
+
 #else
 struct em_data_callback {};
 #define EM_DATA_CB(_active_power_cb) { }
@@ -181,6 +231,12 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 {
 	return 0;
 }
+
+static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
+	unsigned long min_freq, unsigned long cost_margin)
+{
+	return min_freq;
+}
 #endif
 
 #endif
-- 
2.24.1

