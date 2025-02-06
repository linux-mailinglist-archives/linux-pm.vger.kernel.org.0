Return-Path: <linux-pm+bounces-21515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C753BA2B488
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AAA3A335B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF83239080;
	Thu,  6 Feb 2025 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqPsoYD8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B19239077;
	Thu,  6 Feb 2025 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879047; cv=none; b=einCvIu0hRz96+eHi4NF8zOJFQG1E2qFfZLN4LUsFE1RZ3s9gHbXXQQPRdDHFqBcaRrptSceeajQ+aifOoGlHXGLWIemOQ1Rx/1wQsR/m4s9KfAY1xGNLHXHjvyJ2nJPAZy4jUDXBvuMAY1ietSe+7bywy38fKbnxOGhZxApJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879047; c=relaxed/simple;
	bh=p3qh6BgNktnXulCLfeQO4DbZgTv28EEbkItSSHeb074=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhIKUrcSpXPKjfZkYLbKI9p+x8kOXbr0CrJ+cGRRFzuuOxiT680BbxREBepxxE+NVVpoyPEc+uyd4XUmehnzfLbWhSH27td72fdguNPv6ErSZ3Pu088VuoGQWJPS1s3RxcXf+h6bF2lfIxIWDJggET/jqxCHozUGz2hZZEgA6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqPsoYD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E34C4CEE0;
	Thu,  6 Feb 2025 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879047;
	bh=p3qh6BgNktnXulCLfeQO4DbZgTv28EEbkItSSHeb074=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqPsoYD8CT6Q02whTB+FspNJ4+wVpIlV59OnvzBAdd5eCCNOLlUKEp/e12ahIVptW
	 8YCnO228FxK7ieseG1rcMr2zBTE6kkIQZzI0HhhYOXqfO7tUDDjHk0eJbLrfmTH6KW
	 72H1vOjjnfNwxibk79nnKtibzxUW1eWWv2pvev4vNWwg1ESvgw0jvB8l99JcKP7wTA
	 /UVYUE+qYozjq6zNGaFnSxol3tA+PQuIc0cEyoKogSrsgxSXzdbS3ZupmQiavJ2KoY
	 5Tp+mlHAktjU3SCSaxNzqJK1r/+Q+DSuMXEPvaYRL00oZGWGKcgijw/8Ub7QV0YkKs
	 EjOEZu9+ZWOTQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 11/14] cpufreq/amd-pstate: Drop debug statements for policy setting
Date: Thu,  6 Feb 2025 15:56:56 -0600
Message-ID: <20250206215659.3350066-12-superm1@kernel.org>
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

There are trace events that exist now for all amd-pstate modes that
will output information right before programming to the hardware.

This makes the existing debug statements unnecessary remaining
overhead.  Drop them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 754f2d606b371..689de385d06da 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -673,7 +673,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
-	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
 
 	return 0;
 }
@@ -1652,9 +1651,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
-				policy->cpuinfo.max_freq, policy->max);
-
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
-- 
2.43.0


