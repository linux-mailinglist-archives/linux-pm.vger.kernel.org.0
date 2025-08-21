Return-Path: <linux-pm+bounces-32845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8EB3091D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 00:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EFF188FD60
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9AD2EBDEB;
	Thu, 21 Aug 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nnANpXzv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933742EB5D9
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814828; cv=none; b=GHoSc3+NBX5fqjta4luH/f5pJbFDehZegZTPPoDBewaZ65//Labr0qH9I9jlkDEgXWsDG0+oGTv5+3tH5AWOKxC8fseVejGGeXzA8X5w/cYgdozKD7y71w09SKAocUl70C20sqo40rEeYE4o01EviPl4Qu29ThFy8BdJ9CVQjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814828; c=relaxed/simple;
	bh=E2D0ojtfQfljt2g5BHZXaTgJQmrEQSnKvsQlN8vt+E8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=aGqX/NquImEssJByzvyGv4l2AFx5UXtIsCJoSsS5f7ArS6zWFIno7m718AfT7o836eveYEhRiRH2QTki17OUJED7PD6u+qLnw1ODpJl7yhgdNx/n4Bh7PlylsbBdsY7x002nhCHT3SIasLdl8ZoyZjETGKdZkGzd7Y9VinwMz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nnANpXzv; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250821222024euoutp025c7d700011d4e8cb42ed14e78a41da7e~d6Ee7CaK22846128461euoutp02N
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250821222024euoutp025c7d700011d4e8cb42ed14e78a41da7e~d6Ee7CaK22846128461euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755814824;
	bh=gneCQrlXfCS1M6JHy2pbR2786RoUV1TLbG9pNyV9Yj8=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=nnANpXzv9oOqMltL6sRyrhFj1THhUudYIYJIzTaNdIpB+xlG7FFdULNxjCxZ4yccT
	 PtNeIkd6jDNLG/JbGLsZDDpwNiP44CUZEPV8W4dB6R0blCXQ3Xfey6qA56bQz2yFqJ
	 MWwDk/MbRSmtjMYRFA/TTuj1CgtVgsRKIJ+0IOgM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250821222023eucas1p1805feda41e485de76c2981beb8b9102d~d6EdsDJTp2014520145eucas1p1N;
	Thu, 21 Aug 2025 22:20:23 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250821222022eusmtip148e5e33dfe91c2cac87b80f46bf4dbb4~d6EcsLE760253902539eusmtip1N;
	Thu, 21 Aug 2025 22:20:22 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 22 Aug 2025 00:20:17 +0200
Subject: [PATCH v13 3/4] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-apr_14_for_sending-v13-3-af656f7cc6c3@samsung.com>
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
X-CMS-MailID: 20250821222023eucas1p1805feda41e485de76c2981beb8b9102d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250821222023eucas1p1805feda41e485de76c2981beb8b9102d
X-EPHeader: CA
X-CMS-RootMailID: 20250821222023eucas1p1805feda41e485de76c2981beb8b9102d
References: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
	<CGME20250821222023eucas1p1805feda41e485de76c2981beb8b9102d@eucas1p1.samsung.com>

Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
the GPU using the drm/imagination driver.

By adding this node, the kernel can recognize and initialize the GPU,
providing graphics acceleration capabilities on the Lichee Pi 4A and
other boards based on the TH1520 SoC.

Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
controlled programatically.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Drew Fustini <drew@pdp7.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42724bf7e90e08fac326c464d0f080e3bd2cd59b..6ae5c632205ba63248c0a119c03bdfc084aac7a0 100644
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
@@ -500,6 +507,20 @@ clk: clock-controller@ffef010000 {
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
+			resets = <&rst TH1520_RESET_ID_GPU>;
+		};
+
 		rst: reset-controller@ffef528000 {
 			compatible = "thead,th1520-reset";
 			reg = <0xff 0xef528000 0x0 0x4f>;

-- 
2.34.1


