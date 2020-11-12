Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1721B2B0DF6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKLTZT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 14:25:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:65090 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgKLTZS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 14:25:18 -0500
Received: from 89-64-87-233.dynamic.chello.pl (89.64.87.233) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id e8aaa7f4f64da90c; Thu, 12 Nov 2020 20:25:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: intel_pstate: Simplify intel_cpufreq_update_pstate()
Date:   Thu, 12 Nov 2020 20:25:15 +0100
Message-ID: <1628789.U0t87mjxhl@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Avoid doing the same assignment in both branches of a conditional,
do it after the whole conditional instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2569,14 +2569,13 @@ static int intel_cpufreq_update_pstate(s
 	int old_pstate = cpu->pstate.current_pstate;
 
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
-	if (hwp_active) {
+	if (hwp_active)
 		intel_cpufreq_adjust_hwp(cpu, target_pstate,
 					 policy->strict_target, fast_switch);
-		cpu->pstate.current_pstate = target_pstate;
-	} else if (target_pstate != old_pstate) {
+	else if (target_pstate != old_pstate)
 		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
-		cpu->pstate.current_pstate = target_pstate;
-	}
+
+	cpu->pstate.current_pstate = target_pstate;
 
 	intel_cpufreq_trace(cpu, fast_switch ? INTEL_PSTATE_TRACE_FAST_SWITCH :
 			    INTEL_PSTATE_TRACE_TARGET, old_pstate);



