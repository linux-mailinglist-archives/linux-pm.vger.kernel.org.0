Return-Path: <linux-pm+bounces-36991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49884C16D3A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 21:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F29A1A679DB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25720255E43;
	Tue, 28 Oct 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIb9eyuI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D9194A65;
	Tue, 28 Oct 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684756; cv=none; b=G5jqbqtHvUF9OVax9P3mseB9xZrPAKZu7wRf8JST+DJb2hleRnaZRlzxy9fl3MUnM32k6YU8BPhSHQucnMFrpYoHZOY15/VWNpk2cLjYB+yqmWq5jGIKkhlvr38hFAVPZ7kRSr2L3/Se+N+mm7esbPAtJ86xiGyfMGJ95/OkMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684756; c=relaxed/simple;
	bh=Mu2bPbXVELL3QwMDUxBoYvXS8gR7TtieK5wTo2e4Cxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uusl58/4p77KsKeLCtUBEo1DP3ZSf+3ZSL64vrj5RQeN7FfyOLNM+XccFdsc7O6gUf2hh+EXSrO0xqPBfmjKin+bJZaHJr2NxXvTCkcrAzlfVeu6sOriT1D18qU+a5BU2q1xhxPYyOAbljx2exotZ/04vhoFrB+jHeE5gO1R7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIb9eyuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE58C4CEE7;
	Tue, 28 Oct 2025 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761684755;
	bh=Mu2bPbXVELL3QwMDUxBoYvXS8gR7TtieK5wTo2e4Cxw=;
	h=From:To:Cc:Subject:Date:From;
	b=BIb9eyuIlOtGE1/3/lMQR6+nPSyHtcCM+glWUElrjnEjmIYV/lNaEV30Yok7G6FXW
	 rSGLKCmCv7TRaA48Ch9Ejs5oekZNs8voV4vlfMdyY89TKrYewna/IJo0XN41PVN3qY
	 lWCNavUUrC+m5SMEA+jVfZ3yylimymA+/kdFO4wwRE9q4RYPLbMK1F48NlgWFQ2Cq3
	 6yvvkbvOvo84CCwUcbeDzfolFJtrRuP2k6QspFlhHf8Y+FbRCKOvTUP1c9Bos1kXmn
	 vwNTbEawCHAXGDn213jQm2yTVp45Zbh62E9TlWDdh0Y7XHxQD4RXF57vLXHGqheHn2
	 IaRhs0ETgbH4w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] PM: sleep: Allow pm_restrict_gfp_mask() stacking
Date: Tue, 28 Oct 2025 21:52:31 +0100
Message-ID: <5935682.DvuYhMxLoT@rafael.j.wysocki>
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

Allow pm_restrict_gfp_mask() to be called many times in a row to avoid
issues with calling dpm_suspend_start() when the GFP mask has been
already restricted.

Only the first invocation of pm_restrict_gfp_mask() will actually
restrict the GFP mask and the subsequent calls will warn if there is
a mismatch between the expected allowed GFP mask and the actual one.

Moreover, if pm_restrict_gfp_mask() is called many times in a row,
pm_restore_gfp_mask() needs to be called matching number of times in
a row to actually restore the GFP mask.  Calling it when the GFP mask
has not been restricted will cause it to warn.

This is necessary for the GFP mask restriction starting in
hibernation_snapshot() to continue throughout the entire hibernation
flow until it completes or it is aborted (either by a wakeup event or
by an error).

Fixes: 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in hibernation_snapshot()")
Fixes: 469d80a3712c ("PM: hibernate: Fix hybrid-sleep")
Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
Link: https://lore.kernel.org/linux-pm/20251028111730.2261404-1-safinaskar@gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This supersedes

https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/

as it allows the GFP mask to be restricted across the entire hibernation path.

---
 kernel/power/hibernate.c |    4 ----
 kernel/power/main.c      |   22 +++++++++++++++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -706,7 +706,6 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
-		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (!error)
 			goto exit;
@@ -746,9 +745,6 @@ static void power_down(void)
 		cpu_relax();
 
 exit:
-	/* Match the pm_restore_gfp_mask() call in hibernate(). */
-	pm_restrict_gfp_mask();
-
 	/* Restore swap signature. */
 	error = swsusp_unmark();
 	if (error)
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -31,23 +31,35 @@
  * held, unless the suspend/hibernate code is guaranteed not to run in parallel
  * with that modification).
  */
+static unsigned int saved_gfp_count;
 static gfp_t saved_gfp_mask;
 
 void pm_restore_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
-	if (saved_gfp_mask) {
-		gfp_allowed_mask = saved_gfp_mask;
-		saved_gfp_mask = 0;
-	}
+
+	if (WARN_ON(!saved_gfp_count) || --saved_gfp_count)
+		return;
+
+	gfp_allowed_mask = saved_gfp_mask;
+	saved_gfp_mask = 0;
+
+	pm_pr_dbg("GFP mask restored\n");
 }
 
 void pm_restrict_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
-	WARN_ON(saved_gfp_mask);
+
+	if (saved_gfp_count++) {
+		WARN_ON((saved_gfp_mask & ~(__GFP_IO | __GFP_FS)) != gfp_allowed_mask);
+		return;
+	}
+
 	saved_gfp_mask = gfp_allowed_mask;
 	gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
+
+	pm_pr_dbg("GFP mask restricted\n");
 }
 
 unsigned int lock_system_sleep(void)




