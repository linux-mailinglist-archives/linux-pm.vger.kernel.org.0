Return-Path: <linux-pm+bounces-22270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A5A38EB5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1681892913
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF181B0F14;
	Mon, 17 Feb 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR+NF5iJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952961B043F;
	Mon, 17 Feb 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830059; cv=none; b=cxSv09JVK3giCZsp0EjdIsHhq9dCeN7krIEIzTFPcSlLGxSBSF+simwtRBhTvWGDoisva6KB+W+xF2UocSSx4YD16BWFOeswqBDtiF4Vy8aZMwSN/WgNH3d++H6LVALM1NOzkwdT3kHi6tKJRLEsNxmHepDJewuxRnQITUr9D70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830059; c=relaxed/simple;
	bh=ZwzdIdt4tkKwefeyJENY+sytzRynuXgJIrZ1aQEJcHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7Y8qpxaPCc+E6Pda7d9XkvO2N49QyZZAmbF7PquGQ0vDl3mNjixf6IbEwoiAm5D5XcXrQRdxhy/j9fbjgHhdlu/UxZcMgImMMV1Lp4l7csZnHhDAHg81noZ3cRiti/JA5RA1nUahKutzuKFntKXJBt2Mr4q8fFRUqJ356TAeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR+NF5iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744FFC4CEE2;
	Mon, 17 Feb 2025 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830059;
	bh=ZwzdIdt4tkKwefeyJENY+sytzRynuXgJIrZ1aQEJcHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GR+NF5iJcJwegq+O3cPmtK7oZPxYVzHiT0W/q7bF3gMqhlkjSZVIZKHUtph4CMycv
	 JGXrUlgQLMHMaK0EyKOuSNxkoiF/BsZmTwrB8J+q4q5a7bHkzEM+qbGzeaPZR+4/MA
	 anrXNh0pjy0WvJMM4lhQCuZVx0/LC9WDM1NIADxfNCyneKYJdTqxH/fMxmxXpoVULU
	 nCX7O5sNutvW34xRV1naILbmFaXpvjd9z02gz/k30JWzcRzZs82Qnm719gI2HdOrii
	 lf51dZpbNfOvMClUKJWSkI9TlbdzzfyncZUotsGtSXpUzRn6retozaaLsYdWRm8QPX
	 GjmNaHwY1F5CQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 05/18] cpufreq/amd-pstate: Overhaul locking
Date: Mon, 17 Feb 2025 16:06:54 -0600
Message-ID: <20250217220707.1468365-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217220707.1468365-1-superm1@kernel.org>
References: <20250217220707.1468365-1-superm1@kernel.org>
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
index 5a23457a354d1..92ef2e6612a62 100644
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
@@ -1173,8 +1171,6 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	ret = amd_pstate_set_energy_pref_index(policy, ret);
 
 	return ret ? ret : count;
@@ -1347,8 +1343,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
-	if (mode_state_machine[cppc_state][mode_idx])
+	if (mode_state_machine[cppc_state][mode_idx]) {
+		guard(mutex)(&amd_pstate_driver_lock);
 		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	}
 
 	return 0;
 }
@@ -1369,7 +1367,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
 
 	return ret < 0 ? ret : count;
@@ -1641,8 +1638,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
@@ -1682,8 +1677,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		guard(mutex)(&amd_pstate_limits_lock);
-
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(policy);
 
-- 
2.43.0


