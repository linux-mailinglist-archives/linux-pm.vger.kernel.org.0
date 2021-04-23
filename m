Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E527368E9A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhDWINR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 04:13:17 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:58662 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWINR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 04:13:17 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id B6B02CD7E6;
        Fri, 23 Apr 2021 16:12:24 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P18569T140528077227776S1619165544413195_;
        Fri, 23 Apr 2021 16:12:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9422ddefe1494081fcea59c3190594dc>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: rjw@rjwysocki.net
X-RCPT-COUNT: 7
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] PM: Use pm_pr_dbg() instead of pr_debug().
Date:   Fri, 23 Apr 2021 16:12:23 +0800
Message-Id: <20210423081223.26111-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These prints are useful if we're doing PM suspend debugging. Having them
at pr_debug() level means that we need to either enable DEBUG in this
file, or compile the kernel with dynamic debug capabilities. Both of
these options have drawbacks like custom compilation or opting into all
debug statements being included into the kernel image. Given that we
already have infrastructure to collect PM debugging information with
CONFIG_PM_DEBUG and friends, let's change the pr_debug usage here to be
pm_pr_dbg() instead so we can collect the wakeup information in the
kernel logs.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/base/power/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f893c3c5af07..6e64e3fff84c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -133,7 +133,7 @@ void device_pm_add(struct device *dev)
 	if (device_pm_not_required(dev))
 		return;
 
-	pr_debug("Adding info for %s:%s\n",
+	pm_pr_dbg("Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	device_pm_check_callbacks(dev);
 	mutex_lock(&dpm_list_mtx);
@@ -154,7 +154,7 @@ void device_pm_remove(struct device *dev)
 	if (device_pm_not_required(dev))
 		return;
 
-	pr_debug("Removing info for %s:%s\n",
+	pm_pr_dbg("Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	complete_all(&dev->power.completion);
 	mutex_lock(&dpm_list_mtx);
@@ -173,7 +173,7 @@ void device_pm_remove(struct device *dev)
  */
 void device_pm_move_before(struct device *deva, struct device *devb)
 {
-	pr_debug("Moving %s:%s before %s:%s\n",
+	pm_pr_dbg("Moving %s:%s before %s:%s\n",
 		 deva->bus ? deva->bus->name : "No Bus", dev_name(deva),
 		 devb->bus ? devb->bus->name : "No Bus", dev_name(devb));
 	/* Delete deva from dpm_list and reinsert before devb. */
@@ -187,7 +187,7 @@ void device_pm_move_before(struct device *deva, struct device *devb)
  */
 void device_pm_move_after(struct device *deva, struct device *devb)
 {
-	pr_debug("Moving %s:%s after %s:%s\n",
+	pm_pr_dbg("Moving %s:%s after %s:%s\n",
 		 deva->bus ? deva->bus->name : "No Bus", dev_name(deva),
 		 devb->bus ? devb->bus->name : "No Bus", dev_name(devb));
 	/* Delete deva from dpm_list and reinsert after devb. */
@@ -200,7 +200,7 @@ void device_pm_move_after(struct device *deva, struct device *devb)
  */
 void device_pm_move_last(struct device *dev)
 {
-	pr_debug("Moving %s:%s to end of list\n",
+	pm_pr_dbg("Moving %s:%s to end of list\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	list_move_tail(&dev->power.entry, &dpm_list);
 }
-- 
2.20.1



