Return-Path: <linux-pm+bounces-36811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A53C087CA
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 03:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D363BBD8A
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92620ADF8;
	Sat, 25 Oct 2025 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTL8UsKW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D82080C8
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761354072; cv=none; b=l5q5SWzpsxKZ1KBw13AI/zu7fcOO6p1Zo4tc1IL+69eumgvy+IWH/NcYuRegY+JZAmz0GdwF5I1+3XoKEDWMN7EdkJT78ay4cMvujfwwrBddj4Q2UBSt8JOCnXj0IOBPXCchMMfW/Iv5ARwbfgROgDThnCYuXD1Wembb2IEGL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761354072; c=relaxed/simple;
	bh=c+ZpQvjae2c/AAdqSJlETeMLaKJkgZzOK5+wS4XXx/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXnlL9T9t8s3hv8sgrOa8N+z2sL4i9Q8cb8vgBRR3PYgE00Rg3BQPOCbrAp9x2Xb177OxudRcuJg4d73BScWBXtHDrSogImYdHB4TU7HyskCovpM5sBai9hnHx2Hp5BUJfuS/g2YggAkq1whKoCHnEfr2vHBYz552J955bRLLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTL8UsKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22B6C4CEF1;
	Sat, 25 Oct 2025 01:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761354071;
	bh=c+ZpQvjae2c/AAdqSJlETeMLaKJkgZzOK5+wS4XXx/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTL8UsKWoovipVFWA/oyYkuWqKA7BhhalF0vb15+d5BcHviMHcj5buYRLUA9p6xGw
	 pySDCDgcJmYP6aRHz3aK2dIwRgBeuEm/kOo9k+foc1k6WgzDzpzXmMDKS7Yqu31M7M
	 LmXcn9PCpa1/hiB6vrn2mxK+FeN3aldGr+HV0OrzSeEWu9F/OlK0JQBK5/b8+Gq94a
	 s2S3S8OtfluaaOeQiXQPsu79s1gFscBZzqxrXVsJD6cLHN4219BS/4xQTEiPpsgTGT
	 6fFvKK3sN/JVQAGjqe1isjQkErRlOhwaMFSN7YYwb7HL+Wqmcu09GnImVcuJmkx1m6
	 y82yRPl/8ucqQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Cc: linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2 2/2] drm/amd: Manage frozen state internally
Date: Fri, 24 Oct 2025 20:00:58 -0500
Message-ID: <20251025010058.2417352-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025010058.2417352-1-superm1@kernel.org>
References: <20251025010058.2417352-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Why]
On a normal hibernate sequence amdgpu will skip the thaw step due to
commit 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for
normal hibernation").

If the hibernate sequence has been aborted however after this thawed
step runs the PM core will think the device is suspended and will skip
the restore() sequence for amdgpu.  This leads to accessing the device
while in a low power state and will freeze the system.

[How]
Set `dev->power.is_frozen` to indicate to the PM core that an error
code will be returned for thaw() callback because driver managed the
frozen state.  If the restore() callback is called by the PM core the
driver will resume the device.

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * add tag
 * rebase on linux-pm/bleeding-edge
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d032c4e2dce1..693347eb6861b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5247,6 +5247,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (r)
 		return r;
 
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+	if (adev->in_s4)
+		dev->dev->power.is_frozen = 1;
+#endif
+
 	return 0;
 }
 
@@ -5385,6 +5390,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0))
 		dev_warn(adev->dev, "smart shift update failed\n");
 
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+	if (adev->in_s4)
+		dev->dev->power.is_frozen = 0;
+#endif
+
 	return 0;
 }
 
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


