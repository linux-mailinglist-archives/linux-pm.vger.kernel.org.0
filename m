Return-Path: <linux-pm+bounces-39194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C56CA32E0
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 11:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00C8630141F9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0635338F2F;
	Thu,  4 Dec 2025 10:14:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC86338F4D;
	Thu,  4 Dec 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843249; cv=none; b=S5P4MZ5nXQqRsjh3lCjgGcCHHCtNhwAgJNgY5uvsFytAZ/utRV/9+o5Y30pZWy7sxMWrK6YdbskDQfsaYTY/c008b8xVw8u9d/i6aOc4AckQNx8rPd5IJtjPS3sCtAbrlYCT9furimkWekfxA69GSo8NshR/3xzHNqAlVLWmiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843249; c=relaxed/simple;
	bh=jJ+J4azMi46GNdDcZBbnfKfZeONx47CY4QJVdrsGGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlQuzFENMSg6eAiAKkGZanISjdrxhxq5muYH7a7oriL4rZS+rFsIMaWX+GFXD/I77lMhZ6mihWsveNEAcDjO0LGkDbGe0sCrMOZzgBjPv6xz7cHHxSu6MdiTWKYcAEgtFYPTiq6LrAF/Ztx1SP+KamaRa1oq7YMRgBmjl8H2srA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860B61575;
	Thu,  4 Dec 2025 02:14:00 -0800 (PST)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 025A33F73B;
	Thu,  4 Dec 2025 02:14:04 -0800 (PST)
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
Subject: [PATCH v1 3/4] cpufreq: Centralize boost freq QoS requests
Date: Thu,  4 Dec 2025 11:13:39 +0100
Message-ID: <20251204101344.192678-4-pierre.gondois@arm.com>
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

policy_set_boost() calls the cpufreq set_boost callback.
Update the newly added boost_freq_req request from there:
- whenever boost is toggled
- to cover all possible paths

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 23f64346b80f8..9d98b98e7981c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -603,10 +603,16 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 	policy->boost_enabled = enable;
 
 	ret = cpufreq_driver->set_boost(policy, enable);
-	if (ret)
+	if (ret) {
 		policy->boost_enabled = !policy->boost_enabled;
+		return ret;
+	}
 
-	return ret;
+	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
-- 
2.43.0


