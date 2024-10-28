Return-Path: <linux-pm+bounces-16582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D574B9B341B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816ED1F2291E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16481DE2AB;
	Mon, 28 Oct 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMVlIKdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779D1DDC3C;
	Mon, 28 Oct 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127347; cv=none; b=Ei7azWtJ1j27VJkxQI6fauqX/lL9VZdX3Gw528bX1VdjhTsLOf5W8ukollCfc7PySC6GCNrfTxV1Y1DTa2gpUfv2/FuD8oTuozyAncJQpO4OS71Iv/bg3bEDNHpbNxkUsTTYbIEv8wqhfsfMFaW78AtQFS8HKwyu7JHPM27D7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127347; c=relaxed/simple;
	bh=Ews42S4yGz9+E3p0AAfNTbnZYc2rOCe8Nr0nbfGh/Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHuJErXCt7HVryGsyJKAjd7lvYkvOERSMSpLbre/jLc2d3nRjauyBIePyWjRVNsB+m7z7//6J8YTzobwZ+QKXmrqg492YOLoNwAyXGhjIRFvn/Li8YQ43UqHdOzvyZRI+i26bFPxMqmha9F4htE4H30LnGvdbhtVm7KnN75QXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMVlIKdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A06AC4CEC3;
	Mon, 28 Oct 2024 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730127347;
	bh=Ews42S4yGz9+E3p0AAfNTbnZYc2rOCe8Nr0nbfGh/Xg=;
	h=From:To:Cc:Subject:Date:From;
	b=fMVlIKdbVq+1oFQy/iyRpiVkQDLzom4OEAihdPCroE9QcgpmGY0kpvAF+DrlQ10mA
	 SrX+HOvtMD93IA59omagBnAEmGmXRus+6y+sR4kakb1ieKZdwc/3iMF/GOpHF14Xcj
	 FHZ0ms4jImqr5Rl6QOQwS65QzzXkSla8+ZS3QXyOjIstHFPfUZbLcIL+WYscxoEzsC
	 2UkRbpTukLL4dAGlHjPajJptVf3FWprQgBUYNESBuRBs/Ptws4MjxfUlUAlY7/sc4F
	 yUQELguoAcmIu5QGferb0zEWxRonk6TNdA030zH6VziHiUxuyRD0fWCyySSllj4urF
	 SbxMVHIP/d3Bw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH v2 1/2] cpufreq/amd-pstate: Push adjust_perf vfunc init into cpu_init
Date: Mon, 28 Oct 2024 09:55:41 -0500
Message-ID: <20241028145542.1739160-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

As the driver can be changed in and out of different modes it's possible
that adjust_perf is assigned when it shouldn't be.

This could happen if an MSR design is started up in passive mode and then
switches to active mode.

To solve this explicitly clear `adjust_perf` in amd_pstate_epp_cpu_init().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Klara Modin <klarasmodin@gmail.com>
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 206725219d8c9..e480da818d6f5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1504,6 +1504,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
 
+	current_pstate_driver->adjust_perf = NULL;
+
 	return 0;
 
 free_cpudata1:
@@ -1866,8 +1868,6 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		if (cppc_state != AMD_PSTATE_ACTIVE)
-			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
 		static_call_update(amd_pstate_cppc_enable, shmem_cppc_enable);
-- 
2.43.0


