Return-Path: <linux-pm+bounces-22958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192DA4570D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E0E17709D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4C271260;
	Wed, 26 Feb 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYEwJYWZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57877270EDD;
	Wed, 26 Feb 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556189; cv=none; b=KbA0+2eSigVEUcRjW//a9TgSPVuZymj8hpPzXXV4QInRbeD/z/JWeqXG3IrhsXcjswqY0Bn50s7EuxCArhUog0/6a58JczJfWhDmrpGICq9mKDBWS/REc7W+QIGcA1heV7spJC0APnAsIV/eA7JU1KTW1c0HE2/+q8PrhFsVz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556189; c=relaxed/simple;
	bh=RhhlMY/+/0QCcNeMO/gDSOU04nQVsd/ZzzYkWaGrJqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmrp+udgx/4Tr35W1o4l0QM/6J0QriAs4MOEANJ+17UrouMeIwbM78UIWlKDWZTa6fWUg1zDsTy3clcA5cog8dKnUhCaNAerihflCXyRuSKB4FIfw8ueCjafYhLEB7MxwqN8fiy4kq4387TYRL1IhITZbimdcTPP8A9/Kewh34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYEwJYWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF392C4CEE7;
	Wed, 26 Feb 2025 07:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556188;
	bh=RhhlMY/+/0QCcNeMO/gDSOU04nQVsd/ZzzYkWaGrJqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYEwJYWZHgp5B75oS7SQ3F5hLC6rYkWE9MFS1qvx1qxxqU+ANkW1Hd4s2nNgxY7ME
	 0baEBJmV+YAshlX/ecAruKnnyyDePOtM5g+2Me3Lpe+pxkmQiNmQs0SlcneHD0gUiT
	 dtT6JbeDanB+eZ7oBpNucxjYXGr8rDF/fw1gWi2UkszkIRqC70hZrihGtdU0HjHw5P
	 kQMIS0LJUda5Z2ApZOg+yr+uhkt7bJiM0Bz3Vz0PWrPYSXnQTq6LJoxECbMbLwERMR
	 ESvs/hKi8rbujQoeC3ap8UKCsfr+6pz4QHnEtNQf719oD3pE1DU3scrJHJxNJTwNpJ
	 2p/8R6td/WCUg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 05/19] cpufreq/amd-pstate: Overhaul locking
Date: Wed, 26 Feb 2025 01:49:20 -0600
Message-ID: <20250226074934.1667721-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
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
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
---
 drivers/cpufreq/amd-pstate.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bd8bcda4e6eb0..95b77cf145174 100644
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
@@ -1176,8 +1174,6 @@ static ssize_t store_energy_performance_preference(
 	if (ret < 0)
 		return -EINVAL;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	ret = amd_pstate_set_energy_pref_index(policy, ret);
 
 	return ret ? ret : count;
@@ -1350,8 +1346,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
 		return -EINVAL;
 
-	if (mode_state_machine[cppc_state][mode_idx])
+	if (mode_state_machine[cppc_state][mode_idx]) {
+		guard(mutex)(&amd_pstate_driver_lock);
 		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+	}
 
 	return 0;
 }
@@ -1372,7 +1370,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	char *p = memchr(buf, '\n', count);
 	int ret;
 
-	guard(mutex)(&amd_pstate_driver_lock);
 	ret = amd_pstate_update_status(buf, p ? p - buf : count);
 
 	return ret < 0 ? ret : count;
@@ -1644,8 +1641,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	guard(mutex)(&amd_pstate_limits_lock);
-
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
@@ -1685,8 +1680,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->suspended) {
-		guard(mutex)(&amd_pstate_limits_lock);
-
 		/* enable amd pstate from suspend state*/
 		amd_pstate_epp_reenable(policy);
 
-- 
2.43.0


