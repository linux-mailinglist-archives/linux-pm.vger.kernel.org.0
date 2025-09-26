Return-Path: <linux-pm+bounces-35486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F48BA4AF8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D33A9649
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F72FFDD5;
	Fri, 26 Sep 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNHBrXeQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801B2F99AD;
	Fri, 26 Sep 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904899; cv=none; b=a4e0TvJfvcbdttLbF59lPvGmnhoCoFQZroXHfybG9abvfYLEkdhVTk++y65YBwpsG9IXPxssJsVGbN43aUtsAkPAe+btVUkoIugUjRGR629AIq7s0QJE0j+gQFD8y6N5VbYH4PrqhFw5A49Ml9iZMJmX4XwMWP24aHJkmk33l2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904899; c=relaxed/simple;
	bh=sqczlmh3pAGATml95vePna/yJgoTkbxOrgV0U1m7EuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ygu0TI/S2D0xZER7jN4sEUHVKqsC238ZKT9C2PYoabaONRk+MceRUusasVsvkUWL1InDooU2CCTKWHYQPTyOkQx661yUZia/1jhQV0wTwmqr8HbyRHxMHogsxD5rzogbrw0EbK0A6YHL8ftxXKileZdkfy0a3/YMZ0poyjukCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNHBrXeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63813C4CEF7;
	Fri, 26 Sep 2025 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904899;
	bh=sqczlmh3pAGATml95vePna/yJgoTkbxOrgV0U1m7EuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNHBrXeQF+YoMgqdSaCIb+pCJtPYvEe/9RGC4oUf4amWdHyhlKLGFGElmerSM5CdW
	 PJ6JqNZV/A8kBzu6wFuBPHyXuhtznzjjniaiX9IN/HRqH4gNTgvAAdfnr1Y8D09I/D
	 Y/1hK6/i0zkOXwaWsLtzuTmNd6DQCOfIiRWpufo3Rk8ZaADZqtXls39Cu8QuqISZVM
	 vy3BF8rCRlfWPA2y0Gj17Y7/pcvNtXDrzFnhCwY9kvt/YY6crGcwCehxcoRU5NAJh+
	 YmyVroenV6uAJU67Vr2FsuW5O6ZknFBhCF5ucevl24/iZYLWZFt3iSFKujiwpiFOQA
	 +/nOFqqUvZP6g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 1/2] PM: hibernate: Restrict GFP mask in power_down()
Date: Fri, 26 Sep 2025 18:40:25 +0200
Message-ID: <8625379.NyiUUSuA9g@rafael.j.wysocki>
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

Commit 12ffc3b1513e ("PM: Restrict swap use to later in the
suspend sequence") caused hibernation_platform_enter() to call
pm_restore_gfp_mask() via dpm_resume_end(), so when power_down()
returns after aborting hibernation_platform_enter(), it needs
to match the pm_restore_gfp_mask() call in hibernate() that will
occur subsequently.

Address this by adding a pm_restrict_gfp_mask() call to the relevant
error path in power_down().

Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/hibernate.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -733,6 +733,8 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		error = hibernation_platform_enter();
 		if (error == -EAGAIN || error == -EBUSY) {
+			/* Match pm_restore_gfp_mask() in hibernate(). */
+			pm_restrict_gfp_mask();
 			swsusp_unmark();
 			events_check_enabled = false;
 			pr_info("Wakeup event detected during hibernation, rolling back.\n");




