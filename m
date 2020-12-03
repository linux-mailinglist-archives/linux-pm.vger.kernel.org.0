Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0252CE1AD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 23:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbgLCWbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 17:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgLCWbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Dec 2020 17:31:05 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen Yu <yu.c.chen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] intel_idle: fix intel_idle_state_needs_timer_stop build failure
Date:   Thu,  3 Dec 2020 23:30:13 +0100
Message-Id: <20201203223020.1173185-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added function is defined inside of an #ifdef section but
used outside, leading to a build failure:

drivers/idle/intel_idle.c:1510:7: error: implicit declaration of function 'intel_idle_state_needs_timer_stop' [-Werror,-Wimplicit-function-declaration]
                if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
                    ^

Move it ahead of the CONFIG_ACPI_PROCESSOR_CSTATE check.

Fixes: 6e1d2bc675bd ("intel_idle: Fix intel_idle() vs tracing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/idle/intel_idle.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7ee7ffe22ae3..d79335506ecd 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1140,6 +1140,20 @@ static bool __init intel_idle_max_cstate_reached(int cstate)
 	return false;
 }
 
+static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
+{
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	if (boot_cpu_has(X86_FEATURE_ARAT))
+		return false;
+
+	/*
+	 * Switch over to one-shot tick broadcast if the target C-state
+	 * is deeper than C1.
+	 */
+	return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);
+}
+
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 #include <acpi/processor.h>
 
@@ -1210,20 +1224,6 @@ static bool __init intel_idle_acpi_cst_extract(void)
 	return false;
 }
 
-static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
-{
-	unsigned long eax = flg2MWAIT(state->flags);
-
-	if (boot_cpu_has(X86_FEATURE_ARAT))
-		return false;
-
-	/*
-	 * Switch over to one-shot tick broadcast if the target C-state
-	 * is deeper than C1.
-	 */
-	return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);
-}
-
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
-- 
2.27.0

