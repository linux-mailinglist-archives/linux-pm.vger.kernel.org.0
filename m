Return-Path: <linux-pm+bounces-11492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C093E233
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 03:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC351F2112A
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4A18C32E;
	Sun, 28 Jul 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iATQIpnx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECC18C32B;
	Sun, 28 Jul 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127781; cv=none; b=f47kqeTAiAJjtZVnh/e85X3obS6N3wYsorFZ/JDHr9Sx3HYGz+RHMdUtFNdZb2jxn+vEbWjlPY+i82cR0qIo1Hi5T3ENJEyXMYPBjSF/aBsJwj10nGEmtlTlnd1nUxvktwoVL+cd+VQBbeIdbMnDZy8JYkps7fwFafqJj8f6hyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127781; c=relaxed/simple;
	bh=oAG9xdVMkZuVPWP7xshvz1j+tPVw5eeBp8JXbtiw2Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AILB9/uhPpilpyB72V7cCdvq9i6MLVjhLNanYL5nk2ko/Va5vO4kaXs/NQPZRYtxaD2LOsu+3NVO8GXEFiJEyZ01op61M8aavaPkhSi58AtmCZhfsAU8KGcsHblvS8pKlmLbCPNEyCgG00sGATNJYLXN5oSfGrU1iJIxoeVo8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iATQIpnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12585C32781;
	Sun, 28 Jul 2024 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127781;
	bh=oAG9xdVMkZuVPWP7xshvz1j+tPVw5eeBp8JXbtiw2Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iATQIpnxLUkh7VYAcKLmyGmM3ROjPDRgPa6Fd6cQkvSDAzR7cPqZqJVp1U+p3fC6V
	 n2p/O9MQj9N61/oIp5T1ifn2YX+xXMDP9nvrPj0Fn6hvJeAIQFVr89OKMcpqzYjoi3
	 p8RZN+FC+MV6/0v9TZBz6RewdVJEjJzHT4XRg9D3LKGoRczmqW2/sc6p24bt9hB9nn
	 4WGigYKW7HEyBfjUtERGYfeWz6NCAm9KXGRVnBb+pgY2eCoOuv3tz483oYwjVzKPg0
	 aEVUAAGgqdTOUevjvsG90T7LLiC/Hz3GVYtyuNTDcBXt6uAsdsuSAc3wAoddrEg87k
	 rco7PIc628C/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	Andrei Amuraritei <andamu@posteo.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 4/9] cpufreq: amd-pstate: auto-load pstate driver by default
Date: Sat, 27 Jul 2024 20:49:24 -0400
Message-ID: <20240728004934.1706375-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004934.1706375-1-sashal@kernel.org>
References: <20240728004934.1706375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Perry Yuan <perry.yuan@amd.com>

[ Upstream commit 4e4f600ee750facedf6a5dc97e8ae0b627ab4573 ]

If the `amd-pstate` driver is not loaded automatically by default,
it is because the kernel command line parameter has not been added.
To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
function to enable the desired mode (passive/active/guided) before registering
the driver instance.

This ensures that the driver is loaded correctly without relying on the kernel
command line parameter.

When there is no parameter added to command line, Kernel config will
provide the default mode to load.

Meanwhile, user can add driver mode in command line which will override
the kernel config default option.

Reported-by: Andrei Amuraritei <andamu@posteo.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/83301c4cea4f92fb19e14b23f2bac7facfd8bdbb.1718811234.git.perry.yuan@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fe17a05fe6a4e..4eff4f260c477 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1761,8 +1761,13 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
-	switch (cppc_state) {
-	case AMD_PSTATE_UNDEFINED:
+	/*
+	* determine the driver mode from the command line or kernel config.
+	* If no command line input is provided, cppc_state will be AMD_PSTATE_UNDEFINED.
+	* command line options will override the kernel config settings.
+	*/
+
+	if (cppc_state == AMD_PSTATE_UNDEFINED) {
 		/* Disable on the following configs by default:
 		 * 1. Undefined platforms
 		 * 2. Server platforms
@@ -1774,15 +1779,20 @@ static int __init amd_pstate_init(void)
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
-		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
-		if (ret)
-			return ret;
-		break;
+		/* get driver mode from kernel config option [1:4] */
+		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
+	}
+
+	switch (cppc_state) {
 	case AMD_PSTATE_DISABLE:
+		pr_info("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	case AMD_PSTATE_PASSIVE:
 	case AMD_PSTATE_ACTIVE:
 	case AMD_PSTATE_GUIDED:
+		ret = amd_pstate_set_driver(cppc_state);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
@@ -1803,7 +1813,7 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable with return %d\n", ret);
+		pr_err("failed to enable driver mode(%d)\n", cppc_state);
 		return ret;
 	}
 
-- 
2.43.0


