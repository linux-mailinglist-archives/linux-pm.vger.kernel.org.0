Return-Path: <linux-pm+bounces-18459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BD9E1DE3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95054166551
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A671F4734;
	Tue,  3 Dec 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="heu+TRBy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8A1F4280
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233325; cv=none; b=EB3nbgKYJ39bEqnQ69JQRRlU1FL8A5xAjtfPvXRYCGPweHJyXlWRPk2D5ALKA/kYLDBrmxO19JUvmg1wNaqN6sfmfXGSlewnBZhgMHxqRU6hiMnMf5n/lmSSGMBxJZRUPZ/nseqrqA/cbgL3+m0rHDWEBHGbt8OveBNIFkurEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233325; c=relaxed/simple;
	bh=/8XEfny0FAe2wUqpCRK3PGVTg4J5SEm5ROdZaTcOlAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=LJxLOcM1ue8qm6W5eEpNOXZRiDw9bXDkKenzhtNBsZ52dM/puMRmL8D05CRQ7uUMDvcuSqaqaiqyucI1hncGY/TNVmxTmFdITTWr8Dx9GBmKfrza7p93pZnwgx29vxa5ckA1wy/mApRVjIuDBN9uxwdO3MXpLQABWMvUXhs1nWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=heu+TRBy; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134155euoutp0182af37b7a831e8e77f06fe6032335eed~NroRXOsVf2386523865euoutp01G
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241203134155euoutp0182af37b7a831e8e77f06fe6032335eed~NroRXOsVf2386523865euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233315;
	bh=ftJtjrtV1f+CN8Y0edQsq5ZTa846Imc3sylesI9yWLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heu+TRBy27PLRLo1UUHBiBEg/f6Bh8AF4/6dDCBNXZuikkZRr13AaZPBLvf8dGwW8
	 zaeWWMgsIvYMlVdx24vNoPzdALPZyJcPCn3LOoVd4WZ6tIKgiO2q5pVv5JA6fN+hsZ
	 vhdS4uvFIHucSrD/BO38wi33Bl+Zj1bJv+ZiO/V0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134154eucas1p2015ac2747f0d4c4b86a5fb5658eb2731~NroQ3CUnO2016720167eucas1p2-;
	Tue,  3 Dec 2024 13:41:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.CA.20821.2AA0F476; Tue,  3
	Dec 2024 13:41:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134154eucas1p12517024f618800141cd4e7e20e0da72d~NroQdUdOa1267312673eucas1p1z;
	Tue,  3 Dec 2024 13:41:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134154eusmtrp1f6533d8bc671769e5a3de5d80dacb10d~NroQcfCxW0887308873eusmtrp1J;
	Tue,  3 Dec 2024 13:41:54 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-68-674f0aa2d554
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.F6.19654.1AA0F476; Tue,  3
	Dec 2024 13:41:53 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134152eusmtip2f94341df43485e788fcf49425b4d1759~NroPHR5Hm2944429444eusmtip2O;
	Tue,  3 Dec 2024 13:41:52 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v1 04/14] clk: thead: Add clock driver for TH1520 Video
 Output subsystem
Date: Tue,  3 Dec 2024 14:41:27 +0100
Message-Id: <20241203134137.2114847-5-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjOuff23ktj9VIYPdENFcFMFz7V5EyclsXpFZiImSwuC6wZd9WM
	D9OCH9sYIIzPYkAhulKEESOMrDSD0gABKsioUKyzYOk2qGxhyJcQiiiwRWe5bPPf8z7v857n
	fd4cGhc3kBvp00kpnCJJluBDCglDz7LFv1oYJQ8qXZKgO0PVGGr6S02hH9otGKrstgiQw6rH
	0ODiHInq//yZQhPtmQSy1VZQKKtHR6JJtYNE8yqHAA20aki0UNQNkGEhm0Ta7hEK6RYrMfTd
	fBOBbjS3ApSTf1OA7ve9hyYHVDjKUW9AL9qaKfTc9iOBymeNFNLPlAiQSfshyjaWEtI32Dn7
	NxQ7MzlJsLfznlBs+9Mqgm1Rj1CsqqUfsA11+SQ7bGsj2eu90ezDQhPGNt5IZ7O1PRg71/GA
	ZC/p6wBrzRqi2Ebzl8fcPxLui+cSTp/lFIH7PxGeGrNN4Wcyjp7vq7iHZ4DGsALgRkNmNxwb
	XSILgJAWM7UAOp13ML54AqB+0QH4YgHA8sw+qgDQqyMj1bE8XwOgyVy8JpoBsPniFHC9SzIh
	cLSmUuBqeDLTOLQv/rJqgjOPADSMaUiXyoOJhbPPslcnCMYP5hvNq7yIOQCzBjQCfsPN0Nh5
	F3dhN0YKp8sKBLzGHfZ+O0a4MP5Sk9VUjrsMIKMVwpWrKxQ/fBD+1PA7zmMPOGXSr/GvQ/MV
	FcHjZDja5FzTfAVbVKY1HAqHLSukKzPO7IC61kCeDoODRtddXKdYD+2P3fkV1sPLhqs4T4tg
	Xo6YV2+HZaqi/0wttQaMxyycXtITxWCr+pUw6lfCqP/3rQJ4HZBwqcpEOacMTuLOBShlicrU
	JHnAp8mJDeDltzY/NzmbQcXUfEAXwGjQBSCN+3iKanQRcrEoXnbhC06RHKdITeCUXWATTfhI
	RH7xmzkxI5elcJ9z3BlO8W8Xo902ZmDnt5tvnzVeuZxSfMxwnUzr3MUMaUfLipnl8It1uu/7
	pc6SWuv0rF/k+EPGfit9276SE6HPonLlI12NkUHrqk7MRZwLlh8KuSmKCbzgdVfhHfN0b15p
	UMeOKjoqIfdB3a0tY74nB9reFYQXWt4fjag3yQKjQ8bVhhe+RzRxEXjygfQ3f/0gRrLSFyyd
	6Oy/lH7toKNX0+Ep2VI/GDlODe1qk8PQw8xvJ4/7Xyv8wzbhveGtDoHab79Xpk0Um5GbVr5X
	2v7ZOip1T9iylaIO+2L335bHDTu+Pvq3f8hjD432eJAlJmznvSOP3inq8QqXei8d+nh3+tbu
	XmGaPXp4T5R1k/01H0J5Sha8E1coZf8APWKGtkUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xe7oLufzTDVpvWFqcuL6IyWLr71ns
	Fmv2nmOymH/kHKvFvUtbmCyufH3PZrHu6QV2ixd7G1ksrq2Yy27RfGw9m8XLWffYLD723GO1
	uLxrDpvF594jjBbbPrewWaw9cpfdYv3X+UwWCz9uZbFYsmMXo0Vb5zJWi4unXC1eXu5htmib
	xW/xf88Odot/1zayWMx+t5/dYsubiawWx9eGW7Tsn8LiIOvx/kYru8ebly9ZPA53fGH32Ptt
	AYvHzll32T16dp5h9Ni0qpPN4861PWwe804GetzvPs7ksXlJvUfL2mNMHu/3XWXz6NuyitHj
	UvN1do/Np6sDBKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
	Uov07RL0Mp5ce8Vc0OBXcWrueeYGxs2OXYwcHBICJhJ3F8V1MXJyCAksZZQ4+MIQxJYQkJG4
	1v2SBcIWlvhzrYuti5ELqOYVo8T048vBEmwCRhIPls9nBUmICHSySLzdvJYRxGEWeMsocX3m
	RrAqYYEYiYfndzOB2CwCqhKd+0+zgdi8AvYSzZfnsEKskJfYf/AsM4jNKeAg8XpqFyvESfYS
	O/4eZoWoF5Q4OfMJ2ExmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpe
	cn7uJkZgUtl27OeWHYwrX33UO8TIxMF4iFGCg1lJhHf5eu90Id6UxMqq1KL8+KLSnNTiQ4ym
	QHdPZJYSTc4HprW8knhDMwNTQxMzSwNTSzNjJXFetivn04QE0hNLUrNTUwtSi2D6mDg4pRqY
	YgQ0yhl/bN9U/2dn9Qb2Z5UuRRx72srz/AI5U5zlmOece+/yh0nn5An26C6LN/51c0+urjxT
	bpXPKfhM+ABX3WPeCMuqAu9Hx20sXSz0F18TPXxoXV/m/4afnYs9z61kV9qzbmG7+AXuyk1t
	lZn7L/xS27f2Qn7lVCPp17HMD0XXL61euux65YN2p4x9H9SeLWwJnfV4x/8NEarbFsU3ZfRO
	sJ5vWrJ96bzrfxaEFk1I/uFjsUrH07Vgbeeip7abr9o6ySWfy1IO2cCq4lQhs69abvMZTbUM
	9epTRpXdDF/WxPj6NTH8//S0OUYoensMs2HopqLKGTV816L0zX4ErLV7zizwTfGOcLiZM78S
	S3FGoqEWc1FxIgD4HSclswMAAA==
X-CMS-MailID: 20241203134154eucas1p12517024f618800141cd4e7e20e0da72d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134154eucas1p12517024f618800141cd4e7e20e0da72d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134154eucas1p12517024f618800141cd4e7e20e0da72d
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134154eucas1p12517024f618800141cd4e7e20e0da72d@eucas1p1.samsung.com>

The Video Output (VO) module on the T-Head TH1520 SoC has its own set of
clocks that need proper management. This commit introduces the
clk-th1520-vo driver to support the VO subsystem clocks.

Currently, only the clock gates are implemented, as they are the primary
relevant clocks for the VO subsystem at this stage.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/Kconfig                    |  11 ++
 drivers/clk/thead/Makefile                   |   1 +
 drivers/clk/thead/clk-th1520-vo.c            | 168 +++++++++++++++++++
 include/dt-bindings/clock/thead,th1520-clk.h |  34 ++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/clk/thead/clk-th1520-vo.c

diff --git a/drivers/clk/thead/Kconfig b/drivers/clk/thead/Kconfig
index 95e0d9eb965e..937927a1a4b8 100644
--- a/drivers/clk/thead/Kconfig
+++ b/drivers/clk/thead/Kconfig
@@ -11,3 +11,14 @@ config CLK_THEAD_TH1520_AP
 	  on the T-HEAD TH1520 SoC. This includes configuration of
 	  both CPU PLLs, both DPU PLLs as well as the GMAC, VIDEO,
 	  and TEE PLLs.
+
+config CLK_THEAD_TH1520_VO
+	bool "T-HEAD TH1520 VO clock support"
+	depends on ARCH_THEAD || COMPILE_TEST
+	depends on 64BIT
+	default ARCH_THEAD
+	select REGMAP_MMIO
+	help
+	  Say yes here to support the VO sub system clock controller
+	  on the T-HEAD TH1520 SoC. This includes clock gates for the
+	  Video Output components like HDMI, MIPI, DPU and GPU.
diff --git a/drivers/clk/thead/Makefile b/drivers/clk/thead/Makefile
index d7cf88390b69..9afaee27b0b9 100644
--- a/drivers/clk/thead/Makefile
+++ b/drivers/clk/thead/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CLK_THEAD_TH1520_AP) += clk-th1520.o clk-th1520-ap.o
+obj-$(CONFIG_CLK_THEAD_TH1520_VO) += clk-th1520.o clk-th1520-vo.o
diff --git a/drivers/clk/thead/clk-th1520-vo.c b/drivers/clk/thead/clk-th1520-vo.c
new file mode 100644
index 000000000000..3c6d246ab53a
--- /dev/null
+++ b/drivers/clk/thead/clk-th1520-vo.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include "clk-th1520.h"
+
+#define NR_CLKS (CLK_HDMI_PIXCLK + 1)
+
+static const struct clk_parent_data video_pll_pd[] = {
+	/* TODO: provide a proper parent here */
+	NULL,
+};
+
+static CCU_GATE_REGMAP(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
+		       video_pll_pd, 0x50, BIT(0), 0);
+static CCU_GATE_REGMAP(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_pd,
+		       0x50, BIT(3), 0);
+static CCU_GATE_REGMAP(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
+		       video_pll_pd, 0x50, BIT(4), 0);
+static CCU_GATE_REGMAP(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
+		       video_pll_pd, 0x50, BIT(5), 0);
+static CCU_GATE_REGMAP(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
+		       video_pll_pd, 0x50, BIT(6), 0);
+static CCU_GATE_REGMAP(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_pd, 0x50,
+		       BIT(7), 0);
+static CCU_GATE_REGMAP(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_pd, 0x50,
+		       BIT(8), 0);
+static CCU_GATE_REGMAP(CLK_DPU_CCLK, dpu_cclk, "dpu-cclk", video_pll_pd, 0x50,
+		       BIT(9), 0);
+static CCU_GATE_REGMAP(CLK_HDMI_SFR, hdmi_sfr_clk, "hdmi-sfr-clk", video_pll_pd,
+		       0x50, BIT(10), 0);
+static CCU_GATE_REGMAP(CLK_HDMI_PCLK, hdmi_pclk, "hdmi-pclk", video_pll_pd,
+		       0x50, BIT(11), 0);
+static CCU_GATE_REGMAP(CLK_HDMI_CEC, hdmi_cec_clk, "hdmi-cec-clk", video_pll_pd,
+		       0x50, BIT(12), 0);
+static CCU_GATE_REGMAP(CLK_MIPI_DSI0_PCLK, mipi_dsi0_pclk, "mipi-dsi0-pclk",
+		       video_pll_pd, 0x50, BIT(13), 0);
+static CCU_GATE_REGMAP(CLK_MIPI_DSI1_PCLK, mipi_dsi1_pclk, "mipi-dsi1-pclk",
+		       video_pll_pd, 0x50, BIT(14), 0);
+static CCU_GATE_REGMAP(CLK_MIPI_DSI0_CFG, mipi_dsi0_cfg_clk,
+		       "mipi-dsi0-cfg-clk", video_pll_pd, 0x50, BIT(15), 0);
+static CCU_GATE_REGMAP(CLK_MIPI_DSI1_CFG, mipi_dsi1_cfg_clk,
+		       "mipi-dsi1-cfg-clk", video_pll_pd, 0x50, BIT(16), 0);
+static CCU_GATE_REGMAP(CLK_MIPI_DSI0_REFCLK, mipi_dsi0_refclk,
+		       "mipi-dsi0-refclk", video_pll_pd, 0x50, BIT(17), 0);
+static CCU_GATE_REGMAP(CLK_MIPI_DSI1_REFCLK, mipi_dsi1_refclk,
+		       "mipi-dsi1-refclk", video_pll_pd, 0x50, BIT(18), 0);
+static CCU_GATE_REGMAP(CLK_HDMI_I2S, hdmi_i2c_clk, "hdmi-i2c-clk", video_pll_pd,
+		       0x50, BIT(19), 0);
+static CCU_GATE_REGMAP(CLK_X2H_DPU1_ACLK, x2h_dpu1_aclk, "x2h-dpu1-aclk",
+		       video_pll_pd, 0x50, BIT(20), 0);
+static CCU_GATE_REGMAP(CLK_X2H_DPU_ACLK, x2h_dpu_aclk, "x2h-dpu-aclk",
+		       video_pll_pd, 0x50, BIT(21), 0);
+static CCU_GATE_REGMAP(CLK_AXI4_VO_PCLK, axi4_vo_pclk, "axi4-vo-pclk",
+		       video_pll_pd, 0x50, BIT(22), 0);
+static CCU_GATE_REGMAP(CLK_IOPMP_VOSYS_DPU_PCLK, iopmp_vosys_dpu_pclk,
+		       "iopmp-vosys-dpu-pclk", video_pll_pd, 0x50, BIT(23), 0);
+static CCU_GATE_REGMAP(CLK_IOPMP_VOSYS_DPU1_PCLK, iopmp_vosys_dpu1_pclk,
+		       "iopmp-vosys-dpu1-pclk", video_pll_pd, 0x50, BIT(24), 0);
+static CCU_GATE_REGMAP(CLK_IOPMP_VOSYS_GPU_PCLK, iopmp_vosys_gpu_pclk,
+		       "iopmp-vosys-gpu-pclk", video_pll_pd, 0x50, BIT(25), 0);
+static CCU_GATE_REGMAP(CLK_IOPMP_DPU1_ACLK, iopmp_dpu1_aclk, "iopmp-dpu1-aclk",
+		       video_pll_pd, 0x50, BIT(27), 0);
+static CCU_GATE_REGMAP(CLK_IOPMP_DPU_ACLK, iopmp_dpu_aclk, "iopmp-dpu-aclk",
+		       video_pll_pd, 0x50, BIT(28), 0);
+static CCU_GATE_REGMAP(CLK_IOPMP_GPU_ACLK, iopmp_gpu_aclk, "iopmp-gpu-aclk",
+		       video_pll_pd, 0x50, BIT(29), 0);
+static CCU_GATE_REGMAP(CLK_MIPIDSI0_PIXCLK, mipi_dsi0_pixclk,
+		       "mipi-dsi0-pixclk", video_pll_pd, 0x50, BIT(30), 0);
+static CCU_GATE_REGMAP(CLK_MIPIDSI1_PIXCLK, mipi_dsi1_pixclk,
+		       "mipi-dsi1-pixclk", video_pll_pd, 0x50, BIT(31), 0);
+static CCU_GATE_REGMAP(CLK_HDMI_PIXCLK, hdmi_pixclk, "hdmi-pixclk",
+		       video_pll_pd, 0x54, BIT(0), 0);
+
+static struct ccu_common *th1520_vo_gate_clks[] = {
+	&axi4_vo_aclk.common,
+	&gpu_core_clk.common,
+	&gpu_cfg_aclk.common,
+	&dpu0_pixelclk.common,
+	&dpu1_pixelclk.common,
+	&dpu_hclk.common,
+	&dpu_aclk.common,
+	&dpu_cclk.common,
+	&hdmi_sfr_clk.common,
+	&hdmi_pclk.common,
+	&hdmi_cec_clk.common,
+	&mipi_dsi0_pclk.common,
+	&mipi_dsi1_pclk.common,
+	&mipi_dsi0_cfg_clk.common,
+	&mipi_dsi1_cfg_clk.common,
+	&mipi_dsi0_refclk.common,
+	&mipi_dsi1_refclk.common,
+	&hdmi_i2c_clk.common,
+	&x2h_dpu1_aclk.common,
+	&x2h_dpu_aclk.common,
+	&axi4_vo_pclk.common,
+	&iopmp_vosys_dpu_pclk.common,
+	&iopmp_vosys_dpu1_pclk.common,
+	&iopmp_vosys_gpu_pclk.common,
+	&iopmp_dpu1_aclk.common,
+	&iopmp_dpu_aclk.common,
+	&iopmp_gpu_aclk.common,
+	&mipi_dsi0_pixclk.common,
+	&mipi_dsi1_pixclk.common,
+	&hdmi_pixclk.common
+};
+
+static int th1520_clk_vo_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct clk_hw_onecell_data *priv;
+	struct regmap *map;
+	struct clk_hw *hw;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, struct_size(priv, hws, NR_CLKS), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->num = NR_CLKS;
+
+	map = syscon_regmap_lookup_by_phandle(np, "thead,vosys-regmap");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	for (i = 0; i < ARRAY_SIZE(th1520_vo_gate_clks); i++) {
+		struct ccu_gate *cg = hw_to_ccu_gate(&th1520_vo_gate_clks[i]->hw);
+
+		th1520_vo_gate_clks[i]->map = map;
+
+		ret = devm_clk_hw_register(dev, &th1520_vo_gate_clks[i]->hw);
+		if (ret)
+			return ret;
+
+		priv->hws[cg->common.clkid] = hw;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id th1520_clk_vo_match[] = {
+	{
+		.compatible = "thead,th1520-clk-vo",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, th1520_clk_vo_match);
+
+static struct platform_driver th1520_clk_vo_driver = {
+	.probe		= th1520_clk_vo_probe,
+	.driver		= {
+		.name	= "th1520-clk-vo",
+		.of_match_table = th1520_clk_vo_match,
+	},
+};
+module_platform_driver(th1520_clk_vo_driver);
+
+MODULE_DESCRIPTION("T-HEAD TH1520 VO Clock driver");
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/clock/thead,th1520-clk.h b/include/dt-bindings/clock/thead,th1520-clk.h
index a199784b3512..86a7cf2c9acf 100644
--- a/include/dt-bindings/clock/thead,th1520-clk.h
+++ b/include/dt-bindings/clock/thead,th1520-clk.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_CLK_TH1520_H_
 #define _DT_BINDINGS_CLK_TH1520_H_
 
+/* AP clocks */
 #define CLK_CPU_PLL0		0
 #define CLK_CPU_PLL1		1
 #define CLK_GMAC_PLL		2
@@ -93,4 +94,37 @@
 #define CLK_SRAM3		83
 #define CLK_PLL_GMAC_100M	84
 #define CLK_UART_SCLK		85
+
+/* VO clocks */
+#define CLK_AXI4_VO_ACLK		0
+#define CLK_GPU_CORE			1
+#define CLK_GPU_CFG_ACLK		2
+#define CLK_DPU_PIXELCLK0		3
+#define CLK_DPU_PIXELCLK1		4
+#define CLK_DPU_HCLK			5
+#define CLK_DPU_ACLK			6
+#define CLK_DPU_CCLK			7
+#define CLK_HDMI_SFR			8
+#define CLK_HDMI_PCLK			9
+#define CLK_HDMI_CEC			10
+#define CLK_MIPI_DSI0_PCLK		11
+#define CLK_MIPI_DSI1_PCLK		12
+#define CLK_MIPI_DSI0_CFG		13
+#define CLK_MIPI_DSI1_CFG		14
+#define CLK_MIPI_DSI0_REFCLK		15
+#define CLK_MIPI_DSI1_REFCLK		16
+#define CLK_HDMI_I2S			17
+#define CLK_X2H_DPU1_ACLK		18
+#define CLK_X2H_DPU_ACLK		19
+#define CLK_AXI4_VO_PCLK		20
+#define CLK_IOPMP_VOSYS_DPU_PCLK	21
+#define CLK_IOPMP_VOSYS_DPU1_PCLK	22
+#define CLK_IOPMP_VOSYS_GPU_PCLK	23
+#define CLK_IOPMP_DPU1_ACLK		24
+#define CLK_IOPMP_DPU_ACLK		25
+#define CLK_IOPMP_GPU_ACLK		26
+#define CLK_MIPIDSI0_PIXCLK		27
+#define CLK_MIPIDSI1_PIXCLK		28
+#define CLK_HDMI_PIXCLK			29
+
 #endif
-- 
2.34.1


