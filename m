Return-Path: <linux-pm+bounces-22126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353EA36A27
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003EE1890A1E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBD158536;
	Sat, 15 Feb 2025 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxEM/oWi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F428156C7B;
	Sat, 15 Feb 2025 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580781; cv=none; b=JAOE5qGsNobhY3di0LjMOWec1S0X98OI/ir7DDgTEvW8yo9tfZK4RwOwGGelZJcPGyCti7igDHoglXTC0SdNKJ7mInRAEIULDG5C0qLEhYJloJ3lR4CHlkXLxz+e2Mi2U+Lj2RzZs7kYapQRJxQjklojqk8V2YlxB6ckw0Rwev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580781; c=relaxed/simple;
	bh=Nl9jZl9M/WSE1cA0Dz+sYCnF1EoJjkOcHvDt7rY8vnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiBkoSMXh2nBbKSoRZZlqydS8UzVfiM38Ck/QjZZzy5pimHHBxx0Jl7aloa/pnpO05kqqQ7zLx+FutGjIYmcTY8IugACSLN+ACZc7jeIOGINRDwtIDcYhcHVBBqSMLqM4yG3bjc5OQi0S+vVUgvc6zkWO5ACjtusNFAQ1tCzpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxEM/oWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBEDC4CEE9;
	Sat, 15 Feb 2025 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580781;
	bh=Nl9jZl9M/WSE1cA0Dz+sYCnF1EoJjkOcHvDt7rY8vnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxEM/oWiYiES4gPiDboBdxbzvlSTY53Bo9f1YXL4JJjIn06r2fGY5yMwW7pgRtIL4
	 re8kQCld7LMqCLVe0KBwiXWe/ZaNP8mqkDbz6Kv4lTQ7ngiIG3NuZT1QlRHAIOnnjK
	 qGvxKLYD3YoaPW8IczM35Ro9HT/a+ER8u53AA/Au5Pg3cx/GpukejDktC7FqKYtjRH
	 rD6byH1BVrlVP/6OX7EwNBqVHlGxq8LTxgAAYlO7E+kQLLdjis7hyBtil5yxoVzx1s
	 Uuq22foNMDaJoCG7EhjBmO6YXZtNW/hvj+2bI9wJPGI9XAP4tqdU0TXFuChCgh99ki
	 HeXSjb4XSGutw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 05/17] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
Date: Fri, 14 Feb 2025 18:52:32 -0600
Message-ID: <20250215005244.1212285-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
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

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 -----
 drivers/cpufreq/amd-pstate.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 044091806f14f..e5983e5c77ba2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1510,11 +1510,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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


