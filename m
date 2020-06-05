Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF80A1F0030
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 21:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFETEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 15:04:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:50454 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgFETEn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 15:04:43 -0400
IronPort-SDR: rW0HTZkXGRYl8exAr0dUK3tEB/4l2MlUOulMr5CukNjXqwiYYiKZj4KdwxWulJn0HZ6kz8ZKsF
 yaySxo52vHIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 12:04:42 -0700
IronPort-SDR: 6Pojt9FdQK/7USSH4893YJsD4mrDRG9mxHalIS169phCJ11TB/RczLClFRQRPT37qrF/8sgCpw
 UE82yFR831lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="417372180"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2020 12:04:40 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC] PM-runtime: Move all runtime usage related function to runtime.c
Date:   Sat,  6 Jun 2020 03:05:35 +0800
Message-Id: <3e7c571eb9e444c6e326d5cbb1f6e2dce4bb52fe.1591380524.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591380524.git.yu.c.chen@intel.com>
References: <cover.1591380524.git.yu.c.chen@intel.com>
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

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/base/power/runtime.c | 12 ++++++++++++
 include/linux/pm_runtime.h   | 14 ++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

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
index 3dbc207bff53..57afdb122d8a 100644
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
@@ -188,6 +180,8 @@ static inline void pm_runtime_get_suppliers(struct device *dev) {}
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
 static inline void pm_runtime_drop_link(struct device *dev) {}
+static inline void pm_runtime_get_noresume(struct device *dev) {}
+static inline void pm_runtime_put_noidle(struct device *dev) {}
 
 #endif /* !CONFIG_PM */
 
-- 
2.20.1

