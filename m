Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5D2AC18B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 17:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgKIQ5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 11:57:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42276 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgKIQ5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 11:57:09 -0500
Received: from 89-64-87-89.dynamic.chello.pl (89.64.87.89) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id b29284a7e0268766; Mon, 9 Nov 2020 17:57:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2 1/4] cpufreq: Introduce governor flags
Date:   Mon, 09 Nov 2020 17:51:41 +0100
Message-ID: <1876249.M1ZxxmeKtZ@kreacher>
In-Reply-To: <13269660.K2JYd4sGFX@kreacher>
References: <13269660.K2JYd4sGFX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A new cpufreq governor flag will be added subsequently, so replace
the bool dynamic_switching fleid in struct cpufreq_governor with a
flags field and introduce CPUFREQ_GOV_FLAG_DYN_SWITCH to set for
the "dynamic switching" governors instead of it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c          |    2 +-
 drivers/cpufreq/cpufreq_governor.h |    2 +-
 include/linux/cpufreq.h            |    9 +++++++--
 kernel/sched/cpufreq_schedutil.c   |    2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2254,7 +2254,7 @@ static int cpufreq_init_governor(struct
 		return -EINVAL;
 
 	/* Platform doesn't want dynamic frequency switching ? */
-	if (policy->governor->dynamic_switching &&
+	if (policy->governor->flags & CPUFREQ_GOV_FLAG_DYN_SWITCH &&
 	    cpufreq_driver->flags & CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING) {
 		struct cpufreq_governor *gov = cpufreq_fallback_governor();
 
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -156,7 +156,7 @@ void cpufreq_dbs_governor_limits(struct
 #define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)			\
 	{								\
 		.name = _name_,						\
-		.dynamic_switching = true,				\
+		.flags = CPUFREQ_GOV_FLAG_DYN_SWITCH,			\
 		.owner = THIS_MODULE,					\
 		.init = cpufreq_dbs_governor_init,			\
 		.exit = cpufreq_dbs_governor_exit,			\
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -565,12 +565,17 @@ struct cpufreq_governor {
 					 char *buf);
 	int	(*store_setspeed)	(struct cpufreq_policy *policy,
 					 unsigned int freq);
-	/* For governors which change frequency dynamically by themselves */
-	bool			dynamic_switching;
 	struct list_head	governor_list;
 	struct module		*owner;
+	u8			flags;
 };
 
+/* Governor flags */
+
+/* For governors which change frequency dynamically by themselves */
+#define CPUFREQ_GOV_FLAG_DYN_SWITCH	BIT(0)
+
+
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -881,7 +881,7 @@ static void sugov_limits(struct cpufreq_
 struct cpufreq_governor schedutil_gov = {
 	.name			= "schedutil",
 	.owner			= THIS_MODULE,
-	.dynamic_switching	= true,
+	.flags			= CPUFREQ_GOV_FLAG_DYN_SWITCH,
 	.init			= sugov_init,
 	.exit			= sugov_exit,
 	.start			= sugov_start,



