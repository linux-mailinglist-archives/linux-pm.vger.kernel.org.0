Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A837B17B207
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 00:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 18:05:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55902 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEXFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 18:05:37 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a1f513d29558e684; Fri, 6 Mar 2020 00:05:35 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Consolidate policy verification
Date:   Fri, 06 Mar 2020 00:05:34 +0100
Message-ID: <226215910.rrICADBzDZ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is still some code duplication between intel_pstate_verify_policy()
and intel_cpufreq_verify_policy(), so avoid it by moving the common
code into a separate function and calling it from both these places.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2155,15 +2155,19 @@ static void intel_pstate_adjust_policy_m
 	}
 }
 
-static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
+static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
+					   struct cpufreq_policy_data *policy)
 {
-	struct cpudata *cpu = all_cpu_data[policy->cpu];
-
 	update_turbo_state();
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     intel_pstate_get_max_freq(cpu));
 
 	intel_pstate_adjust_policy_max(cpu, policy);
+}
+
+static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
+{
+	intel_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
 
 	return 0;
 }
@@ -2268,12 +2272,7 @@ static int intel_cpufreq_verify_policy(s
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
-	update_turbo_state();
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     intel_pstate_get_max_freq(cpu));
-
-	intel_pstate_adjust_policy_max(cpu, policy);
-
+	intel_pstate_verify_cpu_policy(cpu, policy);
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	return 0;



