Return-Path: <linux-pm+bounces-11491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1393E230
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 03:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6B91C20444
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0E18A948;
	Sun, 28 Jul 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJaTwx0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1F18A93F;
	Sun, 28 Jul 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127779; cv=none; b=eVitEkpmcrTn9K7rXUjL2D2Ka74SeDLoMnkvhPTKvr144DErcdC3n12U/BgrHElLp9ycOgdH6rX6Vs/FJBwdrkwsrn9GP5robpgdIuZn9Lez4T0elCpucPo6H1M+taUw84l0KtkAc2p63tdowo/ii9QL3p6nQtlW5p1iYTSNht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127779; c=relaxed/simple;
	bh=GLO9QUqI2JYHBcVmoBexoT78BpUwwBXQXuDbx55npk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK6vXAGzBUPtCJZnwCJkxwi/6wTTRcy5mM7mmXDDjAhKMZaWhop3YuS6j/tbHUbcmh/IBvGP81L5VKpV1LyFhefV9/HuZgqxg3P6ix6eqIxPAZjWXZ1QJxVW+jwjxJ7M44lL63uby8s1UqWtLlHezDAG0Hb/xGwGItQVn3SSFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJaTwx0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2ACC4AF09;
	Sun, 28 Jul 2024 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127779;
	bh=GLO9QUqI2JYHBcVmoBexoT78BpUwwBXQXuDbx55npk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJaTwx0ruHAymsJI24u/dLj/ddQkRrajXoKiHsnYrjYyJSdZNhZokwHQXRcAyp5Ix
	 jFRV9fuiVcRZZEPJfddbJEejxKJ6Qu+d2cnhDVCaepruitcCo13kNPAuX9/IfxLqyN
	 95g8l6mqON911W8DVTjPPBGBXxcSn3lmJZZsQVXbFQ18C4foI8SFaHtxnE+gLvRe6z
	 Q1+rGCKNxnZ8IRdoTR1gm635XAm6QuH88/SEXhMlAxkBKHMRaz3C13Zb/RkIC60SZL
	 4Xg7PoUBguLf39YpptFoS2woDS3CZazW0jufK/axMl7yD1FmrXI5mDFsloWQ/sMAsE
	 vXHspF/F/mb3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Artem S . Tashkinov" <aros@gmx.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 3/9] cpufreq: amd-pstate: Allow users to write 'default' EPP string
Date: Sat, 27 Jul 2024 20:49:23 -0400
Message-ID: <20240728004934.1706375-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004934.1706375-1-sashal@kernel.org>
References: <20240728004934.1706375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit fc6e0837264a8b2504b6160e63ec92eb012540f3 ]

The EPP string for 'default' represents what the firmware had configured
as the default EPP value but once a user changes EPP to another string
they can't reset it back to 'default'.

Cache the firmware EPP value and allow the user to write 'default' using
this value.

Reported-by: Artem S. Tashkinov <aros@gmx.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931#c61
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 8 +++-----
 drivers/cpufreq/amd-pstate.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ad62dbe8bfbf..fe17a05fe6a4e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -281,10 +281,8 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	int epp = -EINVAL;
 	int ret;
 
-	if (!pref_index) {
-		pr_debug("EPP pref_index is invalid\n");
-		return -EINVAL;
-	}
+	if (!pref_index)
+		epp = cpudata->epp_default;
 
 	if (epp == -EINVAL)
 		epp = epp_values[pref_index];
@@ -1436,7 +1434,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
+	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata, 0);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index e6a28e7f4dbf1..f80b33fa5d43a 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -99,6 +99,7 @@ struct amd_cpudata {
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
+	s16	epp_default;
 };
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0


