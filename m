Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22C295DD6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897702AbgJVL5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:57:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52126 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897699AbgJVL5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:57:54 -0400
Received: from 89-64-87-167.dynamic.chello.pl (89.64.87.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 18c6cd3a29713389; Thu, 22 Oct 2020 13:57:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] cpufreq: Drop restore_freq from struct cpufreq_policy
Date:   Thu, 22 Oct 2020 13:57:45 +0200
Message-ID: <3286881.tlMdjJ8CK2@kreacher>
In-Reply-To: <1666263.spd1I39WAV@kreacher>
References: <1666263.spd1I39WAV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The restore_freq field in struct cpufreq_policy is only used by
__target_index() in one place and a local variable in that function
may as well be used instead of it, so drop it and modify
__target_index() accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   10 +++++-----
 include/linux/cpufreq.h   |    5 -----
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2112,7 +2112,7 @@ static int __target_intermediate(struct
 static int __target_index(struct cpufreq_policy *policy, int index)
 {
 	struct cpufreq_freqs freqs = {.old = policy->cur, .flags = 0};
-	unsigned int intermediate_freq = 0;
+	unsigned int restore_freq, intermediate_freq = 0;
 	unsigned int newfreq = policy->freq_table[index].frequency;
 	int retval = -EINVAL;
 	bool notify;
@@ -2120,6 +2120,9 @@ static int __target_index(struct cpufreq
 	if (newfreq == policy->cur)
 		return 0;
 
+	/* Save last value to restore later on errors */
+	restore_freq = policy->cur;
+
 	notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
 	if (notify) {
 		/* Handle switching to intermediate frequency */
@@ -2157,7 +2160,7 @@ static int __target_index(struct cpufreq
 		 */
 		if (unlikely(retval && intermediate_freq)) {
 			freqs.old = intermediate_freq;
-			freqs.new = policy->restore_freq;
+			freqs.new = restore_freq;
 			cpufreq_freq_transition_begin(policy, &freqs);
 			cpufreq_freq_transition_end(policy, &freqs, 0);
 		}
@@ -2194,9 +2197,6 @@ int __cpufreq_driver_target(struct cpufr
 	if (target_freq == policy->cur)
 		return 0;
 
-	/* Save last value to restore later on errors */
-	policy->restore_freq = policy->cur;
-
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -65,7 +65,6 @@ struct cpufreq_policy {
 	unsigned int		max;    /* in kHz */
 	unsigned int		cur;    /* in kHz, only needed if cpufreq
 					 * governors are used */
-	unsigned int		restore_freq; /* = policy->cur before transition */
 	unsigned int		suspend_freq; /* freq to set during suspend */
 
 	unsigned int		policy; /* see above */
@@ -308,10 +307,6 @@ struct cpufreq_driver {
 	/* define one out of two */
 	int		(*setpolicy)(struct cpufreq_policy *policy);
 
-	/*
-	 * On failure, should always restore frequency to policy->restore_freq
-	 * (i.e. old freq).
-	 */
 	int		(*target)(struct cpufreq_policy *policy,
 				  unsigned int target_freq,
 				  unsigned int relation);	/* Deprecated */



