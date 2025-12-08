Return-Path: <linux-pm+bounces-39301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5829CACF03
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9805E3050BB1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80B31078B;
	Mon,  8 Dec 2025 10:59:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0CB3128AD;
	Mon,  8 Dec 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191599; cv=none; b=dR2E7fy1t1CmWb3sRj625OEfJaecQbwyMPmVND6QsIV2l4ggs5Q2pytaHxnGNr5LvuUsGamzI94Rhd2FXpBeWFZe+81QAZJgIUnIxZ1dGRFloXIHiCRQ9KKGC+GWZs1ga3cHAWSv0yPehNPcSlN9gOs+bha8LPeXr6WxShYCdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191599; c=relaxed/simple;
	bh=F5sirQo0blKuDpg2nMZiUwVRih7MduSsPXXR+XLdvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM22r1nKfJdS5FfrxL07Ldl+mFAbrT8EaX1rH46aE7dzpSWAnwqTJ7U5oyiWg0UzJp9oQBtoO55dZekd9oNBuSXcaRkM/zATEs9XH9LIlr4F5jl8DEDLjo6d5Pvetq0ayP7aKvWHD6f7/AjA8fq1690evkCp8INSBfFfsn+s7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E141691;
	Mon,  8 Dec 2025 02:59:48 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.88.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99D533F762;
	Mon,  8 Dec 2025 02:59:52 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhenglifeng1@huawei.com,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on boost_freq_req
Date: Mon,  8 Dec 2025 11:59:28 +0100
Message-ID: <20251208105933.1369125-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208105933.1369125-1-pierre.gondois@arm.com>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the existing set_boost() callbacks:
- Don't update policy->max as this is done through the qos notifier
  cpufreq_notifier_max() which calls cpufreq_set_policy().
- Remove freq_qos_update_request() calls as the qos request is now
  done in policy_set_boost() and updates the new boost_freq_req

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/amd-pstate.c   |  2 --
 drivers/cpufreq/cppc_cpufreq.c | 21 ++++-----------------
 drivers/cpufreq/cpufreq.c      | 14 ++------------
 3 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b44f0f7a5ba1c..50416358a96ac 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -754,8 +754,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	else if (policy->cpuinfo.max_freq > nominal_freq)
 		policy->cpuinfo.max_freq = nominal_freq;
 
-	policy->max = policy->cpuinfo.max_freq;
-
 	if (cppc_state == AMD_PSTATE_PASSIVE) {
 		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
 		if (ret < 0)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e23d9abea1359..3baf7baaec371 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -597,21 +597,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
-	/*
-	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
-	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
-	 */
-	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
-	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
-						caps->highest_perf : caps->nominal_perf);
-
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
 	 * available if userspace wants to use any perf between lowest & lowest
 	 * nonlinear perf
 	 */
 	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
-	policy->cpuinfo.max_freq = policy->max;
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
+						caps->highest_perf : caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
@@ -776,17 +769,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	int ret;
 
 	if (state)
-		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
-	policy->cpuinfo.max_freq = policy->max;
-
-	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-	if (ret < 0)
-		return ret;
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 65ef0fa70c388..ab2def9e4d188 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1514,10 +1514,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
-	} else {
-		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret < 0)
-			goto out_destroy_policy;
 	}
 
 	if (cpufreq_driver->get && has_target()) {
@@ -2819,16 +2815,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 		return -ENXIO;
 
 	ret = cpufreq_frequency_table_cpuinfo(policy);
-	if (ret) {
+	if (ret)
 		pr_err("%s: Policy frequency update failed\n", __func__);
-		return ret;
-	}
 
-	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
 
-- 
2.43.0


