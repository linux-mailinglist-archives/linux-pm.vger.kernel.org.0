Return-Path: <linux-pm+bounces-35307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527EB9C328
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722BE1B27EA9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E285244685;
	Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMGd07aQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47C13D891
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747141; cv=none; b=TtNPTm35X1NVvnFn+CNCGgj4cH2RTpDhV1sN5zcBTiBVtyagXshX1F7oBR9YlWIpDFWxNXhLsILTaOtlfSR3FLUk0LVudlTjEMHsmO+/XDM+rmewbTF+ypmNw47lV9dMN+8rFPqN0RmohhpyKfpMgElXMUZ/asXrXMQQOBkoVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747141; c=relaxed/simple;
	bh=1Y660VnpdTnvypQovi/8hf/y/7qhkU6Jm967mJShmfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFliy2C4oJxJkmrQmtegsv0Pj1BQAC4NVOmbWezZuj3ULoeZvrZ4g9q8m2PsctlfLowlq/GF48VbFxgpbNGDkVZSo4eovMBZfXhTuptIjNLsKABqrwEOVgppTiSBSLyXC9CkcMFzETH1eq+DUH78GlB/Rt1c/oJsftI0KQI7mM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMGd07aQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325FAC113CF;
	Wed, 24 Sep 2025 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758747140;
	bh=1Y660VnpdTnvypQovi/8hf/y/7qhkU6Jm967mJShmfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMGd07aQfrE5B+Xw9W6d5XwXycDSludKA/eYhNBflJsIwXM3Yo5zHNRHfiwyK3n8a
	 dJantFjbHLN9pVEJI4TKdCm1W1fd7KjYeQrl/guOUim5Wx89LDMZBxBnvxCnZ6MebF
	 bY7wu+fAJ3rMMU+V+H9HOZnBR3FUrLSzqTKEDNSgb6IFjsMmBq+mnlvqf0oyOCFbEY
	 pW57459neXCPUgNzSl5tgr+bRUHPnqUaOFW2tzbn7h99fRZEWd+m7vXhxyl6byYkox
	 3DqmM7OpzvkchJ5YSL1O4SpjWW9O/KEmMZX7N4v9p4lw6rJvlrefi5ZiTBjvScFYmW
	 96Ip3Te0m3I0Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Date: Wed, 24 Sep 2025 15:52:10 -0500
Message-ID: <20250924205211.1059571-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924205211.1059571-1-superm1@kernel.org>
References: <20250924205211.1059571-1-superm1@kernel.org>
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
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 include/linux/suspend.h  | 2 ++
 kernel/power/hibernate.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b3..4b11efd68729 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -479,6 +479,7 @@ extern void unlock_system_sleep(unsigned int);
 
 extern bool pm_sleep_transition_in_progress(void);
 bool pm_hibernate_is_recovering(void);
+bool pm_hibernation_mode_is_suspend(void);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -513,6 +514,7 @@ static inline void unlock_system_sleep(unsigned int flags) {}
 
 static inline bool pm_sleep_transition_in_progress(void) { return false; }
 static inline bool pm_hibernate_is_recovering(void) { return false; }
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 #endif /* !CONFIG_PM_SLEEP */
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1defe8081e64..a991a1362d77 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,6 +80,15 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
+/**
+ * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
+ */
+bool pm_hibernation_mode_is_suspend(void)
+{
+	return hibernation_mode == HIBERNATION_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
+
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
-- 
2.51.0


