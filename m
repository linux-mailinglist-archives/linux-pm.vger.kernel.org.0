Return-Path: <linux-pm+bounces-21508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D1A2B47A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD541679DF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7366246326;
	Thu,  6 Feb 2025 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+83Ga91"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F5237169;
	Thu,  6 Feb 2025 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879041; cv=none; b=K5NFO/lAg2R1N3UJwRLEjmT67u3P46/bZcl4BUhhG/v9i+UZsbN4XpppNWbPNWpqcWQZLMLMn3+sOsr22YUHsQZkxqJN49h0+5FoYAs6BwCNXcVO+3GOOR/167ySCxnj64FAdN64/UljxEY/ksK04xebOsIOyB4cASXRofMjQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879041; c=relaxed/simple;
	bh=Li0T4JMqAU+La8pbVDHzvAeioQXumRVuPuLK6pk0Mt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLngFH56X23ibd2euUibBmKxe0WACQPLWGhrkGhlu6Vo5ZPwhQdFzZ7mAxdoED1CRBX7Wkz5hKd2IdPnZvPPFftUs7Obnf4Uyb9rQYUSU/7/T2aQ5ypoA3K1UgYhA39hCy3tRht26JsgPgiza74fcwPY0LEoJmCRb0tJzlEkX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+83Ga91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA7FC4CEDF;
	Thu,  6 Feb 2025 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879041;
	bh=Li0T4JMqAU+La8pbVDHzvAeioQXumRVuPuLK6pk0Mt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+83Ga91tdtgo0HNEA1gV9eqvVjS+pVLIBsaa9huKUi6N1VttGAmhxjRlYKUeldRB
	 o1yVdYGaodlqowDWa90BHZ/0Zg8DjovjGs2LjO12gjT9dfnGItdrirABTxeH7IykZc
	 oMHFtR/zYyL+SuLcWQ+ob5NdRduDoJfINrJqpJq2+bTq6Bv/HndfxF+KcQsqLgDi8p
	 UNozjfkET5IqKkyqpOKy4D8+sJLkvMgKcOBHQOfouDIcASvC5jQCifC7VSHqv+2R4J
	 XwATgstCMv1+AjoyvCDc7iqsZhEu+8eSfS4cUNBreg4zOrQInK7Nbmjl1WLoKSTS5L
	 TQmLM5nugAvIg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 04/14] cpufreq/amd-pstate: Overhaul locking
Date: Thu,  6 Feb 2025 15:56:49 -0600
Message-ID: <20250206215659.3350066-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206215659.3350066-1-superm1@kernel.org>
References: <20250206215659.3350066-1-superm1@kernel.org>
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
policies changed independently.  Instead introduce locks into to the
cpudata structure and lock each CPU independently.

The remaining "global" driver lock is used to ensure that only one
entity can change driver modes at a given time.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++----------
 drivers/cpufreq/amd-pstate.h |  2 ++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 77bc6418731ee..dd230ed3b9579 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 	return -EINVAL;
 }
 
-static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
 static u8 msr_get_epp(struct amd_cpudata *cpudata)
@@ -283,6 +282,8 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
 	u64 value, prev;
 	int ret;
 
+	lockdep_assert_held(&cpudata->lock);
+
 	value = prev = READ_ONCE(cpudata->cppc_req_cached);
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
@@ -315,6 +316,8 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
+	lockdep_assert_held(&cpudata->lock);
+
 	if (epp == cpudata->epp_cached)
 		return 0;
 
@@ -335,6 +338,8 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 epp;
 
+	guard(mutex)(&cpudata->lock);
+
 	if (!pref_index)
 		epp = cpudata->epp_default;
 	else
@@ -750,7 +755,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	refresh_frequency_limits(policy);
@@ -973,6 +977,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	mutex_init(&cpudata->lock);
+	guard(mutex)(&cpudata->lock);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1179,8 +1186,6 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	ret = amd_pstate_set_energy_pref_index(policy, ret);
 
 	return ret ? ret : count;
@@ -1353,8 +1358,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
-	if (mode_state_machine[cppc_state][mode_idx])
+	if (mode_state_machine[cppc_state][mode_idx]) {
+		guard(mutex)(&amd_pstate_driver_lock);
 		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	}
 
 	return 0;
 }
@@ -1375,7 +1382,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
 
 	return ret < 0 ? ret : count;
@@ -1472,6 +1478,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	mutex_init(&cpudata->lock);
+	guard(mutex)(&cpudata->lock);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1558,6 +1567,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	union perf_cached perf;
 	u8 epp;
 
+	guard(mutex)(&cpudata->lock);
+
 	amd_pstate_update_min_max_limit(policy);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1646,8 +1657,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
@@ -1684,8 +1693,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		guard(mutex)(&amd_pstate_limits_lock);
-
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(policy);
 
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index a140704b97430..6d776c3e5712a 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -96,6 +96,8 @@ struct amd_cpudata {
 	bool	boost_supported;
 	bool	hw_prefcore;
 
+	struct mutex	lock;
+
 	/* EPP feature related attributes*/
 	u8	epp_cached;
 	u32	policy;
-- 
2.43.0


