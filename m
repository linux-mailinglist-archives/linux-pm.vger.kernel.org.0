Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003E517F3E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfEHRnO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 13:43:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHRnO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9045215AD;
        Wed,  8 May 2019 10:43:13 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 166C03F575;
        Wed,  8 May 2019 10:43:11 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 3/7] sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
Date:   Wed,  8 May 2019 18:42:57 +0100
Message-Id: <20190508174301.4828-4-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Choose the highest OPP for a given energy cost, allowing to skip lower
frequencies that would not be cheaper in terms of consumed power. These
frequencies can still be interesting to keep in the energy model to give
more freedom to thermal throttling, but should not be selected under
normal circumstances.

This also prepares the ground for energy-aware frequency boosting.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 82dbacf83649..f4173a7c0f01 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -200,9 +201,19 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
+	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
+
+	/* Maximum power we are ready to spend. */
+	unsigned int cost_margin = 0;
 
 	freq = map_util_freq(util, freq, max);
 
+	/*
+	 * Try to get a higher frequency if one is available, given the extra
+	 * power we are ready to spend.
+	 */
+	freq = em_pd_get_higher_freq(pd, freq, cost_margin);
+
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-- 
2.21.0

