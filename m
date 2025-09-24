Return-Path: <linux-pm+bounces-35305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0EB9C32B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41177A6981
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D31E573F;
	Wed, 24 Sep 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jziuuazt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444113D891
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747140; cv=none; b=j8l8hg8W1wANBdf6AuLuWx6D+Jiiuj5Fgy5Y6HuMBZljcrVtXiSIMvXNXJtI8+KVmDZ7dici1cc/LhxKygpJX6EBBaeQh0cL/76nJ0pFv9zBAPoxDZuvj8SDs13XF5cD5J7ZpqtsQIBzOmw2mKho2fAj3B37OW5CIBHp4ZGQdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747140; c=relaxed/simple;
	bh=hY8KOOIdcLFeStFpDPUnr30X+UWyB7hNIoqZgjHszoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeDJnjzdx05Z286KoySUS6uZYy2oJTCF7bRY2CW5QxBmB22K2i7IKBaSvtiqdoPbZVo+IIF6JDcnb+wX/9jVNxK5LkRNDNvmCRMlOfFnM/lNe5ZcHxIa5+i6jrLJYS81/L426G9n7mZbP1tc8BI86/9pnGY3xhDI6H+f8dEEuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jziuuazt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BDAC4CEF8;
	Wed, 24 Sep 2025 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758747139;
	bh=hY8KOOIdcLFeStFpDPUnr30X+UWyB7hNIoqZgjHszoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jziuuaztodkxEWwbzJvPzU9L1hkTITklU3j8ZBab0HOFzgjHNqcDS74Mxshzgz6ov
	 VX2RTUDI3IczqfPVzyf8sx6sbM2z2Sk4qw2dujH0P/MsG9YDb3tNy+E7ska97rorYU
	 Cyxt+ylCZfy6uqDPaF4C3alA1Nlm+e69cMTBagzOwv6Zj2mr90Xe5pLSea6c4O2WMj
	 J5qAG+t6DONqsAoBawpVB/mWuKt7xgyJ6UelzSxQmrOiU77bn55c0mgipcYImggawR
	 wSD6dO9486KTMQ2SNL07Kw845SHsgUeeERbLZyemCeziISSfd2shuTRjjF9Z35Rrik
	 FPas4J9tTeZ8A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 0/3] Fixes for hybrid sleep
Date: Wed, 24 Sep 2025 15:52:08 -0500
Message-ID: <20250924205211.1059571-1-superm1@kernel.org>
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
or drm.  I would suggest linux-pm with an Ack from Alex on the 3rd
patch.

Cc: Ionut Nechita <ionut_n2001@yahoo.com>
Mario Limonciello (3):
  PM: hibernate: Fix hybrid-sleep
  PM: hibernate: Add pm_hibernation_mode_is_suspend()
  drm/amd: Fix hybrid sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 include/linux/suspend.h                 |  2 ++
 kernel/power/hibernate.c                | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.51.0


