Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7911F13BB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgFHHlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 03:41:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:65231 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgFHHlU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 03:41:20 -0400
IronPort-SDR: CQmoUCxqpyVY144gDNcmQ9HjHsisomzOjrz0DHv1s9xO6t+B/HdceY015PPPcC2dzM/TJ79oZr
 xv9ySoJNkojQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 00:41:19 -0700
IronPort-SDR: 2wrP6yDSENKSDdYN7WA/ndnPhqnAaLsVJevuZ3NP6eQqlIbc1xnCMLuG61+81uKX+Aw6+cDS0x
 jIFLB9JLqAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="274134975"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 00:41:17 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC v2] PM-runtime: change the tracepoints to cover all usage_count
Date:   Mon,  8 Jun 2020 15:42:15 +0800
Message-Id: <0a3ae7be4c467912327005995b1defb4fefd8101.1591600914.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591600914.git.yu.c.chen@intel.com>
References: <cover.1591600914.git.yu.c.chen@intel.com>
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

This patch intends to adjust the logic to be consistent with the
change of usage_counter, that is to say, only after the counter has
been possibly modified, we record it. Besides, all usage changes will
be shown using rpm_usage even if included by other trace points.
And these changes has helped track down the e1000e runtime issue.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: According to Michal's suggestion, adjust the commit log
    to better describe the meaning of this patch.
--
 drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 85a248e196ca..5789d2624513 100644
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
@@ -1433,6 +1438,7 @@ void pm_runtime_forbid(struct device *dev)
 
 	dev->power.runtime_auto = false;
 	atomic_inc(&dev->power.usage_count);
+	trace_rpm_usage_rcuidle(dev, 0);
 	rpm_resume(dev, 0);
 
  out:
@@ -1448,16 +1454,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
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
@@ -1523,9 +1530,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 		/* If it used to be allowed then prevent it. */
 		if (!old_use || old_delay >= 0) {
 			atomic_inc(&dev->power.usage_count);
-			rpm_resume(dev, 0);
-		} else {
 			trace_rpm_usage_rcuidle(dev, 0);
+			rpm_resume(dev, 0);
 		}
 	}
 
@@ -1533,8 +1539,10 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 	else {
 
 		/* If it used to be prevented then allow it. */
-		if (old_use && old_delay < 0)
+		if (old_use && old_delay < 0) {
 			atomic_dec(&dev->power.usage_count);
+			trace_rpm_usage_rcuidle(dev, 0);
+		}
 
 		/* Maybe we can autosuspend now. */
 		rpm_idle(dev, RPM_AUTO);
@@ -1741,12 +1749,14 @@ void pm_runtime_drop_link(struct device *dev)
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
2.17.1

