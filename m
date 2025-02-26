Return-Path: <linux-pm+bounces-22959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D76A45710
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85367177355
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC8271287;
	Wed, 26 Feb 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ganH3Gkt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2527127A;
	Wed, 26 Feb 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556190; cv=none; b=PxR6owdp1EI0Rd/zQaFCsu23IvQbS3mgSQRgbb0uN3cc1VLl0tw8MlGH53cgzrn4ol2hrZtqw22BF0hrK+IsHvozOed98qfG9Kmap3HJYgk9LCH8pI5fgTL+3dNdb8SWo0guM2QI8hsxbb6YXMCtbpWBFZNNG1byiuPEAGj418Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556190; c=relaxed/simple;
	bh=7948qPgNwS4plElTkkI+DCDSLW+DMO0jgom1BwBpJkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnlssKbVDGw8iSTnQ0+GHfotJ0C8uspaUBxK9u5dHnmPSe0Vjh/bIFCrcfyuQIb2HaZnX/lU3rYzhqXS4yI5BFGVsMYgSwYNCMuFHxSom+iAbNEkBZLOQfspMk96IsMFUgE2tTNv+pz52lqWtJFknUcmWzVasaSCi7In1Ouzmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ganH3Gkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6C4C4CEE2;
	Wed, 26 Feb 2025 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556190;
	bh=7948qPgNwS4plElTkkI+DCDSLW+DMO0jgom1BwBpJkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ganH3GktM0umsFArds7uYH2IxjMIU4IDUKaDMBTWJNs52jdcJfc/V8dVrQgM+K17s
	 ypjir1BAC2V5LVIG+FxV+yu+LEaWJXac0kuh8Y9kTo5lEfWTaFPRAtpS7fslNnYh3Y
	 BslArcAEbT9AO1ffmvW7CSzJORc2MTlu0ejdwXe846HvGRTcb4Tr+EGwx6kUqQmjCl
	 NsVMPgGaRCw2eNz3Z0BLPT+m/BM7XdSoED/DSuZMuztjfqgqQR8JVS4028qry7MAll
	 objfGK6/DroVerSynpa+ozG8skqKCVGTvwgmXxycJfpfKUtvV1p38nHVVBInpJECW+
	 CrecqetJDDEzA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 06/19] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
Date: Wed, 26 Feb 2025 01:49:21 -0600
Message-ID: <20250226074934.1667721-7-superm1@kernel.org>
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

The `cppc_cap1_cached` variable isn't used at all, there is no
need to read it at initialization for each CPU.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 -----
 drivers/cpufreq/amd-pstate.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 95b77cf145174..2cec8d7d92f51 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1514,11 +1514,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		if (ret)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_req_cached, value);
-
-		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
-		if (ret)
-			return ret;
-		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
 	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
 	if (ret)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 83532a0079a81..1557e1afea79c 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -76,7 +76,6 @@ struct amd_aperf_mperf {
  * 		  AMD P-State driver supports preferred core featue.
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
- * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -105,7 +104,6 @@ struct amd_cpudata {
 	/* EPP feature related attributes*/
 	u8	epp_cached;
 	u32	policy;
-	u64	cppc_cap1_cached;
 	bool	suspended;
 	u8	epp_default;
 };
-- 
2.43.0


