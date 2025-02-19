Return-Path: <linux-pm+bounces-22496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7DA3CACA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31547189B500
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2C2566EB;
	Wed, 19 Feb 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIAuUmP/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8E2566E4;
	Wed, 19 Feb 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999002; cv=none; b=mWpRVuSGrYLv6CxROusicv3egvFQ0G+28q91EXCeBrNLVGdzCcxXE1mGz/DuL9S/Gpe+GdQFawPSFLdwfvMkUWKovKr/oRxdGdMrBnnxRQFmwlO10J9x4ma3WMznbOzKyNakuu9rzBUOxhr6PEpUz7Dhd4gdVBAb8d9I4Ui210o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999002; c=relaxed/simple;
	bh=6tdRCHYYbUcSAoAig+/AynHxVZA9IBeICBlSn2tn6wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyS2qY1Etc/yI62Ae3hbsJf5Nw69Qd0LxCh9/66P2aodE4YSqSAtYPkr3NWPZlYf+ZQjZAL/Pj37qdHodSezbLmn2uqFWy5fwSc9hujX05ZfTF+un1GWQDtPwC0hAzafao90CRhx8YVriKKmOeXR7hhwVAUO4iQ4p6q87TtEYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIAuUmP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F468C4CEE6;
	Wed, 19 Feb 2025 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999001;
	bh=6tdRCHYYbUcSAoAig+/AynHxVZA9IBeICBlSn2tn6wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIAuUmP/Y7RvUjfcazKiX46BGvaz/kocBDuDQCwxcQFD0SFnC4T3wofiI8W8VD0Yo
	 FLl+XHyLsya34aFLh1TNhZD1tgf7Hz/FA6Qrq6oA7eoQE1SrtxVBdBfK141t5tcvbL
	 xhlNkOFQy82VRuIL7UUFkcMlZatNnquAn2XdykviYzZxOx0NwcaGYxnAJZ/O7wNmXw
	 bQA7wprGA9KautazrvBtmwLgfEU4bnvClWgoFUtXdKgdplDVCP+98YZo6D1X4ZgFtK
	 1LrWKuCiMcZ4XHBf7TL45a1PmkOIMUYTDBvSXchbicxNBydxDKDlTrDcVK5GeZMmDK
	 AszvnGZ+Jp1HQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 05/19] cpufreq/amd-pstate: Overhaul locking
Date: Wed, 19 Feb 2025 15:02:48 -0600
Message-ID: <20250219210302.442954-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pstate_cpu_boost_update() and refresh_frequency_limits() both
update the policy state and have nothing to do with the amd-pstate
driver itself.

A global "limits" lock doesn't make sense because each CPU can have
policies changed independently.  Each time a CPU changes values they
will atomically be written to the per-CPU perf member. Drop per CPU
locking cases.

The remaining "global" driver lock is used to ensure that only one
entity can change driver modes at a given time.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a6066fb4ffb63..85e3daddb56e0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 	return -EINVAL;
 }
 
-static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
 static u8 msr_get_epp(struct amd_cpudata *cpudata)
@@ -752,7 +751,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	refresh_frequency_limits(policy);
@@ -1175,8 +1173,6 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	ret = amd_pstate_set_energy_pref_index(policy, ret);
 
 	return ret ? ret : count;
@@ -1349,8 +1345,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
-	if (mode_state_machine[cppc_state][mode_idx])
+	if (mode_state_machine[cppc_state][mode_idx]) {
+		guard(mutex)(&amd_pstate_driver_lock);
 		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	}
 
 	return 0;
 }
@@ -1371,7 +1369,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
 
 	return ret < 0 ? ret : count;
@@ -1643,8 +1640,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
@@ -1684,8 +1679,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		guard(mutex)(&amd_pstate_limits_lock);
-
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(policy);
 
-- 
2.43.0


