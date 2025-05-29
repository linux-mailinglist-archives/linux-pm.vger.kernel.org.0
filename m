Return-Path: <linux-pm+bounces-27828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9237AC8449
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96589E3FE7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F625A2D1;
	Thu, 29 May 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R1dO6qIx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75005220F4D
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557461; cv=none; b=KawnB6WGdRxmCnO/yjuZnJKH5wlnK4RmFFoIZkYcGI3H93sXxYkAR1RZsa4+sWU3lvCdzYZeFSOqOEKw2yMT1ZNP4QvmR6O+ihl/bkOU+pj0WFWOSNZkPLnJ42vMUj5+AErZDq0HozoNEwPEySGkm4mCp3bxGCNeT2sUDHh076Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557461; c=relaxed/simple;
	bh=1FOB/tgbWbr2J9qY9wwVwJjFsVMUQQmh0+XPdLjMp74=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=FPpypbHBLsoswpWCE+oTRkeu7r7SZ57pjWrcWY3N8SUcAOEGDdcNRvMiRp4oeNQz7ldoyEe9oiQ7lKOzaSPbsq4gEje/NeMMLTf4DbG1RknE9dEqSvCqYC6P+BxZdtk63j9Rxh6jNqm990FTqNdxroyV74VikWsaqsWOblEb360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R1dO6qIx; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222411euoutp022cd94fb4797ed3b6134736fbe926e52c~EH7z8hpGC2216022160euoutp024
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250529222411euoutp022cd94fb4797ed3b6134736fbe926e52c~EH7z8hpGC2216022160euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557451;
	bh=5egH5KWzs9ZC7lOWXRNh1it6vTUa7BxSAQZBLKObvZA=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=R1dO6qIxkW3CQsa3OH9T1WJ45bAArBU4Lvvl6sEs95fbeHIspElrYf5YTB3AFTBQA
	 nMPk73pelIdwVOusfMHmVC1V5r/mhYtwbUQ/EsNdfpiCXMHVGZ4rKWt5gW4QN7vLE+
	 triOhRZmPZ3e+G+IFMeNVjYHwlwYvKVyD7LLhMDo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222411eucas1p27e4b662d6f120c4e83d808cb03e4bb1e~EH7zNTci01565915659eucas1p2w;
	Thu, 29 May 2025 22:24:11 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222410eusmtip2679dfbe0e8921c3283af235ded40b4f8~EH7ySR5a32867928679eusmtip2W;
	Thu, 29 May 2025 22:24:10 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:55 +0200
Subject: [PATCH v3 8/8] drm/imagination: Enable PowerVR driver for RISC-V
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-8-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250529222411eucas1p27e4b662d6f120c4e83d808cb03e4bb1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222411eucas1p27e4b662d6f120c4e83d808cb03e4bb1e
X-EPHeader: CA
X-CMS-RootMailID: 20250529222411eucas1p27e4b662d6f120c4e83d808cb03e4bb1e
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222411eucas1p27e4b662d6f120c4e83d808cb03e4bb1e@eucas1p2.samsung.com>

Several RISC-V boards feature Imagination GPUs that are compatible with
the PowerVR driver. An example is the IMG BXM-4-64 GPU on the Lichee Pi
4A board. This commit adjusts the driver's Kconfig dependencies to allow
the PowerVR driver to be compiled on the RISC-V architecture.

By enabling compilation on RISC-V, we expand support for these GPUs,
providing graphics acceleration capabilities and enhancing hardware
compatibility on RISC-V platforms.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 737ace77c4f1247c687cc1fde2f139fc2e118c50..3b773879d781b17549455fac252cec8adfd3a9c8 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -3,7 +3,7 @@
 
 config DRM_POWERVR
 	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
-	depends on ARM64
+	depends on (ARM64 || RISCV)
 	depends on DRM
 	depends on PM
 	select DRM_EXEC

-- 
2.34.1


