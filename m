Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BEB145AED
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAVRgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:36:18 -0500
Received: from foss.arm.com ([217.140.110.172]:59018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRgQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:36:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B934113E;
        Wed, 22 Jan 2020 09:36:15 -0800 (PST)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CE5B3F6C4;
        Wed, 22 Jan 2020 09:36:14 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     douglas.raillard@arm.com, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
Date:   Wed, 22 Jan 2020 17:35:35 +0000
Message-Id: <20200122173538.1142069-4-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
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
index 09e284dc918a..608963da4916 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -210,9 +211,16 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
2.24.1

