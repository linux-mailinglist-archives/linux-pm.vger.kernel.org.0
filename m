Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA432A8613
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgKESZX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:25:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44024 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKESZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:25:22 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id eb3d0aa0ebe85b20; Thu, 5 Nov 2020 19:25:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] cpufreq: Introduce target min and max frequency hints
Date:   Thu, 05 Nov 2020 19:23:34 +0100
Message-ID: <2233690.N3OVLkotou@kreacher>
In-Reply-To: <7417968.Ghue05m4RV@kreacher>
References: <7417968.Ghue05m4RV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some cpufreq drivers, like intel_pstate (in the passive mode with
HWP enabled) or the CPPC driver, take the "target frequency" coming
from the governor as a hint to pass to the hardware rather than the
exact value to apply.  Then, the hardware may choose to run at
whatever performance point it regards as appropriate, given the
hint and some other data available to it.

Of course, the performance point chosen by the hardware should
stay within the policy min and max limits, but in some cases it may
be necessary to request the hardware to limit the range of
performance points to consider beyond that.

For example, if the powersave governor is in use, it attempts to
make the hardware run at the policy min frequency, but that may
not actually work if the hardware thinks that it has a reason to
run faster and the policy max limit is above the policy min.

In those cases, it is useful to pass additional information to the
driver to indicate that it should tell the hardware to consider a
narrower range of performance points, so add two new fields,
target_min and target_max, to struct cpufreq_policy for this purpose
and make the powersave and performance governors set them to indicate
that the CPU is expected to run exactly at the given frequency (the
policy min or max, respectively).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c             |    3 +++
 drivers/cpufreq/cpufreq_performance.c |    4 ++++
 drivers/cpufreq/cpufreq_powersave.c   |    4 ++++
 include/linux/cpufreq.h               |   16 ++++++++++++++++
 4 files changed, 27 insertions(+)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -63,6 +63,8 @@ struct cpufreq_policy {
 
 	unsigned int		min;    /* in kHz */
 	unsigned int		max;    /* in kHz */
+	unsigned int		target_min; /* in kHz */
+	unsigned int		target_max; /* in kHz */
 	unsigned int		cur;    /* in kHz, only needed if cpufreq
 					 * governors are used */
 	unsigned int		suspend_freq; /* freq to set during suspend */
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2272,6 +2272,9 @@ static int cpufreq_init_governor(struct
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
+	policy->target_min = policy->cpuinfo.min_freq;
+	policy->target_max = policy->cpuinfo.max_freq;
+
 	if (policy->governor->init) {
 		ret = policy->governor->init(policy);
 		if (ret) {
Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
+++ linux-pm/drivers/cpufreq/cpufreq_performance.c
@@ -14,6 +14,10 @@
 static void cpufreq_gov_performance_limits(struct cpufreq_policy *policy)
 {
 	pr_debug("setting to %u kHz\n", policy->max);
+
+	policy->target_min = policy->max;
+	policy->target_max = policy->max;
+
 	__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
 }
 
Index: linux-pm/drivers/cpufreq/cpufreq_powersave.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_powersave.c
+++ linux-pm/drivers/cpufreq/cpufreq_powersave.c
@@ -14,6 +14,10 @@
 static void cpufreq_gov_powersave_limits(struct cpufreq_policy *policy)
 {
 	pr_debug("setting to %u kHz\n", policy->min);
+
+	policy->target_min = policy->min;
+	policy->target_max = policy->min;
+
 	__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
 }
 



