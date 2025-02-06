Return-Path: <linux-pm+bounces-21516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A5A2B48D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9993A9627
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6A23AE68;
	Thu,  6 Feb 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck/pR3hc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A523AE61;
	Thu,  6 Feb 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879048; cv=none; b=DDznkQR9mkxm9WrM64rVuB7PIOPll81ezrNCibaeDIPrQEveJfUJwJ+KvXhE6ITWCxSskRBwvf4YCY4dLAC3RsqJAC0RoZKAXbGktM25KGRahK76yW2jWaroGHMSkeeuQs0GTTUdCoXZI7OWod0lkwaBtGERiQQcckdUzPaq878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879048; c=relaxed/simple;
	bh=URGZZ6jxxr8r/BbpkZq2RX8FQTDG5v4ofyM4U4YCgSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jilqp/eoD04ZEa4e/ARfHsAksrOEqV9L55cZPDZPTD9p/46lZp43MZbX3rHIM9kspKwT7ZVkvKT0P2zIgD/pfwYaqWggS1Iir3iv6MUqAjp11IhvKkFkevjfM1LE2pj4KKIgt8csJ6LhwHSuly866a0aPd7VJxSaL1fNIn0+z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck/pR3hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FEC4CEDF;
	Thu,  6 Feb 2025 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879048;
	bh=URGZZ6jxxr8r/BbpkZq2RX8FQTDG5v4ofyM4U4YCgSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ck/pR3hc7CKIXFDzRpm0CbkIg050TDmyaw++df1ywAZIQc0qD8z3e7om0rIXwtdcg
	 NCmXyKIM1AGYLdn3fUV9iV8opXBvH6+gkJPfioLyVD98qgHxYy0F5TotiY5SgyXxC2
	 mUPJ8XyojFkjBekQaKei7oSOob52RITIgTQ9ZQnnwu0Knc+TJ4VvazIfpgXVFKiH1X
	 B5NWw9s7m1EnJC54396ygzIo7dabCqmDcIxppl7aGHskJxExkNcu7gNw/G1vK5QRlP
	 kVTGfyBJdjz0iJ9VO3b5C8FVf/5VjOfpRlSR8syVvvJ8k1lfxGM3AWh3qF9IgSF0Ih
	 Ysb1LlfCZGUrA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 12/14] cpufreq/amd-pstate: Cache a pointer to policy in cpudata
Date: Thu,  6 Feb 2025 15:56:57 -0600
Message-ID: <20250206215659.3350066-13-superm1@kernel.org>
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

In order to access the policy from a notification block it will
need to be stored in cpudata.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++++------
 drivers/cpufreq/amd-pstate.h |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 689de385d06da..5945b6c7f7e56 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -388,7 +388,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
 	else
 		epp = epp_values[pref_index];
 
-	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
 		return -EBUSY;
 	}
@@ -689,7 +689,7 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
 	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
 		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
 
 	WRITE_ONCE(cpudata->perf, perf);
@@ -1042,6 +1042,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
+	cpudata->policy = policy;
 
 	mutex_init(&cpudata->lock);
 	guard(mutex)(&cpudata->lock);
@@ -1224,9 +1225,8 @@ static ssize_t show_energy_performance_available_preferences(
 {
 	int i = 0;
 	int offset = 0;
-	struct amd_cpudata *cpudata = policy->driver_data;
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
 		return sysfs_emit_at(buf, offset, "%s\n",
 				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
@@ -1543,6 +1543,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
+	cpudata->policy = policy;
 
 	mutex_init(&cpudata->lock);
 	guard(mutex)(&cpudata->lock);
@@ -1632,7 +1633,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 
 	amd_pstate_update_min_max_limit(policy);
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
 		epp = READ_ONCE(cpudata->epp_cached);
@@ -1651,7 +1652,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	cpudata->policy = policy->policy;
+	cpudata->policy = policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
 	if (ret)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 7501d30db9953..16ce631a6c3d5 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -97,9 +97,10 @@ struct amd_cpudata {
 
 	struct mutex	lock;
 
+	struct cpufreq_policy *policy;
+
 	/* EPP feature related attributes*/
 	u8	epp_cached;
-	u32	policy;
 	bool	suspended;
 	u8	epp_default;
 };
-- 
2.43.0


