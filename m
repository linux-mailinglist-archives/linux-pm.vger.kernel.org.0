Return-Path: <linux-pm+bounces-22271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FEA38EC3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F01747C0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED81B392B;
	Mon, 17 Feb 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWPaZ+kO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945B1B3725;
	Mon, 17 Feb 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830060; cv=none; b=L3JHPq7Pjjjf0h0YS5K8C/z37MhczXra6WN7d0ZrST65kl1r3ZEuO3Y7oVIxoIyLaV1dTYN3orYyW3AWTa1gJZCC40Ork90KH0hH/OZSCEmI0oIIbRszZLVVUbweefMaTMZYlSTOUIDf8g2XN4h12TRp8YyH4jVqqIGraWIFq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830060; c=relaxed/simple;
	bh=uOr/6HKQHJB65gZ4C/bWAqnEMWAtVnHUae8r3o/YY8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqmpeX1DtsAbTaIu6b+jh6ngQrVAefeQCYR7iGELPkySKVKWOI4a66gnxF4UKjdVuxFuA1rTVCOzWz/SiMBMANj7S5xAAsXTpPSrHoO5ZYr2WJ7lvEg84QyyNLoqOuZiMRgpSY7qomYJaXjC1PIOfyzoBLKJ/ZzYL0O/D78kFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWPaZ+kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5CDC4CED1;
	Mon, 17 Feb 2025 22:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830060;
	bh=uOr/6HKQHJB65gZ4C/bWAqnEMWAtVnHUae8r3o/YY8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWPaZ+kOIgWp37BqCUZsyZBhJamA7AQ+E4g3Leq2dKW1ByxfkGdzhmOanxE3hGdce
	 +puN3ok4i/MjcrICwZHbsytq4AfmO7ENuL7D5LAV75cHaU3flr+9q039jh2cOf+LiU
	 B6gXAmL7iYSLtmElHg/jq6c16rN9dpIcTtUgZuf7B26cmHwkOdTGQTMjNMK4fJ7tn0
	 fLV9MK64ESXCffxKlgIkrkceA1RWTjn/rC5p2rqiX0GssH34wFTMrot1Rsdp2RLAMo
	 Behvwgb6F97HBrefbYSO0ETXxeFC99jDZ9Q3OgoWMHBW9ntQZAjFVhzXXd6NpH9Ykf
	 fieLWrOhDsBdA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 06/18] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
Date: Mon, 17 Feb 2025 16:06:55 -0600
Message-ID: <20250217220707.1468365-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217220707.1468365-1-superm1@kernel.org>
References: <20250217220707.1468365-1-superm1@kernel.org>
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
index 92ef2e6612a62..c6934c9730bee 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1511,11 +1511,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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


