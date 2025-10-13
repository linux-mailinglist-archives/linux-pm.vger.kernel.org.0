Return-Path: <linux-pm+bounces-35985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983EBD5990
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA1C18A6032
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052C2D3EC0;
	Mon, 13 Oct 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERqtnaxS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F02C21ED
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377707; cv=none; b=eyOlDX8nO//TnRKKyhz+yZASLGtWDADmc2toVdzAYUAg0LmWdmRfquB4chTIj9y9iyvAK5h3ZfKIM+XL0Mpx6N8nq4iPaOYjS0ydnUt/7UOwuPlW0ULhd+8l3WxZl/pQLxGGS+AsKNdPkNls+pGcKrB89ZLHjmeM/t+nUV6i/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377707; c=relaxed/simple;
	bh=5WAuRoHX69rBGibbaw5bc/LE/1SwO8vg1g8NJeXy/nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW/svxDHANyijQnHu6zffbOBGme+BisdactL7U/2ligPadOSWOIIGGug9Huk7VQYAleK7qbXsMs410Ladbscw8ek2oa5wv0LXoXJSPGYBR7ow5LVgC9bmrr4UjItS68JZ5GPFDSX6KGcaaaY4BCbJsEzeaFdqoAZlMNmGThZNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERqtnaxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6DC116D0;
	Mon, 13 Oct 2025 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377706;
	bh=5WAuRoHX69rBGibbaw5bc/LE/1SwO8vg1g8NJeXy/nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERqtnaxSzI5OuEB1q1eSX7n9zavJ17klzUfSyPVnP+qdq37rN8pWQufjgmWzSwRVh
	 DbnPwgkUslj9+86SU5vYIn0gLTzsX6UFhONN7ypll07/96RFjW3j3Y9FHelrScNcVa
	 M+ry+bDmUIA5WofsvWFCnY+4plq/EjBiW+h3au3IMznuPL813Rf1Wutz07BGo6u46U
	 zVNDTdCOSfULDflg20tUwe0pyhb7/I+Q3jVwnfuyTqRL7Y/3PkPy3/wZrgXvJd0Xk6
	 Z9bXnI2DVjB/jvZz2Xl0yOAoi9ZVR1DZN2+LFXWFWrh4N2yVhfHBNFtWYLPNkneTEV
	 aK1+JziMFS7fw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 3/3] PM: Drop pm_hibernate_is_recovering() and pm_hibernation_mode_is_suspend()
Date: Mon, 13 Oct 2025 12:47:11 -0500
Message-ID: <20251013174729.1101186-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013174729.1101186-1-superm1@kernel.org>
References: <20251013174729.1101186-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

All consumers in the kernel of pm_hibernate_is_recovering() and
pm_hibernation_mode_is_suspend() have been dropped.  Remove the symbols.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/base/power/main.c | 14 --------------
 include/linux/suspend.h   |  8 --------
 kernel/power/hibernate.c  | 11 -----------
 3 files changed, 33 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 58f5270a173e8..e2f23e62abb18 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -62,20 +62,6 @@ static pm_message_t pm_transition;
 static DEFINE_MUTEX(async_wip_mtx);
 static int async_error;
 
-/**
- * pm_hibernate_is_recovering - if recovering from hibernate due to error.
- *
- * Used to query if dev_pm_ops.thaw() is called for normal hibernation case or
- * recovering from some error.
- *
- * Return: true for error case, false for normal case.
- */
-bool pm_hibernate_is_recovering(void)
-{
-	return pm_transition.event == PM_EVENT_RECOVER;
-}
-EXPORT_SYMBOL_GPL(pm_hibernate_is_recovering);
-
 static const char *pm_verb(int event)
 {
 	switch (event) {
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 348831cdb60e4..f305fcc7a2cdc 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -420,12 +420,6 @@ static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 }
 #endif /* CONFIG_HIBERNATION */
 
-#if defined(CONFIG_HIBERNATION) && defined(CONFIG_SUSPEND)
-bool pm_hibernation_mode_is_suspend(void);
-#else
-static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
-#endif
-
 int arch_resume_nosmt(void);
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
@@ -486,7 +480,6 @@ extern unsigned int lock_system_sleep(void);
 extern void unlock_system_sleep(unsigned int);
 
 extern bool pm_sleep_transition_in_progress(void);
-bool pm_hibernate_is_recovering(void);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -520,7 +513,6 @@ static inline unsigned int lock_system_sleep(void) { return 0; }
 static inline void unlock_system_sleep(unsigned int flags) {}
 
 static inline bool pm_sleep_transition_in_progress(void) { return false; }
-static inline bool pm_hibernate_is_recovering(void) { return false; }
 
 #endif /* !CONFIG_PM_SLEEP */
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 7af2e392c574a..ec02a8be20b30 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,17 +80,6 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
-#ifdef CONFIG_SUSPEND
-/**
- * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
- */
-bool pm_hibernation_mode_is_suspend(void)
-{
-	return hibernation_mode == HIBERNATION_SUSPEND;
-}
-EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
-#endif
-
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
-- 
2.43.0


