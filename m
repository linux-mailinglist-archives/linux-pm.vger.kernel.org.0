Return-Path: <linux-pm+bounces-22128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0591A36A2A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87047A36F1
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61AD17A586;
	Sat, 15 Feb 2025 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+MnIeUO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF41170A13;
	Sat, 15 Feb 2025 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580783; cv=none; b=W+UHtcZhS7mcfflP/zADMvmnVP8sxNBD8eMr4JjSbIFKlnzCqyfSzsf07XLyFIcJWoOOf/d/KUeLosDxm6NRIg4FE+U7ai8zQvPA1UxvZlpBFKxSzaOyiMbI2oBTa08PFB94RIB1/ctAtTwscu37Tgr+hrsrnkMdDrMgBzH+wKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580783; c=relaxed/simple;
	bh=1RTxA4iwol7Owy8T/Zeqc5ZQedUjvCzqSiHiSuzk7z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nh+3HS4y9HLWH6aU0OPzX6b4zNitR7od9kogcrSj3IgdvyJTUVB3UlhPtIxg8aSwjXaUnm8PT2pDSWjB4AGst8AO6Sd8NbMiFLEfDsoYeeGWdLYzH6eXTu/x92k360K9goh9qmiG9igM9lS3bV0W9QOufm3ttPzw1Z93ZTKlaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+MnIeUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E01FC4CEEA;
	Sat, 15 Feb 2025 00:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580783;
	bh=1RTxA4iwol7Owy8T/Zeqc5ZQedUjvCzqSiHiSuzk7z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+MnIeUOMlgm3pWYOOwAgVo697fioraSeHkmRC93xkN1jVz5Xw75+dbH0bgqU6TLr
	 pkXTWEYLHRRj+wBjnSkdyjTjT0Y32fwT42mPlGeI4e4+Nuk0tCNndCWTe2vYwLOzO7
	 UK957PK9ON6/ECRnnolrc26TQq0+hRczvNZ//xZiYdm9hO3yB4VaDQNWIgLxHucQ6L
	 /n46eVzkxD2lmRLtk/brjRrn4EoWKGg95CsBsDvqOz3/pNfv3Nx6JN1BRb9nUBb5pw
	 a9gMagSpvwSgaKH2h4pt8WEt5G3DHmreSxBDPfh5XH7cgUnqquZhHlSqBCZ5tkCFnf
	 OcTe3iBtAUVUA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 07/17] cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the same
Date: Fri, 14 Feb 2025 18:52:34 -0600
Message-ID: <20250215005244.1212285-8-superm1@kernel.org>
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

Several Ryzen AI processors support the exact same value for lowest
nonlinear perf and lowest perf.  Loosen up the unit tests to allow this
scenario.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * New patch

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


