Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A572ADCE1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgKJR2U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:28:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51620 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbgKJR2U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 12:28:20 -0500
Received: from 89-64-88-129.dynamic.chello.pl (89.64.88.129) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 6021c75f9d64ef1b; Tue, 10 Nov 2020 18:28:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v3 3/4] cpufreq: Add strict_target to struct cpufreq_policy
Date:   Tue, 10 Nov 2020 18:26:37 +0100
Message-ID: <17647050.Bfk6z5ThJy@kreacher>
In-Reply-To: <11312387.r5AVKgp8zO@kreacher>
References: <13269660.K2JYd4sGFX@kreacher> <11312387.r5AVKgp8zO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new field to be set when the CPUFREQ_GOV_STRICT_TARGET flag is
set for the current governor to struct cpufreq_policy, so that the
drivers needing to check CPUFREQ_GOV_STRICT_TARGET do not have to
access the governor object during every frequency transition.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
 
+	policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_STRICT_TARGET);
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
+	 * Set if the CPUFREQ_GOV_STRICT_TARGET flag is set for the current
+	 * governor.
+	 */
+	bool			strict_target;
+
+	/*
 	 * Preferred average time interval between consecutive invocations of
 	 * the driver to set the frequency for this policy.  To be set by the
 	 * scaling driver (0, which is the default, means no preference).



