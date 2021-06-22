Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630493B0516
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFVMsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:48:16 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:55724 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhFVMsP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:48:15 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 06AA7BFCB9;
        Tue, 22 Jun 2021 20:45:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P12363T139710780229376S1624365950601738_;
        Tue, 22 Jun 2021 20:45:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8acd532e65a9685d924ec78448b9ffd6>
X-RL-SENDER: pingshuo@uniontech.com
X-SENDER: pingshuo@uniontech.com
X-LOGIN-NAME: pingshuo@uniontech.com
X-FST-TO: rjw@rjwysocki.net
X-RCPT-COUNT: 7
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   pingshuo <pingshuo@uniontech.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pingshuo <pingshuo@uniontech.com>
Subject: [PATCH] hibernation:stop resume screen during hibernation
Date:   Tue, 22 Jun 2021 20:45:47 +0800
Message-Id: <20210622124547.28317-1-pingshuo@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The display will be woken up during hibernation.
if the computer equipment is poor, it will cause the screen to flicker.
Skip to reusme the display devices in "thaw".

Signed-off-by: pingshuo <pingshuo@uniontech.com>
---
 drivers/base/power/main.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f893c3c5af07..f3e92ac7b4b3 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -35,11 +35,14 @@
 #include <linux/cpuidle.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>
+#include <linux/pci.h>
 
 #include "../base.h"
 #include "power.h"
 
 typedef int (*pm_callback_t)(struct device *);
+#define VIDEO_PCI_CLASS 0x030000
+#define VIDEO_PCI_CLASS_VALID 0xff0000
 
 #define list_for_each_entry_rcu_locked(pos, head, member) \
 	list_for_each_entry_rcu(pos, head, member, \
@@ -693,6 +696,40 @@ static void async_resume_noirq(void *data, async_cookie_t cookie)
 	put_device(dev);
 }
 
+/**
+ * dpm_resume_skip_display_devices - Skip to reusme the display devices.
+ * @dev: Device to handle.
+ * @state: PM transition of the system being carried out.
+ *
+ * Delete the display devices from the wake-up list during the "thaw".
+ */
+static int dpm_resume_skip_display_devices(struct device *dev, pm_message_t state)
+{
+	struct pci_dev *pci_test = to_pci_dev(dev);
+
+	if (state.event == PM_EVENT_THAW) {
+		/*
+		 * Filter out the display devices
+		 */
+		if ((pci_test && ((pci_test->class & VIDEO_PCI_CLASS_VALID) == VIDEO_PCI_CLASS)) ||
+			(dev->driver && dev->driver->name &&
+			strncmp(dev->driver->name, "video", 6) == 0)) {
+
+			pr_info("Skip the display devices during the thaw.");
+			/*
+			 * Remove the display devices from the resume stage
+			 */
+			list_del(&dev->power.entry);
+			/*
+			 * Remove the display devices from the power down stage
+			 */
+			list_del(&dev->kobj.entry);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -713,6 +750,10 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		get_device(dev);
+
+		if (dpm_resume_skip_display_devices(dev, state))
+			continue;
+
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 		mutex_unlock(&dpm_list_mtx);
 
@@ -737,6 +778,8 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
 
+
+
 /**
  * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
-- 
2.20.1



