Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA76315CDC4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgBMWFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54186 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgBMWFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:06 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 74fd50b78f1f059c; Thu, 13 Feb 2020 23:05:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 4/9] intel_idle: Add __initdata annotations to init time variables
Date:   Thu, 13 Feb 2020 23:01:00 +0100
Message-ID: <14137087.YenDkMhGj7@kreacher>
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

Annotate static variables cpuidle_state_table and mwait_substates
with __initdata, because they are only used during the initialization
of the driver.

Also notice that static variable icpu could be annotated analogously
and the structure pointed to by it could be __initconst, but two of
its fields are accessed via icpu in intel_idle_cpu_init() and
auto_demotion_disable(), so introduce two new static variables,
auto_demotion_disable_flags and disable_promotion_to_c1e, to hold
the values of these fields, set them during the initialization and
use them in those functions instead of accessing the source data
structure via icpu.

That allows icpu to be annotated with __initdata, so do that,
and it will also allow some __initconst annotations to be added
subsequently.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e0332d567735..b7341e0b910a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -65,7 +65,11 @@ static struct cpuidle_driver intel_idle_driver = {
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask;
 
-static unsigned int mwait_substates;
+static unsigned int mwait_substates __initdata;
+
+static unsigned long auto_demotion_disable_flags;
+static bool disable_promotion_to_c1e;
+
 static bool lapic_timer_always_reliable;
 
 struct idle_cpu {
@@ -81,9 +85,9 @@ struct idle_cpu {
 	bool use_acpi;
 };
 
-static const struct idle_cpu *icpu;
+static const struct idle_cpu *icpu __initdata;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
-static struct cpuidle_state *cpuidle_state_table;
+static struct cpuidle_state *cpuidle_state_table __initdata;
 
 /*
  * Enable this state by default even if the ACPI _CST does not list it.
@@ -1519,7 +1523,7 @@ static void auto_demotion_disable(void)
 	unsigned long long msr_bits;
 
 	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
-	msr_bits &= ~(icpu->auto_demotion_disable_flags);
+	msr_bits &= ~auto_demotion_disable_flags;
 	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 }
 
@@ -1549,13 +1553,10 @@ static int intel_idle_cpu_init(unsigned int cpu)
 		return -EIO;
 	}
 
-	if (!icpu)
-		return 0;
-
-	if (icpu->auto_demotion_disable_flags)
+	if (auto_demotion_disable_flags)
 		auto_demotion_disable();
 
-	if (icpu->disable_promotion_to_c1e)
+	if (disable_promotion_to_c1e)
 		c1e_promotion_disable();
 
 	return 0;
@@ -1633,6 +1634,8 @@ static int __init intel_idle_init(void)
 	icpu = (const struct idle_cpu *)id->driver_data;
 	if (icpu) {
 		cpuidle_state_table = icpu->state_table;
+		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
+		disable_promotion_to_c1e = icpu->disable_promotion_to_c1e;
 		if (icpu->use_acpi || force_use_acpi)
 			intel_idle_acpi_cst_extract();
 	} else if (!intel_idle_acpi_cst_extract()) {
-- 
2.16.4





