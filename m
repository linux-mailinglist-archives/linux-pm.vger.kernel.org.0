Return-Path: <linux-pm+bounces-39192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFBCA331A
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 11:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1613163554
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D902BDC13;
	Thu,  4 Dec 2025 10:14:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E1338587;
	Thu,  4 Dec 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843243; cv=none; b=MIfsyYLcCxvvOSKAGolM54/mSHOfVIRgNbKwyIx2Mk8Bu89985E9wOKDr52ROE5+YTQjwuWoKfms35Q/bzTVYeREaFOuyw9FhMSeMEhkjnPWKzyCmfcg1tP3SfEznBlyiWtHi0vxp6j2A3YK+7qVCwdJbWZd1CLRXjTx2UqFeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843243; c=relaxed/simple;
	bh=SYfoyoKuJwgZNbxFEKHK/7ZHnCkMIlEup3jnVGaJJQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXuC94Hk8tNxUXJOlwTwTjOQF1/2bR1ypx0r4dQLXvoy7DrwSivgNBgn6xSY+WvKtkKggeN1160C8A8uT1OsXH1/Jrb8TolD1TNJWB0VNu5au/2NxKUgv+iOZHHIObuUY5psYUpYw31wrHRB24DBGURWBXOuDUlr5Nnduzavhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EE8A1575;
	Thu,  4 Dec 2025 02:13:53 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 826B13F73B;
	Thu,  4 Dec 2025 02:13:57 -0800 (PST)
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
Subject: [PATCH v1 1/4] Revert "cpufreq: Fix re-boost issue after hotplugging a CPU"
Date: Thu,  4 Dec 2025 11:13:37 +0100
Message-ID: <20251204101344.192678-2-pierre.gondois@arm.com>
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

policy->max_freq_req represents the maximum allowed frequency as
requested by the policyX/scaling_max_freq sysfs file. This request
applies to all CPUs of the policy. It is not possible to request
a per-CPU maximum frequency.

Thus, the interaction between the policy boost and scaling_max_freq
settings should be handled by adding a boost specific QoS constraint.
This will be handled in the following patches.

This reverts commit 1608f0230510489d74a2e24e47054233b7e4678a.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 852e024facc3c..11b29c7dbea9e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1478,10 +1478,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
-	} else {
-		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret < 0)
-			goto out_destroy_policy;
 	}
 
 	if (cpufreq_driver->get && has_target()) {
-- 
2.43.0


