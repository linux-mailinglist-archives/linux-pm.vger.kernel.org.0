Return-Path: <linux-pm+bounces-35411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D2BA112C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5BC1C2166A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A004B2F2601;
	Thu, 25 Sep 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZw654Q8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B022218ACC
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826276; cv=none; b=tBtNq4KNFYtpKAs4S81IhmrSH7txxKzzms9p/7xuhWbycY76oPYraZJsIXn5k/ndYMkPoSq0iLjIzt0MUIrVXBHWCWBewCselqtsNeIDsHjhQPIpFk/Y0SoC9FyCqty5hEk4T6KfZc6wh2Z4oEOYAVrZgqNW9EjBhVzrb++Y1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826276; c=relaxed/simple;
	bh=N9xmDtQS3dATzW1PaWQLaB6jOOpl3g+2kQS9I+rJQSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvme8C6w1Y1E4bk6cv6bnvjsn33Uz2vRZATKO8Rw6Y2mLYU3ESDGdY5EJ2FbJlYIO3oRKdBjGyhWPuobZcwCaTQNMwV7lAIYnxuW1s+QVQABrkrE6TxRf4tyDJNPKXvqmIXhj+TbsP9+NM9Djcpyl8tzjnK00t6OjFvnT1TAx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZw654Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE810C4CEF0;
	Thu, 25 Sep 2025 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758826276;
	bh=N9xmDtQS3dATzW1PaWQLaB6jOOpl3g+2kQS9I+rJQSw=;
	h=From:To:Cc:Subject:Date:From;
	b=mZw654Q8+XZdehU6FkONM7g+d+2uwy48gI33mkxrM98rY9GKVWrD9eEE/YjTf/cwJ
	 smhRrxLTvg1SUBwMz70t67zej+P/heEJDFJk8WEUgOZKHWZRkd76PU77q2WwvANzwR
	 mMjV77IeuGpFrThBqvh9BE481KMUKeBPYfpCy5K+x9b3lCPRmBFT8ySQcVwdpxuyXd
	 Zw9QHiTsAQb0wKMLBTsRYk9qehDIZQ5mJeQP/FAKa+EK5URX70/83vFJ9MDmsNMO6F
	 MMxnnnR9S7n2OvP7QspGFQEqpl+H1CBx6QOfi+1EJ579V3MFPK5U8zPxxhMW/3qE4t
	 X6/HI0nsOxvFA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Fixes for hybrid sleep
Date: Thu, 25 Sep 2025 13:51:05 -0500
Message-ID: <20250925185108.2968494-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Ionut Nechita reported recently a hibernate failure, but in debugging
the issue it's actually not a hibernate failure; but a hybrid sleep
failure.

Multiple changes related to the change of when swap is disabled in
the suspend sequence contribute to the failure.  See the individual
patches for details.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573

As it touches two subsystems it either needs to go through linux-pm
or drm.  Patch 3 has an Ack from Alex, this should merge through
linux-pm.
---
v3:
 * Push all calls for gfp mask changes into power_down()
Mario Limonciello (AMD) (3):
  PM: hibernate: Fix hybrid-sleep
  PM: hibernate: Add pm_hibernation_mode_is_suspend()
  drm/amd: Fix hybrid sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 include/linux/suspend.h                 |  2 ++
 kernel/power/hibernate.c                | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.51.0


