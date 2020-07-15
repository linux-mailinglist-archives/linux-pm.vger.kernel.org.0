Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B412204E9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGOG0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:26:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:13928 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgGOG0h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 02:26:37 -0400
IronPort-SDR: aX8gO1l3/YCZT0IADyvypCWaUHx/iWU/gAlcqH08XQR6VX0/L3bauJHC5pWgvI26TAxwmqOVSD
 J8CNzRKFs46w==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210636613"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="210636613"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 23:26:36 -0700
IronPort-SDR: tqHfstNg0M1uf5yZLi+bxmXKVxmznw4NYrHFoBc9u/qVBRPVuT7UgqHjQxmVNaHW/Bm0rqf4v8
 zRgih0MS3FQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="281986307"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2020 23:26:34 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michal Miroslaw" <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RESEND v3] PM-runtime: Move all runtime usage related function to runtime.c
Date:   Wed, 15 Jul 2020 14:27:54 +0800
Message-Id: <9c261b5001c853006e4fe719726948dfe3b4d487.1594790493.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594790493.git.yu.c.chen@intel.com>
References: <cover.1594790493.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to track all the runtime usage count change, move the code
related to runtime usage count change from pm_runtime.h to runtime.c,
so that in runtime.c we can leverage trace event to do the tracking.
Meanwhile export pm_runtime_get_noresume() and pm_runtime_put_noidle()
so the module can use them.

No functional changes intended.

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

