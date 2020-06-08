Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400B11F13B8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgFHHlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 03:41:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:7078 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbgFHHlN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 03:41:13 -0400
IronPort-SDR: 3Gg1FWpqdHZ/jkl2vgxRsOqja8svUsIKF0wam3WstZ8IsYGjLSuzp2IjPZj3OyVO7v/btyKpu8
 hVl2gZ2ubJjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 00:41:09 -0700
IronPort-SDR: +cZS7Uo1JfltpvAh8vpLKL6o/4HjE9wSx6oKD/5ZWMnBDOFREMOURCMXx9wuFGAUD0b5U3yt9j
 bjB2QRT3O/Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="274134916"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 00:41:07 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC v2] PM-runtime: Move all runtime usage related function to runtime.c
Date:   Mon,  8 Jun 2020 15:41:58 +0800
Message-Id: <a0cffe38bb82066fe973a916a202c1f8c71cd15e.1591600914.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591600914.git.yu.c.chen@intel.com>
References: <cover.1591600914.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to track all the runtime usage count change, move the code
related to runtime usage count change from pm_runtime.h to runtime.c,
so that in runtime.c we can leverage trace event to do the tracking.
Meanwhile export pm_runtime_get_noresume() and pm_runtime_put_noidle()
so the module can use them.

No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/runtime.c | 12 ++++++++++++
 include/linux/pm_runtime.h   | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9f62790f644c..85a248e196ca 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1738,6 +1738,18 @@ void pm_runtime_drop_link(struct device *dev)
 	spin_unlock_irq(&dev->power.lock);
 }
 
+void pm_runtime_get_noresume(struct device *dev)
+{
+	atomic_inc(&dev->power.usage_count);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_get_noresume);
+
+void pm_runtime_put_noidle(struct device *dev)
+{
+	atomic_add_unless(&dev->power.usage_count, -1, 0);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_put_noidle);
+
 static bool pm_runtime_need_not_resume(struct device *dev)
 {
 	return atomic_read(&dev->power.usage_count) <= 1 &&
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 3dbc207bff53..26510fef2acd 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -59,6 +59,8 @@ extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device *dev);
+extern void pm_runtime_get_noresume(struct device *dev);
+extern void pm_runtime_put_noidle(struct device *dev);
 
 static inline int pm_runtime_get_if_in_use(struct device *dev)
 {
@@ -70,16 +72,6 @@ static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 	dev->power.ignore_children = enable;
 }
 
-static inline void pm_runtime_get_noresume(struct device *dev)
-{
-	atomic_inc(&dev->power.usage_count);
-}
-
-static inline void pm_runtime_put_noidle(struct device *dev)
-{
-	atomic_add_unless(&dev->power.usage_count, -1, 0);
-}
-
 static inline bool pm_runtime_suspended(struct device *dev)
 {
 	return dev->power.runtime_status == RPM_SUSPENDED
-- 
2.17.1

