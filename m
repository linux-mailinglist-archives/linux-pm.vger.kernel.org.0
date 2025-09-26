Return-Path: <linux-pm+bounces-35458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1ABA371C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B6560303
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5C2F5A20;
	Fri, 26 Sep 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj/Qhp/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3E2F5A18;
	Fri, 26 Sep 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885027; cv=none; b=XPwEjtE+G98L/8ZFsyofZ+4E/1pgYCllJxNdvDmCyzda/wHqvlRGfPjicvD7uF3/9uZvtc8r7F0vStWkbnoJoT5c623I0NdNKfhR3rSULSVMrksjTyqU/wFtvWi/NFXLsLaUAZbCPlugr5AQlTggbay8EcdS459PY84LGlpVIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885027; c=relaxed/simple;
	bh=KrSTaivsd8i5geUp+S3za4RDWwkfaab6BWCnjplvC4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aXXoqdVxm6E/BSzV7YpCSb4dAYawvTgHawxzznfw/lHUnorHDbcSaAiDoOosAEQ/PrAfD16ze+dC3Li3T8VNcAAhZTuSr2TL6cPmirhZbRUR42cN7t2z8rIVgKUUzv1xr4CVKkKejESsLFUEjWdvP2Jzraur88rdn8AVNfxymAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj/Qhp/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27D8C16AAE;
	Fri, 26 Sep 2025 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758885026;
	bh=KrSTaivsd8i5geUp+S3za4RDWwkfaab6BWCnjplvC4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=Xj/Qhp/tnzgsUnerwAJ+/vY5DkVhpYa/OS28dD1RQaH8aHNjUjGxLXn85Haqg6CFM
	 vjqeEmJ73RyQ5HzXWbmlBIjJYAZe7j3YGk5rpvOKBG/y/3nNDPrQm+7ji+DVVsZbDv
	 EJzPZ7ZKuteO2BmidDv++9dJnE+vxj53LY9arB7REUw5hIxGq3/wRKDlxYj0OxIstj
	 enRPIGkqw3gbZAwF498XY0GrW1j8wnU5KVll/bQUEKWtlZlHP1TzHJ/eEhzLQqgKj3
	 bC9HNXd45S1OmNjhxUfUbpl3cv/ngUnRj7GlCZ0ALHvwH/gndsU2xfCLHxyywhQ1wB
	 tfUw94923oxmg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Crudup <kenny@panix.com>,
 amd-gfx@lists.freedesktop.org
Subject:
 [PATCH v1] PM: hibernate: Fix pm_hibernation_mode_is_suspend() build breakage
Date: Fri, 26 Sep 2025 13:10:22 +0200
Message-ID: <12746883.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 495c8d35035e ("PM: hibernate: Add pm_hibernation_mode_is_suspend()")
that introduced pm_hibernation_mode_is_suspend() did not define it in
the case when CONFIG_HIBERNATION is unset, but CONFIG_SUSPEND is set.

Subsequent commit 0a6e9e098fcc ("drm/amd: Fix hybrid sleep") made the
amdgpu driver use that function which led to kernel build breakage in
the case mentioned above [1].

Address this by using appropriate #ifdeffery aroung the definition of
pm_hibernation_mode_is_suspend().

Fixes: 0a6e9e098fcc ("drm/amd: Fix hybrid sleep")
Reported-by: KernelCI bot <bot@kernelci.org> 
Closes: https://groups.io/g/kernelci-results/topic/regression_pm_testing/115439919 [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/suspend.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,7 +276,6 @@ extern void arch_suspend_enable_irqs(voi
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
-bool pm_hibernation_mode_is_suspend(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -289,7 +288,6 @@ static inline bool pm_suspend_via_firmwa
 static inline bool pm_resume_via_firmware(void) { return false; }
 static inline bool pm_suspend_no_platform(void) { return false; }
 static inline bool pm_suspend_default_s2idle(void) { return false; }
-static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
@@ -420,6 +418,12 @@ static inline int hibernate_quiet_exec(i
 }
 #endif /* CONFIG_HIBERNATION */
 
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_SUSPEND)
+bool pm_hibernation_mode_is_suspend(void);
+#else
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
+#endif
+
 int arch_resume_nosmt(void);
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV




