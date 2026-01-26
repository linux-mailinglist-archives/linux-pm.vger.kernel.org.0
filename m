Return-Path: <linux-pm+bounces-41456-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDjIIk1Ad2mMdQEAu9opvQ
	(envelope-from <linux-pm+bounces-41456-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:22:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B086C10
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44549303EFB0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1644330321;
	Mon, 26 Jan 2026 10:19:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105B732F761;
	Mon, 26 Jan 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422740; cv=none; b=t2wG5o+QjYhW7PbBr+d3RyZzN+0Pnadf00bi+ZCtu8G880icF+5g3oVFiuxy18/qA2sICkfsfLIG8YyuiLcrQ/EKNCH4aA6Pkys3L0KPMwPqCzI4jNCjhCS9iU+sfe03QwTlvj1LgzEAc0HjokSA+hnRPwBOIZLY+YmHlMdhTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422740; c=relaxed/simple;
	bh=dGp34TShUS6ECyHuxDXtDkIqXYeyziBTGA6ETXCT6Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k34QFpaHT8gHrYZLeutrK8a48GTHDMqfrrO4iipmJB2pDh3EJr9xmYjOm/axcvC15oTLAYurqMBjTyKQVo7b31KS8lKang0gUk+SM4CXokzfhZ5nmDeDQ/nClG86zGqxuW18InB4JXXHL4s1VXYT/FMhsnv7JOmPXbYEANgYWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BCB5339;
	Mon, 26 Jan 2026 02:18:52 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A40B3F632;
	Mon, 26 Jan 2026 02:18:54 -0800 (PST)
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
Subject: [PATCH 2/6] cpufreq: Add boost_freq_req QoS request
Date: Mon, 26 Jan 2026 11:18:11 +0100
Message-ID: <20260126101826.94030-3-pierre.gondois@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41456-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: CC0B086C10
X-Rspamd-Action: no action

The Power Management Quality of Service (PM QoS) allows to
aggregate constraints from multiple entities. It is currently
used to manage the min/max frequency of a given policy.

Frequency constraints can come for instance from:
- Thermal framework: acpi_thermal_cpufreq_init()
- Firmware: _PPC objects: acpi_processor_ppc_init()
- User: by setting policyX/scaling_[min|max]_freq
The minimum of the max frequency constraints is used to compute
the resulting maximum allowed frequency.

When enabling boost frequencies, the same frequency request object
(policy->max_freq_req) as to handle requests from users is used.
As a result, when setting:
- scaling_max_freq
- boost
The last sysfs file used overwrites the request from the other
sysfs file.

To avoid this, create a per-policy boost_freq_req to save the boost
constraints instead of overwriting the last scaling_max_freq
constraint.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 40 ++++++++++++++++++++++++++++++++++-----
 include/linux/cpufreq.h   |  1 +
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index db414c052658b..c8fb4c6656e94 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1359,17 +1359,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	/* Cancel any pending policy->update work before freeing the policy. */
 	cancel_work_sync(&policy->update);
 
-	if (policy->max_freq_req) {
+	if (policy->max_freq_req || policy->boost_freq_req) {
 		/*
-		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
-		 * notification, since CPUFREQ_CREATE_POLICY notification was
-		 * sent after adding max_freq_req earlier.
+		 * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
+		 * notification, since CPUFREQ_CREATE_POLICY notification was sent
+		 * after adding max/boost _freq_req earlier.
 		 */
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 					     CPUFREQ_REMOVE_POLICY, policy);
-		freq_qos_remove_request(policy->max_freq_req);
 	}
 
+	if (policy->boost_freq_req) {
+		freq_qos_remove_request(policy->boost_freq_req);
+		kfree(policy->boost_freq_req);
+	}
+
+	if (policy->max_freq_req)
+		freq_qos_remove_request(policy->max_freq_req);
+
 	freq_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
@@ -1479,6 +1486,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 			goto out_destroy_policy;
 		}
 
+		if (policy->boost_supported) {
+			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
+							 GFP_KERNEL);
+			if (!policy->boost_freq_req) {
+				ret = -ENOMEM;
+				goto out_destroy_policy;
+			}
+
+			ret = freq_qos_add_request(&policy->constraints,
+						   policy->boost_freq_req,
+						   FREQ_QOS_MAX,
+						   FREQ_QOS_MAX_DEFAULT_VALUE);
+			if (ret < 0) {
+				/*
+				 * So we don't call freq_qos_remove_request() for an
+				 * uninitialized request.
+				 */
+				kfree(policy->boost_freq_req);
+				policy->boost_freq_req = NULL;
+				goto out_destroy_policy;
+			}
+		}
+
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0465d1e6f72ac..c292a6a19e4f5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -81,6 +81,7 @@ struct cpufreq_policy {
 	struct freq_constraints	constraints;
 	struct freq_qos_request	*min_freq_req;
 	struct freq_qos_request	*max_freq_req;
+	struct freq_qos_request *boost_freq_req;
 
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
-- 
2.43.0


