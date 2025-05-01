Return-Path: <linux-pm+bounces-26525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DBAA65E2
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 23:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FF24C5651
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E39621FF2F;
	Thu,  1 May 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npp8aFSx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C561A38E1
	for <linux-pm@vger.kernel.org>; Thu,  1 May 2025 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136729; cv=none; b=LUiqdJljPwmjTepqSbZlw13UcYEEYYeSd83+0LfJrKc1bvSgB74XIbJCvjmDBeOCdk87OQ4nF6y8o9YpmByleu+paJTx8piUfq8OKrA/NAEnIUiCGmUQutvXMKEriVMc3adsiSi5LGNfBoJMTmm6UuW2bIxovaVPzadU0r5x3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136729; c=relaxed/simple;
	bh=8ECWJYWGjdt/dGsBcOpJtCQQgT68tQXYYPd6w5b+bms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVgj8+zr4wMSd9h5s6F8GwL4lT8vZ8+6PDQKuYpruVEfShwW8dNwL0UC37Ir+XJXGQu5k0dVhNxYqxVNKzFeVJD1/XcAO92xlCl6271SUyACNrzlAMmu4Ckfyov2S7BrtP4p0jzF2tUz1BD3WvUmy7PC766ijHAJVUPf3vmQkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npp8aFSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188D1C4CEE3;
	Thu,  1 May 2025 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746136728;
	bh=8ECWJYWGjdt/dGsBcOpJtCQQgT68tQXYYPd6w5b+bms=;
	h=From:To:Cc:Subject:Date:From;
	b=Npp8aFSx/uqaxLVu5Vm8+5Vi/Z/reY1b0PwfNOoIT/Y4y+O6j5PXyZACHnpA8vbt3
	 Pc/P/BeuJkwBP1CFjnkOaowqIHmym0PNwi+pWbfHt04ZZOE+zHtIE6znscyui7J62m
	 bYCQOiYeXPxvb+lKvyuWG9EJpzvxo5ntxvdRPRGrh47ibxDX+V2g8eEdTPuu6pSvGI
	 N14GtQlW4uy/ZH+nL2gqtre92kk1pGID+TkpIUQsZ1JLUTodowg9yD3Akswh2o/BxY
	 RjYpEXma3d7/DwzeqNMja+MgeIvflOWx6R4jgPNgoVaoDZz2tDPGHsg686b4ENpHJZ
	 uZcJVNgsS76wQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: Explicitly set PM_SUSPEND_MAX at hibernate entry
Date: Thu,  1 May 2025 16:58:36 -0500
Message-ID: <20250501215838.2501827-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This allows pm_debug_messages to work properly for hibernate.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 kernel/power/hibernate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 23c0f4e6cb2ff..443002fd680de 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -772,6 +772,7 @@ int hibernate(void)
 	}
 
 	pr_info("hibernation entry\n");
+	pm_suspend_target_state = PM_SUSPEND_MAX;
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
@@ -852,6 +853,7 @@ int hibernate(void)
 	hibernate_release();
  Unlock:
 	unlock_system_sleep(sleep_flags);
+	pm_suspend_target_state = PM_SUSPEND_ON;
 	pr_info("hibernation exit\n");
 
 	return error;
-- 
2.43.0


