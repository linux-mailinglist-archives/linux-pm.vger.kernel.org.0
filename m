Return-Path: <linux-pm+bounces-37771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0014C4A68C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 02:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDF33AEFC1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AAC31283E;
	Tue, 11 Nov 2025 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ajaf+jEm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CE2737E3;
	Tue, 11 Nov 2025 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823352; cv=none; b=Fjo2hNlvkIPuTTDggk+PnReUsTAWI09liRZQk1Xbxh4aWJtZVPctzlJxHrYmTgel0WYTImn0GlAH3opFLbXPDSbJY3brqjZRI4VB7Yl4i+gM5kkBpd1FD7g092VVnbBtE3f+3vgto177yMeIhUO8RrqRq8NCVdh7Xjd/YCGv58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823352; c=relaxed/simple;
	bh=203wKZqkcpmLbfjOlXUE4QzwRNIAC0iIxUKUWkmEkxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmPWqciL5kxobTEOtTa+dqa7Xh8pKysTtZagJiJMwSbod2DZCsbz7KifFyWYMD/gywm/4nQ/bfByzqfh5lxFtzDSaU4URybQhPD0GvYDEc6474lyNasYKMjVKSknKObvxW9yCwFbxix6511qPP7ZWrglFpjaQiLM6nretAkuUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ajaf+jEm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762823350; x=1794359350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=203wKZqkcpmLbfjOlXUE4QzwRNIAC0iIxUKUWkmEkxQ=;
  b=Ajaf+jEmn/hR/WsHu7G0mOu+JDgLe5Xhpn7EzJvqlKz2CxXxnGbvd3C+
   C/b6/w20nsyG7LkcnJbXL7MiiVoofwvr1z0eW4453CApZKtVYYIYECwi4
   lqvCZeCplp75ZP12rzjWOsdEl6tu0WxbqJDuQv3b6YAR0bk66olmv0D6x
   HFCaKr79/NuSxrQocWiVT7ZsHh8mmHIFtbwm7Vo91Lmminhty6yf0N3V3
   GJHgdf/fCFmXZEpX7tV11xblQAgGYnhOHcvIMOslOrWOfVebWBzt5u5Px
   eS5CRleyv7EYWfAJfsaRZZevpsdOxjTcIMhAl/JJFqHapR2GmrjTZGyhJ
   g==;
X-CSE-ConnectionGUID: Rx2w0v3qSLeEifKief0n0Q==
X-CSE-MsgGUID: Jbe7T3boQMuhtoWVFwlhHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68740051"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="68740051"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:09:09 -0800
X-CSE-ConnectionGUID: zGdB5+i4TKm6Qt2vv4vy2g==
X-CSE-MsgGUID: MsbCTKQyQ9Gf+3kUhbixag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="194010231"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa005.jf.intel.com with ESMTP; 10 Nov 2025 17:09:10 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trenn@suse.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Aaron Rainbolt <arainbolt@kfocus.org>
Subject: [PATCH] cpufreq: intel_pstate: Check IDA feature only during MSR 0x199 write
Date: Mon, 10 Nov 2025 17:08:40 -0800
Message-ID: <20251111010840.141490-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in
legacy mode") introduced a check for feature X86_FEATURE_IDA to verify
turbo mode support. Although this is the correct way to check for turbo
mode, it causes issues on some platforms that disable turbo during OS
boot but enable it later. Without this feature check, users were able to
write 0 to /sys/devices/system/cpu/intel_pstate/no_turbo post-boot to
get turbo mode frequencies.

To restore the old behavior while still addressing the unchecked MSR
issue on some Skylake-X systems, limit the X86_FEATURE_IDA check to only
when setting MSR 0x199 Turbo Engage Bit (bit 32).

Fixes: ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode")
Reported-by: Aaron Rainbolt <arainbolt@kfocus.org>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2122531
Tested-by: Aaron Rainbolt <arainbolt@kfocus.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 38897bb14a2c..492a10f1bdbf 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -603,9 +603,6 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
-	if (!cpu_feature_enabled(X86_FEATURE_IDA))
-		return true;
-
 	rdmsrq(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
@@ -2106,7 +2103,8 @@ static u64 atom_get_val(struct cpudata *cpudata, int pstate)
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
+	    cpu_feature_enabled(X86_FEATURE_IDA))
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -2271,7 +2269,8 @@ static u64 core_get_val(struct cpudata *cpudata, int pstate)
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
+	    cpu_feature_enabled(X86_FEATURE_IDA))
 		val |= (u64)1 << 32;
 
 	return val;
-- 
2.51.0


