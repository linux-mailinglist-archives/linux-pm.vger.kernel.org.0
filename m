Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22320136B81
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgAJK56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:57:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52228 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgAJK55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:57:57 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 1afd37b8bd6ed074; Fri, 10 Jan 2020 11:57:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/8] intel_idle: Move and clean up intel_idle_cpuidle_devices_uninit()
Date:   Fri, 10 Jan 2020 11:49:58 +0100
Message-ID: <5879575.B8f60l20lB@kreacher>
In-Reply-To: <14127826.m9lEolTOYu@kreacher>
References: <14127826.m9lEolTOYu@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move intel_idle_cpuidle_devices_uninit() closer to its caller,
intel_idle_init(), add the __init modifier to its header, drop a
redundant local variable from it and fix up its kerneldoc comment.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1297,21 +1297,6 @@ static inline bool intel_idle_off_by_def
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
 /*
- * intel_idle_cpuidle_devices_uninit()
- * Unregisters the cpuidle devices.
- */
-static void intel_idle_cpuidle_devices_uninit(void)
-{
-	int i;
-	struct cpuidle_device *dev;
-
-	for_each_online_cpu(i) {
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
-		cpuidle_unregister_device(dev);
-	}
-}
-
-/*
  * ivt_idle_state_table_update(void)
  *
  * Tune IVT multi-socket targets
@@ -1565,6 +1550,17 @@ static int intel_idle_cpu_online(unsigne
 	return 0;
 }
 
+/**
+ * intel_idle_cpuidle_devices_uninit - Unregister all cpuidle devices.
+ */
+static void __init intel_idle_cpuidle_devices_uninit(void)
+{
+	int i;
+
+	for_each_online_cpu(i)
+		cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
+}
+
 static int __init intel_idle_init(void)
 {
 	const struct x86_cpu_id *id;



