Return-Path: <linux-pm+bounces-41459-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFyMNMk/d2mMdQEAu9opvQ
	(envelope-from <linux-pm+bounces-41459-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:19:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF286B34
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7100E3005ABA
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3344330332;
	Mon, 26 Jan 2026 10:19:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE1330640;
	Mon, 26 Jan 2026 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422756; cv=none; b=cld0+kyv2Pr5uHN0GWPGK2e0DHUcHp+S/GqBf01vVkhJh3qyOKVe8gKZLdOlFvf0S8OOo3bThdJgjD2YnoFrjzh9yP7E6W1NhaVR6V+fD+6GELXIkqqSVn8VYgp2PUV+FrUzk6QhRTN6QBx76C91VMGTsQy5b9HF566CQofSm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422756; c=relaxed/simple;
	bh=c1eWi+UqnTIEqEHycUHgp/VD+sNLi0VbrxP4lpcjTEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+KgOVYm1zmrXW1Rbw2QdAPzH+zpVKW44HoppQ3qdJ9l964IjhdG+cmwziOdkDLf6bfaWvyfHLvs1w5b3c4pTuAJNO1el0nJzbSAPpKBthbDVpFOzYAo7uWCkJ49QjyqCkjNIpqloFBObJ0ehUhiIv3Gth+BoF7YjTr+NxcTzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762AF497;
	Mon, 26 Jan 2026 02:19:07 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 796D53F632;
	Mon, 26 Jan 2026 02:19:10 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	zhenglifeng1@huawei.com,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	sumitg@nvidia.com,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/6] cpufreq: Set policy->min and max as real QoS constraints
Date: Mon, 26 Jan 2026 11:18:14 +0100
Message-ID: <20260126101826.94030-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126101826.94030-1-pierre.gondois@arm.com>
References: <20260126101826.94030-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41459-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71DF286B34
X-Rspamd-Action: no action

cpufreq_set_policy() will ultimately override the policy min/max
values written in the .init() callback through:
cpufreq_policy_online()
\-cpufreq_init_policy()
  \-cpufreq_set_policy()
    \-/* Set policy->min/max */
Thus the policy min/max values provided are only temporary.

There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
cpufreq_policy_online()
\-cpufreq_init_policy()
  \-__cpufreq_driver_target()
    \-cpufreq_driver->target()
is called. In this case, some drivers use the policy min/max
values in their .target() callback before they are overridden.

Check cpufreq drivers:
- if their .target() callback doesn't use policy->min or max,
  remove the initialization
- assuming policy->min or max values were populated as constraints,
  set them as QoS real constraints in cpufreq_policy_online()

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/amd-pstate.c      | 24 ++++++++++++------------
 drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
 drivers/cpufreq/cpufreq.c         | 16 ++++++++++++++--
 drivers/cpufreq/gx-suspmod.c      |  9 ++++-----
 drivers/cpufreq/intel_pstate.c    |  3 ---
 drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
 drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
 drivers/cpufreq/virtual-cpufreq.c |  6 +++---
 8 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 310d5938cbdf6..aaafbe9b26cae 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1003,12 +1003,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.min_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.highest_perf);
 
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
@@ -1485,12 +1485,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	perf = READ_ONCE(cpudata->perf);
 
-	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.min_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.lowest_perf);
+	policy->cpuinfo.max_freq = perf_to_freq(perf,
+						cpudata->nominal_freq,
+						perf.highest_perf);
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index fbbbe501cf2dc..831102522ad64 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 		min_fsb = NFORCE2_MIN_FSB;
 
 	/* cpuinfo and default policy values */
-	policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
-	policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
+	policy->cpuinfo.min_freq = min_fsb * fid * 100;
+	policy->cpuinfo.max_freq = max_fsb * fid * 100;
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 43bf6aed90e49..209e2673ca50b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1455,6 +1455,18 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
+		unsigned int min, max;
+
+		/*
+		 * If the driver has set policy->min or max,
+		 * use the value as a QoS request.
+		 */
+		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
+		if (policy->max)
+			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
+		else
+			max = FREQ_QOS_MAX_DEFAULT_VALUE;
+
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
@@ -1469,7 +1481,7 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->min_freq_req, FREQ_QOS_MIN,
-					   FREQ_QOS_MIN_DEFAULT_VALUE);
+					   min);
 		if (ret < 0) {
 			/*
 			 * So we don't call freq_qos_remove_request() for an
@@ -1489,7 +1501,7 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->max_freq_req, FREQ_QOS_MAX,
-					   FREQ_QOS_MAX_DEFAULT_VALUE);
+					   max);
 		if (ret < 0) {
 			policy->max_freq_req = NULL;
 			goto out_destroy_policy;
diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 75b3ef7ec6796..57999b8d51fa2 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -397,7 +397,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
 
 static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 {
-	unsigned int maxfreq;
+	unsigned int minfreq, maxfreq;
 
 	if (!policy || policy->cpu != 0)
 		return -ENODEV;
@@ -418,11 +418,10 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
 	policy->cpu = 0;
 
 	if (max_duration < POLICY_MIN_DIV)
-		policy->min = maxfreq / max_duration;
+		minfreq = maxfreq / max_duration;
 	else
-		policy->min = maxfreq / POLICY_MIN_DIV;
-	policy->max = maxfreq;
-	policy->cpuinfo.min_freq = maxfreq / max_duration;
+		minfreq = maxfreq / POLICY_MIN_DIV;
+	policy->cpuinfo.min_freq = minfreq;
 	policy->cpuinfo.max_freq = maxfreq;
 
 	return 0;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe3745736..bf2f7524d04a9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3047,9 +3047,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
-	policy->min = policy->cpuinfo.min_freq;
-	policy->max = policy->cpuinfo.max_freq;
-
 	intel_pstate_init_acpi_perf_limits(policy);
 
 	policy->fast_switch_possible = true;
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index ac2e90a65f0c4..231edfe8cabaa 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -551,13 +551,13 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
-	policy->max = policy->cpuinfo.max_freq =
+	policy->cpuinfo.max_freq =
 		ioread32(&pcch_hdr->nominal) * 1000;
-	policy->min = policy->cpuinfo.min_freq =
+	policy->cpuinfo.min_freq =
 		ioread32(&pcch_hdr->minimum_frequency) * 1000;
 
-	pr_debug("init: policy->max is %d, policy->min is %d\n",
-		policy->max, policy->min);
+	pr_debug("init: max_freq is %d, min_freq is %d\n",
+		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
 out:
 	return result;
 }
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 4afa48d172dbe..f53b9d7edc76a 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -185,8 +185,8 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 	int ret = -EINVAL;
 
 	/* set default policy and cpuinfo */
-	policy->min = policy->cpuinfo.min_freq = 104000;
-	policy->max = policy->cpuinfo.max_freq =
+	policy->cpuinfo.min_freq = 104000;
+	policy->cpuinfo.max_freq =
 		(cpu_is_pxa320()) ? 806000 : 624000;
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
 
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
index 6ffa16d239b2b..6f7dbef7fda96 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -164,10 +164,10 @@ static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
 		policy->cpuinfo.min_freq = 1;
 		policy->cpuinfo.max_freq = virt_cpufreq_get_perftbl_entry(policy->cpu, 0);
 
-		policy->min = policy->cpuinfo.min_freq;
-		policy->max = policy->cpuinfo.max_freq;
+		policy->cpuinfo.min_freq;
+		policy->cpuinfo.max_freq;
 
-		policy->cur = policy->max;
+		policy->cur = policy->cpuinfo.max_freq;
 		return 0;
 	}
 
-- 
2.43.0


