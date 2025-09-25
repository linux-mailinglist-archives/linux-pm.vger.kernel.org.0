Return-Path: <linux-pm+bounces-35414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADAEBA113C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49333B141F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2031AF39;
	Thu, 25 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvNaqmHH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251231AF33
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826279; cv=none; b=BFgB3lsQkWZorzzpChtoW3H5XCSunyt9vxsU3XvbNJATi4Qx1FvPJ45e8dCj3mpb25+OnY62B0OunxrqFaDoY98WBwiWGHkIuBXCICTSKnzP/oGvKXnMnUK+iGvfDIA9lR7PwZHG1UL0b2wJjVxl5ttg0DJbG5rV/H2WYjCMGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826279; c=relaxed/simple;
	bh=pMR+sh3CGJT+bnR59DvKxbPuW2B4QvkTk5wiF2s4XkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nChHTLift2wfiaF32Z57UyJDn39+gKCAtyQSsvFsvC7WwDPS1ZHFrNgX8byR7MfzES37rNGgaXOT7IrYWCQqIhvmdmVzkwXx9fCPiLX5/OfJkkH64V0pHnz3Dp/U3mwHybPuRtRzb5pLkV8fIzdvCAoVKPu2DATJm+BhoHkUWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvNaqmHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B78C4CEF0;
	Thu, 25 Sep 2025 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758826279;
	bh=pMR+sh3CGJT+bnR59DvKxbPuW2B4QvkTk5wiF2s4XkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvNaqmHHVI5Tqk0ajy9w+QgeIByaq5Htw+pZeXxKwGLTHZvG3IVLGKAn9RzODqcVI
	 YZ+q70+o2b1g4duxRfdnjk5EHYKHy+m7k4GyGrrEQFESyUmh4FG0o+5MSczjAcTWwd
	 /0fbYN4Bez70Gf8ljG7Asq0YtLeudnCovkVp1VpBBZX1KyLsynqXRNdLass3LJWIw6
	 q08cCji0E+jYxg7smDLuhywOlumiLUMOfGPSjUPHctEPB+3PG8RL2JFQjTxb1n4y9Q
	 DrOGkB/LeWwGMc9GLaiY8pPrK2xmurzhyNqw9LX+742MApLJgY66VQmil81ZjDpBmA
	 QrW72Z8GX0baQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH v3 3/3] drm/amd: Fix hybrid sleep
Date: Thu, 25 Sep 2025 13:51:08 -0500
Message-ID: <20250925185108.2968494-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925185108.2968494-1-superm1@kernel.org>
References: <20250925185108.2968494-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Why]
commit 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for
normal hibernation") optimized the flow for systems that are going
into S4 where the power would be turned off.  Basically the thaw()
callback wouldn't resume the device if the hibernation image was
successfully created since the system would be powered off.

This however isn't the correct flow for a system entering into
s0i3 after the hibernation image is created.  Some of the amdgpu
callbacks have different behavior depending upon the intended
state of the suspend.

[How]
Use pm_hibernation_mode_is_suspend() as an input to decide whether
to run resume during thaw() callback.

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for normal hibernation")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Kenneth Crudup <kenny@panix.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 395c6be901ce..dcea66aadfa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2665,7 +2665,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering())
+	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
 		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);
-- 
2.51.0


