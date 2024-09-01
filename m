Return-Path: <linux-pm+bounces-13302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD1967517
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 07:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833D5282BE3
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 05:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417BC405E6;
	Sun,  1 Sep 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGvE9gHZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CE3D994;
	Sun,  1 Sep 2024 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725166855; cv=none; b=khaXErFdbdmei3VEz32Bg1nCVSQ92FQPQ8jrGa+4lhzl7XbQV3zsbeP0V6qgS6uOj58WAZBiTTQmtU/A/xqwnVmHnQJL/DceUHMyqxRHG8ZIwreyPN6uw5EMUkgY3zvF3yUEd51KjSFQGoMzggkk9ObgP8C1CiJsJi7rEy/c9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725166855; c=relaxed/simple;
	bh=GWsNo5Xq/zBa88c/rIYoO+estylIGE9Wrxxtz3W8TjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZn5udhFeBgnBWu2nuvrddNkT/x7PJISjRjXxF8ncI5Ejtav9xhlmtbLKs2lI6W2aJLKaur6U3CQ2puWQkQoXTk0BLinsFNSCLueq24MpYdIDfnwbpEQAsTOtHNgDhLar1v8yB9qynA/jb1yMdTTez9ZlfntTX27F16GegHMyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGvE9gHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EC3C4CECF;
	Sun,  1 Sep 2024 05:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725166854;
	bh=GWsNo5Xq/zBa88c/rIYoO+estylIGE9Wrxxtz3W8TjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGvE9gHZbvWSz7DCeCmOviUIPSbDHnHq/uDfa8hdRxPpQLcel+w1gImiLWRKujGVF
	 /NsXHu8fMtR/IF6N6yUJU897Iz37y19GNygmgYx+a+zqbpW49kLWxhZpG8c8HI2AHU
	 r1Uy5u/LgczHI+Xw6kn/ln38h8xI6KXhqnTcIjH67XwLYQeM1Zf0mIrewd04v6EDP3
	 XmlrZwU6A/XU9LTdLxRxvtnk4OyCp+OX9OxyCbxUjynMqpDtE8wxQ1UaopALVm0pha
	 8TFHAy9llQ4IfwFrUxyh8usyij+GBTuGP0+/2s32aUtb2/YrtDGXWp+viY0ClSUA5H
	 nM9dG98nHIzbg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit()
Date: Sun,  1 Sep 2024 00:00:35 -0500
Message-ID: <20240901050035.1739935-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240901050035.1739935-1-superm1@kernel.org>
References: <20240901050035.1739935-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pstate_set_epp() calls cppc_set_epp_perf() which can fail for
a variety of reasons but this is ignored.  Change the return flow
to allow failures.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 89438a3654002..b07be4d945e4d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1556,7 +1556,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	pr_debug("CPU %d exiting\n", policy->cpu);
 }
 
-static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
+static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
@@ -1606,7 +1606,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		 * This return value can only be negative for shared_memory
 		 * systems where EPP register read/write not supported.
 		 */
-		return;
+		return epp;
 	}
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1619,12 +1619,13 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	}
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
-	amd_pstate_set_epp(cpudata, epp);
+	return amd_pstate_set_epp(cpudata, epp);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
 
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
@@ -1634,7 +1635,9 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
-	amd_pstate_epp_update_limit(policy);
+	ret = amd_pstate_epp_update_limit(policy);
+	if (ret)
+		return ret;
 
 	/*
 	 * policy->cur is never updated with the amd_pstate_epp driver, but it
-- 
2.43.0


