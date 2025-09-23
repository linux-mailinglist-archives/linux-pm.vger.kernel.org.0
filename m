Return-Path: <linux-pm+bounces-35230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C3B96957
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDE03AF703
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8D258EF3;
	Tue, 23 Sep 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIdSP5Sh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD6255222;
	Tue, 23 Sep 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641379; cv=none; b=TSyepEKIs9np8BYBZ3/e9sNFjz/etHPtRt2wVoZMro4MeYLn9lj2Ik4k1swJRgduYCNq7MiYKv5+3zuaHTE3H473ld0z/mexk9knGRBOVrdovtX0+6I9pJVnAiZlZMM2CYHtdfTUUaytb96cPOvhxcgTr++MpqvLIeHvkXIQRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641379; c=relaxed/simple;
	bh=6figqhN+fqqavs4AE5ijwFY0JtDX7qF//FIEuuuZwJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Duw0Nuzdb83Gm2Sns8f+IQUcfko2X4qrVHVjd+KQBXzkhdZmWNuRfYjSIEPnq/8f3XOfjrQbM55RqSNt/hOpcg25NKvByDf38wZtFRoBfR8v5ol4U2aTZ99HXBE4Yem5a+WOCZ2U+J/mEzU+YYX+wXbwe3Z/1geoHA4nXG42ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIdSP5Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC26C4CEF5;
	Tue, 23 Sep 2025 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641378;
	bh=6figqhN+fqqavs4AE5ijwFY0JtDX7qF//FIEuuuZwJE=;
	h=From:To:Cc:Subject:Date:From;
	b=oIdSP5ShOObqJ5sN4bHK9CwfnLl5PdwmaNHd3uUKHx3qGFaMhlKXPkbTODQiKJz8p
	 1FKk/2nsGrGPB8mTJxKWeeBnR+CpZkL3Gv/wWBJrQNm1mWqafYMkJWxkq54FrlDKp+
	 t0MKkKhHDNILKLpIdo+58gXIUDD6PVy2XJZC/efdsZu8X7z2oVL7axf6TLVQw8hceu
	 ZixDhdJywggC7MTFIgmD7eVimVVfrQKMxNmaBhZb8r4e97kmjHIff0wFB2WRttHkAp
	 QLOFTeudljJLSoz2QMhmKwGPbykzv0wsv9mpKYsPUUBo7OnLXyBEI3tBKO/pflxSEr
	 g1xb1wyOjk6sw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate
Date: Tue, 23 Sep 2025 10:29:29 -0500
Message-ID: <20250923152929.1306578-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After resuming from S4, all CPUs except the boot CPU have the wrong EPP
hint programmed.  This is because when the CPUs were offlined the EPP value
was reset to 0.

This is a similar problem as fixed by
commit ba3319e590571 ("cpufreq/amd-pstate: Fix a regression leading to EPP
0 after resume") and the solution is also similar.  When offlining rather
than reset the values to zero, reset them to match those chosen by the
policy. When the CPUs are onlined again these values will be restored.

Closes: https://community.frame.work/t/increased-power-usage-after-resuming-from-suspend-on-ryzen-7040-kernel-6-15-regression/74531/20?u=mario_limonciello
Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9f3b9dc26ab5..ba2adea03db1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1617,7 +1617,11 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
 	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
 	 */
-	return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+	return amd_pstate_update_perf(policy, perf.bios_min_perf,
+				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
+				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
+				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
+				     false);
 }
 
 static int amd_pstate_suspend(struct cpufreq_policy *policy)
-- 
2.51.0


