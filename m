Return-Path: <linux-pm+bounces-22492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B3A3CAC9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092DC3B2EC3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992B254B1F;
	Wed, 19 Feb 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnI++ptg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253E184F;
	Wed, 19 Feb 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998998; cv=none; b=U9FE7UyErld65uig8aumnjdWvnIcyqU4nO+LeJqsT3ldn7vcHk9mMlL6w6RnJ/q+aBHjMbMrr7YZQSfXtk5sWkZyhs9lB4vyZaC6g1dOvN7YAAX3yVS4XESEhp/m/6giGUrIBzCMXiDGpks704aZWEUHVXm9UG0xmfp1xa8AYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998998; c=relaxed/simple;
	bh=kC1dYjkCZA3muN1LdAqevhAUigSzg76qP4qgSHoki0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRtW5k7ME/U9Lo1BjCKFxfJHzNh7Hsa8LYOYbMbdqzA1onXm1UUNj0T437c4O35Zl7YHPEWhGXuJOOp9Eheptgt+jyIsUdRito06UzrRxkkaI+4QXfJP5JMHy5DCuAd+eXUuskx+uZJ2sIUBE1xkJmhwMokiI8NmPyh8WNq0rec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnI++ptg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A27C4CEE0;
	Wed, 19 Feb 2025 21:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739998998;
	bh=kC1dYjkCZA3muN1LdAqevhAUigSzg76qP4qgSHoki0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnI++ptgtoYu41WXMZOsqafeUydXIrkWDtQ2MNmss+iBF8+aZ/jeP4CRb/GjB8Ub1
	 0FOvBknKzWYnbLGj4Ov8M/qqxYzI2c9JHbK15yW5msD0o1IcvFt9P7Bfhm7Ab65twA
	 ZvlJLnLT3hgD8YA4qsde1B1r8we0j8wSUeoEgenpQ/oMUe2PkVOHFBZSEsU/1/2vE0
	 0eJYjTdGlbBR5PulJ2I35tljCXbjBrhDFAMprl7rrby1wng2Kw/wASa56Qj8Cbu7LR
	 hnuz0W1QdYEt9wGJ/1WfcMQFGpftX4cDnwNj3uHPd0CkrfY6Z5gGdym8RkOVJwgbNY
	 z8WXJMdzgTyKQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Miroslav Pavleski <miroslav@pavleski.net>
Subject: [PATCH v4 01/19] cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
Date: Wed, 19 Feb 2025 15:02:44 -0600
Message-ID: <20250219210302.442954-2-superm1@kernel.org>
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

During resume it's possible the firmware didn't restore the CPPC request
MSR but the kernel thinks the values line up. This leads to incorrect
performance after resume from suspend.

To fix the issue invalidate the cached value at suspend. During resume use
the saved values programmed as cached limits.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reported-by: Miroslav Pavleski <miroslav@pavleski.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f425fb7ec77d7..12fb63169a24c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1611,7 +1611,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 					  max_perf, policy->boost_enabled);
 	}
 
-	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
+	return amd_pstate_epp_update_limit(policy);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
@@ -1660,6 +1660,9 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	if (cppc_state != AMD_PSTATE_ACTIVE)
 		return 0;
 
+	/* invalidate to ensure it's rewritten during resume */
+	cpudata->cppc_req_cached = 0;
+
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-- 
2.43.0


