Return-Path: <linux-pm+bounces-35984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A579FBD598D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F10E18A6288
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DC2D23A9;
	Mon, 13 Oct 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcXAX4cj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215782C21D8
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377705; cv=none; b=DUhd6loTLM7uPPGTOV0Futb7Pk1XdMFAANUaNg++fHcmoKJU4U3krvFCKj1PMdef0zK29vRqTY19nbngwmo5EH3OHmdMowmM6ZiUVU7n6JNfPH24ncgZNTXjzkKqqndWdAkc0JOKjzRhaxixeZi/Rf/MAbP3emi3AAdDlnqnNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377705; c=relaxed/simple;
	bh=ZdIBAWFzrHtYqH0jGDYXyDGwbLVNel0hknXRuAIjNIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPSus+M/Adoi3zVB93e74Xqel+KH3gBRwICdEkovzYAFnlCGtlxmZL19/wfeT+H+QyJHVGGSDgIWIiOfzxDRh0jg3GZKtnlvpXDx/w8VxTTK/dK9cRP98OaJ6+6eSTz1tHWkRR0KCiffZM924FLZy27Ki9PcLLa5SiE8ARUWVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcXAX4cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75EDC4CEE7;
	Mon, 13 Oct 2025 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377705;
	bh=ZdIBAWFzrHtYqH0jGDYXyDGwbLVNel0hknXRuAIjNIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcXAX4cj/NejI+9lD1+sudiNdbchlfcjVND8urE61nxlTqI9fFnH25UTb7Y7Aprcy
	 B66rvVV8yQt8+aX8+R10iq74I7bWtjVBEy1eUhGmxeQ6CrjY5jCYueMi7neHO1Z2ZH
	 AaSMoLE+FFP2wiLc1XXU3UZV7mAOJ8lxydS1TP2OI4pZ6q1L3L+Sa35RkzSrSVcR2Y
	 JAn9xDilVGxRA11O5L6YPSh6WRIVJBQMaTVYzg/0RStAlh/R4kefUZ9az4DjGefxXj
	 yzcrz7Hxedk1KNGmoeifJrEJwJNT9CO7/w/OejwSbV3ZMcy+gIxpRLWdS5bLLazvKR
	 IczzJDI2W09PA==
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
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 2/3] drm/amd: Drop special cases for thaw() callback
Date: Mon, 13 Oct 2025 12:47:10 -0500
Message-ID: <20251013174729.1101186-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013174729.1101186-1-superm1@kernel.org>
References: <20251013174729.1101186-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The special cases to use pm_hibernate_is_recovering() and
pm_hibernation_mode_is_suspend() were for an optimization to avoid
turning the display on and moving memory around when the system
was about to hibernate anyway.

As the hibernate core skips thaw() unless it's necessary drop them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6d547f4e4bafc..4a37c3e517a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2671,10 +2671,6 @@ static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
-	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
-		return 0;
-
 	return amdgpu_device_resume(drm_dev, true);
 }
 
-- 
2.43.0


