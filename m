Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AE136B82
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgAJK57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:57:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57942 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgAJK55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:57:57 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5f256afba73a7416; Fri, 10 Jan 2020 11:57:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/8] intel_idle: Rearrange intel_idle_cpuidle_driver_init()
Date:   Fri, 10 Jan 2020 11:48:25 +0100
Message-ID: <1622492.zbETNhdsud@kreacher>
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

Notice that intel_idle_state_table_update() only needs to be called
if icpu is not NULL, so fold it into intel_idle_init_cstates_icpu(),
and pass a pointer to the driver object to
intel_idle_cpuidle_driver_init() as an argument instead of
referencing it locally in there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1447,16 +1447,12 @@ static void sklh_idle_state_table_update
 	skl_cstates[5].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C8-SKL */
 	skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C9-SKL */
 }
-/*
- * intel_idle_state_table_update()
- *
- * Update the default state_table for this CPU-id
- */
 
-static void intel_idle_state_table_update(void)
+static void intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
-	switch (boot_cpu_data.x86_model) {
+	int cstate;
 
+	switch (boot_cpu_data.x86_model) {
 	case INTEL_FAM6_IVYBRIDGE_X:
 		ivt_idle_state_table_update();
 		break;
@@ -1468,11 +1464,6 @@ static void intel_idle_state_table_updat
 		sklh_idle_state_table_update();
 		break;
 	}
-}
-
-static void intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
-{
-	int cstate;
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
 		unsigned int mwait_hint;
@@ -1515,12 +1506,8 @@ static void intel_idle_init_cstates_icpu
  * intel_idle_cpuidle_driver_init()
  * allocate, initialize cpuidle_states
  */
-static void __init intel_idle_cpuidle_driver_init(void)
+static void __init intel_idle_cpuidle_driver_init(struct cpuidle_driver *drv)
 {
-	struct cpuidle_driver *drv = &intel_idle_driver;
-
-	intel_idle_state_table_update();
-
 	cpuidle_poll_state_init(drv);
 	drv->state_count = 1;
 
@@ -1633,7 +1620,8 @@ static int __init intel_idle_init(void)
 	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
 
-	intel_idle_cpuidle_driver_init();
+	intel_idle_cpuidle_driver_init(&intel_idle_driver);
+
 	retval = cpuidle_register_driver(&intel_idle_driver);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();



