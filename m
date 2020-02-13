Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0315CDCA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgBMWFE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56758 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgBMWFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:03 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id cd99d6a76986736f; Thu, 13 Feb 2020 23:05:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 9/9] intel_idle: Update copyright notice, known limitations and version
Date:   Thu, 13 Feb 2020 23:04:30 +0100
Message-ID: <21103799.F4mdUiJjoy@kreacher>
In-Reply-To: <2960689.qre192dJKD@kreacher>
References: <2960689.qre192dJKD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Update the copyright notice in intel_idle.c to cover the recent
changes, drop the description of a "known limitation" that is not
a limitation any more and bump up the driver version number.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index de1367d996c5..65b84d5dc457 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2,8 +2,9 @@
 /*
  * intel_idle.c - native hardware idle loop for modern Intel processors
  *
- * Copyright (c) 2013, Intel Corporation.
+ * Copyright (c) 2013 - 2020, Intel Corporation.
  * Len Brown <len.brown@intel.com>
+ * Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
 /*
@@ -25,11 +26,6 @@
 /*
  * Known limitations
  *
- * The driver currently initializes for_each_online_cpu() upon modprobe.
- * It it unaware of subsequent processors hot-added to the system.
- * This means that if you boot with maxcpus=n and later online
- * processors above n, those processors will use C1 only.
- *
  * ACPI has a .suspend hack to turn off deep c-statees during suspend
  * to avoid complications with the lapic timer workaround.
  * Have not seen issues with suspend, but may need same workaround here.
@@ -55,7 +51,7 @@
 #include <asm/mwait.h>
 #include <asm/msr.h>
 
-#define INTEL_IDLE_VERSION "0.4.1"
+#define INTEL_IDLE_VERSION "0.5.1"
 
 static struct cpuidle_driver intel_idle_driver = {
 	.name = "intel_idle",
-- 
2.16.4





