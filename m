Return-Path: <linux-pm+bounces-39300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1ECACEF6
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26A1630164EA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71DE3112BB;
	Mon,  8 Dec 2025 10:59:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8714A8E;
	Mon,  8 Dec 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191593; cv=none; b=mGPjKvd+FLlcJ5na30e5qM4b/UAe4OnTsqGyE52OM7JgrBp6yBM9hU/p1Av9Po1R1qeA3I5hTeuOoDtMORPekEF5+SPY0xS1HHDTrcnjwxiFgWmFhfd5Aud7zG6SMJ2e0NLn2vliIsxEAImi303a5LEK/JKjV2oiCvHokUHJWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191593; c=relaxed/simple;
	bh=FsB8Y8Hvs1X3OlpqQ37vcZpAElV+amsN8Ck2Zrldxto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVNsuP/O0CcUWcqain2MuKEbi9rIxg+mFJ0V4/wCDqz2inHavDWPNEg/gCALTSruTlC6QmoTvwmou6cgI4E7SPo8b5RHB7lqt9YbxZlOppa8o+Pizka0iMHvU4i6I8xn8Z/mmGfotpcYBkpcJU1hgdyyinAZjCBu7LCKbtSDUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E14F21691;
	Mon,  8 Dec 2025 02:59:43 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.88.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A6C23F762;
	Mon,  8 Dec 2025 02:59:47 -0800 (PST)
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
Subject: [PATCH v2 2/3] cpufreq: Centralize boost freq QoS requests
Date: Mon,  8 Dec 2025 11:59:27 +0100
Message-ID: <20251208105933.1369125-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208105933.1369125-1-pierre.gondois@arm.com>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
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
 drivers/cpufreq/cpufreq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 942416f2741b0..65ef0fa70c388 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -603,10 +603,18 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 	policy->boost_enabled = enable;
 
 	ret = cpufreq_driver->set_boost(policy, enable);
-	if (ret)
+	if (ret) {
 		policy->boost_enabled = !policy->boost_enabled;
+		return ret;
+	}
 
-	return ret;
+	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		policy->boost_enabled = !policy->boost_enabled;
+		return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
-- 
2.43.0


