Return-Path: <linux-pm+bounces-17104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7299C04F9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 12:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9100B21D8A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C32076BA;
	Thu,  7 Nov 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtnh4e7T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493A1D95B0
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980572; cv=none; b=VjBwWbjX9JLLhrWwnjWmB4wcHawHI0OHK9Nu/jypUcUCY4Zuvhmh8wiKZ/qEyu2NPsjli/HbJy04iJDLTJOG9YMKozVW29CYcFR4TMaGUh5KMvspEkdUSLYPNMqqfrcBQFP4EF+heoNLgEiFttum+AdDZ2TFF0kNUX17t7ZpwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980572; c=relaxed/simple;
	bh=t83gPAjBLIkh+ZIvB8UfzQlaBlQDLiPc6u4B6+hxmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/pSnOYr7z0RpauTIUVGGrgr0NBbNxS1IPxC/KrUPSj8HJGY3MmZvuIHQpHoaHTnN3tEv0SlHe3tLOI4Vbzj/QY8G7BAJc7bkwF5i/aifHHzgC7Sh7+zGPHTQtEu5tA3U93BhMOwkX8N+fpi925e0Y2203AZIUELx3tgPo/8v2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtnh4e7T; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730980571; x=1762516571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t83gPAjBLIkh+ZIvB8UfzQlaBlQDLiPc6u4B6+hxmkY=;
  b=gtnh4e7TAzCuQrj2fiO+TheVviF4uzncjhUL3OnwiZ/ENkxmh5Is7wBP
   8gV3oSeQVC2xQqYItcXz14bDs79EBBm+O+aV3IM+bVn+CWj6DLRNi5MlC
   GKexVZAbgxuFzniNioa66554g7VK7BJ4Ep2okn5hpZVruvu+eQlvmpIeW
   LbK9ezQQLtPUjOX73EmCQSxGq8V/9AdylNOE0eZjKeCcxAVHSSi5NqHOe
   C5/7PnnNFc5NpBraszrt4M5tu8H2KSmW7JEt+O9A5fUERVXw9waRsds3h
   ro44g6EppvVMZd/+gsZi/PHfyhD9ODsOitQcyQRRxMAGiH4BrXe1UjzJs
   Q==;
X-CSE-ConnectionGUID: KOlc7s+8TsWbz6latBGPlw==
X-CSE-MsgGUID: gSg8sQ4XRdaZLrx1pRTG0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30674519"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30674519"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 03:56:11 -0800
X-CSE-ConnectionGUID: n77+zIogTg2fEiJIBpObJw==
X-CSE-MsgGUID: Yu39RSO6RiCYqzB16fd32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="89692756"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2024 03:56:09 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>,
	Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] intel_idle: add Granite Rapids Xeon D support
Date: Thu,  7 Nov 2024 13:56:07 +0200
Message-ID: <20241107115608.52233-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Granite Rapids Xeon C C-states support: C1, C1E, C6, and C6P.

The C-states are basically the same as in Granite Rapids Xeon SP/AP, but
characteristics (latency, target residency) are a bit different.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 67aebfe0fed6..ac4d8faa3886 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1069,6 +1069,47 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state gnrd_cstates[] __initdata = {
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
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_INIT_XSTATE |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
+		.exit_latency = 220,
+		.target_residency = 650,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6P",
+		.desc = "MWAIT 0x21",
+		.flags = MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_INIT_XSTATE |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
+		.exit_latency = 240,
+		.target_residency = 750,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E",
@@ -1508,6 +1549,12 @@ static const struct idle_cpu idle_cpu_gnr __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_gnrd __initconst = {
+	.state_table = gnrd_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_avn __initconst = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1593,6 +1640,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&idle_cpu_gnr),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	&idle_cpu_gnrd),
 	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&idle_cpu_bxt),

base-commit: ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2
-- 
2.43.1


