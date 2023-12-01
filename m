Return-Path: <linux-pm+bounces-619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4FD801249
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 19:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793661C20A05
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B924EB4A;
	Fri,  1 Dec 2023 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3DaGH8T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97067FF;
	Fri,  1 Dec 2023 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454196; x=1732990196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZAqXOnxDi8CJBM0P2gmiWJwpeYA52txwCkVi6p934tY=;
  b=H3DaGH8TIFYzczk0AdpXA6G8kfWthkuSP1ss257HArQn8+jv3vWtlrZ3
   YKAxwCLD0gpoGs+gAi9uIXvnrc808hROrMAzL1tcRfjmXTDo7oLXDdFgf
   Q8ZsFhRw/Au+fc98j0TgMEqjG3Hv1B2VZI2tT1MUjSQu4B6o1GByO89tI
   CW+KuN9lm/6PbtR1IPoEPee64C92wL/riAXSXVCSoXv/or6qKlm9U1AMI
   hA3eEUtFnANEqSrbbEMApUktwQKM/L+ytBNHqGUvuZFuEInpNpt2UX+LJ
   /S09IIaQ6CqZ17ZIlSG1e5PSshvifwAe4omD9+IDuz/3zamaWOCj7f0IO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396330408"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="396330408"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804146951"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="804146951"
Received: from shwdedcgde01.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.208.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:09:54 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] intel_idle: Add Meteorlake support
Date: Sat,  2 Dec 2023 02:09:28 +0800
Message-Id: <20231201180928.1103797-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add intel_idle support for MeteorLake.

C1 and C1E states on Meteorlake are mutually exclusive like Alderlake
and Raptorlake, but they have little latency difference with measureable
power difference. Thus always enable "C1E promotion" bit and expose C1E
only.

Expose C6 because it has less power compared with C1E, and smaller
latency compared with C8/C10.

Ignore C8 and expose C10 because C8 does not show latency advantage
compared with C10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dcda0afecfc5..cfd0b24fd7f1 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -923,6 +923,35 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state mtl_l_cstates[] __initdata = {
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 140,
+		.target_residency = 420,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C10",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 310,
+		.target_residency = 930,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state gmt_cstates[] __initdata = {
 	{
 		.name = "C1",
@@ -1349,6 +1378,10 @@ static const struct idle_cpu idle_cpu_adl_l __initconst = {
 	.state_table = adl_l_cstates,
 };
 
+static const struct idle_cpu idle_cpu_mtl_l __initconst = {
+	.state_table = mtl_l_cstates,
+};
+
 static const struct idle_cpu idle_cpu_gmt __initconst = {
 	.state_table = gmt_cstates,
 };
@@ -1423,6 +1456,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&idle_cpu_mtl_l),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&idle_cpu_gmt),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&idle_cpu_spr),
-- 
2.34.1


