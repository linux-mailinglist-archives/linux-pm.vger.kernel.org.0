Return-Path: <linux-pm+bounces-24649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB011A7683E
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F581885726
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387421D5AE;
	Mon, 31 Mar 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn4DcN9S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA18D21D5A7;
	Mon, 31 Mar 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431681; cv=none; b=Umu6PfDWCswgQKS2xs9z01Abt5xQmR8giLlWCiPASLdH5pszYhsZBNcegYq0KFTwyHL5P3nyPFucs2Y2xA3B11hpwp5olMLHECxIsMYfv6qIn2e0z66f7ere8mxsZ6pYdwZlD2U9ylovtEr8yeK7IJYK0iD4pMy9UE3yC6ULQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431681; c=relaxed/simple;
	bh=GIrt7w0DLmjw04BZ37oHxkGh+eTxPO57Gus5gul+Uuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c34VDPTzw3jU0kAqzzZ5g6lNKSc31k/mNv1XuEh9XCjC3U2uW8YMy32FUFSwAW0KGy354eWMeuc+ShqssBd7PeJ457yuw3sBozCZlEZWn+ziVP/KkHAxpb/MEM6ZEP/SbK9ZCyv/8K3uc+VG3bcJkLQOhuCYeXODH8OAydtxJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn4DcN9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F358C4CEE3;
	Mon, 31 Mar 2025 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431681;
	bh=GIrt7w0DLmjw04BZ37oHxkGh+eTxPO57Gus5gul+Uuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jn4DcN9Sismu84Q1M4GTygU0FNGUhraxzQ57+GVS8d/PpvbcnzYxaKTsA2cb4/k97
	 giNCv+OHHFOyV0B7Z1fImfQJpFsJIjYJ1nBxcOe/5/FZ5Y1mzy6rYWLDeuyteJoZZR
	 Uh+cKZ3rRfQ72LuWikTyrQA66M9HwAyh4HTTDCTUSzfWkPFC57noVa0YcfG3GvTgWe
	 4vpyrHQ+0tmV/1dYXEHOS4g9fN0oijPcZh9YukaDzL1bWsgpX76fBBa3op6eVgES1Y
	 N1RmQt9+K3TcMI1iDT5D56zNyelbVnWwKTzWj/lDs+qlGs1eEdsPDOb4gM4Ty0IVbc
	 huZzCzEZI5h1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Miroslav Pavleski <miroslav@pavleski.net>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 13/18] cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend
Date: Mon, 31 Mar 2025 10:34:03 -0400
Message-Id: <20250331143409.1682789-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit b7a41156588ad03757bf0a2f0e05d6cbcebeaa9e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 313550fa62d41..340fb00aec6d7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1617,7 +1617,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 					  max_perf, policy->boost_enabled);
 	}
 
-	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
+	return amd_pstate_epp_update_limit(policy);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
@@ -1666,6 +1666,9 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	if (cppc_state != AMD_PSTATE_ACTIVE)
 		return 0;
 
+	/* invalidate to ensure it's rewritten during resume */
+	cpudata->cppc_req_cached = 0;
+
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-- 
2.39.5


