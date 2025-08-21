Return-Path: <linux-pm+bounces-32846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFEB3091B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 00:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86F9AE88AD
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610DA2ECE89;
	Thu, 21 Aug 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HSLnsP2Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C32EAB89
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814830; cv=none; b=Bfe8KU7HFSpdw/2aL5yisG2+9eznVbD4UlL6puFUY0bL1RUDSVYHMJjgWSRP+Vm2eglUTiICOdbITT8ye5By/c7dxRf/Kwtl0RGXw9v2EMhsqN44h9JiCQvbzu8XdlHWXdYdbiPJsQ5tgtQ1iSePblRkNLfuW3rL0XcY9zlNBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814830; c=relaxed/simple;
	bh=3+d0bC5Tq8aMj8373zA7XkZtS5Kc2LtPcfvRUsK0/Qc=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=DstYGuy5hrZ4kPlPSPm0xlVcOKyyMwk8a8OTJLaqX9zOlhWuj5CjMXTwkfBxHDZ0Hu65OUFOdtHX9pWkPQOgHepM5xRx3JJtoi/R+K0TUGCYKFDZ9xPGjJcMD7JtGi91hXsNZsAbxnyPPf6MP9sO7Jjae2EasymFAbIl1TD/vKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HSLnsP2Y; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250821222025euoutp02ea0f8ac5833afe0a2e8e5c74b326a3c2~d6EfhmdG-2845828458euoutp02Q
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250821222025euoutp02ea0f8ac5833afe0a2e8e5c74b326a3c2~d6EfhmdG-2845828458euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755814825;
	bh=sKprqc5e6NKeYW0/ZlcX1W6ahYkIBlxOh0FMJaxMLh4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=HSLnsP2YK8Jbl7O6GM3HUNrCApoNrjm/y0dbQh8Z3PHH2S09I0fb2nLgApPKgItGN
	 0ZUyKHjEnmMKnTDzeuM9f7NdTyOQBio06c8Ck7olId6czj4S34AA2AutI4FPVKVLs9
	 sJxpny0i+MIFDhGs/qGITRT+jBJVPZGpKzivvfhk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250821222024eucas1p1e4f66aeff7be9e3319633c6067339595~d6EewxrMM2013020130eucas1p1R;
	Thu, 21 Aug 2025 22:20:24 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250821222023eusmtip10b6e5460e41b514eff348e2f5b8f09aa~d6EdwMk2Y2143321433eusmtip1B;
	Thu, 21 Aug 2025 22:20:23 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 22 Aug 2025 00:20:18 +0200
Subject: [PATCH v13 4/4] drm/imagination: Enable PowerVR driver for RISC-V
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-apr_14_for_sending-v13-4-af656f7cc6c3@samsung.com>
In-Reply-To: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
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
X-CMS-MailID: 20250821222024eucas1p1e4f66aeff7be9e3319633c6067339595
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250821222024eucas1p1e4f66aeff7be9e3319633c6067339595
X-EPHeader: CA
X-CMS-RootMailID: 20250821222024eucas1p1e4f66aeff7be9e3319633c6067339595
References: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
	<CGME20250821222024eucas1p1e4f66aeff7be9e3319633c6067339595@eucas1p1.samsung.com>

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
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
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


