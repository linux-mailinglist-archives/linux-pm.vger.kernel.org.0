Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2273C2ADCE5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJR2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:28:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64472 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJR2W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 12:28:22 -0500
Received: from 89-64-88-129.dynamic.chello.pl (89.64.88.129) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id a3535b29aed76d2e; Tue, 10 Nov 2020 18:28:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v3 2/4] cpufreq: Introduce CPUFREQ_GOV_STRICT_TARGET
Date:   Tue, 10 Nov 2020 18:26:10 +0100
Message-ID: <11987196.RHpQgyFsab@kreacher>
In-Reply-To: <11312387.r5AVKgp8zO@kreacher>
References: <13269660.K2JYd4sGFX@kreacher> <11312387.r5AVKgp8zO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new governor flag, CPUFREQ_GOV_STRICT_TARGET, for the
governors that want the target frequency to be set exactly to the
given value without leaving any room for adjustments on the hardware
side and set this flag for the powersave and performance governors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_performance.c |    1 +
 drivers/cpufreq/cpufreq_powersave.c   |    1 +
 include/linux/cpufreq.h               |    3 +++
 3 files changed, 5 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
+++ linux-pm/drivers/cpufreq/cpufreq_performance.c
@@ -20,6 +20,7 @@ static void cpufreq_gov_performance_limi
 static struct cpufreq_governor cpufreq_gov_performance = {
 	.name		= "performance",
 	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_GOV_STRICT_TARGET,
 	.limits		= cpufreq_gov_performance_limits,
 };
 
Index: linux-pm/drivers/cpufreq/cpufreq_powersave.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_powersave.c
+++ linux-pm/drivers/cpufreq/cpufreq_powersave.c
@@ -21,6 +21,7 @@ static struct cpufreq_governor cpufreq_g
 	.name		= "powersave",
 	.limits		= cpufreq_gov_powersave_limits,
 	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_GOV_STRICT_TARGET,
 };
 
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -575,6 +575,9 @@ struct cpufreq_governor {
 /* For governors which change frequency dynamically by themselves */
 #define CPUFREQ_GOV_DYNAMIC_SWITCHING	BIT(0)
 
+/* For governors wanting the target frequency to be set exactly */
+#define CPUFREQ_GOV_STRICT_TARGET	BIT(1)
+
 
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,



