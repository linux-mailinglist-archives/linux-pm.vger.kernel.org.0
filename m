Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4B22C67
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 08:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfETG4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 02:56:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60062 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfETG4o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 02:56:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BEF9320017C;
        Mon, 20 May 2019 08:56:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7F7220016F;
        Mon, 20 May 2019 08:56:35 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5FA54402A2;
        Mon, 20 May 2019 14:56:28 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 1/3] PM: wakeup: Add routine to help fetch wakeup source object.
Date:   Mon, 20 May 2019 14:58:14 +0800
Message-Id: <20190520065816.32360-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some user might want to go through all registered wakeup sources
and doing things accordingly. For example, SoC PM driver might need to
do HW programming to prevent powering down specific IP which wakeup
source depending on. And is user's responsibility to identify if this
wakeup source he is interested in.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v3:
	- Adjust indentation of *attached_dev;.

Change in v2:
	- None.

 drivers/base/power/wakeup.c |   18 ++++++++++++++++++
 include/linux/pm_wakeup.h   |    3 +++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5b2b6a0..6904485 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -14,6 +14,7 @@
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/of_device.h>
 #include <linux/pm_wakeirq.h>
 #include <trace/events/power.h>
 
@@ -226,6 +227,22 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 	}
 }
 EXPORT_SYMBOL_GPL(wakeup_source_unregister);
+/**
+ * wakeup_source_get_next - Get next wakeup source from the list
+ * @ws: Previous wakeup source object, null means caller want first one.
+ */
+struct wakeup_source *wakeup_source_get_next(struct wakeup_source *ws)
+{
+	struct list_head *ws_head = &wakeup_sources;
+
+	if (ws)
+		return list_next_or_null_rcu(ws_head, &ws->entry,
+				struct wakeup_source, entry);
+	else
+		return list_entry_rcu(ws_head->next,
+				struct wakeup_source, entry);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_get_next);
 
 /**
  * device_wakeup_attach - Attach a wakeup source object to a device object.
@@ -242,6 +259,7 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 		return -EEXIST;
 	}
 	dev->power.wakeup = ws;
+	ws->attached_dev = dev;
 	if (dev->power.wakeirq)
 		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 0ff134d..913b2fb 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -50,6 +50,7 @@
  * @wakeup_count: Number of times the wakeup source might abort suspend.
  * @active: Status of the wakeup source.
  * @has_timeout: The wakeup source has been activated with a timeout.
+ * @attached_dev: The device it attached to
  */
 struct wakeup_source {
 	const char 		*name;
@@ -70,6 +71,7 @@ struct wakeup_source {
 	unsigned long		wakeup_count;
 	bool			active:1;
 	bool			autosleep_enabled:1;
+	struct device		*attached_dev;
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -101,6 +103,7 @@ static inline void device_set_wakeup_path(struct device *dev)
 extern void wakeup_source_remove(struct wakeup_source *ws);
 extern struct wakeup_source *wakeup_source_register(const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
+extern struct wakeup_source *wakeup_source_get_next(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
 extern void device_set_wakeup_capable(struct device *dev, bool capable);
-- 
1.7.1

