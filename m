Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F652AC190
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgKIQ5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 11:57:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61328 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbgKIQ5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 11:57:07 -0500
Received: from 89-64-87-89.dynamic.chello.pl (89.64.87.89) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 38f5c0c130c6c1e8; Mon, 9 Nov 2020 17:57:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2 3/4] cpufreq: Add strict_target to struct cpufreq_policy
Date:   Mon, 09 Nov 2020 17:53:53 +0100
Message-ID: <2826323.52ZM0ncLkd@kreacher>
In-Reply-To: <13269660.K2JYd4sGFX@kreacher>
References: <13269660.K2JYd4sGFX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new field to be set when the CPUFREQ_GOV_FLAG_STRICT_TARGET
flag is set for the current governor to struct cpufreq_policy, so
that the drivers needing to check CPUFREQ_GOV_FLAG_STRICT_TARGET do
not have to access the governor object during every frequency
transition.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 ++
 include/linux/cpufreq.h   |    6 ++++++
 2 files changed, 8 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2280,6 +2280,8 @@ static int cpufreq_init_governor(struct
 		}
 	}
 
+	policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_FLAG_STRICT_TARGET);
+
 	return 0;
 }
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -109,6 +109,12 @@ struct cpufreq_policy {
 	bool			fast_switch_enabled;
 
 	/*
+	 * Set if the CPUFREQ_GOV_FLAG_STRICT_TARGET flag is set for the
+	 * current governor.
+	 */
+	bool			strict_target;
+
+	/*
 	 * Preferred average time interval between consecutive invocations of
 	 * the driver to set the frequency for this policy.  To be set by the
 	 * scaling driver (0, which is the default, means no preference).



