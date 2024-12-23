Return-Path: <linux-pm+bounces-19665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AA9FAE78
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1381F1883ACE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E01B0F23;
	Mon, 23 Dec 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gPCpv0px"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C611ADFEC
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958576; cv=none; b=LX5AsoBTiq9f7SxWHOyhpBQL7tf3MBfMokFIlNZiNLEqZEXk9Ozsl6tzRK+8mnWz8jjH2szyOUJVgw9izEWVufZy6NBK6Bp4P1aHSjXrIz2ahNAWqI1U95RO+Kru0wMcqIh8C8oWa+yUQRRb9qSHKFdEfWWokHY13Sc5KO+2i3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958576; c=relaxed/simple;
	bh=7HoB4EfyjtSWBojQXWvvOT4GXrtm3bilNDnmRA8fsoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=izxa7YzANo5hF9pnowc8DquwCPbkuVunlEDyWFcjozn/yTeUQT2NiegLwlRe1vljXdCen5lSmwVrDxtRZiVEvKy8RtQcHq9EeLtLOqx5E9YrMAIRHn5/ln9nNAVzuXm3ci7wxVTjmLqo1qihtGffDhugP7zc+QcUsFBSzK9OJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gPCpv0px; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241223125604euoutp020e10bb1641a293bbc284f3260182b6c8~Tz589Ft090892808928euoutp023
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241223125604euoutp020e10bb1641a293bbc284f3260182b6c8~Tz589Ft090892808928euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734958564;
	bh=C4h9GPzlj4oI2Na2dbvVI9zIU+Tuq3m+5nlOyHoE5KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPCpv0pxHYbiyPjcbDr2vWclavPXakxiyerLA94SBT7E7tclloYj+P4st6jwEDYwJ
	 0iiAvGoCjNTSjHEGIxWHC/e7O6OB+It1Xvggtbgn3HqlDpn1kcXfHIiPOurqlrdTiC
	 fX0KYVf8rDb10sF8KFGMopYYdxxnVHffi1HsxyRM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241223125603eucas1p226a97648f9f4a66e535bed10fb7d5b37~Tz58cnoFE1741317413eucas1p2E;
	Mon, 23 Dec 2024 12:56:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.B6.20821.3ED59676; Mon, 23
	Dec 2024 12:56:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125603eucas1p26a140c47956d7901c08cb06e7be744c7~Tz58AM8wL1741317413eucas1p2D;
	Mon, 23 Dec 2024 12:56:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241223125603eusmtrp110cc28fd2ac2a4f025daa40d3fd19db1~Tz57-aGCe2059320593eusmtrp1Y;
	Mon, 23 Dec 2024 12:56:03 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-63-67695de3732d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.73.19654.3ED59676; Mon, 23
	Dec 2024 12:56:03 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125601eusmtip2baa8c26bb05f02aa7809fd2cddbadee5~Tz56pkl5p3253332533eusmtip2X;
	Mon, 23 Dec 2024 12:56:01 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v2 02/19] clk: thead: Add clock support for VO subsystem
 in T-Head TH1520 SoC
Date: Mon, 23 Dec 2024 13:55:36 +0100
Message-Id: <20241223125553.3527812-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223125553.3527812-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Pw/OMXYPHifJFCIQSkAyh8+B7aUkI51NxZ9116nmnMeQB
	d8HQTaw8TAgYgjPURcT4MSSURUxyjsV2EuecDEKXsJiojDjBFIKQXxp0UIwHy/9e38/7/fm+
	P5/vfXm4UE+u4Yklh1mpRJQWRPIJQ9us7bXBveLUiI77waj9dg2Gmv5WUaihxYYhtcXmhvq7
	9Rj6dWacRBcf3KLQo5YcAjk0lRTKbWsk0bCqn0QTin43ZDdVkGjqlAUgw1QeibQWJ4UaZ9QY
	OjfRRKDaZhNA8sILbqjr53jk7G8n0LBdgSO5yhP9c6WZQguOSwQq/7OVQvrRM27Iqt2F8lq/
	ImL8mfHefIoZHR4mmGsnpimm5Uk1wRhVTopRGG8ARldfSDJ9jiskU9XxAfPbSSvGXK49zuRp
	2zCmeD6CGf+ph2S+1NcDpjv3NvW+cA9/SzKbJj7CSje+lcg/oMw5Cw464j51GH4H2cD4RhFw
	50F6EzxZUoEXAT5PSGsAXCh2Ei5BSE8DON0VwglTANY06rBnHaraWyQn1AHYaVID7jAKYKGt
	DLhcJP06HKhTu7kELzqfgPnXc5ZcOP0QQMNQBelyraT3w1mtcjGQxyPodfDudJYLBfRWqCnc
	waUFwNarN3EXu9MxsKGod+l+Ab0CdpQNLY2KL3pym8qXdoD0JT5s1n6Pc81xsEd1geB4JRyx
	6imO/WCnUrFcz4ADTZPL/ixoVFiXeTPss82Rrnlwej1sNG10IaTfhmVlL3HoAXvHVnATeMCz
	hlKcKwvgCbmQuyMYlihO/Zdp0xiWn5CBNyqridMgUPXcLqrndlH9H1sN8HrgzWbK0lNZWaSE
	/SRcJkqXZUpSw/dnpOvA4sfuXLBONoPKkYlwM8B4wAwgDw/yEpiF4lShIFn02VFWmvGRNDON
	lZmBL48I8hasSw5ghXSq6DD7McseZKXPVIznviYbOyQeXNV9f+SPIfDh9QLP0a1ex4D+Teh9
	fq19YlPCL553Cny2x0QQPqpDoWPeVdHBolfqSyxJLwYC3zpwzGPz8LawFLqq7z1Mm/1ttMIW
	Lzh387sd+9buDmdao7qUcVcnHkRrc3W7Hnk7jZkdSXmrx47uvVc6+HLIEY9Qs/+7nRcfHxds
	/2Y9XyPfJpjDZy0Rl7XKscjYpz+MJMbuNO0z1k3++FeA/UxbQs7caq/S3edjCzYQ5QNJ81Qw
	updyTS25u0cQk1DkE5VSs0GT+LTdPxC+s7M3LET+Qnxdlt+rPjM2X/s4lhSq/px4+HhLfIVf
	Q9WTnju+04Ff6JSnZ+ajV0V9XRxEyA6IIsNwqUz0L4XP8bpHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xe7qPYzPTDb594bI4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVrcvXeCxeLl
	5R5mi7ZZ/Bb/9+xgt/h3bSOLxex3+9kttryZyGpxfG24Rcv+KSwOch7vb7Sye7x5+ZLF43DH
	F3aPvd8WsHjsnHWX3aNn5xlGj02rOtk87lzbw+Yx72Sgx/3u40wem5fUe7SsPcbk0f/XwOP9
	vqtsHn1bVjF6XGq+zh4gFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXMblxEmPBNZeKa9ueMTYw7rTqYuTkkBAwkZi15AJbFyMXh5DAUkaJ/ZOO
	sEAkZCSudb+EsoUl/lzrgip6xSjx9tUFJpAEm4CRxIPl81lBbBGBxSwSe/dVghQxC7xllLg+
	cyNYt7BAokTjmx1ANgcHi4CqxK0vNSAmr4C9xIpOf4j58hL7D55lBrE5BRwk1nTdYASxhYBK
	/p36wAZi8woISpyc+QRsIjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQv
	XS85P3cTIzC5bDv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe0goM12INyWxsiq1KD++qDQntfgQ
	oynQ1ROZpUST84HpLa8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6p
	BqYo/mPCx1d1hFdkfLO54nBtK/epoJbXaXuV7Tb9YLtrVLXi86eYs3dtivf+8tO90PjBiXPW
	3YrL3Ex6R20sq7o6F+yyspv43VD/dUKlwfHsk/Ovnbge5euVXDuXdXucpfQ507U3uGxYF/TF
	rj+xIOZ03qornBzPMrhE5TRVJil9eCPvNq3vw9P/Xyb9kNu/xVq7/PIfkYCUuZrdpzNWJV27
	wmPKti7vx0/m2MUFGerr5/RIWqaxbg9ef7BXbw+/INO1LSXLfRob3137ER9xRyGmNciY84NN
	rxfL9oe9IvkypsuPujRtFhe14E1jyZZ5Nl1I2WVPeDvL8qfOJ+Lsr4rZX/dhOLdyo8qT/57z
	viqxFGckGmoxFxUnAgCWyKIBtwMAAA==
X-CMS-MailID: 20241223125603eucas1p26a140c47956d7901c08cb06e7be744c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125603eucas1p26a140c47956d7901c08cb06e7be744c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125603eucas1p26a140c47956d7901c08cb06e7be744c7
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125603eucas1p26a140c47956d7901c08cb06e7be744c7@eucas1p2.samsung.com>

The T-Head TH1520 SoC integrates a variety of clocks for its subsystems,
including the Application Processor (AP) and the Video Output (VO) [1].
Up until now, the T-Head clock driver only supported AP clocks.

This commit extends the driver to provide clock functionality for the VO
subsystem. At this stage, the focus is on implementing the VO clock
gates, as these are currently the most relevant and required components
for enabling and disabling the VO subsystem functionality. Future
enhancements may introduce additional VO-related clocks as necessary.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/clk-th1520-ap.c | 160 ++++++++++++++++++++++++++----
 1 file changed, 142 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 17e32ae08720..b3c719d4f4ac 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -840,6 +840,67 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
 static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
 static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
 
+static CCU_GATE(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
+		video_pll_clk_pd, 0x0, BIT(0), 0);
+static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
+		0x0, BIT(3), 0);
+static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
+		video_pll_clk_pd, 0x0, BIT(4), 0);
+static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
+		video_pll_clk_pd, 0x0, BIT(5), 0);
+static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
+		video_pll_clk_pd, 0x0, BIT(6), 0);
+static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
+		BIT(7), 0);
+static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,
+		BIT(8), 0);
+static CCU_GATE(CLK_DPU_CCLK, dpu_cclk, "dpu-cclk", video_pll_clk_pd, 0x0,
+		BIT(9), 0);
+static CCU_GATE(CLK_HDMI_SFR, hdmi_sfr_clk, "hdmi-sfr-clk", video_pll_clk_pd,
+		0x0, BIT(10), 0);
+static CCU_GATE(CLK_HDMI_PCLK, hdmi_pclk, "hdmi-pclk", video_pll_clk_pd, 0x0,
+		BIT(11), 0);
+static CCU_GATE(CLK_HDMI_CEC, hdmi_cec_clk, "hdmi-cec-clk", video_pll_clk_pd,
+		0x0, BIT(12), 0);
+static CCU_GATE(CLK_MIPI_DSI0_PCLK, mipi_dsi0_pclk, "mipi-dsi0-pclk",
+		video_pll_clk_pd, 0x0, BIT(13), 0);
+static CCU_GATE(CLK_MIPI_DSI1_PCLK, mipi_dsi1_pclk, "mipi-dsi1-pclk",
+		video_pll_clk_pd, 0x0, BIT(14), 0);
+static CCU_GATE(CLK_MIPI_DSI0_CFG, mipi_dsi0_cfg_clk, "mipi-dsi0-cfg-clk",
+		video_pll_clk_pd, 0x0, BIT(15), 0);
+static CCU_GATE(CLK_MIPI_DSI1_CFG, mipi_dsi1_cfg_clk, "mipi-dsi1-cfg-clk",
+		video_pll_clk_pd, 0x0, BIT(16), 0);
+static CCU_GATE(CLK_MIPI_DSI0_REFCLK, mipi_dsi0_refclk, "mipi-dsi0-refclk",
+		video_pll_clk_pd, 0x0, BIT(17), 0);
+static CCU_GATE(CLK_MIPI_DSI1_REFCLK, mipi_dsi1_refclk, "mipi-dsi1-refclk",
+		video_pll_clk_pd, 0x0, BIT(18), 0);
+static CCU_GATE(CLK_HDMI_I2S, hdmi_i2c_clk, "hdmi-i2c-clk", video_pll_clk_pd,
+		0x0, BIT(19), 0);
+static CCU_GATE(CLK_X2H_DPU1_ACLK, x2h_dpu1_aclk, "x2h-dpu1-aclk",
+		video_pll_clk_pd, 0x0, BIT(20), 0);
+static CCU_GATE(CLK_X2H_DPU_ACLK, x2h_dpu_aclk, "x2h-dpu-aclk",
+		video_pll_clk_pd, 0x0, BIT(21), 0);
+static CCU_GATE(CLK_AXI4_VO_PCLK, axi4_vo_pclk, "axi4-vo-pclk",
+		video_pll_clk_pd, 0x0, BIT(22), 0);
+static CCU_GATE(CLK_IOPMP_VOSYS_DPU_PCLK, iopmp_vosys_dpu_pclk,
+		"iopmp-vosys-dpu-pclk", video_pll_clk_pd, 0x0, BIT(23), 0);
+static CCU_GATE(CLK_IOPMP_VOSYS_DPU1_PCLK, iopmp_vosys_dpu1_pclk,
+		"iopmp-vosys-dpu1-pclk", video_pll_clk_pd, 0x0, BIT(24), 0);
+static CCU_GATE(CLK_IOPMP_VOSYS_GPU_PCLK, iopmp_vosys_gpu_pclk,
+		"iopmp-vosys-gpu-pclk", video_pll_clk_pd, 0x0, BIT(25), 0);
+static CCU_GATE(CLK_IOPMP_DPU1_ACLK, iopmp_dpu1_aclk, "iopmp-dpu1-aclk",
+		video_pll_clk_pd, 0x0, BIT(27), 0);
+static CCU_GATE(CLK_IOPMP_DPU_ACLK, iopmp_dpu_aclk, "iopmp-dpu-aclk",
+		video_pll_clk_pd, 0x0, BIT(28), 0);
+static CCU_GATE(CLK_IOPMP_GPU_ACLK, iopmp_gpu_aclk, "iopmp-gpu-aclk",
+		video_pll_clk_pd, 0x0, BIT(29), 0);
+static CCU_GATE(CLK_MIPIDSI0_PIXCLK, mipi_dsi0_pixclk, "mipi-dsi0-pixclk",
+		video_pll_clk_pd, 0x0, BIT(30), 0);
+static CCU_GATE(CLK_MIPIDSI1_PIXCLK, mipi_dsi1_pixclk, "mipi-dsi1-pixclk",
+		video_pll_clk_pd, 0x0, BIT(31), 0);
+static CCU_GATE(CLK_HDMI_PIXCLK, hdmi_pixclk, "hdmi-pixclk", video_pll_clk_pd,
+		0x4, BIT(0), 0);
+
 static CLK_FIXED_FACTOR_HW(gmac_pll_clk_100m, "gmac-pll-clk-100m",
 			   &gmac_pll_clk.common.hw, 10, 1, 0);
 
@@ -956,7 +1017,40 @@ static struct ccu_common *th1520_gate_clks[] = {
 	&sram3_clk.common,
 };
 
-#define NR_CLKS	(CLK_UART_SCLK + 1)
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
+#define NR_CLKS	(CLK_HDMI_PIXCLK + 1)
 
 static const struct regmap_config th1520_clk_regmap_config = {
 	.reg_bits = 32,
@@ -965,13 +1059,40 @@ static const struct regmap_config th1520_clk_regmap_config = {
 	.fast_io = true,
 };
 
+static int th1520_add_gate_clocks(struct device *dev,
+				  struct clk_hw_onecell_data *priv,
+				  struct regmap *map, void __iomem *base,
+				  struct ccu_common **gate_clks,
+				  size_t gate_clks_size)
+{
+	struct clk_hw *hw;
+	int i;
+
+	for (i = 0; i < gate_clks_size; i++) {
+		struct ccu_gate *cg = hw_to_ccu_gate(&gate_clks[i]->hw);
+
+		gate_clks[i]->map = map;
+
+		hw = devm_clk_hw_register_gate_parent_data(
+			dev, cg->common.hw.init->name,
+			cg->common.hw.init->parent_data, 0,
+			base + cg->common.cfg0, ffs(cg->enable) - 1, 0, NULL);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		priv->hws[cg->common.clkid] = hw;
+	}
+
+	return 0;
+}
+
 static int th1520_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct clk_hw_onecell_data *priv;
 
-	struct regmap *map;
-	void __iomem *base;
+	struct regmap *map, *map_vosys;
+	void __iomem *base, *base_vosys;
 	struct clk_hw *hw;
 	int ret, i;
 
@@ -981,14 +1102,22 @@ static int th1520_clk_probe(struct platform_device *pdev)
 
 	priv->num = NR_CLKS;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_ioremap_resource_byname(pdev, "ap-clks");
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	base_vosys = devm_platform_ioremap_resource_byname(pdev, "vo-clks");
+	if (IS_ERR(base_vosys))
+		return PTR_ERR(base_vosys);
+
 	map = devm_regmap_init_mmio(dev, base, &th1520_clk_regmap_config);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
+	map_vosys = devm_regmap_init_mmio(dev, base_vosys, &th1520_clk_regmap_config);
+	if (IS_ERR(map_vosys))
+		return PTR_ERR(map_vosys);
+
 	for (i = 0; i < ARRAY_SIZE(th1520_pll_clks); i++) {
 		struct ccu_pll *cp = hw_to_ccu_pll(&th1520_pll_clks[i]->hw);
 
@@ -1033,21 +1162,16 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		priv->hws[cm->common.clkid] = hw;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(th1520_gate_clks); i++) {
-		struct ccu_gate *cg = hw_to_ccu_gate(&th1520_gate_clks[i]->hw);
-
-		th1520_gate_clks[i]->map = map;
-
-		hw = devm_clk_hw_register_gate_parent_data(dev,
-							   cg->common.hw.init->name,
-							   cg->common.hw.init->parent_data,
-							   0, base + cg->common.cfg0,
-							   ffs(cg->enable) - 1, 0, NULL);
-		if (IS_ERR(hw))
-			return PTR_ERR(hw);
+	ret = th1520_add_gate_clocks(dev, priv, map, base, th1520_gate_clks,
+				     ARRAY_SIZE(th1520_gate_clks));
+	if (ret)
+		return ret;
 
-		priv->hws[cg->common.clkid] = hw;
-	}
+	ret = th1520_add_gate_clocks(dev, priv, map_vosys, base_vosys,
+				     th1520_vo_gate_clks,
+				     ARRAY_SIZE(th1520_vo_gate_clks));
+	if (ret)
+		return ret;
 
 	ret = devm_clk_hw_register(dev, &osc12m_clk.hw);
 	if (ret)
-- 
2.34.1


