Return-Path: <linux-pm+bounces-35393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D8BA083B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7937C3B4768
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1730597D;
	Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQrYLilY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940263054FC
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815967; cv=none; b=ZtoVCK5BjtB+ya1wPiDQjhyNOtY/xmARektYAbb+EeTgFDDw2eDhmUpwhq/FX5wxjKnQgNeaOJKyao0ES3Yxh5FIq1bMl0cfCypizMJK/6AGkuetMWfzoMm9XNwmWaJgBuJoFxYgu6/uuUH+wR38FO4eaz5gK4F0JulfbsbFV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815967; c=relaxed/simple;
	bh=INk8pAkP1MKRcuSN9wuYkgmnh4DJkRPi0ztA4HKAiUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFE40s8ZT0o1rqaW41jRB2GM7YnUN3l4gWeNcmBjVQm2BqPCI+Kfu/kh7QGwtaUXLR/Oc7Bv5QPWoPeSHRF/ieeqIvDB+VPmD3ldb5qw2OjXg2ZUr/ERVp3RGVgXOFvI1IU+Bx30hLsUrzDfR4g9zKNcKuh6Bjh8SweeY9buuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQrYLilY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA8DC4CEF0;
	Thu, 25 Sep 2025 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815967;
	bh=INk8pAkP1MKRcuSN9wuYkgmnh4DJkRPi0ztA4HKAiUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQrYLilY0sI7d0B37e4LLUA+Kip4Xz3sHc+NCAn96xhjxjfbAOMejuhXqv6fuLGSa
	 CJ+7PyE/aMP4AGuftLxy/AIHUjfmN6HLHl40oNXSbcvBNQLXcaTzXwCuN2VJIOQ5ig
	 dsO79KIBBDuEfi2HYwKlTD2WeZVHsQ4OuFbUEFqHwmaBTUSXPpWGGWt5kvKNrO515Z
	 ge6YKEO4Uq+ez5/vdReAg2/+4RNAyJ4wQupGKZnNlQ2pHrV3g/aAROKseSWbZ9goz/
	 xZlEOUBoNbqmeSmjEYnKUsI5KXmbDkWEs/YTKQbbkPv/ykw1udXGGj32TtwEQbti28
	 GKcusOwSF5dwA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH v2 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Date: Thu, 25 Sep 2025 10:59:17 -0500
Message-ID: <20250925155918.2725474-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925155918.2725474-1-superm1@kernel.org>
References: <20250925155918.2725474-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers have different flows for hibernation and suspend. If
the driver opportunistically will skip thaw() then it needs a hint
to know what is happening after the hibernate.

Introduce a new symbol pm_hibernation_mode_is_suspend() that drivers
can call to determine if suspending the system for this purpose.

Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Tested-by: Kenneth Crudup <kenny@panix.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Move under CONFIG_SUSPEND scope (LKP robot)
 * Add tags
---
 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b37..0664c685f0b24 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+bool pm_hibernation_mode_is_suspend(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -288,6 +289,7 @@ static inline bool pm_suspend_via_firmware(void) { return false; }
 static inline bool pm_resume_via_firmware(void) { return false; }
 static inline bool pm_suspend_no_platform(void) { return false; }
 static inline bool pm_suspend_default_s2idle(void) { return false; }
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 52c1818749724..09f5271c98f35 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,6 +80,17 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
+#ifdef CONFIG_SUSPEND
+/**
+ * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
+ */
+bool pm_hibernation_mode_is_suspend(void)
+{
+	return hibernation_mode == HIBERNATION_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
+#endif
+
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
-- 
2.43.0


