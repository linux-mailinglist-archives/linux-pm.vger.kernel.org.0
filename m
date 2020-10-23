Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B694629726D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbgJWPgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:36:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63900 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbgJWPgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:36:47 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id f97b26b3a52a1870; Fri, 23 Oct 2020 17:36:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 3/4] cpufreq: Introduce cpufreq_driver_test_flags()
Date:   Fri, 23 Oct 2020 17:35:46 +0200
Message-ID: <28638601.XPu5T7AxD8@kreacher>
In-Reply-To: <2183878.gTFULuzKx9@kreacher>
References: <2183878.gTFULuzKx9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a helper function to test the flags of the cpufreq driver in use
againt a given flags mask.

In particular, this will be needed to test the
CPUFREQ_NEED_UPDATE_LIMITS cpufreq driver flag in the schedutil
governor.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/cpufreq/cpufreq.c |   12 ++++++++++++
 include/linux/cpufreq.h   |    1 +
 2 files changed, 13 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1909,6 +1909,18 @@ void cpufreq_resume(void)
 }
 
 /**
+ * cpufreq_driver_test_flags - Test cpufreq driver's flags against given ones.
+ * @flags: Flags to test against the current cpufreq driver's flags.
+ *
+ * Assumes that the driver is there, so callers must ensure that this is the
+ * case.
+ */
+bool cpufreq_driver_test_flags(u16 flags)
+{
+	return !!(cpufreq_driver->flags & flags);
+}
+
+/**
  *	cpufreq_get_current_driver - return current driver's name
  *
  *	Return the name string of the currently loaded cpufreq driver
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -428,6 +428,7 @@ struct cpufreq_driver {
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
+bool cpufreq_driver_test_flags(u16 flags);
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 



