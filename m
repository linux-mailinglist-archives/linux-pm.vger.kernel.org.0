Return-Path: <linux-pm+bounces-21235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358DBA24F22
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BEF162F01
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D011FAC58;
	Sun,  2 Feb 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbLgJ7Je"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C11D7E57
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516394; cv=none; b=SC5EMd6lmtOqi/q1gGzY0m3lGXHYFySYdIsoudv9MDVebSthqDttwpA2STMtNVo+jlu9eBOc+uB8l8142iaI/cljaT2hw1XoqD3fd3Ry6p+Sl7dCxTF2J18YaZAGHicZjIhK3IjkqEgjSs6qsnZqEg01ppyuz4+cVwWRENCB1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516394; c=relaxed/simple;
	bh=EvVJn3xRrjbeDc84ltW7ovM+DtAxQ+oFlxMhDD7729I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8QI+Ai7uI7eTptXN7sAJZZpBsBmlKd2Ga3blhXgsry/UoAeRvpv8YZpZk2tIrvmUZZudiUbVSn88mftew2tCwA7+gu0PYkWfFHqOAQ4S7ZY2VPFizOvegYNlGyZ0W3NfvgbHjSLYyoWNo/eO67v/QajYkz6apn66avs1S39z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbLgJ7Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F58C4CEE5;
	Sun,  2 Feb 2025 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516394;
	bh=EvVJn3xRrjbeDc84ltW7ovM+DtAxQ+oFlxMhDD7729I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=sbLgJ7JeMivQVUY/3rllUC9ThtBNlzDvwBUbESGVzYLaHALp8QTX2Ah18PR2cvM9q
	 /NNu677cidC7yw8DzTz47cYqd86U6IOU4XScjRvHo2h8+ms8d01p94Q9M1wgcJAfaV
	 KUPc/UYcgiZgwiuqtJ4S991ieEvlrkKPEUVckQIuqWJN4V8X3d4CrpFrnSc21KSy5P
	 j3KuHr0t7r5lJetd9HfQQwcZg+ylpDZpme3cND8aRc0hJX41H0WezeLA5QGvlcKXFU
	 DbLWdTmXe70pOyQB2FrOdYC+295+lbwYNT6saUu7VnHJns3bOVYatw6l0NIhxQ1/Ql
	 pJRt1CuAE/G4Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 12/25] tools/power turbostat: Add fixed RAPL PSYS divisor for SPR
Date: Sun,  2 Feb 2025 11:09:28 -0600
Message-ID: <debe797c1e972ebe434c90f3fa7f54d9cf7ab251.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Intel Sapphire Rapids is an exception and has fixed divisor for RAPL PSYS
counter set to 1.0. Add a platform bit and enable it for SPR.

Reported-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a2ca1c6c3638..1bcecfed721b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -358,7 +358,7 @@ unsigned long long cpuidle_cur_sys_lpi_us;
 unsigned int tj_max;
 unsigned int tj_max_override;
 double rapl_power_units, rapl_time_units;
-double rapl_dram_energy_units, rapl_energy_units;
+double rapl_dram_energy_units, rapl_energy_units, rapl_psys_energy_units;
 double rapl_joule_counter_range;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
@@ -424,6 +424,7 @@ struct platform_features {
 	bool has_per_core_rapl;	/* Indicates cores energy collection is per-core, not per-package. AMD specific for now */
 	bool has_rapl_divisor;	/* Divisor for Energy unit raw value from MSR_RAPL_POWER_UNIT */
 	bool has_fixed_rapl_unit;	/* Fixed Energy Unit used for DRAM RAPL Domain */
+	bool has_fixed_rapl_psys_unit;	/* Fixed Energy Unit used for PSYS RAPL Domain */
 	int rapl_quirk_tdp;	/* Hardcoded TDP value when cannot be retrieved from hardware */
 	int tcc_offset_bits;	/* TCC Offset bits in MSR_IA32_TEMPERATURE_TARGET */
 	bool enable_tsc_tweak;	/* Use CPU Base freq instead of TSC freq for aperf/mperf counter */
@@ -824,6 +825,7 @@ static const struct platform_features spr_features = {
 	.has_msr_core_c1_res = 1,
 	.has_irtl_msrs = 1,
 	.has_cst_prewake_bit = 1,
+	.has_fixed_rapl_psys_unit = 1,
 	.trl_msrs = TRL_BASE | TRL_CORECOUNT,
 	.rapl_msrs = RAPL_PKG_ALL | RAPL_DRAM_ALL | RAPL_PSYS,
 };
@@ -1292,7 +1294,7 @@ static const struct rapl_counter_arch_info rapl_counter_arch_infos[] = {
 	 .msr = MSR_PLATFORM_ENERGY_STATUS,
 	 .msr_mask = 0x00000000FFFFFFFF,
 	 .msr_shift = 0,
-	 .platform_rapl_msr_scale = &rapl_energy_units,
+	 .platform_rapl_msr_scale = &rapl_psys_energy_units,
 	 .rci_index = RAPL_RCI_INDEX_ENERGY_PLATFORM,
 	 .bic = BIC_SysWatt | BIC_Sys_J,
 	 .compat_scale = 1.0,
@@ -7112,6 +7114,11 @@ void rapl_probe_intel(void)
 	else
 		rapl_dram_energy_units = rapl_energy_units;
 
+	if (platform->has_fixed_rapl_psys_unit)
+		rapl_psys_energy_units = 1.0;
+	else
+		rapl_psys_energy_units = rapl_energy_units;
+
 	time_unit = msr >> 16 & 0xF;
 	if (time_unit == 0)
 		time_unit = 0xA;
-- 
2.43.0


