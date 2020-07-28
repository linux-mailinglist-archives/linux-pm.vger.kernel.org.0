Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0723108C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgG1RJf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 13:09:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51838 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbgG1RJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 13:09:35 -0400
Received: from 89-64-88-69.dynamic.chello.pl (89.64.88.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 834f0adb485bc348; Tue, 28 Jul 2020 19:09:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Francisco Jerez <currojerez@riseup.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active mode
Date:   Tue, 28 Jul 2020 19:09:32 +0200
Message-ID: <11585512.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because intel_pstate_set_energy_pref_index() reads and writes the
MSR_HWP_REQUEST register without using the cached value of it used by
intel_pstate_hwp_boost_up() and intel_pstate_hwp_boost_down(), those
functions may overwrite the value written by it and so the EPP value
set via sysfs may be lost.

To avoid that, make intel_pstate_set_energy_pref_index() take the
cached value of MSR_HWP_REQUEST just like the other two routines
mentioned above and update it with the new EPP value coming from
user space in addition to updating the MSR.

Note that the MSR itself still needs to be updated too in case
hwp_boost is unset or the boosting mechanism is not active at the
EPP change time.

Fixes: e0efd5be63e8 ("cpufreq: intel_pstate: Add HWP boost utility and sched util hooks")
Reported-by: Francisco Jerez <currojerez@riseup.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is on top of https://patchwork.kernel.org/patch/11689347/

---
 drivers/cpufreq/intel_pstate.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -653,11 +653,12 @@ static int intel_pstate_set_energy_pref_
 		epp = cpu_data->epp_default;
 
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
-		u64 value;
-
-		ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
-		if (ret)
-			return ret;
+		/*
+		 * Use the cached HWP Request MSR value, because the register
+		 * itself may be updated by intel_pstate_hwp_boost_up() or
+		 * intel_pstate_hwp_boost_down() at any time.
+		 */
+		u64 value = READ_ONCE(cpu_data->hwp_req_cached);
 
 		value &= ~GENMASK_ULL(31, 24);
 
@@ -667,6 +668,12 @@ static int intel_pstate_set_energy_pref_
 			epp = epp_values[pref_index - 1];
 
 		value |= (u64)epp << 24;
+		/*
+		 * The only other updater of hwp_req_cached in the active mode,
+		 * intel_pstate_hwp_set(), is called under the same lock as this
+		 * function, so it cannot run in parallel with the update below.
+		 */
+		WRITE_ONCE(cpu_data->hwp_req_cached, value);
 		ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
 	} else {
 		if (epp == -EINVAL)



