Return-Path: <linux-pm+bounces-39195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B404CA331D
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8FD30D3D84
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A498337699;
	Thu,  4 Dec 2025 10:14:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFE3358C6;
	Thu,  4 Dec 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843254; cv=none; b=bGg92IL8hgQAtT66s8ftIlQVN4o47f5pB29npkxTKR1VPXUMCc0GywYb3ZcRUyo/VSuUyItlDQShqFV9NsS0lTS3rg9iL292NPzpIeAXDrxlYw/0yKR9BppPmwU6ScMyC/J+IAV3s/njAQumPt9o+/4GrdlY9mmHcbFI5j82Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843254; c=relaxed/simple;
	bh=7p3Q3R/TN0IjnjA1YQqyM+/v+u0kbdHf83OddMbsRo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is9CFXkeHF7SURHD48UfmtpGyNxDz7af9WgdTqOd+BpItEmWWHdvtUNyHfqFb3fsA97DyxpwPBBzU9SZGlShIsXkDmmTCottKBYNlffkBJ6YRO+1VtnxtuyUb9YM/6jnoSKBL1qYftnfABBjOF9bn9ABmWyIkY554yCdnnpTxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D91E339;
	Thu,  4 Dec 2025 02:14:04 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB88B3F73B;
	Thu,  4 Dec 2025 02:14:08 -0800 (PST)
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
Subject: [PATCH v1 4/4] cpufreq: Update set_boost callbacks to rely on boost_freq_req
Date: Thu,  4 Dec 2025 11:13:40 +0100
Message-ID: <20251204101344.192678-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204101344.192678-1-pierre.gondois@arm.com>
References: <20251204101344.192678-1-pierre.gondois@arm.com>
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
 drivers/cpufreq/cppc_cpufreq.c | 20 ++++----------------
 drivers/cpufreq/cpufreq.c      | 10 ++--------
 3 files changed, 6 insertions(+), 26 deletions(-)

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
index e23d9abea1359..a2f64099d39a4 100644
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
@@ -779,14 +772,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	int ret;
 
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
index 9d98b98e7981c..c360af436f1ea 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2820,16 +2820,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
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


