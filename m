Return-Path: <linux-pm+bounces-31697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A97B1726F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 15:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0AE17E049
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898332D372C;
	Thu, 31 Jul 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Es8c2Yq5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0D2D23BC
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969831; cv=none; b=OnNUqMlVhqhmLRteryXK2pYmXJTQd/tBzpIF5CnI2B5u8acyh0u8sWU1mPIOLk6nVqgKvVShw9ZPFCSbvV7ruAEumyTfm+eSepF5eFqgSIEio6q88yOoLd0u1T7l7hUMaQ2CrcSbM0rtMWEfcbuqpHg89lG2SnbzMpluM7OYcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969831; c=relaxed/simple;
	bh=Eqahkamg13uwXjpD2HqVe8PGEmKJKZBW1G6dF/3Hy5o=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=nXyyBDOEDwBipfWLhbzUUN58d2LBLgCQ41WlpOMjW1LLGgzDpxSzo74M4OfybtgXkXHs3U1Fm16lMzZlvH2e7w/EFWL/KH5bBF2n/nb5Ucf7ZZZJCY/mFhs1Jvf/JknODq7obNvX5fpN9yTbOhcUvhW4C+hg9liwtWVkf65ZVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Es8c2Yq5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250731135023euoutp029326c76dc3535a54b8309f4dd833c3fd~XWkLxkHO11416814168euoutp02H
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 13:50:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250731135023euoutp029326c76dc3535a54b8309f4dd833c3fd~XWkLxkHO11416814168euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753969823;
	bh=o9pup7lxdlJYj1WCugUFlZF6W3E8/CCvLfzm1q+9rG4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=Es8c2Yq5qhXWnh/0jOSHEfENH34QtVdjTK6zOwwr7JeShukwtnWhRcZIzpddg6o8c
	 LaMHg5suhHtsPW8u9ABHWFVay6v99hvJCQyd1HydwARUYO1Remj7fxaQ6H6HMnSJTp
	 qHgPYXT9sFvjahYKSkhSRKZm6Pd/WrsMSRwwuvnM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250731135022eucas1p25e396efeb6096c7359a029a775d0f21f~XWkLCUHpl0703007030eucas1p2m;
	Thu, 31 Jul 2025 13:50:22 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250731135021eusmtip2a53c34b00c11d99c50154d27f553bfe5~XWkKBtDkV3049030490eusmtip2Z;
	Thu, 31 Jul 2025 13:50:21 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 31 Jul 2025 15:50:15 +0200
Subject: [PATCH v9 5/5] drm/imagination: Enable PowerVR driver for RISC-V
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-apr_14_for_sending-v9-5-c242dc1ffc14@samsung.com>
In-Reply-To: <20250731-apr_14_for_sending-v9-0-c242dc1ffc14@samsung.com>
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250731135022eucas1p25e396efeb6096c7359a029a775d0f21f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250731135022eucas1p25e396efeb6096c7359a029a775d0f21f
X-EPHeader: CA
X-CMS-RootMailID: 20250731135022eucas1p25e396efeb6096c7359a029a775d0f21f
References: <20250731-apr_14_for_sending-v9-0-c242dc1ffc14@samsung.com>
	<CGME20250731135022eucas1p25e396efeb6096c7359a029a775d0f21f@eucas1p2.samsung.com>

Several RISC-V boards feature Imagination GPUs that are compatible with
the PowerVR driver. An example is the IMG BXM-4-64 GPU on the Lichee Pi
4A board. This commit adjusts the driver's Kconfig dependencies to allow
the PowerVR driver to be compiled on the RISC-V architecture.

By enabling compilation on RISC-V, we expand support for these GPUs,
providing graphics acceleration capabilities and enhancing hardware
compatibility on RISC-V platforms.

The RISC-V support is restricted to 64-bit systems (RISCV && 64BIT) as
the driver currently has an implicit dependency on a 64-bit platform.

Add a dependency on MMU to fix a build warning on RISC-V configurations
without an MMU.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 3bfa2ac212dccb73c53bdc2bc259bcba636e7cfc..682dd2633d0c012df18d0f7144d029b67a14d241 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -3,8 +3,9 @@
 
 config DRM_POWERVR
 	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
-	depends on ARM64
+	depends on (ARM64 || RISCV && 64BIT)
 	depends on DRM
+	depends on MMU
 	depends on PM
 	select DRM_EXEC
 	select DRM_GEM_SHMEM_HELPER

-- 
2.34.1


