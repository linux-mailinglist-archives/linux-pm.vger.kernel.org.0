Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB51849BE3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 10:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfFRISb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 04:18:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52859 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFRISb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 04:18:31 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 56c7ecd8cdf32c1f; Tue, 18 Jun 2019 10:18:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] PM: suspend: Rename pm_suspend_via_s2idle()
Date:   Tue, 18 Jun 2019 10:18:28 +0200
Message-ID: <7812857.KkDK7346ep@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The name of pm_suspend_via_s2idle() is confusing, as it doesn't
reflect the purpose of the function precisely enough and it is
very similar to pm_suspend_via_firmware(), which has a different
purpose, so rename it as pm_suspend_default_s2idle() and update
its only caller, i8042_register_ports(), accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/serio/i8042.c |    2 +-
 include/linux/suspend.h     |    4 ++--
 kernel/power/suspend.c      |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -282,7 +282,7 @@ static inline bool idle_should_enter_s2i
 	return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
 }
 
-extern bool pm_suspend_via_s2idle(void);
+extern bool pm_suspend_default_s2idle(void);
 extern void __init pm_states_init(void);
 extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
 extern void s2idle_wake(void);
@@ -314,7 +314,7 @@ static inline void pm_set_suspend_via_fi
 static inline void pm_set_resume_via_firmware(void) {}
 static inline bool pm_suspend_via_firmware(void) { return false; }
 static inline bool pm_resume_via_firmware(void) { return false; }
-static inline bool pm_suspend_via_s2idle(void) { return false; }
+static inline bool pm_suspend_default_s2idle(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -62,16 +62,16 @@ enum s2idle_states __read_mostly s2idle_
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
 /**
- * pm_suspend_via_s2idle - Check if suspend-to-idle is the default suspend.
+ * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
  * Return 'true' if suspend-to-idle has been selected as the default system
  * suspend method.
  */
-bool pm_suspend_via_s2idle(void)
+bool pm_suspend_default_s2idle(void)
 {
 	return mem_sleep_current == PM_SUSPEND_TO_IDLE;
 }
-EXPORT_SYMBOL_GPL(pm_suspend_via_s2idle);
+EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
Index: linux-pm/drivers/input/serio/i8042.c
===================================================================
--- linux-pm.orig/drivers/input/serio/i8042.c
+++ linux-pm/drivers/input/serio/i8042.c
@@ -1410,7 +1410,7 @@ static void __init i8042_register_ports(
 		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
 		 * by default.
 		 */
-		if (pm_suspend_via_s2idle() && i == I8042_KBD_PORT_NO)
+		if (pm_suspend_default_s2idle() && i == I8042_KBD_PORT_NO)
 			device_set_wakeup_enable(&serio->dev, true);
 	}
 }



