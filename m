Return-Path: <linux-pm+bounces-39193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B7CA3329
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1ADF303265C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414D338937;
	Thu,  4 Dec 2025 10:14:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA26326D73;
	Thu,  4 Dec 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843247; cv=none; b=Tdezpj/SIFwTywL0cNWA1/ap3OPwou7jeZGcN+p4KPPy2RXNt2dKmgW7jkPWcthwYCHawNJKXnQykuEOE7wE2mWcqbx77ZQVs/N6EC9ZJd9KqFBD2NCOHvdkp3mrOeFiY2JaPIXDXFXkI13fFwplIgJrSJ5UbUzPZCp5Iz07R/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843247; c=relaxed/simple;
	bh=9XY4nMc+9Bb3G6FNU9WFpUEwhPv2wCvQ0zwByOnuiUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAyZT+zvY+WMu5J+K7BSA+zCTWqv0GD/dCXTm1Dd79vwDfCQEKxRn3DT22TnPUop8uLjjcNV+HHifXkznBgDJSQ50GEXsN+0lFf2BVFy6/k7RIZEBZGyvgwyu6Qd8mFuA9d/HdR+KGuDkDipQogvApDZSsbgArJFl2R1JtMgGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C944F339;
	Thu,  4 Dec 2025 02:13:56 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67A793F73B;
	Thu,  4 Dec 2025 02:14:01 -0800 (PST)
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
Subject: [PATCH v1 2/4] cpufreq: Add boost_freq_req QoS request
Date: Thu,  4 Dec 2025 11:13:38 +0100
Message-ID: <20251204101344.192678-3-pierre.gondois@arm.com>
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
 drivers/cpufreq/cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 11b29c7dbea9e..23f64346b80f8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1370,6 +1370,18 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		freq_qos_remove_request(policy->max_freq_req);
 	}
 
+	if (policy->boost_freq_req) {
+		/*
+		 * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
+		 * notification, since CPUFREQ_CREATE_POLICY notification was
+		 * sent after adding boost_freq_req earlier.
+		 */
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+					     CPUFREQ_REMOVE_POLICY, policy);
+		freq_qos_remove_request(policy->boost_freq_req);
+		kfree(policy->boost_freq_req);
+	}
+
 	freq_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
@@ -1476,6 +1488,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 			goto out_destroy_policy;
 		}
 
+		if (policy->boost_supported) {
+			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
+				GFP_KERNEL);
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


