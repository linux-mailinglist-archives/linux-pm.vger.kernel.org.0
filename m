Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0069D41AC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfJKNpl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 09:45:41 -0400
Received: from foss.arm.com ([217.140.110.172]:60910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfJKNpk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 09:45:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1721570;
        Fri, 11 Oct 2019 06:45:39 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 051BE3F68E;
        Fri, 11 Oct 2019 06:45:37 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, douglas.raillard@arm.com,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: [RFC PATCH v3 3/6] sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
Date:   Fri, 11 Oct 2019 14:44:57 +0100
Message-Id: <20191011134500.235736-4-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011134500.235736-1-douglas.raillard@arm.com>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Choose the highest OPP for a given energy cost, allowing to skip lower
frequencies that would not be cheaper in terms of consumed power. These
frequencies can still be interesting to keep in the energy model to give
more freedom to thermal throttling, but should not be selected under
normal circumstances.

This also prepares the ground for energy-aware frequency boosting.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9abda58827c0..aab8c0498dd1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -208,9 +209,16 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
+	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
 
 	freq = map_util_freq(util, freq, max);
 
+	/*
+	 * Try to get a higher frequency if one is available, given the extra
+	 * power we are ready to spend.
+	 */
+	freq = em_pd_get_higher_freq(pd, freq, 0);
+
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-- 
2.23.0

