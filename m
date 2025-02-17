Return-Path: <linux-pm+bounces-22275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FFA38EC6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9826F188CCD8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D61DDC11;
	Mon, 17 Feb 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBFHakTq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEA1DD539;
	Mon, 17 Feb 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830064; cv=none; b=gjUeLhHRKnztK1Yi6ZpKomvkUXeEqWOQM8qTYdgtIuh+M2I3oCtpi1IdK3xOOrW1GRZORN+BVdCcV/2ndtyn983nWKMu51wxFdVBAssZNDNKs6JhBj3IG+qE/xfDBOV3QxFWvyi6qvlHREX9Iq4ChjFXH8a+2Vy4Cxi1JFLeojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830064; c=relaxed/simple;
	bh=KIwG/kEIVb6cTf+T/wqq7Akr9rEXI8YurHlaC3SVGpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8xyUKFg6/8/+SKCl0l5fLGU3hXN0k6sYYrovTCrJDNUjVuroVGdb/PUM+158EACqpuDzNCnO8ivFBmdNskI4rsbPQsje/KMOlfsyj6WVhLKa80r3cICfjBjUtsVmY7XxQ6ZvzDe2Nm5fxppf2nWeb0M0NKKEM0OHeROaT6q/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBFHakTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F09C4CEEA;
	Mon, 17 Feb 2025 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830064;
	bh=KIwG/kEIVb6cTf+T/wqq7Akr9rEXI8YurHlaC3SVGpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBFHakTqHj57wKa/bEqkDs3pnfyy7gQqMQGI6CLnD7j7HrEsZh6rv3pO3u2kfiUFJ
	 1tGPC+kl2hSgMT9qFEQOXErClpfsOJnW8ohu/DbG6YABP1RbvQEhjDCXn0bVoZ4gRb
	 d/GlULSMNWRpF0PNCDnfK/Abads23HTyJifZHLlXSvk96NR/PAe0MQlyzmLtdzJI/2
	 H14bPf58whMyxTfCgsQTbU4BvXbccQa0cIR8tvYZXutKuowtIHo3XX8Q3sgtiUGIhi
	 0h4oe81C7ZyvBrXPZZuT2e8Dm2JD4mRa/1QYGZvTMNnU2wUKw8IwZwpk4w7VvGtBq0
	 tl5/yfedLngfg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 11/18] cpufreq/amd-pstate-ut: Adjust variable scope for amd_pstate_ut_check_freq()
Date: Mon, 17 Feb 2025 16:07:00 -0600
Message-ID: <20250217220707.1468365-12-superm1@kernel.org>
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

The cpudata variable is only needed in the scope of the for loop. Move it
there.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 3a541780f374f..6b04b5b54b3b5 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -186,10 +186,10 @@ static int amd_pstate_ut_check_perf(u32 index)
 static int amd_pstate_ut_check_freq(u32 index)
 {
 	int cpu = 0;
-	struct amd_cpudata *cpudata = NULL;
 
 	for_each_online_cpu(cpu) {
 		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+		struct amd_cpudata *cpudata;
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
-- 
2.43.0


