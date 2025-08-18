Return-Path: <linux-pm+bounces-32507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A3B29CCA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8AD2A3628
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97023009C1;
	Mon, 18 Aug 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAnoPGOI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC2222256F
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507173; cv=none; b=KyEYvVLlYfQCNd9O6BB1lmKkcpHTDHMt099KiGFbrOdQTcAJB3IuC25Pp+x+OvG6Z772fklmlK/L8L1tmnenK0KvkWHLw+Q0VQqzK4rrrHMEmRVHYmoH/fuKZaOlRNzmv5Wo4/GZ2TPN+kELcICYbTT6LfCiNRQs9mY3sr0yHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507173; c=relaxed/simple;
	bh=MMgjjHur+oefZlT8P3IUvZUFYRkZ3XzTyhGOF8EDh4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrPbwLzbRVrqOHn3+BK9vu1Frxes7y78BpuTQX6OuheiPUGDoqUPpcgquoh66YcmSSbKJv8ktxQO/OaLMIIp6GsITYvyKg2pEeaW12hML8Du3f8Ug2fug9zCfK1Cd064wd/QLwG6bEcfF68r/tkPK5ViFzIZOBpDqSXiLxojYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAnoPGOI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755507171; x=1787043171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MMgjjHur+oefZlT8P3IUvZUFYRkZ3XzTyhGOF8EDh4w=;
  b=WAnoPGOIePzdUCSbkxipRw5CxZnkQuX+5zpdONEIHrVhIOkS9239Fb4v
   R0RitP14JQsgMXd9SDtpx1rcNzjWRcbCtN1McrR3TdVY956og2IpnLxRE
   7o15zpbOI7BMDKyM+9713fT6gASsDIBjYMqMEfhrT3Rfs/bOj7whiuCh4
   s6jF2dTcl712vmXIBXTS/u6YMuFl10Ox3aktVktcQ9u5sJU/cbe2Ae2kt
   2OQlwp40or2m8MZNQL5KmKabnJ5qYkisFjLTrZ/ODHcNzun/a92KeSuSB
   ww73ffUjy4un6iJ5cB8MRpWHwn5SS61NHzpylLNViXmS+w3bB0x/t6/Z0
   g==;
X-CSE-ConnectionGUID: YOwrT4RPTiSDnhiGKgC+8w==
X-CSE-MsgGUID: DGgI9FX9Sx2yRSc8T7VrfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="56754817"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="56754817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 01:52:50 -0700
X-CSE-ConnectionGUID: UZJM8051S025YInMwdrsdw==
X-CSE-MsgGUID: QKhoKjDoR/OIDhKA2T0nbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="204689008"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Aug 2025 01:52:48 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	artem.bityutskiy@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] intel_idle: Remove unnecessary address-of operators
Date: Mon, 18 Aug 2025 14:21:24 +0530
Message-Id: <20250818085124.3897921-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant address-of operators (&) when assigning the intel_idle
function pointer to the .enter field in cpuidle_state structures.in C,
the & is not needed for function names. This change improves code
consistency and readability by using the more conventional form without
the & operator.

No functional change intended.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/idle/intel_idle.c | 256 +++++++++++++++++++-------------------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 73747d20df85..bdd7e2dbec0e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -259,7 +259,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 3,
 		.target_residency = 6,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -267,7 +267,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -275,7 +275,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -283,7 +283,7 @@ static struct cpuidle_state nehalem_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -296,7 +296,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -304,7 +304,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -312,7 +312,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 211,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -320,7 +320,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
 		.target_residency = 345,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
@@ -328,7 +328,7 @@ static struct cpuidle_state snb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
 		.target_residency = 345,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -341,7 +341,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6N",
@@ -349,7 +349,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 275,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
@@ -357,7 +357,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 500,
 		.target_residency = 560,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
@@ -365,7 +365,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7S",
@@ -373,7 +373,7 @@ static struct cpuidle_state byt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -386,7 +386,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6N",
@@ -394,7 +394,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 275,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
@@ -402,7 +402,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 560,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
@@ -410,7 +410,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7S",
@@ -418,7 +418,7 @@ static struct cpuidle_state cht_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -431,7 +431,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -439,7 +439,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -447,7 +447,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -455,7 +455,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 300,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
@@ -463,7 +463,7 @@ static struct cpuidle_state ivb_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 87,
 		.target_residency = 300,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -476,7 +476,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -484,7 +484,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 80,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -492,7 +492,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -500,7 +500,7 @@ static struct cpuidle_state ivt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 82,
 		.target_residency = 300,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -513,7 +513,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -521,7 +521,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 250,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -529,7 +529,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 300,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -537,7 +537,7 @@ static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 84,
 		.target_residency = 400,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -550,7 +550,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -558,7 +558,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -566,7 +566,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 600,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -574,7 +574,7 @@ static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 88,
 		.target_residency = 700,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -587,7 +587,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -595,7 +595,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -603,7 +603,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 33,
 		.target_residency = 100,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -611,7 +611,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
@@ -619,7 +619,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -627,7 +627,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
@@ -635,7 +635,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -643,7 +643,7 @@ static struct cpuidle_state hsw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -655,7 +655,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -663,7 +663,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -671,7 +671,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 40,
 		.target_residency = 100,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -679,7 +679,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
@@ -687,7 +687,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -695,7 +695,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
@@ -703,7 +703,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -711,7 +711,7 @@ static struct cpuidle_state bdw_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -724,7 +724,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -732,7 +732,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C3",
@@ -740,7 +740,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 70,
 		.target_residency = 100,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -748,7 +748,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED | CPUIDLE_FLAG_IBRS,
 		.exit_latency = 85,
 		.target_residency = 200,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
@@ -756,7 +756,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x33) | CPUIDLE_FLAG_TLB_FLUSHED | CPUIDLE_FLAG_IBRS,
 		.exit_latency = 124,
 		.target_residency = 800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -764,7 +764,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED | CPUIDLE_FLAG_IBRS,
 		.exit_latency = 200,
 		.target_residency = 800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
@@ -772,7 +772,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED | CPUIDLE_FLAG_IBRS,
 		.exit_latency = 480,
 		.target_residency = 5000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -780,7 +780,7 @@ static struct cpuidle_state skl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED | CPUIDLE_FLAG_IBRS,
 		.exit_latency = 890,
 		.target_residency = 5000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -793,7 +793,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -801,7 +801,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -809,7 +809,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED | CPUIDLE_FLAG_IBRS,
 		.exit_latency = 133,
 		.target_residency = 600,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -822,7 +822,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -830,7 +830,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 4,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -838,7 +838,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 170,
 		.target_residency = 600,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -861,7 +861,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -869,7 +869,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -877,7 +877,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 220,
 		.target_residency = 600,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -885,7 +885,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 280,
 		.target_residency = 800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -893,7 +893,7 @@ static struct cpuidle_state adl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 680,
 		.target_residency = 2000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -906,7 +906,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -914,7 +914,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -922,7 +922,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 170,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -930,7 +930,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 600,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -938,7 +938,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 230,
 		.target_residency = 700,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -951,7 +951,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -959,7 +959,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 420,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -967,7 +967,7 @@ static struct cpuidle_state mtl_l_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 310,
 		.target_residency = 930,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -980,7 +980,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -988,7 +988,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -996,7 +996,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 195,
 		.target_residency = 585,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -1004,7 +1004,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 260,
 		.target_residency = 1040,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -1012,7 +1012,7 @@ static struct cpuidle_state gmt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 660,
 		.target_residency = 1980,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1025,7 +1025,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1033,7 +1033,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1042,7 +1042,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 					   CPUIDLE_FLAG_INIT_XSTATE,
 		.exit_latency = 290,
 		.target_residency = 800,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1055,7 +1055,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1063,7 +1063,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 4,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1073,7 +1073,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 170,
 		.target_residency = 650,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6P",
@@ -1083,7 +1083,7 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 210,
 		.target_residency = 1000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1096,7 +1096,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1104,7 +1104,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 4,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1114,7 +1114,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 220,
 		.target_residency = 650,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6P",
@@ -1124,7 +1124,7 @@ static struct cpuidle_state gnrd_cstates[] __initdata = {
 					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 240,
 		.target_residency = 750,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1137,7 +1137,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C2",
@@ -1145,7 +1145,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10),
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C4",
@@ -1153,7 +1153,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
 		.target_residency = 400,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1161,7 +1161,7 @@ static struct cpuidle_state atom_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1173,7 +1173,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 4,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C4",
@@ -1181,7 +1181,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
 		.target_residency = 400,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1189,7 +1189,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7",
@@ -1197,7 +1197,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
@@ -1205,7 +1205,7 @@ static struct cpuidle_state tangier_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1217,7 +1217,7 @@ static struct cpuidle_state avn_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1225,7 +1225,7 @@ static struct cpuidle_state avn_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x51) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 15,
 		.target_residency = 45,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1237,7 +1237,7 @@ static struct cpuidle_state knl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle },
 	{
 		.name = "C6",
@@ -1245,7 +1245,7 @@ static struct cpuidle_state knl_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 120,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle },
 	{
 		.enter = NULL }
@@ -1258,7 +1258,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1266,7 +1266,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1274,7 +1274,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 133,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C7s",
@@ -1282,7 +1282,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x31) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 155,
 		.target_residency = 155,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C8",
@@ -1290,7 +1290,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1000,
 		.target_residency = 1000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C9",
@@ -1298,7 +1298,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2000,
 		.target_residency = 2000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C10",
@@ -1306,7 +1306,7 @@ static struct cpuidle_state bxt_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 10000,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1319,7 +1319,7 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1327,7 +1327,7 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1335,7 +1335,7 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 50,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1352,7 +1352,7 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1360,7 +1360,7 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 15,
 		.target_residency = 25,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6",
@@ -1368,7 +1368,7 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 130,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1381,7 +1381,7 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1389,7 +1389,7 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 10,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
@@ -1397,7 +1397,7 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 500,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
@@ -1410,7 +1410,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C1E",
@@ -1418,7 +1418,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 10,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6S",
@@ -1427,7 +1427,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 270,
 		.target_residency = 700,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.name = "C6SP",
@@ -1436,7 +1436,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 310,
 		.target_residency = 900,
-		.enter = &intel_idle,
+		.enter = intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
 		.enter = NULL }
-- 
2.34.1


