Return-Path: <linux-pm+bounces-22502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0629A3CADC
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFBF189CDC1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F22580F9;
	Wed, 19 Feb 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhZcOjY3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E22580F3;
	Wed, 19 Feb 2025 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999007; cv=none; b=efEJTQFCtBCTJbZryXO+I8Q4ni4lD/54jFAKqEDEpq+7b8Yjdlvh1S9qaBOB4F+NrhsWpZJlzaZWRx4pQK2mZgImLauQgeDLc8knCv7+SkF/c1f8+A5+JehAGDaoWwk3GDvstUkE/0M4HqUvpUUj07Cr88dneN1CgSeCbM3LBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999007; c=relaxed/simple;
	bh=KIwG/kEIVb6cTf+T/wqq7Akr9rEXI8YurHlaC3SVGpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqXE1Z7LsrG54q3P6/YDdT0XYAbdU1OunTXWLEeaunbnU6twAuAaQjB2lFPdbOFczVavEZfNf0YuaT7Ib/jk1SKOKhkarxeiwj/jhmdYd8HhtDUmYstQEiXyRs9a4ojwCBP8xnM+JLoF5NvT1puoDAx3f54tUd8H8Bh0pozaa30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhZcOjY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC4AC4CEDD;
	Wed, 19 Feb 2025 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999007;
	bh=KIwG/kEIVb6cTf+T/wqq7Akr9rEXI8YurHlaC3SVGpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhZcOjY3PNVO5cu5nltnm2NJ0C9lJumIaeW/Qlccem83RFe9DYFmP3T7bp89URZtZ
	 eP7ceZ/EYXoIJtJIG8zMSbmoTWkh8fw2SNdfwDQUE/sEQyZkMtY392OmE17IycGVAa
	 EUp1ca4qfrYgTDIHRln4n+QFY/RvgVotuxrAP/3cyVx2K/UDx9tX5DMlvFjWBUqCQb
	 sK5N9+zDFfgrlBqfo8ZYMdnu2ao4OHYQkSz75a/QCKyk5xXw7FIzjW3C0E2+k5Q5y6
	 3doYJ0Dp2MH1a1HR+m38UL+a9A5h4xp/GLhxZ9rckSTJEs8LnMCog4lGtVypCwwn1q
	 fnZ4TphBCitlw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 11/19] cpufreq/amd-pstate-ut: Adjust variable scope for amd_pstate_ut_check_freq()
Date: Wed, 19 Feb 2025 15:02:54 -0600
Message-ID: <20250219210302.442954-12-superm1@kernel.org>
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


