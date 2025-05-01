Return-Path: <linux-pm+bounces-26522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A1AA652F
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 23:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08874A68B2
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DBC261389;
	Thu,  1 May 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDJ3QtPG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F525F970
	for <linux-pm@vger.kernel.org>; Thu,  1 May 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746134264; cv=none; b=ILixDPXZFIyFM2RbDUOj58cVN1fxabdzViT+WiBESfvy+OqDRg1HbCi1yLPhVIhOAacSqAjo+G/2PSmLqM6THLb/0DE099UUhanl2ZbqqwLtrRygXTisaNvGoesCnx0ALtE9PpctSiylI+ek0h8okHcSZ99/I5pbiAwfJuAM6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746134264; c=relaxed/simple;
	bh=PaL6fSpxU3x6hlhh7NpF14QNceBepBMnGGT5NyW1Kk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3bz714DeQ6Skr52Pv0senfKEoSSxr5JX8iZlUccl2WToKaVYJaKIS3TOmskJLHndNwS9l07F9QIonRL4Prh0Qvxxu6/FaOWD8rIGZWMVo6cFC4a23KRX2JnX1Uvc7nJ2v0nh0k54JB5ld0IP+agRgfGQYJq4a2RA8mi8SzmjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDJ3QtPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AEBC4CEEF;
	Thu,  1 May 2025 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746134263;
	bh=PaL6fSpxU3x6hlhh7NpF14QNceBepBMnGGT5NyW1Kk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDJ3QtPGpXRAm5yXpFnRjAiAArom0g+X7z9IkpMCHFbp6js7r9C9Ie7NVFIE2vPxT
	 gHlT9P8Tb7CzR/cMLwbHoK6irWKYvgij9cm23DAI/a/Grd8oAV8RUc3XPUY/m5QnCQ
	 Jli4WO6CSEuJoBDlmpfPaA2I/B1T4VMIivsMXVjDLg50d84xwrCFnYQTCE4qfnYRKA
	 4ZVsuL9h+lSNdurO2vZV7BaTN6PdJOOYYhphhp2kRpjDj0rD7qF25N/Yvk/KPahcw9
	 YyNOGAW7w5itvGbDVKZEyKCfapIstkEbbREc3cDIGLP9kVyjg0XEO6ZMBb4w54JhY9
	 kPBg8AJTWhwgw==
From: Mario Limonciello <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 2/2] drm/amd: Use suspend and hibernate post freeze notifications
Date: Thu,  1 May 2025 16:17:33 -0500
Message-ID: <20250501211734.2434369-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501211734.2434369-1-superm1@kernel.org>
References: <20250501211734.2434369-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification
callback support") introduced a VRAM eviction earlier in the PM
sequences when swap was still available for evicting to. This helped
to fix a number of memory pressure related bugs but also exposed a
new one.

If a userspace process is actively using the GPU when suspend starts
then a deadlock could occur.

Instead of going off the prepare notifier, use the PM notifiers that
occur after processes have been frozen to do evictions.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f354cd532dc1..cad311b9fd834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4917,10 +4917,10 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
 	int r;
 
 	switch (mode) {
-	case PM_HIBERNATION_PREPARE:
+	case PM_HIBERNATION_POST_FREEZE:
 		adev->in_s4 = true;
 		fallthrough;
-	case PM_SUSPEND_PREPARE:
+	case PM_SUSPEND_POST_FREEZE:
 		r = amdgpu_device_evict_resources(adev);
 		/*
 		 * This is considered non-fatal at this time because
-- 
2.43.0


