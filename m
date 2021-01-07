Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2608C2ED6EA
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 19:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbhAGSpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 13:45:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53232 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbhAGSpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 13:45:14 -0500
Received: from 89-64-81-64.dynamic.chello.pl (89.64.81.64) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id c4c52b1d753055a3; Thu, 7 Jan 2021 19:44:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v1 1/3] cpufreq: intel_pstate: Always read hwp_cap_cached with READ_ONCE()
Date:   Thu, 07 Jan 2021 19:42:15 +0100
Message-ID: <1993550.StjdRojnlU@kreacher>
In-Reply-To: <5701645.lOV4Wx5bFT@kreacher>
References: <5701645.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because intel_pstate_get_hwp_max() which updates hwp_cap_cached
may run in parallel with the readers of it, annotate all of the
read accesses to it with READ_ONCE().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -914,7 +914,7 @@ static void intel_pstate_hwp_offline(str
 	}
 
 	value &= ~GENMASK_ULL(31, 0);
-	min_perf = HWP_LOWEST_PERF(cpu->hwp_cap_cached);
+	min_perf = HWP_LOWEST_PERF(READ_ONCE(cpu->hwp_cap_cached));
 
 	/* Set hwp_max = hwp_min */
 	value |= HWP_MAX_PERF(min_perf);
@@ -1750,6 +1750,7 @@ static int hwp_boost_hold_time_ns = 3 *
 static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
 {
 	u64 hwp_req = READ_ONCE(cpu->hwp_req_cached);
+	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
 	u32 max_limit = (hwp_req & 0xff00) >> 8;
 	u32 min_limit = (hwp_req & 0xff);
 	u32 boost_level1;
@@ -1776,14 +1777,14 @@ static inline void intel_pstate_hwp_boos
 		cpu->hwp_boost_min = min_limit;
 
 	/* level at half way mark between min and guranteed */
-	boost_level1 = (HWP_GUARANTEED_PERF(cpu->hwp_cap_cached) + min_limit) >> 1;
+	boost_level1 = (HWP_GUARANTEED_PERF(hwp_cap) + min_limit) >> 1;
 
 	if (cpu->hwp_boost_min < boost_level1)
 		cpu->hwp_boost_min = boost_level1;
-	else if (cpu->hwp_boost_min < HWP_GUARANTEED_PERF(cpu->hwp_cap_cached))
-		cpu->hwp_boost_min = HWP_GUARANTEED_PERF(cpu->hwp_cap_cached);
-	else if (cpu->hwp_boost_min == HWP_GUARANTEED_PERF(cpu->hwp_cap_cached) &&
-		 max_limit != HWP_GUARANTEED_PERF(cpu->hwp_cap_cached))
+	else if (cpu->hwp_boost_min < HWP_GUARANTEED_PERF(hwp_cap))
+		cpu->hwp_boost_min = HWP_GUARANTEED_PERF(hwp_cap);
+	else if (cpu->hwp_boost_min == HWP_GUARANTEED_PERF(hwp_cap) &&
+		 max_limit != HWP_GUARANTEED_PERF(hwp_cap))
 		cpu->hwp_boost_min = max_limit;
 	else
 		return;



