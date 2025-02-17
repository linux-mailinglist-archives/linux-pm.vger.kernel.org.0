Return-Path: <linux-pm+bounces-22281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6BA38ED5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213E6174AFD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE201DF260;
	Mon, 17 Feb 2025 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkBTEfLE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B651DF24B;
	Mon, 17 Feb 2025 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830069; cv=none; b=X8OQzAd9qqHsWAd+uU+LHSLl1gbRSRzlPp52VLGE1rttjfkwq7KLv8fcff1uUrnoMLUvR/GUcIpRIx4p8S5ICf5VbHZKUKsWpxpHkPeH4OHRbIrgRLXU5NkFCE0jZgUAtyxcPVvnzqzdubMx22ICubrEnWdOtJqV515knI+BTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830069; c=relaxed/simple;
	bh=XB8H1wjb48jXgguiXOM2q3McwxHjzVCURinUHtPIn+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2OnopINM7cwmZtgpDQpfzWEMQXhc6siQvEnFV1RAX3Nac/JYcVlI69DnB7CPeJvEFvIwqyA4T2gg4r7MFmsaGCf01ff0TtoQELJheOhIGMQh3di7Vqdt6JH9XcsidHSZI+VKYfS0JYg/ZUatKGOS8QGqxfjBCF5vBWFhgmvXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkBTEfLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB3C4CEE4;
	Mon, 17 Feb 2025 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830069;
	bh=XB8H1wjb48jXgguiXOM2q3McwxHjzVCURinUHtPIn+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkBTEfLE2nHSp7d5OxYCF1Cdu35QVP8IrrmCKL3RQ8WavLTtmlHBRVFEQt+5Om6IE
	 +AxSZZx2La8fXHWl3LLuTNlqz9Lc0nJcn3tgdL7AY6jEtg7ZaGM4lN0JmlZLa5cjj2
	 GkFeOBGmyAlMyCJRhirktiy5Q6HfUKEwybhApOqpajdEUSsq4cVSjmsZeNU1mq4ffC
	 c7hlJwANf4qfPhMSk/15cYELYwxchffy64gJqzSW5p9fzr1U8Jsrd9Hh7+vFn4SPGs
	 gIIzoGr9NpuZfR9HxrJ09dXfnknRufa8wV5YKrg8ItR7N2Mcda9p6drW/GdjZWAPlR
	 Wzwm+MtCm5M/w==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 16/18] cpufreq/amd-pstate: Drop debug statements for policy setting
Date: Mon, 17 Feb 2025 16:07:05 -0600
Message-ID: <20250217220707.1468365-17-superm1@kernel.org>
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

There are trace events that exist now for all amd-pstate modes that
will output information right before programming to the hardware.

This makes the existing debug statements unnecessary remaining
overhead.  Drop them.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f4c9d7fe28f5..9985edf9d0d55 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -667,7 +667,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
-	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
 
 	return 0;
 }
@@ -1633,9 +1632,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
-				policy->cpuinfo.max_freq, policy->max);
-
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
-- 
2.43.0


