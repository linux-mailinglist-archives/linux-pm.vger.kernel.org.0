Return-Path: <linux-pm+bounces-33067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826AB3534B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38113242638
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 05:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5982ED84A;
	Tue, 26 Aug 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNeLl8eo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330392ED15F;
	Tue, 26 Aug 2025 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186076; cv=none; b=WJTjmhVFUqb56L1Wx2YbiZbXKtST5RSSW6B9kys/EveniiELZvIV7bDtCeeBZcrOwXHHzybXkGkea9TUjjy4rb/MGbwvClSfSCQN83spk/ierrHxpyxaCrwKZxkTZd+Pykq+a4GVlaM3YYtlok1xkhpfu/2rzosFPrWl0w+FHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186076; c=relaxed/simple;
	bh=Lg0ntXLyOVhk9d2Z5zxtehykNJftJDOgFU7UUO57tLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvk5+TUtGYAT7TxToZwK9+xYMRIW/8+bXTOLnvLVlt8n0FJmzP++FE0ktABmS0XUt23n/CJj63TxAHGHAbdm7nBtowrVVFB0RVtnCy8wh4fP3wSlsd4srV3zABuxOPqq9+UQhgBVqwrJEO3fhgKO8RG89XZblUFQqadmgi49Xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNeLl8eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2904AC4CEF1;
	Tue, 26 Aug 2025 05:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756186075;
	bh=Lg0ntXLyOVhk9d2Z5zxtehykNJftJDOgFU7UUO57tLM=;
	h=From:To:Cc:Subject:Date:From;
	b=cNeLl8eoHXHLYekMyZoe+3QezYWcFLBy/jubmOuYMpk8zswM1VeEmUnOiqT7r1OM2
	 FFWpxjulvSlh+fNh5DDTKFP65ZxL52vOMF6YKqNiS9SBtPLjYpscTcxTbIL/vO4y6l
	 qZ7WW1QH9nxF4ZDoThStFkbpOmnUBCjhn/OmS0EizuosT3ygSJYX7usKC7ktCHGq+f
	 3s06Xw56jNEUpB7jJMuyKEG5Tl1GkYokkzfM6wgyOQFYXAyFg3A0p9wi47uLlJOijS
	 fOBOi7Vt15246FnWmF2nC9t2Z1ht0fgrfV3z1OqHzQNg4Mii7IDYjbiH7KatRe9+Sd
	 Do84zarAb54tg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume
Date: Tue, 26 Aug 2025 00:27:47 -0500
Message-ID: <20250826052747.2240670-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the suspend sequence the cached CPPC request is destroyed
with the expectation that it's restored during resume.  This assumption
broke when the separate cache EPP variable was removed, and then it was
broken again by commit 608a76b65288 ("cpufreq/amd-pstate: Add support
for the "Requested CPU Min frequency" BIOS option") which explicitly
set it to zero during suspend.

Remove the invalidation and set the value during the suspend call to
update limits so that the cached variable can be used to restore on
resume.

Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
Fixes: b7a41156588a ("cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend")
Closes: https://community.frame.work/t/increased-power-usage-after-resuming-from-suspend-on-ryzen-7040-kernel-6-15-regression/
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bbc27ef9edf7b..8eca4707226b8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1626,13 +1626,14 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
 	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
 	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
 	 */
-	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
+				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
+				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
+				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
+				     false);
 	if (ret)
 		return ret;
 
-	/* invalidate to ensure it's rewritten during resume */
-	cpudata->cppc_req_cached = 0;
-
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-- 
2.43.0


