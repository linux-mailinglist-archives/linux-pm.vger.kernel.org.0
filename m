Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84D4159D83
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBKXin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53835 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgBKXim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:42 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9926a881a97b5522; Wed, 12 Feb 2020 00:38:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 26/28] PM: QoS: Update file information comments
Date:   Wed, 12 Feb 2020 00:35:39 +0100
Message-ID: <2027470.TsXNxnrcfu@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Update the file information comments in include/linux/pm_qos.h
and kernel/power/qos.c by adding titles along with copyright and
authors information to them and changing the qos.c description to
better reflect its contents (outdated information is dropped from
it in particular).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h | 15 +++++++++++----
 kernel/power/qos.c     | 34 ++++++++++++----------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index e0ca4d780457..df065db3f57a 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -1,10 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PM_QOS_H
-#define _LINUX_PM_QOS_H
-/* interface for the pm_qos_power infrastructure of the linux kernel.
+/*
+ * Definitions related to Power Management Quality of Service (PM QoS).
+ *
+ * Copyright (C) 2020 Intel Corporation
  *
- * Mark Gross <mgross@linux.intel.com>
+ * Authors:
+ *	Mark Gross <mgross@linux.intel.com>
+ *	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
+
+#ifndef _LINUX_PM_QOS_H
+#define _LINUX_PM_QOS_H
+
 #include <linux/plist.h>
 #include <linux/notifier.h>
 #include <linux/device.h>
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 7374c76f409a..ef73573db43d 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -1,31 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * This module exposes the interface to kernel space for specifying
- * QoS dependencies.  It provides infrastructure for registration of:
+ * Power Management Quality of Service (PM QoS) support base.
  *
- * Dependents on a QoS value : register requests
- * Watchers of QoS value : get notified when target QoS value changes
+ * Copyright (C) 2020 Intel Corporation
  *
- * This QoS design is best effort based.  Dependents register their QoS needs.
- * Watchers register to keep track of the current QoS needs of the system.
+ * Authors:
+ *	Mark Gross <mgross@linux.intel.com>
+ *	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * There are 3 basic classes of QoS parameter: latency, timeout, throughput
- * each have defined units:
- * latency: usec
- * timeout: usec <-- currently not used.
- * throughput: kbs (kilo byte / sec)
+ * Provided here is an interface for specifying PM QoS dependencies.  It allows
+ * entities depending on QoS constraints to register their requests which are
+ * aggregated as appropriate to produce effective constraints (target values)
+ * that can be monitored by entities needing to respect them, either by polling
+ * or through a built-in notification mechanism.
  *
- * There are lists of pm_qos_objects each one wrapping requests, notifiers
- *
- * User mode requests on a QOS parameter register themselves to the
- * subsystem by opening the device node /dev/... and writing there request to
- * the node.  As long as the process holds a file handle open to the node the
- * client continues to be accounted for.  Upon file release the usermode
- * request is removed and a new qos target is computed.  This way when the
- * request that the application has is cleaned up when closes the file
- * pointer or exits the pm_qos_object will get an opportunity to clean up.
- *
- * Mark Gross <mgross@linux.intel.com>
+ * In addition to the basic functionality, more specific interfaces for managing
+ * global CPU latency QoS requests and frequency QoS requests are provided.
  */
 
 /*#define DEBUG*/
-- 
2.16.4





