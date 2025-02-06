Return-Path: <linux-pm+bounces-21509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF9A2B47B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C673B188A0C4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC6246335;
	Thu,  6 Feb 2025 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+Jz3YKI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EB24632D;
	Thu,  6 Feb 2025 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879042; cv=none; b=Q11XFA46y31USplUbrZ5vCIcPCRFhxDds2BQPrL5Kxgg8ublz/rk0uyBWg6b6ZHVFNEn/5/L83WlcJbnYB0wucbNno5auU+jhuKD1og/5Wtgmstlnx6Bvxjz3ewDYoepmVGhw2tE8HItwJhCq0XkmpNGehQOvCEPHRfgGRfx3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879042; c=relaxed/simple;
	bh=gJbdpDFvup7s/b/RWdWJCeE8Jz9tfQVoKc2gBtA/h8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwaY+6AFeQfBi8U9+r8SIOGkOhxT6Jp8ht+arn2xU8NwajSQTAWFNCnlAnecgwy0ybiiKJ67yLmO98ApPATLsCzPjY45T3ZpK86bFRTsV88g+pKzfXTV3Irvxinl+2zZkvNu2V/cLU0LAMylDNJnIyqdE5ifv2QI2qdGcddxwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+Jz3YKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E37EC4CEE4;
	Thu,  6 Feb 2025 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879042;
	bh=gJbdpDFvup7s/b/RWdWJCeE8Jz9tfQVoKc2gBtA/h8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+Jz3YKIPxEE1f28LA6Fv8aAfa6JWH5IK5x818kj13BDim+Io2YivAxQuPH2ghOKB
	 Z4DERLHAKgoDoOcy/UlH5tUUDTM3I+jB1SWcS4F3mFpbfU9DMB9dOVmrfiWvrZWJje
	 OZxu6MMyNDMo47tqi1Ou9bi3f5+FfLE02v87DmwL5PqlN+8rqL/l4LWfKKB8O8rtF3
	 w2acAacDh6lXSrg+KrOspTfWQ5gPByNFLiOb0/cC2OrN6XCJqi5uUb6RDVuUj9Z/zm
	 ISeQ4Tl4VL+mdVs6fdgiDqHHcBvhOG9OVtyBYoSaf1UuvNMCnzvAUQCRjg+LOWFBK0
	 ctCczCCqlMglg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 05/14] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
Date: Thu,  6 Feb 2025 15:56:50 -0600
Message-ID: <20250206215659.3350066-6-superm1@kernel.org>
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

The `cppc_cap1_cached` variable isn't used at all, there is no
need to read it at initialization for each CPU.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 -----
 drivers/cpufreq/amd-pstate.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dd230ed3b9579..71636bd9884c8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1529,11 +1529,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
index 6d776c3e5712a..7501d30db9953 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -71,7 +71,6 @@ struct amd_aperf_mperf {
  * 		  AMD P-State driver supports preferred core featue.
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
- * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -101,7 +100,6 @@ struct amd_cpudata {
 	/* EPP feature related attributes*/
 	u8	epp_cached;
 	u32	policy;
-	u64	cppc_cap1_cached;
 	bool	suspended;
 	u8	epp_default;
 };
-- 
2.43.0


