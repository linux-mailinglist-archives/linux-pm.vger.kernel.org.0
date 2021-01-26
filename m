Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD3305479
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 08:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317387AbhA0Alc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbhAZV1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 16:27:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 429FB20449;
        Tue, 26 Jan 2021 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611696419;
        bh=/5rQa8ixsaJvkZPasx13vrCPQbW5A69Xppug6eQxMz4=;
        h=From:To:Cc:Subject:Date:From;
        b=tk0XhOWBrsjta83FGTcHH3GfsRGi6uTUOBktN/OiyCiUtEKwKppmJ/GbcUMPJJXIa
         tO/HzqFjyxvJ7FIZsPav783oSb2s4xoMbAeSWF/M5wQevmljAaZRbKqdYfu5jO12In
         8dm25J/3QfoRVWCj4etvULVDlNjM5FzGZ3FiolGLZ1GU4h/T/WWCL1d0fB8dp+zqok
         Yl7n+z6z4sv9MOq3WmEZk/4aB1E0c0xhDDkvJ+PnmKmB+jYJMQYFQGZdkrG7NS3Orb
         ucdT2JrV0L6qOzXEE9GhP1yWLqDaiDpZCMVpMPxDLcT+rpqNC4baF+mfJN3s+zqIIY
         cmr42n5m98O8A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PM: runtime: Fix typos and grammar
Date:   Tue, 26 Jan 2021 15:26:55 -0600
Message-Id: <20210126212655.2921965-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix minor typos and grammatical issues.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/runtime_pm.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 0553008b6279..d9c777b18f7a 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -579,7 +579,7 @@ should be used.  Of course, for this purpose the device's runtime PM has to be
 enabled earlier by calling pm_runtime_enable().
 
 Note, if the device may execute pm_runtime calls during the probe (such as
-if it is registers with a subsystem that may call back in) then the
+if it is registered with a subsystem that may call back in) then the
 pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
 appropriate to ensure that the device is not put back to sleep during the
 probe. This can happen with systems such as the network device layer.
@@ -587,11 +587,11 @@ probe. This can happen with systems such as the network device layer.
 It may be desirable to suspend the device once ->probe() has finished.
 Therefore the driver core uses the asynchronous pm_request_idle() to submit a
 request to execute the subsystem-level idle callback for the device at that
-time.  A driver that makes use of the runtime autosuspend feature, may want to
+time.  A driver that makes use of the runtime autosuspend feature may want to
 update the last busy mark before returning from ->probe().
 
 Moreover, the driver core prevents runtime PM callbacks from racing with the bus
-notifier callback in __device_release_driver(), which is necessary, because the
+notifier callback in __device_release_driver(), which is necessary because the
 notifier is used by some subsystems to carry out operations affecting the
 runtime PM functionality.  It does so by calling pm_runtime_get_sync() before
 driver_sysfs_remove() and the BUS_NOTIFY_UNBIND_DRIVER notifications.  This
@@ -603,7 +603,7 @@ calling pm_runtime_suspend() from their ->remove() routines, the driver core
 executes pm_runtime_put_sync() after running the BUS_NOTIFY_UNBIND_DRIVER
 notifications in __device_release_driver().  This requires bus types and
 drivers to make their ->remove() callbacks avoid races with runtime PM directly,
-but also it allows of more flexibility in the handling of devices during the
+but it also allows more flexibility in the handling of devices during the
 removal of their drivers.
 
 Drivers in ->remove() callback should undo the runtime PM changes done
@@ -693,7 +693,7 @@ that the device appears to be runtime-suspended and its state is fine, so it
 may be left in runtime suspend provided that all of its descendants are also
 left in runtime suspend.  If that happens, the PM core will not execute any
 system suspend and resume callbacks for all of those devices, except for the
-complete callback, which is then entirely responsible for handling the device
+.complete() callback, which is then entirely responsible for handling the device
 as appropriate.  This only applies to system suspend transitions that are not
 related to hibernation (see Documentation/driver-api/pm/devices.rst for more
 information).
@@ -706,7 +706,7 @@ out the following operations:
     right before executing the subsystem-level .prepare() callback for it and
     pm_runtime_barrier() is called for every device right before executing the
     subsystem-level .suspend() callback for it.  In addition to that the PM core
-    calls  __pm_runtime_disable() with 'false' as the second argument for every
+    calls __pm_runtime_disable() with 'false' as the second argument for every
     device right before executing the subsystem-level .suspend_late() callback
     for it.
 
@@ -783,7 +783,7 @@ driver/base/power/generic_ops.c:
   `int pm_generic_restore_noirq(struct device *dev);`
     - invoke the ->restore_noirq() callback provided by the device's driver
 
-These functions are the defaults used by the PM core, if a subsystem doesn't
+These functions are the defaults used by the PM core if a subsystem doesn't
 provide its own callbacks for ->runtime_idle(), ->runtime_suspend(),
 ->runtime_resume(), ->suspend(), ->suspend_noirq(), ->resume(),
 ->resume_noirq(), ->freeze(), ->freeze_noirq(), ->thaw(), ->thaw_noirq(),
-- 
2.25.1

