Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4A2B0E01
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKLT0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 14:26:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53402 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKLT0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 14:26:45 -0500
Received: from 89-64-87-233.dynamic.chello.pl (89.64.87.233) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 1f8f3d0442f51a48; Thu, 12 Nov 2020 20:26:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: schedutil: Simplify sugov_update_next_freq()
Date:   Thu, 12 Nov 2020 20:26:42 +0100
Message-ID: <25503091.Kiabxektef@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rearrange a conditional to make it more straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -102,12 +102,10 @@ static bool sugov_should_update_freq(str
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (!sg_policy->need_freq_update) {
-		if (sg_policy->next_freq == next_freq)
-			return false;
-	} else {
+	if (sg_policy->need_freq_update)
 		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
-	}
+	else if (sg_policy->next_freq == next_freq)
+		return false;
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;



