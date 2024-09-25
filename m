Return-Path: <linux-pm+bounces-14668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE02985822
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3025E2829A3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35B17DE15;
	Wed, 25 Sep 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+guAPOM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370317CA16;
	Wed, 25 Sep 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264211; cv=none; b=bk6Tf7hPzk5nULYgEBCLH1cTilgs5YPc/gc/T8DTAMkdbKoa3nY1V7AdwHu4VX5Kd4A51eu+egkOAb/VL0ynjt2lyNlTqVROUK1vS6TY347E8LhYTQSpEZjHAFir2pDCXyy9aHRWvd2WOP3ghTFU5LPjhFCB7WvfQVeXccmMmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264211; c=relaxed/simple;
	bh=1KFSo2JJR5BRcSgzdzgu8XCHZUUmjaS5k4pywFzQCNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3gHPGk9lNgLfQvtX/CB8vDAbd+Cpdl7euCfQjpSkcHJ7HK5Vbh8UVrdaR+Vy1WuSbABnlfy6PyMohIvrJ80jG+psMr8iL9vJsahZCYdcfNccCdqgMBIgDmPk3QlQ/aZ5MjzXLX23O8pj/FvbL9anDSSP4UKvZ+KuhlXYlhrSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+guAPOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A47C4CEC7;
	Wed, 25 Sep 2024 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264211;
	bh=1KFSo2JJR5BRcSgzdzgu8XCHZUUmjaS5k4pywFzQCNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+guAPOMGZ14rxao4C14fiyGoQDSC15PIvqt0Kv+zKB7/CfKvnD27r2m9RlECaM4I
	 8wzjNcB4JK8q0vz0k3z+fs3HUi/uxuORbiQmBqocrm8i6LVUQQJKXP7pKczkXBJ8OJ
	 CRI4Kjp1f5b3nCAuL+53L4wiRxG1IU+oezRnI/v+c+4YpjNvMl6IQ4GiXNKASgRVnE
	 yOLndeANoV/wHAdeiQvx2HfVrKJSP77j2GoK+MDO+L3bfLOiSua9Gp5MhuJp7/g08W
	 doPPtY86no6ChQxqpeBXZ3xusgW+2yMSPAR9tkPVAJ+c1xL1kB8ewVJvj5LiAYNUJh
	 OZU+n2CsFWtSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jacob.jun.pan@linux.intel.com,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 005/244] intel_idle: Disable promotion to C1E on Jasper Lake and Elkhart Lake
Date: Wed, 25 Sep 2024 07:23:46 -0400
Message-ID: <20240925113641.1297102-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 5bb33212b5c664396e5de4cd5a2999abb84a3978 ]

PCIe ethernet throughut is sub-optimal on Jasper Lake and Elkhart Lake.

The CPU can take long time to exit to C0 to handle IRQ and perform DMA
when C1E has been entered.

For this reason, adjust intel_idle to disable promotion to C1E and still
use C-states from ACPI _CST on those two platforms.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219023
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://patch.msgid.link/20240820041128.102452-1-kai.heng.feng@canonical.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/idle/intel_idle.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9aab7abc2ae90..ac1c6f4f9c7f2 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1475,6 +1475,10 @@ static const struct idle_cpu idle_cpu_dnv __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_tmt __initconst = {
+	.disable_promotion_to_c1e = true,
+};
+
 static const struct idle_cpu idle_cpu_snr __initconst = {
 	.state_table = snr_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1538,6 +1542,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
 	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,       &idle_cpu_tmt),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,     &idle_cpu_tmt),
 	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&idle_cpu_snr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&idle_cpu_grr),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&idle_cpu_srf),
@@ -2075,7 +2081,7 @@ static void __init intel_idle_cpuidle_driver_init(struct cpuidle_driver *drv)
 
 	drv->state_count = 1;
 
-	if (icpu)
+	if (icpu && icpu->state_table)
 		intel_idle_init_cstates_icpu(drv);
 	else
 		intel_idle_init_cstates_acpi(drv);
@@ -2209,7 +2215,11 @@ static int __init intel_idle_init(void)
 
 	icpu = (const struct idle_cpu *)id->driver_data;
 	if (icpu) {
-		cpuidle_state_table = icpu->state_table;
+		if (icpu->state_table)
+			cpuidle_state_table = icpu->state_table;
+		else if (!intel_idle_acpi_cst_extract())
+			return -ENODEV;
+
 		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
 		if (icpu->disable_promotion_to_c1e)
 			c1e_promotion = C1E_PROMOTION_DISABLE;
-- 
2.43.0


