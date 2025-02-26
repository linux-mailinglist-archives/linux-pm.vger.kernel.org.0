Return-Path: <linux-pm+bounces-22961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A210A45715
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7874017775A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5974026BDB9;
	Wed, 26 Feb 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjVfO5jX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200A271839;
	Wed, 26 Feb 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556193; cv=none; b=hSed3ZGPCmNS4L+LyITqiYUFD8rXhY+cTnuBeEtgUH/LV4UJk5r1vkgcYifhce1d0O0edK3u6tSGcKvvY30YwwqKrlkavh683dxO5I2KGIDKJ54GuIWiC79QRZkIAZIqFf0XqRlAEo4SjVumXOTZuAFAzQl/IW1qpqb24/z34CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556193; c=relaxed/simple;
	bh=4fgPtjxQ+iiiTGlFmFYmmvw8hB/zd6dMGJt9QzGFgSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmrSeE0l89o7oIB7jbiaJFvUipk1BwMO7mt9yZZwEQpEZOxivrREa99Z25dIzCZElCvb7m8Vpa6fIzUd0AVUVun6yl/QQ4gfCL5OhZnrKI6PoJBlZw1TIp6BLj5L3rLUgnpyQ/h0333IhKMlyDadIwD157ld/CK2gjzNyURfXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjVfO5jX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00491C4CEE9;
	Wed, 26 Feb 2025 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556193;
	bh=4fgPtjxQ+iiiTGlFmFYmmvw8hB/zd6dMGJt9QzGFgSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjVfO5jX7NcDN2Dm4WRjof428bwHTpK8Z5JDP1gf/Vm2RyfYssLjHUYO4nOuKCgSb
	 CZtHWzp7LOOI7u8nhslwnSsfQzq45nPubADye5iRAfESke/5L6+O1ZDS9mlHvw/Aok
	 5T5RZ4kr+pEDZ3kjPR/bWCvKtKxs3fLKowKwPLf0xN4xifb70fPvxfTEH86bNX7Zf+
	 EPseZkVFdiyi86/gxz3qUWX2oWDhqJAYlWaBJEv0DWEQK8ygoMooERyrS24I2+Pwp3
	 wGyeAfuOc8SNa2lJtszbGlTV8GLsoHVlFkCiMc7HTgoqRQuTWbpjPVxc/nfOZUev9C
	 oZ0w3sXaaIbng==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 08/19] cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the same
Date: Wed, 26 Feb 2025 01:49:23 -0600
Message-ID: <20250226074934.1667721-9-superm1@kernel.org>
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

Several Ryzen AI processors support the exact same value for lowest
nonlinear perf and lowest perf.  Loosen up the unit tests to allow this
scenario.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
---
 drivers/cpufreq/amd-pstate-ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index e02672e67380a..b3693a4c28d26 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -184,7 +184,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 
 		if (!((highest_perf >= nominal_perf) &&
 			(nominal_perf > lowest_nonlinear_perf) &&
-			(lowest_nonlinear_perf > lowest_perf) &&
+			(lowest_nonlinear_perf >= lowest_perf) &&
 			(lowest_perf > 0))) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
@@ -217,7 +217,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 
 		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
-			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
+			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
 			(policy->cpuinfo.min_freq > 0))) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
-- 
2.43.0


