Return-Path: <linux-pm+bounces-30734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C4B02E33
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 01:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560FA1C21BCF
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1A1531C8;
	Sat, 12 Jul 2025 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/YOKvM2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3E3BE6C
	for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2025 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752363442; cv=none; b=Oc2UuiT4tZnSiZ9BxGxujCGh7DTJDgRP80mmlQrgrd/BQU/pqsGnsLdUrssbnV4ypzCUf1yeB9TLRFbfnVQTMB3rDDF4lHdljI+/W3P178Fc3QdiBDyAY6HxY4m/KtSVCtDVjNANSU372fRaJTq0hLs1MuNJjhB/W6Dd8x6mHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752363442; c=relaxed/simple;
	bh=/LiC+Ai0of5JbvPFlAftW4zV6IqawUX5LcPgMaLbbmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCnldGCFcRBxCWsmuh8CdIPzNm3R4ToktQU1eILPiXoAFQ9WHvARWIckdVQFEGD+18yiKWpnPfBAjgEKj1txziMm7IryVfGYwn5ALrQMu8mXQT3Xh7+XdU5GHkTlLJRs76yC0RrARkH9PcVisgz57K3OECiTK/ExB8uuKu2JTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/YOKvM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A6DC4CEEF;
	Sat, 12 Jul 2025 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752363441;
	bh=/LiC+Ai0of5JbvPFlAftW4zV6IqawUX5LcPgMaLbbmM=;
	h=From:To:Cc:Subject:Date:From;
	b=j/YOKvM2os2z1tsxH1GXdZwmkWn2UXNLFcDUdLMeMIJOWFsLRlwr7l0Efy9wkHPCZ
	 GsdnanLWr3SzvCWZfWinJsK4u+d2P+spUwec3HkA3e0cmqtPY6pWD9SRPwLdKPpYwx
	 9HXz2s9ym6CT3PglrsW3BJh70YMO0+8xJeN9Jn5a4/llpHajKZDmsA71WnIyHypfiW
	 gT6DfGZV6njAU1GIETHDV9vfs8NeGxbAOrXnRkbXcb1IH9htVLP0Jvh6J7/KQA/KR2
	 SFSVrCAvuW/qjOTdx5+/XdYD/sxwEwzz8fljnlr5x7KlO04dMAH8G+7VnITkU1OJyZ
	 kBsnxcASlvqMw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com,
	guoqing.zhang@amd.com
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: hibernate: Add stub for pm_hibernate_is_recovering()
Date: Sat, 12 Jul 2025 18:37:12 -0500
Message-ID: <20250712233715.821424-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Randy reports that amdgpu fails to compile with the following error:
ERROR: modpost: "pm_hibernate_is_recovering" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This happens because pm_hibernate_is_recovering() is only compiled when
CONFIG_PM_SLEEP is set.  Add a stub for it so that drivers don't need
to depend upon CONFIG_PM.

Cc: Samuel Zhang <guoqing.zhang@amd.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/dri-devel/CAJZ5v0h1CX+aTu7dFy6vB-9LM6t5J4rt7Su3qVnq1xx-BFAm=Q@mail.gmail.com/T/#m2b9fe212b35fde11d58fcbc4e0727bc02ebba7b0
Fixes: c2aaddbd2dede ("PM: hibernate: add new api pm_hibernate_is_recovering()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
--
v2:
 * put stub in right ifdef
---
 include/linux/suspend.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 293137210fdf4..fcb150ee83b6b 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -426,8 +426,6 @@ int is_hibernate_resume_dev(dev_t dev);
 static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 #endif
 
-bool pm_hibernate_is_recovering(void);
-
 /* Hibernation and suspend events */
 #define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
 #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
@@ -478,6 +476,7 @@ extern unsigned int lock_system_sleep(void);
 extern void unlock_system_sleep(unsigned int);
 
 extern bool pm_sleep_transition_in_progress(void);
+bool pm_hibernate_is_recovering(void);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -508,6 +507,7 @@ static inline unsigned int lock_system_sleep(void) { return 0; }
 static inline void unlock_system_sleep(unsigned int flags) {}
 
 static inline bool pm_sleep_transition_in_progress(void) { return false; }
+static inline bool pm_hibernate_is_recovering(void) { return false; }
 
 #endif /* !CONFIG_PM_SLEEP */
 
-- 
2.43.0


