Return-Path: <linux-pm+bounces-39726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40081CD357B
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 19:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3B313009F71
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44430CD8D;
	Sat, 20 Dec 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="MJepbfoS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0B27CB04;
	Sat, 20 Dec 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256690; cv=pass; b=eH7zSPet/X6wjz6To5plSrmdDzRsMVRz4izmNxtZ2glB92PtRp9J2ULJBhziROBi7jYzDlFneau0BMXEgW4nTFANkKKaggMAvAppwauB0At/2tC+C7ZL540t5epe++Y2Ao1BBKylrnZ+a/LgEEygHw/0S/6LCcRgvD4hO1bgRo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256690; c=relaxed/simple;
	bh=CqYHrHAH/Jsla26IK8xYrtLEa0nb+PUDFvp4jEXJNyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQB6GiMsV1ppjFd47ycg3/3IijmpyRKl1buBCEEQOHJzxpKv2SvWCs8J/xy3f3jePKO0KCHutPeXRY9GtGF4rcFEQoScAn4yGpw/L8bknCGLZkBkJq4McW+qHIJ8lt9Q+eT3NVOqIJB0+u7XA7wwowEd7cGvFqCU9vzj/buGz3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=MJepbfoS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766256639; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MsNirVtsBPgMUKM4LqhhRrIx3Ur9lC+OTQZL6dxKUkOHuy7b35NUfB2b7cqxe9PvBxP7l3ay09KENoO/mdpARgxTHZHbWNjfDnV2vMob/1yuPzI1NHDoYQj9D1WG/O+De7riAcPU2bqNFSyfzpGrKBHiA0rsko8FJvZenAs4pN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766256639; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8rRlnY9LZnCWGx1zTU/aPAeZJrjVXsHfEKZP3E41uXI=; 
	b=XzZkCm2B7Gaihpm0ONGK0/VfiawLu4hI2foGyi5f8mnjmm7CDjoTaLwQvQKm7OPmWR0dH1ZrSuMjRjvweFQtXW66sP/clPFzq9qH97Y7LqN4x8TLKbr7RMBcu4Jo4zod6c9xCbNjmimj8ca1lkagYNxCEfSxgrNL2ee0ZANVLao=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766256639;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8rRlnY9LZnCWGx1zTU/aPAeZJrjVXsHfEKZP3E41uXI=;
	b=MJepbfoSqB0kxqG/gC3DSa4eX2BPv0L6tb4Ksi3eTDBPWdgarkE4y5lgUiEOrw9o
	02rsAe65LLLwrZw0tO8R9NnCgAg/uVes1yHeW/WpR0oZ6ihyoAdyxykoCkYQH9Bkn99
	/yuJbYxKLcX/ZVA0Fp+Io9anLVWWACLlojAsSm9E=
Received: by mx.zohomail.com with SMTPS id 1766256639151549.0735477560279;
	Sat, 20 Dec 2025 10:50:39 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 20 Dec 2025 19:49:54 +0100
Subject: [PATCH v2 3/4] drm/panthor: Implement reading shader_present from
 nvmem
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-mt8196-shader-present-v2-3-45b1ff1dfab0@collabora.com>
References: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
In-Reply-To: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

On some platforms, notably MediaTek MT8196, the shader_present bitmask
in the Mali GPU register for it has cores enabled that may be faulty.
The true shader_present bitmask is found in an efuse instead.

Implement reading shader_present from an nvmem cell if one is present,
falling back to the Mali register if it's absent. The error codes are
trickled up through to the probe function so that probe deferral works.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 87ebb7ae42c4..80c521784cd3 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/nvmem-consumer.h>
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
@@ -109,7 +110,25 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 	return "(Unknown Mali GPU)";
 }
 
-static void panthor_gpu_info_init(struct panthor_device *ptdev)
+static int overload_shader_present(struct panthor_device *ptdev)
+{
+	u64 contents;
+	int ret;
+
+	ret = nvmem_cell_read_variable_le_u64(ptdev->base.dev, "shader-present",
+					      &contents);
+	if (!ret)
+		ptdev->gpu_info.shader_present = contents;
+	else if (ret == -ENOENT)
+		return 0;
+	else
+		return dev_err_probe(ptdev->base.dev, ret,
+				     "Failed to read shader-present nvmem cell\n");
+
+	return 0;
+}
+
+static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -143,13 +162,18 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT);
 		ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT);
 	}
+
+	return overload_shader_present(ptdev);
 }
 
-static void panthor_hw_info_init(struct panthor_device *ptdev)
+static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
 	u32 major, minor, status;
+	int ret;
 
-	panthor_gpu_info_init(ptdev);
+	ret = panthor_gpu_info_init(ptdev);
+	if (ret)
+		return ret;
 
 	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
 	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
@@ -172,6 +196,8 @@ static void panthor_hw_info_init(struct panthor_device *ptdev)
 		 "shader_present=0x%0llx l2_present=0x%0llx tiler_present=0x%0llx",
 		 ptdev->gpu_info.shader_present, ptdev->gpu_info.l2_present,
 		 ptdev->gpu_info.tiler_present);
+
+	return 0;
 }
 
 static int panthor_hw_bind_device(struct panthor_device *ptdev)
@@ -218,7 +244,5 @@ int panthor_hw_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	panthor_hw_info_init(ptdev);
-
-	return 0;
+	return panthor_hw_info_init(ptdev);
 }

-- 
2.52.0


