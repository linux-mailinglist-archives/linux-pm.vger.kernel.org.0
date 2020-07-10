Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B821ADC7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 06:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgGJELG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 00:11:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:48310 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgGJELF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 00:11:05 -0400
IronPort-SDR: zthha9ddH52MsCsaeheEjUVTGXHBiHwoBCYKHae8iiNM4x+lLZaAAqWg0hwj6ZOED+Rfoz1CLq
 WE8g66mFQ3SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="135611521"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="135611521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 21:11:05 -0700
IronPort-SDR: O8JSIaYP8xEdErt152VGO90GCWM6m1o5mEKemJL0bHREATm5oBf16JEQe97HEdZ2/CohI0VM5z
 qXbRCTstSjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="389362043"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 21:11:02 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH][v2] intel_idle: Customize IceLake server support
Date:   Fri, 10 Jul 2020 12:12:01 +0800
Message-Id: <20200710041201.22390-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On ICX platform, the CPU frequency will slowly ramp up
when woken up from C-states deeper than/equals to C1E.
Although this feature does save energy in many cases
this might also cause unexpected result. For example,
workload might get unstable performance due to the uncertainty
of CPU frequency. Besides, the CPU frequency might not be locked
to specific level when the CPU utilization is low.

Thus this patch disables C1E auto-promotion and expose
C1E as a separate idle state, so that the C1E and C6 can
be disabled via sysfs when necessary.

Besides C1 and C1E, the exit latency of C6 was measured
by a dedicated tool. However the exit latency(41us) exposed
by _CST is much smaller than the one we measured(128us). This
is probably due to the _CST uses the exit latency when woken
up from PC0+C6, rather than PC6+C6 when C6 was measured. Choose
the latter as we need the longest latency in theory.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Minor commit message refinement for better understanding.
--
 drivers/idle/intel_idle.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f4495841bf68..1eab606d858b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -752,6 +752,35 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state icx_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 4,
+		.target_residency = 4,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 128,
+		.target_residency = 384,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E",
@@ -1056,6 +1085,12 @@ static const struct idle_cpu idle_cpu_skx __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_icx __initconst = {
+	.state_table = icx_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_avn __initconst = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1110,6 +1145,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.17.1

