Return-Path: <linux-pm+bounces-22510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E39A3CAE8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24283189BBA4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AB25E464;
	Wed, 19 Feb 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdENsraZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C325E45F;
	Wed, 19 Feb 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999015; cv=none; b=TetXfM6Qn11LQQlug/e0P4zjoAjBft6wZUTKzOQcLF/scKuTGDAw0FdnhsGPWgFD6a2qGN5FRK9OGCf1Cx7ghOaugKRii9TANIWUvpMNaVY3QKk4BnzeDNdzH5F4xcjdnqpQoE4MXASuaB/+Ie2JT0JQghzEKCQsqL6HuufgyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999015; c=relaxed/simple;
	bh=WTzO3oBnq/qedOzKGSH7Hoth3Dlm5/JLQ/Unfm5RalE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK2XBdctMDWT77kqe8LxaoaDPzDXUO36szV/bAlSJvlPF5m3fbCwKryvOlrgsO0AUnOppiD2YFdm0a1f2TMNLx7JhqlDhpTWbPYOnbscFl233wz/WwENzsRjOPsbhDXclKRlkdTpgMXSw335uUh3BkiceBp5lSnJlZxANzIXi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdENsraZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25555C4CEE0;
	Wed, 19 Feb 2025 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999014;
	bh=WTzO3oBnq/qedOzKGSH7Hoth3Dlm5/JLQ/Unfm5RalE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdENsraZfdRH+dbiq+MRqeHGgeQX1x+4a1qHnbborf8ta/r0wKWtAymPZ2h9/Lpye
	 eDXV7UjcRTdghu2TSudmd/PcMv9cy8k/HW+VLz9Ug+j4FUzMs8jRNpyNdYn18mpTe8
	 4fUEMbZf2TxksJz/cXnxJ210shp3syV5CmheOMaGpUBbUXnA+JoExd9OGMipu6ux/0
	 n+ssMwPsjoNhwG7T2ssgY5WhbAgvkuBjs5M05aZXaxknTVJu/a9/iVTrWRPekPdVl9
	 FuFjbWEGjAsnAxFPLzBHteYSHXNY6VkHnrKvAd8NtF8g7LIMuzyu6Gxj0mopZqlmVl
	 pu8nDwXoBjYjw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 19/19] cpufreq/amd-pstate: Drop amd_pstate_epp_cpu_offline()
Date: Wed, 19 Feb 2025 15:03:02 -0600
Message-ID: <20250219210302.442954-20-superm1@kernel.org>
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

When the CPU goes offline there is no need to change the CPPC request
because the CPU will go into the deepest C-state it supports already.

Actually changing the CPPC request when it goes offline messes up the
cached values and can lead to the wrong values being restored when
it comes back.

Instead if the CPU comes back online let amd_pstate_epp_set_policy()
restore it to expected values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 408e63aff377a..5068778c1542a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1610,14 +1610,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
-	union perf_cached perf = READ_ONCE(cpudata->perf);
-
-	if (cpudata->suspended)
-		return 0;
-
-	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
-				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
+	return 0;
 }
 
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
-- 
2.43.0


