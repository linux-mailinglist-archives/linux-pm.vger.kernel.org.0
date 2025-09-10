Return-Path: <linux-pm+bounces-34348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0796B512E2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F93B445EA6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD2314A74;
	Wed, 10 Sep 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8j16vwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EF3019CB;
	Wed, 10 Sep 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497323; cv=none; b=SuQcNx6BU1gfXcG3Y1h+diD2QrmcNxFF0GRBiY9ZjT73HjUH2xNHkeJIqsSe15OiKJrmVgAn9R4SoYZMYqHeyDBhMtRw/5oKXMBHFADkb3v6CaXQmUN46kkw+NXmAEPzG1H3ftyEWIRJFbJxEnE97pCVb3Sh1T6AIa6VRz+OXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497323; c=relaxed/simple;
	bh=Q/D5DE49ECUqmH9mkN/VUpp/l0AsTJ+0SW+Id7Joh1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PJh44VYm6kvagOBZ7XCwITHyy9RWg6MKjzGfhfUNLEcXOsx6fw0n3Cx1xi+Lo7M2nzf1s+kMGmYWQSm+5GuWwxB+MnLHXcMgTsMb45i94fNxHyKshcL7kTLZFgDgeUeofxoPGD+Vywe0eBy0cL4Im1b8oGXgTj8eASOR1Qsrjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8j16vwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D92C4CEF8;
	Wed, 10 Sep 2025 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757497323;
	bh=Q/D5DE49ECUqmH9mkN/VUpp/l0AsTJ+0SW+Id7Joh1w=;
	h=From:To:Cc:Subject:Date:From;
	b=K8j16vwhmXNpDmXpVRcd0di61oyu91wLv4fjGvW8NCM9dRrL6kEHtOuRuskcXcqBd
	 VQv/8PpVDH9RWTTEu0SLW3shG8nByvwePGgguvCXOmQB9fVZGMqECCZ9BqXwRfQ/WS
	 ZgUkLPBno1vOtLMXnB8gVQkdLFsjDyr37Pj+DQIv9r1zSu+MIc6267rK1bnbQRB5ZZ
	 xPPV+qnWIGBjJyv9e2X5Ax6h4RieINq02di6NHYDquMRUIRvDOk18j5/0lSAGlQ1kW
	 mL/hyLsHjqztlXwvr3b0D75hCUKRueIA7DpUfvS5yPa1bywS6F4W4jy25ryqmqJcVA
	 FWUC5d5zU2B0A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Todd Brandt <todd.e.brandt@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Zhang <guoqing.zhang@amd.com>
Subject: [PATCH v1] PM: hibernate: Restrict GFP mask in hibernation_snapshot()
Date: Wed, 10 Sep 2025 11:41:59 +0200
Message-ID: <5924662.DvuYhMxLoT@rafael.j.wysocki>
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

Commit 12ffc3b1513e ("PM: Restrict swap use to later in the suspend
sequence") incorrectly removed a pm_restrict_gfp_mask() call from
hibernation_snapshot(), so memory allocations involving swap are not
prevented from being carried out in this code path any more which may
lead to serious breakage.

The symptoms of such breakage have become visible after adding a
shrink_shmem_memory() call to hibernation_snapshot() in commit
2640e819474f ("PM: hibernate: shrink shmem pages after dev_pm_ops.prepare()")
which caused this problem to be much more likely to manifest itself.

However, since commit 2640e819474f was initially present in the DRM
tree that did not include commit 12ffc3b1513e, the symptoms of this
issue were not visible until merge commit 260f6f4fda93 ("Merge tag
'drm-next-2025-07-30' of https://gitlab.freedesktop.org/drm/kernel")
that exposed it through an entirely reasonable merge conflict
resolution.

Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220555
Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is super-urgent, so I'm going to fast-track it.

---
 kernel/power/hibernate.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -449,6 +449,7 @@ int hibernation_snapshot(int platform_mo
 	shrink_shmem_memory();
 
 	console_suspend_all();
+	pm_restrict_gfp_mask();
 
 	error = dpm_suspend(PMSG_FREEZE);
 




