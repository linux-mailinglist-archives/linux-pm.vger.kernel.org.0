Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FDC2D169A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 17:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLGQkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 11:40:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43374 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgLGQkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 11:40:32 -0500
Received: from 89-64-79-106.dynamic.chello.pl (89.64.79.106) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id f644db2eefb3634f; Mon, 7 Dec 2020 17:39:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [PATCH v1 2/4] cpufreq: schedutil: Adjust utilization instead of frequency
Date:   Mon, 07 Dec 2020 17:29:47 +0100
Message-ID: <1916732.tSaCp9PeQq@kreacher>
In-Reply-To: <20360841.iInq7taT2Z@kreacher>
References: <20360841.iInq7taT2Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When avoiding reduction of the frequency after the target CPU has
been busy since the previous frequency update, adjust the utilization
instead of adjusting the frequency, because doing so is more prudent
(it is done to counter a possible utilization deficit after all) and
it will allow some code to be shared after a subsequent change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -437,7 +437,7 @@ static void sugov_update_single(struct u
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	unsigned int cached_freq = sg_policy->cached_raw_freq;
+	unsigned long prev_util = sg_cpu->util;
 	unsigned int next_f;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
@@ -451,17 +451,14 @@ static void sugov_update_single(struct u
 	sugov_get_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time);
 
-	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
 	 */
-	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
-		next_f = sg_policy->next_freq;
+	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+		sg_cpu->util = prev_util;
 
-		/* Restore cached freq as next_freq has changed */
-		sg_policy->cached_raw_freq = cached_freq;
-	}
+	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
 
 	/*
 	 * This code runs under rq->lock for the target CPU, so it won't run



