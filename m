Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01B2B8454
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgKRTCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 14:02:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50702 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRTCp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 14:02:45 -0500
Received: from 89-64-89-10.dynamic.chello.pl (89.64.89.10) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 589eb52260f9054a; Wed, 18 Nov 2020 20:02:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Fix up several kerneldoc comments
Date:   Wed, 18 Nov 2020 20:02:42 +0100
Message-ID: <1739462.uCgn0Xls2p@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix up the remaining kerneldoc comments that don't adhere to the
expected format and clarify some of them a bit.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   72 +++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -298,8 +298,10 @@ struct cpufreq_policy *cpufreq_cpu_acqui
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
 
-/*
- * adjust_jiffies - adjust the system "loops_per_jiffy"
+/**
+ * adjust_jiffies - Adjust the system "loops_per_jiffy".
+ * @val: CPUFREQ_PRECHANGE or CPUFREQ_POSTCHANGE.
+ * @ci: Frequency change information.
  *
  * This function alters the system "loops_per_jiffy" for the clock
  * speed change. Note that loops_per_jiffy cannot be updated on SMP
@@ -331,14 +333,14 @@ static void adjust_jiffies(unsigned long
 }
 
 /**
- * cpufreq_notify_transition - Notify frequency transition and adjust_jiffies.
+ * cpufreq_notify_transition - Notify frequency transition and adjust jiffies.
  * @policy: cpufreq policy to enable fast frequency switching for.
  * @freqs: contain details of the frequency update.
  * @state: set to CPUFREQ_PRECHANGE or CPUFREQ_POSTCHANGE.
  *
- * This function calls the transition notifiers and the "adjust_jiffies"
- * function. It is called twice on all CPU frequency changes that have
- * external effects.
+ * This function calls the transition notifiers and adjust_jiffies().
+ *
+ * It is called twice on all CPU frequency changes that have external effects.
  */
 static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 				      struct cpufreq_freqs *freqs,
@@ -1646,13 +1648,12 @@ static void cpufreq_remove_dev(struct de
 }
 
 /**
- *	cpufreq_out_of_sync - If actual and saved CPU frequency differs, we're
- *	in deep trouble.
- *	@policy: policy managing CPUs
- *	@new_freq: CPU frequency the CPU actually runs at
+ * cpufreq_out_of_sync - Fix up actual and saved CPU frequency difference.
+ * @policy: Policy managing CPUs.
+ * @new_freq: New CPU frequency.
  *
- *	We adjust to current frequency first, and need to clean up later.
- *	So either call to cpufreq_update_policy() or schedule handle_update()).
+ * Adjust to the current frequency first and clean up later by either calling
+ * cpufreq_update_policy(), or scheduling handle_update().
  */
 static void cpufreq_out_of_sync(struct cpufreq_policy *policy,
 				unsigned int new_freq)
@@ -1832,7 +1833,7 @@ int cpufreq_generic_suspend(struct cpufr
 EXPORT_SYMBOL(cpufreq_generic_suspend);
 
 /**
- * cpufreq_suspend() - Suspend CPUFreq governors
+ * cpufreq_suspend() - Suspend CPUFreq governors.
  *
  * Called during system wide Suspend/Hibernate cycles for suspending governors
  * as some platforms can't change frequency after this point in suspend cycle.
@@ -1868,7 +1869,7 @@ suspend:
 }
 
 /**
- * cpufreq_resume() - Resume CPUFreq governors
+ * cpufreq_resume() - Resume CPUFreq governors.
  *
  * Called during system wide Suspend/Hibernate cycle for resuming governors that
  * are suspended with cpufreq_suspend().
@@ -1920,10 +1921,10 @@ bool cpufreq_driver_test_flags(u16 flags
 }
 
 /**
- *	cpufreq_get_current_driver - return current driver's name
+ * cpufreq_get_current_driver - Return the current driver's name.
  *
- *	Return the name string of the currently loaded cpufreq driver
- *	or NULL, if none.
+ * Return the name string of the currently registered cpufreq driver or NULL if
+ * none.
  */
 const char *cpufreq_get_current_driver(void)
 {
@@ -1935,10 +1936,10 @@ const char *cpufreq_get_current_driver(v
 EXPORT_SYMBOL_GPL(cpufreq_get_current_driver);
 
 /**
- *	cpufreq_get_driver_data - return current driver data
+ * cpufreq_get_driver_data - Return current driver data.
  *
- *	Return the private data of the currently loaded cpufreq
- *	driver, or NULL if no cpufreq driver is loaded.
+ * Return the private data of the currently registered cpufreq driver, or NULL
+ * if no cpufreq driver has been registered.
  */
 void *cpufreq_get_driver_data(void)
 {
@@ -1954,17 +1955,16 @@ EXPORT_SYMBOL_GPL(cpufreq_get_driver_dat
  *********************************************************************/
 
 /**
- *	cpufreq_register_notifier - register a driver with cpufreq
- *	@nb: notifier function to register
- *      @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER
- *
- *	Add a driver to one of two lists: either a list of drivers that
- *      are notified about clock rate changes (once before and once after
- *      the transition), or a list of drivers that are notified about
- *      changes in cpufreq policy.
+ * cpufreq_register_notifier - Register a notifier with cpufreq.
+ * @nb: notifier function to register.
+ * @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER.
+ *
+ * Add a notifier to one of two lists: either a list of notifiers that run on
+ * clock rate changes (once before and once after every transition), or a list
+ * of notifiers that ron on cpufreq policy changes.
  *
- *	This function may sleep, and has the same return conditions as
- *	blocking_notifier_chain_register.
+ * This function may sleep and it has the same return values as
+ * blocking_notifier_chain_register().
  */
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
 {
@@ -2001,14 +2001,14 @@ int cpufreq_register_notifier(struct not
 EXPORT_SYMBOL(cpufreq_register_notifier);
 
 /**
- *	cpufreq_unregister_notifier - unregister a driver with cpufreq
- *	@nb: notifier block to be unregistered
- *	@list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER
+ * cpufreq_unregister_notifier - Unregister a notifier from cpufreq.
+ * @nb: notifier block to be unregistered.
+ * @list: CPUFREQ_TRANSITION_NOTIFIER or CPUFREQ_POLICY_NOTIFIER.
  *
- *	Remove a driver from the CPU frequency notifier list.
+ * Remove a notifier from one of the cpufreq notifier lists.
  *
- *	This function may sleep, and has the same return conditions as
- *	blocking_notifier_chain_unregister.
+ * This function may sleep and it has the same return values as
+ * blocking_notifier_chain_unregister().
  */
 int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 {



