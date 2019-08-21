Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2797018
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 05:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfHUDNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 23:13:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39148 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfHUDNx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 23:13:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E7501A04CA;
        Wed, 21 Aug 2019 05:13:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 925D91A004C;
        Wed, 21 Aug 2019 05:13:43 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8AD3F402FF;
        Wed, 21 Aug 2019 11:13:35 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Li Biwen <biwen.li@nxp.com>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v6 1/3] PM: wakeup: Add routine to help fetch wakeup source object.
Date:   Wed, 21 Aug 2019 11:15:35 +0800
Message-Id: <20190821031537.46824-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some user might want to go through all registered wakeup sources
and doing things accordingly. For example, SoC PM driver might need to
do HW programming to prevent powering down specific IP which wakeup
source depending on. So add this API to help walk through all registered
wakeup source objects on that list and return them one by one.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v6:
	- Add wakeup_source_get_star() and wakeup_source_get_stop() to aligned 
	with wakeup_sources_stats_seq_start/nex/stop.

Change in v5:
	- Update commit message, add decription of walk through all wakeup
	source objects.
	- Add SCU protection in function wakeup_source_get_next().
	- Rename wakeup_source member 'attached_dev' to 'dev' and move it up
	(before wakeirq).

Change in v4:
	- None.

Change in v3:
	- Adjust indentation of *attached_dev;.

Change in v2:
	- None.

 drivers/base/power/wakeup.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm_wakeup.h   |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ee31d4f..61bc16b 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -14,6 +14,7 @@
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/of_device.h>
 #include <linux/pm_wakeirq.h>
 #include <trace/events/power.h>
 
@@ -228,6 +229,43 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 EXPORT_SYMBOL_GPL(wakeup_source_unregister);
 
 /**
+ * wakeup_source_get_star - Begin a walk on wakeup source list
+ * @srcuidx: Lock index allocated for this caller.
+ */
+struct wakeup_source *wakeup_source_get_start(int *srcuidx)
+{
+	struct list_head *ws_head = &wakeup_sources;
+
+	*srcuidx = srcu_read_lock(&wakeup_srcu);
+
+	return list_entry_rcu(ws_head->next, struct wakeup_source, entry);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_get_start);
+
+/**
+ * wakeup_source_get_next - Get next wakeup source from the list
+ * @ws: Previous wakeup source object
+ */
+struct wakeup_source *wakeup_source_get_next(struct wakeup_source *ws)
+{
+	struct list_head *ws_head = &wakeup_sources;
+
+	return list_next_or_null_rcu(ws_head, &ws->entry,
+				struct wakeup_source, entry);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_get_next);
+
+/**
+ * wakeup_source_get_stop - Stop a walk on wakeup source list
+ * @idx: Dedicated lock index of this caller.
+ */
+void wakeup_source_get_stop(int idx)
+{
+	srcu_read_unlock(&wakeup_srcu, idx);
+}
+EXPORT_SYMBOL_GPL(wakeup_source_get_stop);
+
+/**
  * device_wakeup_attach - Attach a wakeup source object to a device object.
  * @dev: Device to handle.
  * @ws: Wakeup source object to attach to @dev.
@@ -242,6 +280,7 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 		return -EEXIST;
 	}
 	dev->power.wakeup = ws;
+	ws->dev = dev;
 	if (dev->power.wakeirq)
 		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 9102760..e6b47b6 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -23,6 +23,7 @@ struct wake_irq;
  * @name: Name of the wakeup source
  * @entry: Wakeup source list entry
  * @lock: Wakeup source lock
+ * @dev: The device it attached to
  * @wakeirq: Optional device specific wakeirq
  * @timer: Wakeup timer list
  * @timer_expires: Wakeup timer expiration
@@ -42,6 +43,7 @@ struct wakeup_source {
 	const char 		*name;
 	struct list_head	entry;
 	spinlock_t		lock;
+	struct device		*dev;
 	struct wake_irq		*wakeirq;
 	struct timer_list	timer;
 	unsigned long		timer_expires;
@@ -88,6 +90,9 @@ extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
 extern struct wakeup_source *wakeup_source_register(const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
+extern struct wakeup_source *wakeup_source_get_start(int *srcuidx);
+extern struct wakeup_source *wakeup_source_get_next(struct wakeup_source *ws);
+extern void wakeup_source_get_stop(int idx);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
 extern void device_set_wakeup_capable(struct device *dev, bool capable);
-- 
2.7.4

