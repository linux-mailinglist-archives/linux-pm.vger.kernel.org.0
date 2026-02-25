Return-Path: <linux-pm+bounces-43196-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM8BGd63nmnwWwQAu9opvQ
	(envelope-from <linux-pm+bounces-43196-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:50:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F419466A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF833303B90A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC774318131;
	Wed, 25 Feb 2026 08:50:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083F31159C;
	Wed, 25 Feb 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009408; cv=none; b=R6S+bwEnGMi3jiQCaLZjkRgyLCUlCc+QIXO/TLZDcFHV4Q9vvewpnq67IK+G9mbNoiH+W6Z4OZlP+yTWAdv8OKv4+FmNkP04i+HTOuy+Gwl+6hUKefhmrgYgvP7l+DwWGaVKmSPAtamEIiKOaL+FHPxQWFc5oe9RYPQBd61RdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009408; c=relaxed/simple;
	bh=5h/KzbDoPmUb02rODNvzgGXvVjv/K+uw/125oBtaZnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz7L7Db+5Ap4cnC8eJqOGuymdktoTAsDisDK4CyMs7pPIQVBy+UxxrRlR8B9XcyumIMEt+MbaMfDHFZY95akG+AFPOObKqFImPOcfEkNiu2sroVEZ/5IML3TaSA2H44kzM1G5QJWvdoj6jFt8F7AsCR0DTmH1k3BuJ58m0xhAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31139169E;
	Wed, 25 Feb 2026 00:50:00 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F17CE3F59E;
	Wed, 25 Feb 2026 00:50:02 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
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
Subject: [PATCH v5 4/6] cpufreq: Update .set_boost() callbacks to rely on boost_freq_req
Date: Wed, 25 Feb 2026 09:49:21 +0100
Message-ID: <20260225084930.1692228-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225084930.1692228-1-pierre.gondois@arm.com>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
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
	TAGGED_FROM(0.00)[bounces-43196-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 0B5F419466A
X-Rspamd-Action: no action

In the existing .set_boost() callbacks:
- Don't update policy->max as this is done through the qos notifier
  cpufreq_notifier_max() which calls cpufreq_set_policy().
- Remove freq_qos_update_request() calls as the qos request is now
  done in policy_set_boost() and updates the new boost_freq_req

Note:
cpufreq_frequency_table_cpuinfo() is also called through:
cpufreq_policy_online()
\-cpufreq_table_validate_and_sort()
  \-cpufreq_frequency_table_cpuinfo()
which relies on cpufreq_frequency_table_cpuinfo() to set
policy->min and max initizalization at driver init. This
regression is solved in the next patch.

Note2:
acpi-cpufreq.c seems to be the only cpufreq driver not
setting cpuinfo.max_freq. Populate it the nominal frequency at
driver init.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/acpi-cpufreq.c |  1 +
 drivers/cpufreq/amd-pstate.c   |  2 --
 drivers/cpufreq/cppc_cpufreq.c | 10 ++--------
 drivers/cpufreq/cpufreq.c      | 16 +++++++---------
 drivers/cpufreq/freq_table.c   |  7 +++----
 5 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e73a66785d69d..6a6e26e1be14a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -857,6 +857,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		 * governor from selecting inadequate CPU frequencies.
 		 */
 		arch_set_max_freq_ratio(true);
+		policy->cpuinfo.max_freq = nominal_freq;
 	}
 
 	policy->freq_table = freq_table;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c45bc98721d24..310d5938cbdf6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	else if (policy->cpuinfo.max_freq > nominal_freq)
 		policy->cpuinfo.max_freq = nominal_freq;
 
-	policy->max = policy->cpuinfo.max_freq;
-
 	if (cppc_state == AMD_PSTATE_PASSIVE) {
 		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
 		if (ret < 0)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9eac77c4f2944..4c46c7ea318eb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
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
index 42de32488f422..20266fb42d18d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1500,10 +1500,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 				goto out_destroy_policy;
 			}
 
+			/*
+			 * If boost is supported,
+			 * init the constraint with cpuinfo.max_freq.
+			 */
 			ret = freq_qos_add_request(&policy->constraints,
 						   policy->boost_freq_req,
 						   FREQ_QOS_MAX,
-						   FREQ_QOS_MAX_DEFAULT_VALUE);
+						   policy->cpuinfo.max_freq);
 			if (ret < 0) {
 				/*
 				 * So we don't call freq_qos_remove_request() for an
@@ -2818,16 +2822,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
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
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 7f251daf03ce3..9b37f37c36389 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 			max_freq = freq;
 	}
 
-	policy->min = policy->cpuinfo.min_freq = min_freq;
-	policy->max = max_freq;
+	policy->cpuinfo.min_freq = min_freq;
 	/*
 	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
 	 * it as is.
 	 */
 	if (policy->cpuinfo.max_freq < max_freq)
-		policy->max = policy->cpuinfo.max_freq = max_freq;
+		policy->cpuinfo.max_freq = max_freq;
 
-	if (policy->min == ~0)
+	if (min_freq == ~0)
 		return -EINVAL;
 	else
 		return 0;
-- 
2.43.0


