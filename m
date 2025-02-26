Return-Path: <linux-pm+bounces-22954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70444A456FB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BB9172A35
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5826D5C8;
	Wed, 26 Feb 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB80VaoQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2D26D5B4;
	Wed, 26 Feb 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556183; cv=none; b=W4rtcShOkTP17Jge44JlXV5Abz56aTA9IfCNJqwJHGqzI6hzcc1bFAGJCHJD6+p/DYZ6YTyzlFcPv7kz05Wm/G7A5SIkqj1lbstMXF8Vr0PlkfJ9QcCg23911Q/KdEwc8x0ARKfnGh6L6IhKYh2s6TLBKOp0bWTOPnT8XEqBj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556183; c=relaxed/simple;
	bh=BrOubcwuEEN6CSCwegHziTWdKo7Rf4NmB0rVPPiVqIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W229TWXKJ7C+EqVkxwBlYmZcHtsBT4XLaI0XgsnyBdyY5jMPj67wGJe4uPR2EEfYcbCxejv3y7Opm4EdhbkaOBU5ICJNlIy21fMz1hVsoe4Op68FS4t4BrLdwGNNEY/NQSS10bDIuWdAqzlDpd5l+ZZd602KkFxXx9W4YqdCpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB80VaoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29162C4CEE7;
	Wed, 26 Feb 2025 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556183;
	bh=BrOubcwuEEN6CSCwegHziTWdKo7Rf4NmB0rVPPiVqIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eB80VaoQMVDCzHU/O0qH7o2oYKcijTkjGlrpPTZbdKSWKdn6bKpmrdTSdi4MpzN1e
	 OjeSzAzM+DVxPTVFK5P2JGs0E7RBWqxtJQUSAU4hTblZ+F/M/vBK+F8ej/zdqk0QFL
	 h6LlMIg+5plHR7UHct5tNVPZlhDUx0FqUxa+lhKaO10s4m+noIk3MG67KeNJydpu0j
	 w7fUgvoUNAJ1ksOr3yBnwT7GKRn4Hy3ghD/Ih5X+JcUShrupsIr3xpe5ImSjy+F/Z1
	 m0gFkesnAItnfb7ddiCTzY8a11mHwsBnqOqFNN4MS4RDqk7Oh1rg2wvk8tDtm6NWTW
	 gpDJfdD018uJw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Miroslav Pavleski <miroslav@pavleski.net>
Subject: [PATCH v5 01/19] cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
Date: Wed, 26 Feb 2025 01:49:16 -0600
Message-ID: <20250226074934.1667721-2-superm1@kernel.org>
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
index dc38ef4c8f725..a093389a8fe3e 100644
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


