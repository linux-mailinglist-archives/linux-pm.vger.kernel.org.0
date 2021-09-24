Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E556A41706C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbhIXKqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 06:46:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:25209 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhIXKqk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 06:46:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211123587"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="211123587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 03:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="436959466"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2021 03:45:05 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2] intel_idle: remove a couple of useless variables
Date:   Fri, 24 Sep 2021 13:45:04 +0300
Message-Id: <20210924104504.2430239-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924075920.2087149-1-dedekind1@gmail.com>
References: <20210924075920.2087149-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch is a cleanup and has no functional impact.

Remove the 'auto_demotion_disable_flags' and 'disable_promotion_to_c1e' global
variables because we already have them in the global 'icpu' structure. Other
'icpu' members like 'use_acpi' are not duplicated, and it's better to be
consistent on this. Consistency improves readability.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

Changes since v1:
 * fixed crash on a platform for which the driver does not have a table. In
   this case 'icpu' is NULL and we need to check for NULL in
   'intel_idle_cpu_init()'.

 drivers/idle/intel_idle.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 70c2237a7261..a73183016dd4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -67,9 +67,6 @@ static unsigned int disabled_states_mask;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
-static unsigned long auto_demotion_disable_flags;
-static bool disable_promotion_to_c1e;
-
 struct idle_cpu {
 	struct cpuidle_state *state_table;
 
@@ -1644,7 +1641,7 @@ static void auto_demotion_disable(void)
 	unsigned long long msr_bits;
 
 	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
-	msr_bits &= ~auto_demotion_disable_flags;
+	msr_bits &= ~icpu->auto_demotion_disable_flags;
 	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 }
 
@@ -1676,10 +1673,13 @@ static int intel_idle_cpu_init(unsigned int cpu)
 		return -EIO;
 	}
 
-	if (auto_demotion_disable_flags)
+	if (!icpu)
+		return 0;
+
+	if (icpu->auto_demotion_disable_flags)
 		auto_demotion_disable();
 
-	if (disable_promotion_to_c1e)
+	if (icpu->disable_promotion_to_c1e)
 		c1e_promotion_disable();
 
 	return 0;
@@ -1757,8 +1757,6 @@ static int __init intel_idle_init(void)
 	icpu = (const struct idle_cpu *)id->driver_data;
 	if (icpu) {
 		cpuidle_state_table = icpu->state_table;
-		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
-		disable_promotion_to_c1e = icpu->disable_promotion_to_c1e;
 		if (icpu->use_acpi || force_use_acpi)
 			intel_idle_acpi_cst_extract();
 	} else if (!intel_idle_acpi_cst_extract()) {
-- 
2.31.1

