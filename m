Return-Path: <linux-pm+bounces-35982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B8CBD5984
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 945B54E9326
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5FB2D3A75;
	Mon, 13 Oct 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyHaMzwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4A2C158D
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377702; cv=none; b=OmJFyUOzB825EnYO9bk4cTfeE4v+8Z+ua6PypnsNK0kDZMXZrROsMmtDE6I7ypSDcpVnv6OIgeltnTkb81EkWgB9RABv5iEi/UIa2UQWdHFZ/kLJpHaQce/hcanhCa/61iRaHoLAWtccoP1u+N4vxjooHtxJ1QlghjSiW1vaIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377702; c=relaxed/simple;
	bh=rDKkST9tqltd0Ny8fDT010gtFjkEG2+9tPi6uazi6LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTabAWA4IjfbhcLnpOBafpA27yH1wy4Nls7dPM51lPXMMkcuFHKx6p2karFMuAczF36+SK9qdzkESj1j6VYBcYoYlAp0UT5C8JEIxrdVMaU79ve7mZbj+jM68BKlXJcyVkZ90Qx/XRXIF+fkMBqtGkUCX63r5/ie1Rz87tL7xLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyHaMzwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC636C19423;
	Mon, 13 Oct 2025 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377702;
	bh=rDKkST9tqltd0Ny8fDT010gtFjkEG2+9tPi6uazi6LU=;
	h=From:To:Cc:Subject:Date:From;
	b=gyHaMzwlTgMJtX2fHdfT0YV+acAVS/02MFd3ytPgYy96cSpAXOWb4KPRfOR72owXz
	 goCKHn6oy+vkgfNj+QCBEENnIRM6oUzFjTA4oxnqf2llo1kAboxjSDQQf9IUbhexdU
	 EZX3Gskx/LvKWFDVOeW+koGCJfIuzfZnsJz1zdtrXdvt5YLYFnShF9H3dyz0uKNfo2
	 6OTWf/hw3eRkjXHnZNG6XhR5yI0T9ypsACxzHRzyyJoEyuviQP9Ve+QeUrwkImyhGD
	 PNsyGuN5Ny3IkNU9XxDzkDefr/YXDQlipuZzHq6FnaMrpiKhSiTH+bRJzzc6yb0ZSB
	 K0KxJB10QXFTQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	simona@ffwll.ch
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 0/3] Skip thaw sequence for all devices, not just amdgpu
Date: Mon, 13 Oct 2025 12:47:08 -0500
Message-ID: <20251013174729.1101186-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of looking at the hibernate code recently again I was considering
whether we really need the thaw stage at all when things are working well.

So I wanted to explore what breaks if we just skip it.  This should speed
up the S4 sequence since nothing needs to resume.

If we do this we can drop the special cases in amdgpu and the exported
symbols too.

Mario Limonciello (3):
  PM: hibernate: Nominally skip thaw sequence for all devices
  drm/amd: Drop special cases for thaw() callback
  PM: Drop pm_hibernate_is_recovering() and
    pm_hibernation_mode_is_suspend()

 drivers/base/power/main.c               | 20 ++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 ----
 include/linux/suspend.h                 |  8 --------
 kernel/power/hibernate.c                | 24 ++++++++++--------------
 kernel/power/user.c                     |  3 +++
 5 files changed, 19 insertions(+), 40 deletions(-)

-- 
2.43.0


