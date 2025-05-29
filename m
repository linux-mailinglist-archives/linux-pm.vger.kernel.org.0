Return-Path: <linux-pm+bounces-27827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E6AC8448
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88B31710C8
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052E258CE5;
	Thu, 29 May 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="INdOF+Rf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627024EA9D
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557460; cv=none; b=CQkc3l+30aJqdKILxvKG31IegCRewoH6oJzsQp645sx9jYxr7+BqNg3s2ixKhKAJYwszSSa13IyIMgC6jI/pfTHOEzPEHHz3k0SKJ+yRrrLTbXevJyCzjqvFHbPW5PKLUaYK+CY4V93MBrnDHpjEmHC7XeUWNmbq3mOV6KfOhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557460; c=relaxed/simple;
	bh=d6wIdElBOLG6xQuvZ2bU9mvzEoZIWeAG2YgNqMUnmXw=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=jMkjjRoRPpfW5i2qnCAnaRMsyT70QNHxWNvDKtlNcSRb9HiK8zEIBAnRXGnZmK86sQ0wJPaaJhAVaMsIw5J/QO02jS0plHk1mj0qS3hHyEDhiidosQJjAfGX2v70Yg4YfvRQJwzJ6Z6T4pCIRvLhJC0Oh/fNbU8jX+EGY99RtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=INdOF+Rf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222411euoutp02c912c34f2c625b206f41e0d978d5fe81~EH7zefHWn0242202422euoutp02S
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250529222411euoutp02c912c34f2c625b206f41e0d978d5fe81~EH7zefHWn0242202422euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557451;
	bh=1ZbpOJ5cqo6u8v/Cxt565zQQp/mhmNI7EweztDD0hgk=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=INdOF+RfEFSSDdxXgb03n5NwmRKgpVTgTK1/EZwCkw21jLWXJeTO6RjCvGPAByNJz
	 QDRrPbGT3nTCdAd/wdI1p1xCKYSg5s4bErbmLPLvbH9yVjlTkRxfpw8yeLNV9fa7r1
	 QDwBcalGIRk1fXDlz5/TWi7pQnFsSNJyYQBtRlHk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944~EH7yOiEY10077600776eucas1p28;
	Thu, 29 May 2025 22:24:10 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222409eusmtip208fc59df153696657f5efe1ccf7cdbaa~EH7xUl_h23031530315eusmtip2N;
	Thu, 29 May 2025 22:24:09 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:54 +0200
Subject: [PATCH v3 7/8] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-7-83d5744d997c@samsung.com>
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
X-CMS-MailID: 20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944
X-EPHeader: CA
X-CMS-RootMailID: 20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944@eucas1p2.samsung.com>

Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
the GPU using the drm/imagination driver.

By adding this node, the kernel can recognize and initialize the GPU,
providing graphics acceleration capabilities on the Lichee Pi 4A and
other boards based on the TH1520 SoC.

Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
controlled programatically.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6170eec79e919b606a2046ac8f52db07e47ef441..ee937bbdb7c08439a70306f035b1cc82ddb4bae2 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -225,6 +225,13 @@ aonsys_clk: clock-73728000 {
 		#clock-cells = <0>;
 	};
 
+	gpu_mem_clk: mem-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "gpu_mem_clk";
+		#clock-cells = <0>;
+	};
+
 	stmmac_axi_config: stmmac-axi-config {
 		snps,wr_osr_lmt = <15>;
 		snps,rd_osr_lmt = <15>;
@@ -504,6 +511,21 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@ffef400000 {
+			compatible = "thead,th1520-gpu", "img,img-bxm-4-64",
+				     "img,img-rogue";
+			reg = <0xff 0xef400000 0x0 0x100000>;
+			interrupt-parent = <&plic>;
+			interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vo CLK_GPU_CORE>,
+				 <&gpu_mem_clk>,
+				 <&clk_vo CLK_GPU_CFG_ACLK>;
+			clock-names = "core", "mem", "sys";
+			power-domains = <&aon TH1520_GPU_PD>;
+			power-domain-names = "a";
+			resets = <&rst TH1520_RESET_ID_GPU>;
+		};
+
 		rst: reset-controller@ffef528000 {
 			compatible = "thead,th1520-reset";
 			reg = <0xff 0xef528000 0x0 0x4f>;

-- 
2.34.1


