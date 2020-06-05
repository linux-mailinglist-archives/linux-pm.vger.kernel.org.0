Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3791F0033
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 21:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgFETE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 15:04:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:12924 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgFETE7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 15:04:59 -0400
IronPort-SDR: /8QlvB6ZhTf5XF37AYd1aCtLm3c8IfOVmUtr5JQks5z76GKlnZtuFDTtrPAJCBUH7nQMOlbQi0
 i+mKMA+3SYGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 12:04:56 -0700
IronPort-SDR: so7DLzq1yp6BvnF8hi/wQpHSwI9mxUiGmwxwaZxc+/8kX6NPxrmAl9DSAi+Bs1TmGoUhfFt2S5
 NH6vdXfBLFwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="417372231"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2020 12:04:54 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC] PM-runtime: add tracepoints to cover all usage_count changes
Date:   Sat,  6 Jun 2020 03:05:52 +0800
Message-Id: <6ce5c2d21758363b7c9a31187eda1787bc4a6160.1591380524.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591380524.git.yu.c.chen@intel.com>
References: <cover.1591380524.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
has added some tracepoints to monitor the change of runtime usage, and
there is something to improve:
1. There are some places that adjust the usage count have not
   been traced yet. For example, pm_runtime_get_noresume() and
   pm_runtime_put_noidle()
2. The change of the usage count will not be tracked if decreased
   from 1 to 0.

This patch address above issues by tracking the usage count whenever
it has been modified. And these changes has helped track down the
e1000e runtime issue.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/runtime.c | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 85a248e196ca..4aa2b5aa0bb8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1004,10 +1004,11 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
-		if (!atomic_dec_and_test(&dev->power.usage_count)) {
-			trace_rpm_usage_rcuidle(dev, rpmflags);
+		bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
+
+		trace_rpm_usage_rcuidle(dev, rpmflags);
+		if (non_zero)
 			return 0;
-		}
 	}
 
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
@@ -1038,10 +1039,12 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
 	int retval;
 
 	if (rpmflags & RPM_GET_PUT) {
-		if (!atomic_dec_and_test(&dev->power.usage_count)) {
-			trace_rpm_usage_rcuidle(dev, rpmflags);
+		bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
+
+		trace_rpm_usage_rcuidle(dev, rpmflags);
+		if (non_zero)
 			return 0;
-		}
+
 	}
 
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
@@ -1073,8 +1076,10 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
 			dev->power.runtime_status != RPM_ACTIVE);
 
-	if (rpmflags & RPM_GET_PUT)
+	if (rpmflags & RPM_GET_PUT) {
 		atomic_inc(&dev->power.usage_count);
+		trace_rpm_usage_rcuidle(dev, rpmflags);
+	}
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 	retval = rpm_resume(dev, rpmflags);
@@ -1448,16 +1453,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
  */
 void pm_runtime_allow(struct device *dev)
 {
+	bool is_zero;
+
 	spin_lock_irq(&dev->power.lock);
 	if (dev->power.runtime_auto)
 		goto out;
 
 	dev->power.runtime_auto = true;
-	if (atomic_dec_and_test(&dev->power.usage_count))
+	is_zero = atomic_dec_and_test(&dev->power.usage_count);
+	trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
+	if (is_zero)
 		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
-	else
-		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
-
  out:
 	spin_unlock_irq(&dev->power.lock);
 }
@@ -1523,9 +1529,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 		/* If it used to be allowed then prevent it. */
 		if (!old_use || old_delay >= 0) {
 			atomic_inc(&dev->power.usage_count);
-			rpm_resume(dev, 0);
-		} else {
 			trace_rpm_usage_rcuidle(dev, 0);
+			rpm_resume(dev, 0);
 		}
 	}
 
@@ -1533,8 +1538,10 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 	else {
 
 		/* If it used to be prevented then allow it. */
-		if (old_use && old_delay < 0)
+		if (old_use && old_delay < 0) {
 			atomic_dec(&dev->power.usage_count);
+			trace_rpm_usage_rcuidle(dev, 0);
+		}
 
 		/* Maybe we can autosuspend now. */
 		rpm_idle(dev, RPM_AUTO);
@@ -1741,12 +1748,14 @@ void pm_runtime_drop_link(struct device *dev)
 void pm_runtime_get_noresume(struct device *dev)
 {
 	atomic_inc(&dev->power.usage_count);
+	trace_rpm_usage_rcuidle(dev, 0);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_get_noresume);
 
 void pm_runtime_put_noidle(struct device *dev)
 {
 	atomic_add_unless(&dev->power.usage_count, -1, 0);
+	trace_rpm_usage_rcuidle(dev, 0);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_put_noidle);
 
-- 
2.20.1

