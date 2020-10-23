Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A63297272
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbgJWPgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:36:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52656 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbgJWPgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:36:49 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id d99488cc2732ed08; Fri, 23 Oct 2020 17:36:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 1/4] cpufreq: Introduce CPUFREQ_NEED_UPDATE_LIMITS driver flag
Date:   Fri, 23 Oct 2020 17:35:19 +0200
Message-ID: <1673796.UrKzctInAk@kreacher>
In-Reply-To: <2183878.gTFULuzKx9@kreacher>
References: <2183878.gTFULuzKx9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Generally, a cpufreq driver may need to update some internal upper
and lower frequency boundaries on policy max and min changes,
respectively, but currently this does not work if the target
frequency does not change along with the policy limit.

Namely, if the target frequency does not change along with the
policy min or max, the "target_freq == policy->cur" check in
__cpufreq_driver_target() prevents driver callbacks from being
invoked and they do not even have a chance to update the
corresponding internal boundary.

This particularly affects the "powersave" and "performance"
governors that always set the target frequency to one of the
policy limits and it never changes when the other limit is updated.

To allow cpufreq the drivers needing to update internal frequency
boundaries on policy limits changes to avoid this issue, introduce
a new driver flag, CPUFREQ_NEED_UPDATE_LIMITS, that (when set) will
neutralize the check mentioned above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/cpufreq/cpufreq.c |    3 ++-
 include/linux/cpufreq.h   |   10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -297,7 +297,7 @@ __ATTR(_name, 0644, show_##_name, store_
 
 struct cpufreq_driver {
 	char		name[CPUFREQ_NAME_LEN];
-	u8		flags;
+	u16		flags;
 	void		*driver_data;
 
 	/* needed by all drivers */
@@ -417,6 +417,14 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_IS_COOLING_DEV			BIT(7)
 
+/*
+ * Set by drivers that need to update internale upper and lower boundaries along
+ * with the target frequency and so the core and governors should also invoke
+ * the diver if the target frequency does not change, but the policy min or max
+ * may have changed.
+ */
+#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(8)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2191,7 +2191,8 @@ int __cpufreq_driver_target(struct cpufr
 	 * exactly same freq is called again and so we can save on few function
 	 * calls.
 	 */
-	if (target_freq == policy->cur)
+	if (target_freq == policy->cur &&
+	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
 		return 0;
 
 	if (cpufreq_driver->target)



