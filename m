Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843FC143530
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 02:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAUBa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 20:30:58 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:47974 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUBa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 20:30:58 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 21 Jan 2020 10:00:55 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.127 with ESMTP; 21 Jan 2020 10:00:55 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daewoong Kim <daewoong00.kim@lge.com>,
        Seokjoo Lee <seokjoo.lee@lge.com>,
        Lee Gunho <gunho.lee@lge.com>, Chanho Min <chanho.min@lge.com>
Subject: [PATCH] PM / sleep: fix use-after-free on async resume
Date:   Tue, 21 Jan 2020 10:00:52 +0900
Message-Id: <1579568452-27253-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some device can be released during suspend (e.g. usb disconnection).
But, Its child device still use dev->parent's lock in dpm_wait().
It can be ocurred use-after-free as bellows. This is happened during
usb resume in practice.

device hierarchy: "1-1" <- "1-1:1.2" <- "ep83"

<parent>		<child>
device_resume("1-1:1.2")
dpm_wait("1-1")
			device_resume("ep_83");
			dpm_wait("1-1:1.2");
 usb_disconnect
  put_device("1-1:1.2")

put_device("1-1:1.2")
 usb_release_interface
 kfree(intf) <- "1-1:1.2"'s struct device is freed

			 wait_for_common
			 do {
			 ...
			 spin_lock_irq(&x->wait.lock); <- "1-1:1-2"'s lock
			 } while (!x->done && timeout);

This is call stack of the system hang caused by freed lock value in practice.

Call trace:
[<ffffffc000ef59a8>] _raw_spin_lock_irq+0x38/0x80
[<ffffffc000ef2dac>] wait_for_common+0x12c/0x140
[<ffffffc000ef2dd4>] wait_for_completion+0x14/0x20
[<ffffffc000480c1c>] dpm_wait+0x5c/0xb0
[<ffffffc0004813d8>] device_resume+0x78/0x320
[<ffffffc000481ed4>] async_resume+0x24/0xe0
[<ffffffc0000c671c>] async_run_entry_fn+0x54/0x158
[<ffffffc0000bd720>] process_one_work+0x1e8/0x4b0
[<ffffffc0000bdb10>] worker_thread+0x128/0x4b8
[<ffffffc0000c3a14>] kthread+0x10c/0x110
[<ffffffc00008ddd0>] ret_from_fork+0x10/0x40

To prevent such use-after-free, dpm_wait_for_parent() keeps parent's reference
using get/put_device even if it is disconnected.

Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Daewoong Kim <daewoong00.kim@lge.com>
---
 drivers/base/power/main.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f946511..95a7499 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -234,13 +234,29 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
  * @dev: Device to wait for.
  * @async: If unset, wait only if the device's power.async_suspend flag is set.
  */
+static void _dpm_wait(struct device *dev, bool async)
+{
+	if (async || (pm_async_enabled && dev->power.async_suspend))
+		wait_for_completion(&dev->power.completion);
+}
+
 static void dpm_wait(struct device *dev, bool async)
 {
 	if (!dev)
 		return;
 
-	if (async || (pm_async_enabled && dev->power.async_suspend))
-		wait_for_completion(&dev->power.completion);
+	_dpm_wait(dev, async);
+}
+
+static void dpm_wait_for_parent(struct device *dev, bool async)
+{
+	if (dev && dev->parent) {
+		struct device *dev_p = dev->parent;
+
+		get_device(dev_p);
+		_dpm_wait(dev_p, async);
+		put_device(dev_p);
+	}
 }
 
 static int dpm_wait_fn(struct device *dev, void *async_ptr)
@@ -277,7 +293,7 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 
 static void dpm_wait_for_superior(struct device *dev, bool async)
 {
-	dpm_wait(dev->parent, async);
+	dpm_wait_for_parent(dev, async);
 	dpm_wait_for_suppliers(dev, async);
 }
 
-- 
2.7.4

