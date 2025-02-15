Return-Path: <linux-pm+bounces-22125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45539A36A30
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673C717077B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D2155744;
	Sat, 15 Feb 2025 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgKmy8fU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06641547E9;
	Sat, 15 Feb 2025 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580781; cv=none; b=WFjmEF7DaMLsRaGCGotJSPueEbTUrmZwZvcq3WAhpZzVQzsbFbtL6D3iMW8xZRvQSJkWK/4+2B12bK87lEfY33PLWQpH6MVd4QCFtlEI5UQ/GVzsxijJbsKthjIjrHS9EotzwYe8aWBF4XGBTflb00oH3s51me1e8VrUkb04sC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580781; c=relaxed/simple;
	bh=1eu54laXX5QENxOyftPttloLUmqVslmlVOap9ITMfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvoPqiK4O2/OZYFc/sk/6D4TBdvhZXQslpF1FQb8/6ZQrEV6IevyS0Ffe6QoHApR3oUKNMyd70iHxRo3b2yEXbbU1rOlOeFmBnqxdQAgfuxjj3GAzU+Z1rTgQKuORP2gQ1LoGNqIn0srTfbOeoDLyOfnW8VrgiQ/xTZWaFxyVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgKmy8fU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD00BC4CEE6;
	Sat, 15 Feb 2025 00:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580780;
	bh=1eu54laXX5QENxOyftPttloLUmqVslmlVOap9ITMfoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WgKmy8fUQV3a5wZ2YaL+2RA8ST89pLI7q2tMr+Klh+dKqNiNDVs+eQu5YDQxtDMIv
	 EzLKHymXy+OxXy+LYRbHtXZupFo+nIJw811hLBOAVfIzgH13eRRjW6VHP5LHgkqoht
	 NRcbyZWmhNB+eAxIDD+KXOGqy+40JCna//22PRwSkKZ10VPVZAx5FsqSgjt8ZYiw/C
	 /2+k9rHa/+GPaajXzGyCNEkSDygJ4LxCnZ1j4TaHU/HGDw9sclCfht4sew2fDgTPW2
	 Yk2ele9Tn3nQGYdPtrMNaLbthmbKDAA1Wi0TclyEmGGljxT4clpBdcPvp+FIbFCMng
	 AlgH3i28XJkpQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 04/17] cpufreq/amd-pstate: Overhaul locking
Date: Fri, 14 Feb 2025 18:52:31 -0600
Message-ID: <20250215005244.1212285-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8c3b54030ec56..044091806f14f 100644
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
@@ -1172,8 +1170,6 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	ret = amd_pstate_set_energy_pref_index(policy, ret);
 
 	return ret ? ret : count;
@@ -1346,8 +1342,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
-	if (mode_state_machine[cppc_state][mode_idx])
+	if (mode_state_machine[cppc_state][mode_idx]) {
+		guard(mutex)(&amd_pstate_driver_lock);
 		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	}
 
 	return 0;
 }
@@ -1368,7 +1366,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
 
 	return ret < 0 ? ret : count;
@@ -1640,8 +1637,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
@@ -1678,8 +1673,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		guard(mutex)(&amd_pstate_limits_lock);
-
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(policy);
 
-- 
2.43.0


