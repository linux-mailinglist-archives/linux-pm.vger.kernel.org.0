Return-Path: <linux-pm+bounces-22497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC80A3CACF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0487B189BBC7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFAD256C9C;
	Wed, 19 Feb 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQqX+LJA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E91256C6F;
	Wed, 19 Feb 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999003; cv=none; b=hDUkhpdYGi9vRC56bB5hRU/9243Y4NzOD9DEcpHeM4DOZODBcuGB0HFz2Phep8tAqgU6JQsbO7m+4Ql7FOnnh1XfhX+Gx+b1J0dKTlpEPme04Ti8HmDkZt9IV+vKk0phMxxBPfEpQpMHWvNGV5Ik7CDIUhhU83QPnotHuU9hEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999003; c=relaxed/simple;
	bh=Kp4WFuW18ZVHGo9JBwlhMfyWpoIT6B9JJnSIu4scvGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnJCY5ch0YodR//YK9abd5v+qSAWAO1rv8gQQw5aDVnDW2GOP+cPKFfnQeVvToKbPzkiASW2mNrl1ciwqxzsD7ra3FKQmOICIDCf3iBnaqqeW85PMn0uaqS8peUXJoQXdhRDlNnuQGVHgOv2xugPVIrrrzjFZcVOuxnmGS8HtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQqX+LJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEBCC4CEED;
	Wed, 19 Feb 2025 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999002;
	bh=Kp4WFuW18ZVHGo9JBwlhMfyWpoIT6B9JJnSIu4scvGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQqX+LJA03pP6aOhF+KgS2TFbHcoh0WAXC7XDfpaD8hyQLDRvFzU9Pe7CoDSNy+NT
	 wF4KJ4mf3PAuysMtnT0LMe5h1NJ2GYY1BGj80P56x5Goi6lve48LPWistCiEaiY1gV
	 rnsj0+vPIDV4ZgmvF/e+UP/z3Dgn85FhMgiV47eMSWyoqWJPYJBjymvhSwSyUjvGyK
	 UsZ4+mciJ9ivog6zDnd/7+Z82xb12wK5ZEbC8CpkrMecMhqED43wwTm/GoBNkXjPrn
	 3JsPObBJTj9yJoaltOxWLZwVXSdeE11UhtXXt2Wr/dFV8EocHCtB5aIHdrx/A0Lb9d
	 pho8vWvY8KOYA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 06/19] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
Date: Wed, 19 Feb 2025 15:02:49 -0600
Message-ID: <20250219210302.442954-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
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
index 85e3daddb56e0..e61a430183693 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1513,11 +1513,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
index 8421c83c07919..1a52582dbac9d 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -74,7 +74,6 @@ struct amd_aperf_mperf {
  * 		  AMD P-State driver supports preferred core featue.
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
- * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -103,7 +102,6 @@ struct amd_cpudata {
 	/* EPP feature related attributes*/
 	u8	epp_cached;
 	u32	policy;
-	u64	cppc_cap1_cached;
 	bool	suspended;
 	u8	epp_default;
 };
-- 
2.43.0


