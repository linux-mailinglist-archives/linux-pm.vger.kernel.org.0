Return-Path: <linux-pm+bounces-36831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60682C0A230
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 04:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C690434AD4D
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3066A2E413;
	Sun, 26 Oct 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0FKXXi3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1B17C9E
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761449485; cv=none; b=qOKMu+k/gzilYg/Erd0mtkUOp0evfYlpaA+JiORjHKfIicH9IC+OO2TSTaH922Z1QUpMiKxGTpQDJvny0gAf0eCPrF8MAGwPZQDdxTcqCPc8QQLHJ5z44/9G33pYC+F1889pq8n1RLgr2Z1wG2LBMEW5Ks1kRktqmftL3Y+h7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761449485; c=relaxed/simple;
	bh=eYCciPjO1aS8sWJ0V5x97hiAcsCfjPqZTFRozflIuwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgm/NinxpwvjpQEv86PIsteNqKFk3TRCuYF5J9fPZNv2AC0vNPmfyzRMfUwrlierWyVDGiziaN1PFma3KhR6bitUzGWHVd92JejKG7Q+NJk/VzDNEyLM7jF7+v3lppbtnJhmJcxH+mSOnVazTqtrld7zDXz3LMUhYSOeZffFTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0FKXXi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA4CC4CEE7;
	Sun, 26 Oct 2025 03:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761449481;
	bh=eYCciPjO1aS8sWJ0V5x97hiAcsCfjPqZTFRozflIuwc=;
	h=From:To:Cc:Subject:Date:From;
	b=V0FKXXi39WnUFT2FRJhVne9a6nYxePvk9ZbISZnW+bN0mTWm88XmbSGU2yh/HLy1i
	 LbbgR+i8LQQbJ8qWSpCW1AwFGd3q7dBY8c7enDNOwXZvEnlPeSTs4X7MVuJr4QXP18
	 h2WDGqV9s6INLoVjSQg/fDrjxoDHboQ5Sbk1VcVA7Yy+sLzrhdTeNjdwyo/bT06oEv
	 ZHbUz1s4hmXmApuxFLR0wxyFE+6PCt2ziZsgCMwRrgFPj9HozkpkbvBFFjzxoYDJR+
	 hYiJTaFNi6bF5NyC9YbM/ZHVx8c+qFvQEDu4KbmPC5ZSCuv5IpRC9PkSaJNIY2vpkE
	 edJbUXhTXryHA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	superm1@kernel.org
Cc: Askar Safin <safinaskar@gmail.com>,
	rafael.j.wysocki@intel.com,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
Date: Sat, 25 Oct 2025 22:31:00 -0500
Message-ID: <20251026033115.436448-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in
hibernation_snapshot()") added a restrict GFP mask call that leads to
mismatch when using the platform for hibernation.  As part of calling
hibernation_platform_enter() the mask will be restricted when calling
dpm_suspend_start().

This is a similar problem as occurred with hybrid sleep that was fixed
by commit 469d80a3712c6 ("PM: hibernate: Fix hybrid-sleep").

Restore GFP maks as part of power_down() in HIBERNATION_PLATFORM case
to fix the mismatch.

Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
Fixes: 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in hibernation_snapshot()")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/hibernate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff235512..e15907f28c4cd 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -721,6 +721,7 @@ static void power_down(void)
 		kernel_restart(NULL);
 		break;
 	case HIBERNATION_PLATFORM:
+		pm_restore_gfp_mask();
 		error = hibernation_platform_enter();
 		if (error == -EAGAIN || error == -EBUSY) {
 			events_check_enabled = false;
-- 
2.43.0


