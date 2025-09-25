Return-Path: <linux-pm+bounces-35413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC63BA1135
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DAD4A1255
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A631AF1A;
	Thu, 25 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwGsMAn2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C55218ACC
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826279; cv=none; b=P9eQ4FCE2k8UO+EeLBaj6OheCgeDMFiEnMCf5VcHd6X+iOvofsZTtnQ33jlJVQqqrqUOTDjWvNd1AMjmwug42wTpbsCfCDkCSIETE2PecN47Zc9TQ48p6SzzY5e44IXqx6Y9qXNhyU9LHgnaPRLewJYjVbeVhK/vxrHHERxCF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826279; c=relaxed/simple;
	bh=81pFJLjzWdM5K0V6A9OllguEzbxDlS2RLTi+U/uBqms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H78SB15EOhN2Wf2grKw2XZDfit1KL8QhUALXGic5bK2Oje1/e1YNVNfGmzdxdQ8WkFULLQVRA9ToLX0g5u2CByn3LiEHMEP8ofRmwhgsH+ZLm6eKIr7bQJn1vpj4CktcUkolIZGT/pUF5LO97sS+y171ljy+PVikFuYq1dGeDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwGsMAn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9405BC4CEF7;
	Thu, 25 Sep 2025 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758826278;
	bh=81pFJLjzWdM5K0V6A9OllguEzbxDlS2RLTi+U/uBqms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwGsMAn2VhIzz2l/4U1WjoJuQmwIk0781RuRrWsUHX2QYliW+tznQcw9Vzr62O37+
	 VeT3qXPJZvFAw3HPu/J3EB4t/JPsiz0xNpNmbMVcFO3SKouxIHsyZLuHWh2BafuEEP
	 bAkl50aeMWSyTp1yOWw3HU7ojK5C5+ytwSHeEJJIsxn1NRn8FRrM/hle5AWUYpw7rU
	 4HIk+GH3QgL+wos+1x20uDTPsF4k0Ewp2CCDkgIV1Ej/Vbp4iQTtuSgIL9KItnWsbx
	 aZ/wbs8l0aVu8LrfK6232aUgBeHAreKTqFYgyGe+Xy8I4q+Zfr1YEAPee/bM5YkIkW
	 xFbGx5H+G9A/Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Kenneth Crudup <kenny@panix.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Date: Thu, 25 Sep 2025 13:51:07 -0500
Message-ID: <20250925185108.2968494-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925185108.2968494-1-superm1@kernel.org>
References: <20250925185108.2968494-1-superm1@kernel.org>
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
 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..0664c685f0b2 100644
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
index 3c6b110ee9b0..989d76a911de 100644
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
2.51.0


