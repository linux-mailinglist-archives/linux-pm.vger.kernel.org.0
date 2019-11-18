Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008E710038D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 12:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRLL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 06:11:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48118 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRLL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 06:11:28 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b3af18d642a7f005; Mon, 18 Nov 2019 12:11:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpuidle: Introduce cpuidle_driver_state_disabled() for driver quirks
Date:   Mon, 18 Nov 2019 12:11:24 +0100
Message-ID: <5502311.VOJAVHccSv@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 99e98d3fb100 ("cpuidle: Consolidate disabled state checks")
overlooked the fact that the imx6q and tegra20 cpuidle drivers use
the "disabled" field in struct cpuidle_state for quirks which trigger
after the initialization of cpuidle, so reading the initial value of
that field is not sufficient for those drivers.

In order to allow them to implement the quirks without using the
"disabled" field in struct cpuidle_state, introduce a new helper
function and modify them to use it.

Fixes: 99e98d3fb100 ("cpuidle: Consolidate disabled state checks")
Reported-by: Len Brown <lenb@kernel.org> 
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/mach-imx/cpuidle-imx6q.c     |    4 ++--
 arch/arm/mach-tegra/cpuidle-tegra20.c |    2 +-
 drivers/cpuidle/driver.c              |   28 ++++++++++++++++++++++++++++
 include/linux/cpuidle.h               |    4 ++++
 4 files changed, 35 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -389,3 +389,31 @@ void cpuidle_driver_unref(void)
 
 	spin_unlock(&cpuidle_driver_lock);
 }
+
+/**
+ * cpuidle_driver_state_disabled - Disable or enable an idle state
+ * @drv: cpuidle driver owning the state
+ * @idx: State index
+ * @disable: Whether or not to disable the state
+ */
+void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
+				 bool disable)
+{
+	unsigned int cpu;
+
+	mutex_lock(&cpuidle_lock);
+
+	for_each_cpu(cpu, drv->cpumask) {
+		struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
+
+		if (!dev)
+			continue;
+
+		if (disable)
+			dev->states_usage[idx].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
+		else
+			dev->states_usage[idx].disable &= ~CPUIDLE_STATE_DISABLED_BY_DRIVER;
+	}
+
+	mutex_unlock(&cpuidle_lock);
+}
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -149,6 +149,8 @@ extern int cpuidle_register_driver(struc
 extern struct cpuidle_driver *cpuidle_get_driver(void);
 extern struct cpuidle_driver *cpuidle_driver_ref(void);
 extern void cpuidle_driver_unref(void);
+extern void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
+					bool disable);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_register_device(struct cpuidle_device *dev);
 extern void cpuidle_unregister_device(struct cpuidle_device *dev);
@@ -186,6 +188,8 @@ static inline int cpuidle_register_drive
 static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
 static inline struct cpuidle_driver *cpuidle_driver_ref(void) {return NULL; }
 static inline void cpuidle_driver_unref(void) {}
+static inline void cpuidle_driver_state_disabled(struct cpuidle_driver *drv,
+					       int idx, bool disable) { }
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
 {return -ENODEV; }
Index: linux-pm/arch/arm/mach-imx/cpuidle-imx6q.c
===================================================================
--- linux-pm.orig/arch/arm/mach-imx/cpuidle-imx6q.c
+++ linux-pm/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -62,13 +62,13 @@ static struct cpuidle_driver imx6q_cpuid
  */
 void imx6q_cpuidle_fec_irqs_used(void)
 {
-	imx6q_cpuidle_driver.states[1].disabled = true;
+	cpuidle_driver_state_disabled(&imx6q_cpuidle_driver, 1, true);
 }
 EXPORT_SYMBOL_GPL(imx6q_cpuidle_fec_irqs_used);
 
 void imx6q_cpuidle_fec_irqs_unused(void)
 {
-	imx6q_cpuidle_driver.states[1].disabled = false;
+	cpuidle_driver_state_disabled(&imx6q_cpuidle_driver, 1, false);
 }
 EXPORT_SYMBOL_GPL(imx6q_cpuidle_fec_irqs_unused);
 
Index: linux-pm/arch/arm/mach-tegra/cpuidle-tegra20.c
===================================================================
--- linux-pm.orig/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ linux-pm/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -203,7 +203,7 @@ void tegra20_cpuidle_pcie_irqs_in_use(vo
 {
 	pr_info_once(
 		"Disabling cpuidle LP2 state, since PCIe IRQs are in use\n");
-	tegra_idle_driver.states[1].disabled = true;
+	cpuidle_driver_state_disabled(&tegra_idle_driver, 1, true);
 }
 
 int __init tegra20_cpuidle_init(void)



