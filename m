Return-Path: <linux-pm+bounces-13301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D34967515
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 07:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16521F21DDD
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 05:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3C3A8CE;
	Sun,  1 Sep 2024 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLPdqJO2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654838DCD;
	Sun,  1 Sep 2024 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725166854; cv=none; b=ivWRPE8HGu4eB8zyG29Ic1ylViumgeyCYP1wvh1MsXbPZaNeDkLBzlRpeTBunt7Fq3XD+AP2+3RH0BOr46ANY2dGVBAMQtZT3JVlmGu0AU9ObxdQh+4pA4rSwbDnyonSywQi9kckJh5RTdG78k6/qHT9SzCalIkFbcGRf2LXjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725166854; c=relaxed/simple;
	bh=qS9OG2FwozCYC9N0Q7rAvjhikn2TbNYsFEDX6iax1xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6cUyhRWl9+G3vZLGbGkF+up4xsBcQKzptInkoo4vdklEq7LyFYavZVMMoXfGc0XrU/Qga4VLsPC5A8Eg06cK9pICEmFu69ddJDQHcRsjzB519L+tC2Kk5iBiue7tDEoq5xg4qvr30vs0835teC/uulfqHg7glvp1+o2xjdNLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLPdqJO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5551FC4CEC7;
	Sun,  1 Sep 2024 05:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725166853;
	bh=qS9OG2FwozCYC9N0Q7rAvjhikn2TbNYsFEDX6iax1xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLPdqJO2xJCPI1K23kMFOa1/jA7nbEwFTxV/pD2KejDjUkDmDHMVupkbevt7NvtY/
	 hhgXovT42M8FdV82Co6M0dTvnfbS395+llLLWMoA+kGHvljoPzOLblXDdLiFbjEvp3
	 nsxQCQHGAspAdSU+0AFgIqGDWbNv6Ezpm1AlnU4/toW/qbgFIhKdmkQB4Z+M2YE+PQ
	 /kulZ38Ltlmv3/5iADZ2evuhBs6fChUoY0eZ3lXBtBtXRFe2Jv2oYPbH6oFi/Jrt2Y
	 +rPR3hrdBiYYHpysVWzu0duFUKqE+nEUoZhFkuzgi+1wp05qGykLa31H7xxDx7u5w6
	 74mS+amNp9KlQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate: Add an early param to disable MSR mode
Date: Sun,  1 Sep 2024 00:00:34 -0500
Message-ID: <20240901050035.1739935-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240901050035.1739935-1-superm1@kernel.org>
References: <20240901050035.1739935-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This lets a system that supports the MSR run in shared memory mode
instead to help replicate and debug issues.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 Documentation/admin-guide/pm/amd-pstate.rst   |  5 +++
 drivers/cpufreq/amd-pstate.c                  | 32 +++++++++++++------
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9ff..041c609ed50ea 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -383,6 +383,11 @@
 			disable
 			  Disable amd-pstate preferred core.
 
+	amd_pstate_msr=
+			[X86]
+			disable
+			  Disable amd-pstate CPPC MSR (force shared memory).
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index d0324d44f5482..b06632556102e 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -411,6 +411,11 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
 always be advertised by the platform. But OS can choose to ignore that via the
 kernel parameter ``amd_prefcore=disable``.
 
+``amd_pstate_msr=disable``
+
+For systems that support a dedicated CPPC MSR, ignore it's use and run
+with shared memory instead.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 93adde45bebce..89438a3654002 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -88,6 +88,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+static bool amd_pstate_msr = true;
 static struct quirk_entry *quirks;
 
 /*
@@ -187,7 +188,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 	u64 epp;
 	int ret;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		if (!cppc_req_cached) {
 			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
 					&cppc_req_cached);
@@ -260,7 +261,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
 		value &= ~GENMASK_ULL(31, 24);
@@ -813,7 +814,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
 {
 	int ret;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		u64 cap1;
 
 		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
@@ -1058,7 +1059,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC))
+	if (amd_pstate_msr)
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
@@ -1288,7 +1289,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 	cppc_state = mode;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
+	if (amd_pstate_msr || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
 	for_each_present_cpu(cpu) {
@@ -1524,7 +1525,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1612,7 +1613,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = 0;
 
 	/* Set initial EPP value */
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	}
@@ -1657,7 +1658,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.max_perf = max_perf;
@@ -1691,7 +1692,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	mutex_lock(&amd_pstate_limits_lock);
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr) {
 		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 		/* Set max perf same as min perf */
@@ -1936,7 +1937,9 @@ static int __init amd_pstate_init(void)
 	}
 
 	/* capability check */
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
+	if (amd_pstate_msr)
+		amd_pstate_msr = cpu_feature_enabled(X86_FEATURE_CPPC);
+	if (amd_pstate_msr) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
@@ -2002,8 +2005,17 @@ static int __init amd_prefcore_param(char *str)
 	return 0;
 }
 
+static int __init amd_msr_param(char *str)
+{
+	if (!strcmp(str, "disable"))
+		amd_pstate_msr = false;
+
+	return 0;
+}
+
 early_param("amd_pstate", amd_pstate_param);
 early_param("amd_prefcore", amd_prefcore_param);
+early_param("amd_pstate_msr", amd_msr_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.43.0


