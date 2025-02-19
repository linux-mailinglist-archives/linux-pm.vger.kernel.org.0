Return-Path: <linux-pm+bounces-22499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15197A3CAD2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9123AA1F7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DB4257ACB;
	Wed, 19 Feb 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8nSXFoU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29B257AC1;
	Wed, 19 Feb 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999005; cv=none; b=EloAaHrqk1UExu7cg8kg1+JMoSy4VaPEUkIF0CXtWpRfGQ0HcuXo2SjpbMgiFDTW9U7EY0jTtLK3XRNLK24TNxEo6l5laYoETNsyOdcqo19E44HtnuBwoTtfae+ecFQRJyv7mq40hpn4QWgu6wq3hi12kTn4dyASb6JRLWWvdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999005; c=relaxed/simple;
	bh=89hZJsTz1/1KdvISKnlVIBNt2V7Be0uqSdSXNCI1ZKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvztM+7+gMq+o/mK+2phznSylCUTjoXymxurlD2taYJoiPA6Zr5oPmQR2kFKCTv+22Y22JwK9QpCNC8YSFEc6T7ezDthpfa0HRt2nXyDdZOnJkRkBtBeZgfU5xhyN5nU+Z6knjsS7/yRp8mr9Oj26dWI74yL4aUD0zl27nZuP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8nSXFoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06581C4CEEB;
	Wed, 19 Feb 2025 21:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999004;
	bh=89hZJsTz1/1KdvISKnlVIBNt2V7Be0uqSdSXNCI1ZKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8nSXFoUdCfy0i6pN08wHBuVqCydVsTLeP7UFAF6rnwALgJ9dyipr8C6861cV+44F
	 +m/6hEgd5IAPB9RWnSnU+Ygy/c4abyIRX9c/pIl1Vyu7KSXR84PpAx4In1XjsP49Rv
	 6LDgw6Xwq6llmDCRxMTI0tpZ8h9llkejtoOCUsIZFMe/gPKkJn4Hy5lhJGBKXZk+RB
	 NA+UnRVkElU4qHkGROaxGrM11/8dzWACjFhQ5S2vVicy3NE3xfGX7Zj9sUU51GQ54d
	 QEr75U0CjI6dldOjWfYshcTctryNpgZyoCMHB3lOEGSIgoY+YJKJ0TIAxGZBbOs0+Z
	 h09+rUA1jXEsQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 08/19] cpufreq/amd-pstate-ut: Allow lowest nonlinear and lowest to be the same
Date: Wed, 19 Feb 2025 15:02:51 -0600
Message-ID: <20250219210302.442954-9-superm1@kernel.org>
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


