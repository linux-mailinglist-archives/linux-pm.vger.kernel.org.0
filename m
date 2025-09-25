Return-Path: <linux-pm+bounces-35391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE2BA0823
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E768717AD93
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C1303C87;
	Thu, 25 Sep 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIh1lUsp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D4302CC0
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815965; cv=none; b=qfMWJFQXElNgtyGKMw6u6wsUMxorXyoTq4ToZ8u1REXzCzVc4btImqE+lGzuF9S4GsG5Y3Ju5+JiLF/RnNuE/mLz+ROWi6Fld0NLR7RKtSVEhshPi6OekFjc9Rsu0zZzJgMvAACo+G+3uSHs3TGHqJwZa1gCHCwSCg1NqMy/hFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815965; c=relaxed/simple;
	bh=yhOhJkZZYMouooZCDf68+qrRmrCaon7hXJObEYatR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQ6kjcoTXjehpo+okkIilXOab6wPbOKWMv3s/YhRSm+99CZat4rFMB2JziEf5XFUx2GdmCtC3Z6iKZMfCfMrP+s+ni3ywx6tJwL28m4TrsjyxYYqeLcBmLdRvKTQK35n+tUWw+pSH4A2zuouwgEKqqjx1zYsSHaLpm5w+EdZt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIh1lUsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F081C4CEF0;
	Thu, 25 Sep 2025 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815965;
	bh=yhOhJkZZYMouooZCDf68+qrRmrCaon7hXJObEYatR+M=;
	h=From:To:Cc:Subject:Date:From;
	b=pIh1lUspaOok0glq7a3NwhZEtia7yCbFCSfMfqSf7M9225UNmhEdhJlSxmwxCsxv0
	 LQ5xDsWs8Mp9cXzjKZnDUqMpYZYURZ5LwvqesXoNxZuuR8UURMM1bP9dawUn+gcPoR
	 soLi5VEgSbel8LbTSs1Z9YD8LRdWJ5zgqyQopPA03FGuHaDdFa71ce3N314xnZGC0d
	 Anmft5EYlvvgSr4kcPEg5jfcz2FGY/lJjUtGUpzJu688CRwjtuof76oAYcbmK4QnT1
	 zdPSCSj5GPBiZ4xsczw9IALvSTGiBwrqNKFReqptnNH1tUeQDqARKrEPb3tdz4AhVe
	 Dpq/engWHZglw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 0/3] Fixes for hybrid sleep
Date: Thu, 25 Sep 2025 10:59:15 -0500
Message-ID: <20250925155918.2725474-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ionut Nechita reported recently a hibernate failure, but in debugging
the issue it's actually not a hibernate failure; but a hybrid sleep
failure.

Multiple changes related to the change of when swap is disabled in
the suspend sequence contribute to the failure.  See the individual
patches for details.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573

NOTE: I realize this is super late in the cycle, so sorry about that,
but I debugged it as fast as I could as soon as I heard about it.
If it needs to push out to the next cycle it is what it is.

As it touches two subsystems it either needs to go through linux-pm
or drm.  Patch 3 has an Ack from Alex, this should merge through
linux-pm.

---
v2:
 * Fix LKP robot errors without CONFIG_SUSPEND
 * Add tags


Mario Limonciello (AMD) (3):
  PM: hibernate: Fix hybrid-sleep
  PM: hibernate: Add pm_hibernation_mode_is_suspend()
  drm/amd: Fix hybrid sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 include/linux/suspend.h                 |  2 ++
 kernel/power/hibernate.c                | 22 +++++++++++++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.43.0


