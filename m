Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F9284B43
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJFMBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:01:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47766 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgJFMBe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:01:34 -0400
Received: from 89-64-87-80.dynamic.chello.pl (89.64.87.80) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.489)
 id 1d3ccde0236c9eb8; Tue, 6 Oct 2020 14:01:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: schedutil: Simplify sugov_fast_switch()
Date:   Tue, 06 Oct 2020 14:01:31 +0200
Message-ID: <1869109.WhRmcVd4D2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop a redundant local variable definition from sugov_fast_switch()
and rearrange the code in there to avoid the redundant logical
negation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The code reads a bit easier after this change IMV.

linux-next material.

---
 kernel/sched/cpufreq_schedutil.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -114,12 +114,8 @@ static bool sugov_update_next_freq(struc
 static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 			      unsigned int next_freq)
 {
-	struct cpufreq_policy *policy = sg_policy->policy;
-
-	if (!sugov_update_next_freq(sg_policy, time, next_freq))
-		return;
-
-	cpufreq_driver_fast_switch(policy, next_freq);
+	if (sugov_update_next_freq(sg_policy, time, next_freq))
+		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
 }
 
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,



