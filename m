Return-Path: <linux-pm+bounces-35485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6013BBA4AF2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE27A63AA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E72242D9A;
	Fri, 26 Sep 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fViBS2mS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1026229B1F;
	Fri, 26 Sep 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904895; cv=none; b=lsdMCs5ga4qOlo5qdZ9i6pAQ2+nm/BnbBNlP7EyByHVxG4D9hZhAGAG8LLmLsAa86DzmpH71qyH32TBWq/oQhB9yvOEUmRZrr19I5bT8yACOycY9rF9hpkuPdBmWc/566KDChrSVuIvANjwlvjZbJIW/ODd1cVYVw8ZI9oCPBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904895; c=relaxed/simple;
	bh=Adm6HvYSUc4fdo95/IlsLBb45FB8Zii6Mcrl6yg6xgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMFdOV3pBNWyF2rjJbZ1hFk5uemjiyaJ6LVeIRFdvkhm/0xwR9mcRIhAHBhVHE4wx2AW4/AP8x0onH0a/AMXvTtXmzb9/manwvx4vjDwAICYVZNuXBQmcUJcgqQJ4MiW+vw8tWJBV4s0R6y9YbSEeaL3xVGHCL+sM5nxZmmHTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fViBS2mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B47BC4CEF4;
	Fri, 26 Sep 2025 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904895;
	bh=Adm6HvYSUc4fdo95/IlsLBb45FB8Zii6Mcrl6yg6xgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fViBS2mS5Z08a7P2FivkLV6xsp+iGOicTArxX5PYY6agjVQHAbWzT0qPpp2BC2upB
	 E9lL1+39xflCOd5Sdu8Fxq3HkGk4uI0OqP9fNWuvTjQS7TDMForkbRhFCYu/dHN2VC
	 0pMzf4/OQu+KOQE/IjFlFX+BJAqataVBtNR0OZiZYSuMXHChFod2bD8WcYXcA1pup6
	 hq8h0jlQwCu6mNW6Wzi6Ggn4uvE9efnLk99w2tVXbdpdLVHtnmvnedo4FqGBHsiSoq
	 wwSCXUgkoboHxZH/3od+iOXzaMpg33kaekwdYrxgQqJi5quCkLcLFMXpjr3ViiqZtD
	 EYXl8AE+9RIng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 2/2] PM: hibernate: Combine return paths in power_down()
Date: Fri, 26 Sep 2025 18:41:21 +0200
Message-ID: <3571055.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3303305.5fSG56mABF@rafael.j.wysocki>
References: <3303305.5fSG56mABF@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid code duplication and improve clarity, combine the code
paths in power_down() leading to a return from that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/hibernate.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -708,21 +708,11 @@ static void power_down(void)
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
 		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
-		if (error) {
-			hibernation_mode = hibernation_ops ?
-						HIBERNATION_PLATFORM :
-						HIBERNATION_SHUTDOWN;
-		} else {
-			/* Match pm_restore_gfp_mask() call in hibernate() */
-			pm_restrict_gfp_mask();
+		if (!error)
+			goto rollback;
 
-			/* Restore swap signature. */
-			error = swsusp_unmark();
-			if (error)
-				pr_err("Swap will be unusable! Try swapon -a.\n");
-
-			return;
-		}
+		hibernation_mode = hibernation_ops ? HIBERNATION_PLATFORM :
+						     HIBERNATION_SHUTDOWN;
 	}
 #endif
 
@@ -733,12 +723,9 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		error = hibernation_platform_enter();
 		if (error == -EAGAIN || error == -EBUSY) {
-			/* Match pm_restore_gfp_mask() in hibernate(). */
-			pm_restrict_gfp_mask();
-			swsusp_unmark();
 			events_check_enabled = false;
 			pr_info("Wakeup event detected during hibernation, rolling back.\n");
-			return;
+			goto rollback;
 		}
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
@@ -757,6 +744,15 @@ static void power_down(void)
 	pr_crit("Power down manually\n");
 	while (1)
 		cpu_relax();
+
+rollback:
+	/* Match the pm_restore_gfp_mask() call in hibernate(). */
+	pm_restrict_gfp_mask();
+
+	/* Restore swap signature. */
+	error = swsusp_unmark();
+	if (error)
+		pr_err("Swap will be unusable! Try swapon -a.\n");
 }
 
 static int load_image_and_restore(void)




