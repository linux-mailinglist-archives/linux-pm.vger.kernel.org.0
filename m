Return-Path: <linux-pm+bounces-22274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0D0A38EC5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E25C189357A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BA1DCB09;
	Mon, 17 Feb 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ5t3y1k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6A1C2335;
	Mon, 17 Feb 2025 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830064; cv=none; b=SvZ5Pfy4u3OD24uJ3oiEeQPta2qLCZbGXO9XQWKXKDXlvsPOq6dasDDqa0AYOIF7GKVn/r6VOLgdem7EpnM9PJGuOKKOMLzex3Ac9SKsbfUSMCQ70YJyQaMMDsNX1gz6qt0eETxizeRTV5yBw1PA62/DATm26/O/wxbTJ41FtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830064; c=relaxed/simple;
	bh=89hZJsTz1/1KdvISKnlVIBNt2V7Be0uqSdSXNCI1ZKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6TFU1UGycdd9R+410MkxoM4cGCa9x/sbgUZpygwdFs8QAjhqOXtOTOyWhiaGA3aW802/aTNkkeZCNpIR5wyjk8WAY1+e0+24jxiCaFhfWvWVxXPKDfZojkmnqgEhU/30MovKYdoRMwIpUUPn2vHCdFLdNMtJzhnDKIl1Drl910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ5t3y1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469BDC4CEE4;
	Mon, 17 Feb 2025 22:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830061;
	bh=89hZJsTz1/1KdvISKnlVIBNt2V7Be0uqSdSXNCI1ZKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZ5t3y1ks/GLzbeh9cDKoXJ1uUqdjX8t8x3OTatwmZO3NFsAdWBnAgFqFAy+XWNC+
	 +hSpK7kWMejaM/pRn2dr48RqUj5Tr82ClDMkkpPf78Qpl0lpPZhIi4DIfmnIg5Ysoe
	 7w3tRHZaEFOX6VlWVhZHhuOpJmxJMn8zFnnCas4bPP2ZoL59fuDAwC4Z+FP5CYFiS/
	 JuO2HJhL6ALGSxpWfilYDVxl2ZqEINNQXmYe6vHy2Kq+iKLbt19VM0lXF3o4jwhUxN
	 mpf0BGnVnAajNxu79+jApwrvh+heL82Hdj7URJsStKREU+ZvDIhRzVWsXiSUAhaPFO
	 KCRvA5XyWCgpA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 08/18] cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the same
Date: Mon, 17 Feb 2025 16:06:57 -0600
Message-ID: <20250217220707.1468365-9-superm1@kernel.org>
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

Several Ryzen AI processors support the exact same value for lowest
nonlinear perf and lowest perf.  Loosen up the unit tests to allow this
scenario.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 9f790c7254d52..0f0b867e271cc 100644
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


