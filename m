Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0812B40A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfL0Kkn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 05:40:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62862 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfL0Kkn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 05:40:43 -0500
Received: from 79.184.255.87.ipv4.supernova.orange.pl (79.184.255.87) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 17a46f8e8f570a8f; Fri, 27 Dec 2019 11:40:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: Drop unused cpuidle_driver_ref/unref() functions
Date:   Fri, 27 Dec 2019 11:40:40 +0100
Message-ID: <2529185.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpuidle_driver_ref() and cpuidle_driver_unref() functions are not
used and the refcnt field in struct cpuidle_driver operated by them
is not updated anywhere else (so it is permanently equal to 0), so
drop both of them along with refcnt.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/driver.c |   46 ----------------------------------------------
 include/linux/cpuidle.h  |    5 -----
 2 files changed, 51 deletions(-)

Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -155,8 +155,6 @@ static void __cpuidle_driver_init(struct
 {
 	int i;
 
-	drv->refcnt = 0;
-
 	/*
 	 * Use all possible CPUs as the default, because if the kernel boots
 	 * with some CPUs offline and then we online one of them, the CPU
@@ -240,9 +238,6 @@ static int __cpuidle_register_driver(str
  */
 static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
-	if (WARN_ON(drv->refcnt > 0))
-		return;
-
 	if (drv->bctimer) {
 		drv->bctimer = 0;
 		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
@@ -350,47 +345,6 @@ struct cpuidle_driver *cpuidle_get_cpu_d
 EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
 
 /**
- * cpuidle_driver_ref - get a reference to the driver.
- *
- * Increment the reference counter of the cpuidle driver associated with
- * the current CPU.
- *
- * Returns a pointer to the driver, or NULL if the current CPU has no driver.
- */
-struct cpuidle_driver *cpuidle_driver_ref(void)
-{
-	struct cpuidle_driver *drv;
-
-	spin_lock(&cpuidle_driver_lock);
-
-	drv = cpuidle_get_driver();
-	if (drv)
-		drv->refcnt++;
-
-	spin_unlock(&cpuidle_driver_lock);
-	return drv;
-}
-
-/**
- * cpuidle_driver_unref - puts down the refcount for the driver
- *
- * Decrement the reference counter of the cpuidle driver associated with
- * the current CPU.
- */
-void cpuidle_driver_unref(void)
-{
-	struct cpuidle_driver *drv;
-
-	spin_lock(&cpuidle_driver_lock);
-
-	drv = cpuidle_get_driver();
-	if (drv && !WARN_ON(drv->refcnt <= 0))
-		drv->refcnt--;
-
-	spin_unlock(&cpuidle_driver_lock);
-}
-
-/**
  * cpuidle_driver_state_disabled - Disable or enable an idle state
  * @drv: cpuidle driver owning the state
  * @idx: State index
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -116,7 +116,6 @@ DECLARE_PER_CPU(struct cpuidle_device, c
 struct cpuidle_driver {
 	const char		*name;
 	struct module 		*owner;
-	int                     refcnt;
 
         /* used by the cpuidle framework to setup the broadcast timer */
 	unsigned int            bctimer:1;
@@ -148,8 +147,6 @@ extern u64 cpuidle_poll_time(struct cpui
 
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 extern struct cpuidle_driver *cpuidle_get_driver(void);
-extern struct cpuidle_driver *cpuidle_driver_ref(void);
-extern void cpuidle_driver_unref(void);
 extern void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
 					bool disable);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
@@ -187,8 +184,6 @@ static inline u64 cpuidle_poll_time(stru
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
-static inline struct cpuidle_driver *cpuidle_driver_ref(void) {return NULL; }
-static inline void cpuidle_driver_unref(void) {}
 static inline void cpuidle_driver_state_disabled(struct cpuidle_driver *drv,
 					       int idx, bool disable) { }
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }



