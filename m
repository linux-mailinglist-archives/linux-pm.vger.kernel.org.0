Return-Path: <linux-pm+bounces-22972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA56A45739
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4843F1898A34
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02956224236;
	Wed, 26 Feb 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuJUCmBz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E022422C;
	Wed, 26 Feb 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556208; cv=none; b=kDY6YOuLypIWnMfQJAwELB3Sb5hB0LggBIob9PGCHxSt9qH/BrPYpdyQbHp1YudURMCW66v6crDejdIUsi7rSVMATlJc7e6MKp7GURbfSih+ahx5gBhjZrb1VIKLx3Y5k/SeVkNh7yEHGkzgJDU5iKbfJxdnwr8I1YW1oMb24KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556208; c=relaxed/simple;
	bh=wy2qW87sv3CHOyK6U2e65npVmbKA0sNrgjJ+lZsr8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErmwBFpm08tZysovKX8dME3WQNFm6bTpYb5xqFiTZe/xzM51vDmbeKLYuvDumJJdaJ3QlTQAcUm5P9V5NmOjM5Uub0UTw8UYyqfKT1DkzPHcMPswRF/Ahnf0ZRFJUmRI52MB5JHMBtMSWQFtdozMiJp2Vg2NIXw8dfSrE9pX/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuJUCmBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ABBC4CEE9;
	Wed, 26 Feb 2025 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556208;
	bh=wy2qW87sv3CHOyK6U2e65npVmbKA0sNrgjJ+lZsr8Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuJUCmBzbN8UUQsXAEoah0Gyxhfyuao4yhEyHftpbZ+jVXyK32YpEMsE/g5z0GvRa
	 yNzVLSUECefqJKID8TXckU5PQcjlyAlyH+0hri0wf4NJtNE5/yVKUnpC3mnHGOefbb
	 uh0SGkhX/1s3AvgsvBTZD2rd1CtjESSkPWwHZ4n+hTnqu2KfXXelpMn6hKg1//+z8k
	 b6RZle1ZXb7HHTa0ysOIfaejd4umXrIXsa/SMsZ/xSJPQdrq1FFJfG7KK5EGYn+ewp
	 h42WwCCNYMrw1NvAVvplYma1o0cxd3qEA+i174RAw4McMBt1mmwDQHorKhv9LGbdPR
	 qLaer6TO5ik3Q==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 19/19] cpufreq/amd-pstate: Drop actions in amd_pstate_epp_cpu_offline()
Date: Wed, 26 Feb 2025 01:49:34 -0600
Message-ID: <20250226074934.1667721-20-superm1@kernel.org>
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

When the CPU goes offline there is no need to change the CPPC request
because the CPU will go into the deepest C-state it supports already.

Actually changing the CPPC request when it goes offline messes up the
cached values and can lead to the wrong values being restored when
it comes back.

Instead drop the actions and if the CPU comes back online let
amd_pstate_epp_set_policy() restore it to expected values.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Reword commit message
 * Add tag
---
 drivers/cpufreq/amd-pstate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 24a1f9e129b61..4a364ae9b56a1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1580,14 +1580,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
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


