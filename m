Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED921372B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgGCJEu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 05:04:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:38702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCJEt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jul 2020 05:04:49 -0400
IronPort-SDR: gOx/e53kru2QXxcGrCkwR5SHVbOdWD8h0ljxwyZ4z9zZw8uJy78Q7gODaakgUf3MKbpussjkDp
 1AZkBpFjGLfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="212138636"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="212138636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 02:04:49 -0700
IronPort-SDR: 7kxNk0o4XkdReLoS7Rl97nsKf0zg7Ab68OgR5Wx67aNMO4qoIBQDUUukFpNPR5EfNPNwg23b7O
 HMVaUxlgUUVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="267299967"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2020 02:04:44 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] intel_idle: Customize IceLake server support
Date:   Fri,  3 Jul 2020 17:02:42 +0800
Message-Id: <20200703090242.5564-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On ICX platform, the CPU frequency will slowly ramp up
when woken up from C-states deeper than/equals to C1E,
and since C1E auto-promotion is enabled by default,
this might cause unexpected result.

Thus this patch disables C1E auto-promotion and expose
C1E as a separate idle state, so that the C1E and C6 can
be disabled via sysfs when necessary.

Besides C1 and C1E, the exit latency of C6 was measured
by a dedicated tool. However the exit latency(41us) exposed
by _CST is much smaller than the one measured(128us). This
is probably due to the _CST uses the exit latency when woken
up from PC0+C6, rather than PC6+C6 when C6 was measured.

Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
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

