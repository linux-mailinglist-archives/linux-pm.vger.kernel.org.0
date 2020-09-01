Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5A259D5C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgIARjz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 13:39:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59386 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgIARjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 13:39:54 -0400
Received: from 89-64-88-247.dynamic.chello.pl (89.64.88.247) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 4763ca42f0cd1aa2; Tue, 1 Sep 2020 19:39:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v4 3/5] cpufreq: intel_pstate: Tweak the EPP sysfs interface
Date:   Tue, 01 Sep 2020 19:29:55 +0200
Message-ID: <5280698.oOqPgdve7T@kreacher>
In-Reply-To: <3748218.V0HrpZKF9g@kreacher>
References: <3748218.V0HrpZKF9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Modify the EPP sysfs interface to reject attempts to change the EPP
to values different from 0 ("performance") in the active mode with
the "performance" policy (ie. scaling_governor set to "performance"),
to avoid situations in which the kernel appears to discard data
passed to it via the EPP sysfs attribute.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

v2 -> v3: New patch

v3 -> v4: Add the R-by from Artem

---
 Documentation/admin-guide/pm/intel_pstate.rst | 4 +++-
 drivers/cpufreq/intel_pstate.c                | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index cdd1a9a7f9a2..5072e7064d13 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -123,7 +123,9 @@ Energy-Performance Bias (EPB) knob (otherwise), which means that the processor's
 internal P-state selection logic is expected to focus entirely on performance.
 
 This will override the EPP/EPB setting coming from the ``sysfs`` interface
-(see `Energy vs Performance Hints`_ below).
+(see `Energy vs Performance Hints`_ below).  Moreover, any attempts to change
+the EPP/EPB to a value different from 0 ("performance") via ``sysfs`` in this
+configuration will be rejected.
 
 Also, in this configuration the range of P-states available to the processor's
 internal P-state selection logic is always restricted to the upper boundary
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e540448e0bd0..b308c39b6204 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -684,6 +684,14 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 		else if (epp == -EINVAL)
 			epp = epp_values[pref_index - 1];
 
+		/*
+		 * To avoid confusion, refuse to set EPP to any values different
+		 * from 0 (performance) if the current policy is "performance",
+		 * because those values would be overridden.
+		 */
+		if (epp > 0 && cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
+			return -EBUSY;
+
 		ret = intel_pstate_set_epp(cpu_data, epp);
 	} else {
 		if (epp == -EINVAL)
-- 
2.26.2




