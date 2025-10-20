Return-Path: <linux-pm+bounces-36483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0FBF28DB
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61B6C34D4FE
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674113314D1;
	Mon, 20 Oct 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly7YWfNU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43B265296
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979214; cv=none; b=MTxwy8MfR50iaKRCmEOiQekGWjYzaut22PkTar3BLELUdAGPYHVHSItIcRhciNDuTphRefF1WzNraOz9F7f1nARU6poqVGMKn1viW+UVnsZJ2p+WLaECK3OuwcRRaFcRcWLE7g0P2CwDkhdp1YPbk/pEvb7da/ecFDHqJzNn2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979214; c=relaxed/simple;
	bh=1rkkZ5AZJ1f6tx+F7MiJYeMTvVjq0iVEGK4upPvLgz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkHY+r2sMtlePtBfpEMW22XHsPYJ72OvnEz8Y/9ulC6ybofFwBgfaSc/qPtCGoiXB8RNPSLJyyacpcWoGCNPsP6jxkmbNZarSqftWPAQFj5XdfXmOJX2Bz9a75cc75UJ3Qcj/PSLf25E9Gbl0hYBi/jTns7Qm7dhlU7cuFLRh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly7YWfNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA132C113D0;
	Mon, 20 Oct 2025 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979214;
	bh=1rkkZ5AZJ1f6tx+F7MiJYeMTvVjq0iVEGK4upPvLgz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ly7YWfNUgbVv3Pn+Pbo5Pc8AMCOcOM6wlyp67ru21Ff5AKntHmv4GVUMprIhExqJN
	 3AFV89l4OniDqENxwIrZ5QLfdH0+X0jVJTqEvtNzNuiwNs/WtsZrCbWdsUS3ojOSnD
	 zX881mOUzZEG6wEXmkHpBVX3BOdaJxUNrUDbyBQ9P2AArtYK0+bQ5+Xdjd7XzM3TO8
	 259wwJEOkKW8oxZmdgsI+UhiqDJfONNfIlRKVbUuVtKvQhTWmzlrGf0XGUhW5gNk0H
	 w5MmAZIvQ1Nzw75hoyOe+IzPEQlG8frbq9WJq91ldvDI0/7kAI8JHY5sZs1c4sLMDM
	 yxWMPbwhReyrA==
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
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Subject: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success
Date: Mon, 20 Oct 2025 11:50:49 -0500
Message-ID: <20251020165317.3992933-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020165317.3992933-1-superm1@kernel.org>
References: <20251020165317.3992933-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The PM core should be notified that thaw was skipped for the device
so that if it's tried to be resumed (such as an aborted hibernate)
that it gets another chance to resume.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 61268aa82df4d..d40af069f24dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 
 	/* do not resume device if it's normal hibernation */
 	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
-		return 0;
+		return -EBUSY;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
-- 
2.43.0


