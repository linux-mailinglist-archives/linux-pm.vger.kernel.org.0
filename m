Return-Path: <linux-pm+bounces-11950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3A949539
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3042D1F21EC6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D4155CAD;
	Tue,  6 Aug 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaA3OZvx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728E155351
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960198; cv=none; b=Qu8cB7JEvNYAbvZwu9RZ+9iJxIBTnR7l5Gg0dpfI38aCcC20cgjRLsCYM84wLW8ydgOXutdVj/myaeIE2Uk/mrZNFkecjhojhepUhXRg2EpYZlDnJXpWZ8BOO51qRmN/ywKwHn2SKn87RVgmi5RJ9RqzVwQaMeIuodZDBfoSR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960198; c=relaxed/simple;
	bh=isLQceTqhL1zefGegQJZHAx1Xj58HC+fB3titdDSuvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+4rQ39YBDLw9uU02ODimUXe2q9Z62zJMpv4ScIyl7aEICLjScfcnHniRYVbwYzLJ4t/3YOb6YmzqXpfsmhwJlVPeWvUTFuCnHVfC2IsfVp61L2vNb4vkhdpc+zm/JlYNN5g1q0ssjoFg7ai3wgg3TCAzoY5cjrebRUgubGKW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaA3OZvx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722960197; x=1754496197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=isLQceTqhL1zefGegQJZHAx1Xj58HC+fB3titdDSuvo=;
  b=FaA3OZvxYG+9KClK7dOSezdK1nNUJFJ6KYRpMgAZcAWPHRwLDfZ0zc07
   qdl86pRN8IK8nR342qPWTuCQg5Ak/7LI3mz1MWj62gnbRzxkQZGqx2ySF
   xByWe72BSK09JOc6Uh/bu1M3UmaOdDLRJeM/VC0poDUPFT1HjDuooLSq1
   ErtsNzTEScKIIbOqkkT2/4rWJzwv1UcTTQWWJgFlsOMDvDY3QcRuWnlH0
   hM4uMaDQT4BVTBr7ssIuzUOECyJmPDCRfdDAE/jTHk62ZPXsdRDFhAAtJ
   UbwvyBN2H/y0WUIM9iRILNjrjZb26EOp7jWS7JYrDku6I6dqsWpZ7Z2dr
   g==;
X-CSE-ConnectionGUID: 6tWak2M7TIiz02IxEiSmBw==
X-CSE-MsgGUID: SDm0AwQBS32i6zmBzpzMgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38443155"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38443155"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:03:13 -0700
X-CSE-ConnectionGUID: Ixv5k5G4TA+qYgzFWyRb6g==
X-CSE-MsgGUID: 1O59h59PQ3ijUeEHFxsdNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56206014"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2024 09:03:11 -0700
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] intel_idle: add Granite Rapids Xeon support
Date: Tue,  6 Aug 2024 19:03:10 +0300
Message-ID: <20240806160310.3719205-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Granite Rapids Xeon C-states, which are C1, C1E, C6, and C6P.

Comparing to previous Xeon Generations (e.g., Emerald Rapids), C6 requests end
up only in core C6 state, and no package C-state happens (even if all cores are
in core C6). C6P requests also end up in core C6, but if all cores are idle,
the SoC enters the package C6 state.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

Used 'wult' tool for measuring 'exit_latency', and 'pbe' tool for measuring
'target_residency', both tools are part of the the 'wult' project:
https://github.com/intel/wult

 drivers/idle/intel_idle.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9aab7abc2ae9..e20f57ac307e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1022,6 +1022,45 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state gnr_cstates[] __initdata = {
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
+					   CPUIDLE_FLAG_INIT_XSTATE,
+		.exit_latency = 170,
+		.target_residency = 650,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6P",
+		.desc = "MWAIT 0x21",
+		.flags = MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_INIT_XSTATE,
+		.exit_latency = 210,
+		.target_residency = 1000,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E",
@@ -1453,6 +1492,12 @@ static const struct idle_cpu idle_cpu_spr __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_gnr __initconst = {
+	.state_table = gnr_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_avn __initconst = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1533,6 +1578,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&idle_cpu_gmt),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&idle_cpu_spr),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&idle_cpu_gnr),
 	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.43.1


