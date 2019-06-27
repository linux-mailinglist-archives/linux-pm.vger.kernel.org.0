Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B75881D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 19:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF0RQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 13:16:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfF0RQU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 13:16:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68290D6E;
        Thu, 27 Jun 2019 10:16:19 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12E4A3F718;
        Thu, 27 Jun 2019 10:16:17 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, quentin.perret@arm.com,
        douglas.raillard@arm.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com
Subject: [RFC PATCH v2 1/5] PM: Introduce em_pd_get_higher_freq()
Date:   Thu, 27 Jun 2019 18:15:59 +0100
Message-Id: <20190627171603.14767-2-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627171603.14767-1-douglas.raillard@arm.com>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

em_pd_get_higher_freq() returns a frequency greater or equal to the
provided one while taking into account a given cost margin. It also
skips inefficient OPPs that have a higher cost than another one with a
higher frequency.

The efficiency of an OPP is measured as efficiency=capacity/power.
OPPs with the same efficiency are assumed to be equivalent, since they
will consume as much energy for a given amount of work to do. That may
take more or less time depending on the frequency, but will consume the
same energy.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 include/linux/energy_model.h | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7bcb3e..cc9819967f8d 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -159,6 +159,53 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 	return pd->nr_cap_states;
 }
 
+#define EM_COST_MARGIN_SCALE 1024U
+
+/**
+ * em_pd_get_higher_freq() - Get the highest frequency that does not exceed the
+ * given cost margin compared to min_freq
+ * @pd		: performance domain for which this must be done
+ * @min_freq	: minimum frequency to return
+ * @cost_margin	: allowed margin compared to min_freq, on the
+ *		  EM_COST_MARGIN_SCALE scale.
+ *
+ * Return: the chosen frequency, guaranteed to be at least as high as min_freq.
+ */
+static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
+	unsigned long min_freq, unsigned long cost_margin)
+{
+	unsigned long max_cost = 0;
+	struct em_cap_state *cs;
+	int i;
+
+	if (!pd)
+		return min_freq;
+
+	/* Compute the maximum allowed cost */
+	for (i = 0; i < pd->nr_cap_states; i++) {
+		cs = &pd->table[i];
+		if (cs->frequency >= min_freq) {
+			max_cost = cs->cost +
+				(cs->cost * cost_margin) / EM_COST_MARGIN_SCALE;
+			break;
+		}
+	}
+
+	/* Find the highest frequency that will not exceed the cost margin */
+	for (i = pd->nr_cap_states-1; i >= 0; i--) {
+		cs = &pd->table[i];
+		if (cs->cost <= max_cost)
+			return cs->frequency;
+	}
+
+	/*
+	 * We should normally never reach here, unless min_freq was higher than
+	 * the highest available frequency, which is not expected to happen.
+	 */
+	return min_freq;
+}
+
+
 #else
 struct em_perf_domain {};
 struct em_data_callback {};
@@ -182,6 +229,12 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
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
2.22.0

