Return-Path: <linux-pm+bounces-26520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D6AA652D
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B04A46BD
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FB257443;
	Thu,  1 May 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO8b29nx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A7253332
	for <linux-pm@vger.kernel.org>; Thu,  1 May 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746134263; cv=none; b=EqVrV7IbkPaLjJMnE99RafkI1uurhMmHRFU2LkQFZ58EriZvsYS4VNQsSedp40E9EFrQNvUooRXSS1uxEGxariZ0ezFBQJKdco3uOiKnriIAAkJfODAYIEW9t64lrGVIt+TLmjnI30c2aQpXCPfaHJ4B+lPS8Bl2cgA6bNMaHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746134263; c=relaxed/simple;
	bh=ezi9K3Epx60pZdQ7FxZyZ9yVvMN3Di0TUurJQagcf74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmMIDJp2Kch3kHsV9RHXMSxT/fQ1YZLKgH5DIK5X7BPpGBAVuXV13/8HuAOF81fcnFpv44ihzkuVdZzl1kyPo2YIwZS1fs0Y2N/OAVDCRZmfeD9CalIvnej1RDPe5Oz2g0rUZ+1sBJJY5yO0Vdu6tbZRIwiO2I3F5EmhCL7XkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO8b29nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC97C4CEE3;
	Thu,  1 May 2025 21:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746134261;
	bh=ezi9K3Epx60pZdQ7FxZyZ9yVvMN3Di0TUurJQagcf74=;
	h=From:To:Cc:Subject:Date:From;
	b=hO8b29nxu3zuNtZftjLJYD7Ty2mb09NntcFBmVqcgx8ustUAecnsJy8ygRWprSVKx
	 dtgs8wigxH91xwGtU9iH6CytaoXBK9VUexlp4yaIF/rBtr5cU6C9+x2t2kfFSbtzZo
	 643LL3pB+LM71mBK/YwvnNTeevbOupjYUzKDjpLaHRnEkP4Qqvk4sLyZCXMfSdXjgw
	 /bHhUtfen3lETp2K/VRpJn2esqsHN8k2zYa5+HEbg0oMF79oibHa6St/pQdIM9eM7T
	 I6r/6SSqxK2BUhExv2wO/+UMA1cUhktLwFBFUEIyXXJxd2AHnuo82RtQmFwMxq2Jjy
	 +aZg+6z+BjI6g==
From: Mario Limonciello <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 0/2] Evict VRAM after processes are frozen
Date: Thu,  1 May 2025 16:17:31 -0500
Message-ID: <20250501211734.2434369-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

As part of the suspend and hibernate sequences devices supported
by amdgpu will have VRAM evicted.  This has been littered with problems
in the past, and now it is called strategically at multiple times
during power management sequences.

Most recently there were a number of issues reported that were root caused
to physical memory pressure at suspend time where VRAM couldn't be evicted.
A new call was introduced using a PM notifier before swap was turned off
so that even if there are physical memory pressures VRAM could still be
evicted into swap.

This helped, but users using older systemd noted that this could lead to a
deadlock.  This is because user processes aren't frozen by older versions
of systemd and thus if a game is running it could potentially be creating
BOs during the eviction thus preventing eviction from ever completing.

This isn't an issue with newer systemd because it uses cgroup freezing
to freeze user processes. Nonetheless this isn't a good behavior to rely
upon for userspace, so this series aims to solve the problem in another way.

Introduce new PM notifier calls after "prepare" notifier is done AND after
tasks have been frozen.  amdgpu listens to these PM notifier calls and
will run the first eviction at this time.

Mario Limonciello (2):
  PM: Add suspend and hibernate notifications for after freeze
  drm/amd: Use suspend and hibernate post freeze notifications

 Documentation/driver-api/pm/notifiers.rst  | 19 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 include/linux/suspend.h                    | 14 ++++++++------
 kernel/power/hibernate.c                   |  9 +++++++--
 kernel/power/suspend.c                     | 13 +++++++++----
 5 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.43.0


