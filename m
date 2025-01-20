Return-Path: <linux-pm+bounces-20703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F62A17159
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA317A242D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93701EE7D8;
	Mon, 20 Jan 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FqVzm7A1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B915B102
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393692; cv=none; b=halVqt7KB0S3KHvxzag9loEutsi6Nq/zStZEgIPY6H92S6mCNf7FOjXJMU8SqkNpXPR/7S7mwvG2vdYny7Fwh/Tdt958knWVzvf6nmGMNnnpVZG+D5Pc3geK4+4JRxBIXvsdWoJclBBPDfyhN4i4CFSuRvm1mEBEIpTw+2BXFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393692; c=relaxed/simple;
	bh=OkuBQZaAVBT0Dm+hNqE4oDuRvp5FbMhpSSXRXGMdr1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JNGumULoFhTQHkNNRktRPRZhChLAMHm8Loq0/8wzn0wjWZrKbNV3a1VdplVJvPNDdErnTLaSG/y8wEwQ2bdL/TXYcmplki471eBUt5puwRUiOdO2S37+yCQkZXPN9GEaqE5srhLrhfrfuLMQjqGIAdETRt3Ca5bVJsj5533Q/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FqVzm7A1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250120172123euoutp0190b0e40eb643b87bd3847983c2bb5f9e~cdlmamNwi2431224312euoutp01G
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250120172123euoutp0190b0e40eb643b87bd3847983c2bb5f9e~cdlmamNwi2431224312euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737393683;
	bh=0ETZ637pDMV7GrYjE/vZu7/autur8GcFWWIpYOcLCQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqVzm7A1DvRuGQ+WD8RVjgaHGW/WZNrDvn7ADxuAm9CxTK/dZAuM7SC5ixWQn8SOz
	 i/XJb4MYqpSE4dnswOZ2jDgyGfKiOcTFLX4TW4WJjfblJ9EUg+j1cXZcEIj6iuaA5C
	 vCBtGyg8DYjd8XwXJdUjrihE/kqdOfHEf2jvvBBE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250120172122eucas1p1f0f947143efe3c08e6d9e273ccc69a3e~cdll4ybSz0936109361eucas1p1Z;
	Mon, 20 Jan 2025 17:21:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.66.20409.2168E876; Mon, 20
	Jan 2025 17:21:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250120172121eucas1p24ed47f684da5f1dcf0df7735e21f2b4c~cdlk9kNL11089910899eucas1p2q;
	Mon, 20 Jan 2025 17:21:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250120172121eusmtrp2c870ca6fdedf79b556f49f9b2170fd57~cdlk6yscY0490804908eusmtrp2b;
	Mon, 20 Jan 2025 17:21:21 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-bb-678e8612db2a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.95.19654.1168E876; Mon, 20
	Jan 2025 17:21:21 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172120eusmtip1e9d3558706edcb5753a4f7e294197100~cdljmdK_p1308113081eusmtip1Y;
	Mon, 20 Jan 2025 17:21:20 +0000 (GMT)
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
Subject: [RFC v3 02/18] clk: thead: Add clock support for VO subsystem in
 T-Head TH1520 SoC
Date: Mon, 20 Jan 2025 18:20:55 +0100
Message-Id: <20250120172111.3492708-3-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120172111.3492708-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG9957ubd0K16rzlcxU2Ho2CY69vVmGIUE8ZLFTKcBpyGjmXfV
	8VHSCkxnIlDAwkpFgqEUXFnnoOsEIpaOEigBocgmZQMtHQJlG4goUFlBp4gMuHXzv+ec8zt5
	npMcHi78iVzLO5Z4nJUmiuL9SD5hsj7q2iLMVom3pU28ia716jBUO6uh0KVGG4a0rTYvNNht
	xNCNGReJqkZ+pdCdxnQC2fUXKCS3VpNoTDNIoinloBfqqS8lkTuvFSCTO5NEla0DFKqe0WLo
	26laAl2sqwcoO6fcC/328y40MHiNQGM9Shxla5ah+YY6Cj21XyZQyWQThYzj57xQe2U0ymwq
	JEJfYVyOLIoZHxsjmKuKaYppfFBGMGbNAMUozdcBU2PIIZl+ewPJfNOxj3F+3Y4xVy6eZjIr
	rRhzdm4b47LcJBmV0QCYbnkvtVd4iL/9CBt/LIWVbt0Ryz96x+oikyYPfml0x6WBGx/mAm8e
	pN+Bs09+98oFfJ6Q1gNYobQQXDENYIemxDNxA+h4YiOerRj+0HmoCgBnzvwIuGIcwEvDKmqR
	IulgOFShXVpfSWcRMKstfYnC6VEATcOl5CK1go6BDkU+tqgJOgAqXFNLWkDvhGr7NMn5rYdN
	zZ34ovamQ+HDm40UxyyHHcXDS5nwBUZeW4IvGkD6Mh8qp8o8YcPho+46nNMr4N12I8XpdXDe
	rMU4LYFDtX97mFPQrGz36BDYb3u8EIK3YBAIq+u3cu0wWK8rX2pD2gc6JpZzEXxggakI59oC
	qMgWcvQmeF6Z95+pTW/ymDJwqLmAygcbNc8do3nuGM3/vmUAN4DVbLIsQczKghPZ1CCZKEGW
	nCgO+kySUAMWfvuXp+3TdaDi7lRQC8B4oAVAHu63UrDqvlIsFBwRnTjJSiWfSpPjWVkL8OUR
	fqsFuqYssZAWi46zcSybxEqfTTGe99o0LKUgcLRw3/0Q1Rhdqr3151cF1z8XzF6hseHAIf2E
	OPzVA3OpIf6TFZb1u0whUWczonTLLHOa04df2HTy9oXW/fwkp70vYre/ImDD+fE18pbcqJqR
	Il9N35n8vW2usJg4Jf/ew/nu1x7Iv2+Rhr03Itng/0XgrOT2YcGe/qLyx8aq8KGNn0jf3Zwq
	UIZa1NYPfF2dEboqtcIa2xwZZbWvyzxQqt7hEJPb85x5RHF02wm3eY0zwyYOSykWHtr5g/mj
	GFNGTYQ6MSc1+P0+n6vzL62yfCdTVd/6Z1RyLnnPy9Hpb0cWzntLNt+resP58eSpzi2Gg381
	+AcYYnu6evdHarte1Gf4EbKjordex6Uy0b9ElNYcSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xu7qCbX3pBh3n9C1OXF/EZLH19yx2
	izV7zzFZzD9yjtXi3qUtTBZXvr5ns1j39AK7xYu9jSwW11bMZbdoPraezeLlrHtsFh977rFa
	XN41h83ic+8RRottn1vYLNYeuctusf7rfCaLhR+3slgs2bGL0aKtcxmrxcVTrhZ3751gsXh5
	uYfZom0Wv8X/PTvYLf5d28hiMfvdfnaLLW8mslocXxtu0bJ/CouDnMf7G63sHm9evmTxONzx
	hd1j77cFLB47Z91l9+jZeYbRY9OqTjaPO9f2sHnMOxnocb/7OJPH5iX1Hi1rjzF59P818Hi/
	7yqbR9+WVYwel5qvswcIRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehlvDj2nq3gXUTFls/ZDYxXvLsYOTkkBEwkVj1cxNLFyMUhJLCUUeLJuenM
	EAkZiWvdL1kgbGGJP9e62CCKXjFKrP93GSzBJmAk8WD5fFYQW0RgMYvE3n2VIEXMAm8ZJa7P
	3AhUxMEhLBAt0bZUDaSGRUBVouP9RyYQm1fAXmLGtS9sEAvkJfYfPAu2mFPAQeL71b3sILYQ
	UM2dq92MEPWCEidnPgHbywxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L
	10vOz93ECEwu24793LKDceWrj3qHGJk4GA8xSnAwK4nwin7oSRfiTUmsrEotyo8vKs1JLT7E
	aAp090RmKdHkfGB6yyuJNzQzMDU0MbM0MLU0M1YS52W7cj5NSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gcl0u/dq9q9S29hYVKaxlWSVhsfN23Wo4ffq+j8fV4crsheos1VyZb04tunPzOv7Lhuwvao8
	0fvpAJNq3L6ZITf5lu+oe3/tvdiuSaeWu951vcD7e++UkMsWGze+j5v1U8Uu/PnPjucbPkY5
	bmBY33Xbg1M4j3Pv1ONv1Dw3yk68LfF6q05He3uYqcKChruzmXWMMsqvl3+wjihZE1VkG3dn
	wTLzudmMenpSa5M8V1iYmK37wzfJa/nRe37W2yYKOgadqLjY9ba/4g+72OUVq9IPuTMWnk/S
	+VbrzpxuGp82IWfdJmvf4DLrlCl9cnckvCTq5qc3m+mZXTZhX3P7wTfrB3JBa1dvnfbxRG3T
	vOdKLMUZiYZazEXFiQDbGQmgtwMAAA==
X-CMS-MailID: 20250120172121eucas1p24ed47f684da5f1dcf0df7735e21f2b4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172121eucas1p24ed47f684da5f1dcf0df7735e21f2b4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172121eucas1p24ed47f684da5f1dcf0df7735e21f2b4c
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172121eucas1p24ed47f684da5f1dcf0df7735e21f2b4c@eucas1p2.samsung.com>

The T-Head TH1520 SoC integrates a variety of clocks for its subsystems,
including the Application Processor (AP) and the Video Output (VO) [1].
Up until now, the T-Head clock driver only supported AP clocks.

This commit extends the driver to provide clock functionality for the VO
subsystem. At this stage, the focus is on implementing the VO clock
gates, as these are currently the most relevant and required components
for enabling and disabling the VO subsystem functionality.  Future
enhancements may introduce additional VO-related clocks as necessary.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/clk-th1520-ap.c | 197 +++++++++++++++++++++++++-----
 1 file changed, 169 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 1015fab95251..2897b732624b 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -847,6 +847,67 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
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
+static CCU_GATE(CLK_HDMI_I2S, hdmi_i2s_clk, "hdmi-i2s-clk", video_pll_clk_pd,
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
 
@@ -963,7 +1024,38 @@ static struct ccu_common *th1520_gate_clks[] = {
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
+	&hdmi_i2s_clk.common,
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
 
 static const struct regmap_config th1520_clk_regmap_config = {
 	.reg_bits = 32,
@@ -972,8 +1064,44 @@ static const struct regmap_config th1520_clk_regmap_config = {
 	.fast_io = true,
 };
 
+struct th1520_plat_data {
+	struct ccu_common **th1520_pll_clks;
+	struct ccu_common **th1520_div_clks;
+	struct ccu_common **th1520_mux_clks;
+	struct ccu_common **th1520_gate_clks;
+
+	int nr_clks;
+	int nr_pll_clks;
+	int nr_div_clks;
+	int nr_mux_clks;
+	int nr_gate_clks;
+};
+
+static const struct th1520_plat_data th1520_ap_platdata = {
+	.th1520_pll_clks = th1520_pll_clks,
+	.th1520_div_clks = th1520_div_clks,
+	.th1520_mux_clks = th1520_mux_clks,
+	.th1520_gate_clks = th1520_gate_clks,
+
+	.nr_clks = CLK_UART_SCLK + 1,
+
+	.nr_pll_clks = ARRAY_SIZE(th1520_pll_clks),
+	.nr_div_clks = ARRAY_SIZE(th1520_div_clks),
+	.nr_mux_clks = ARRAY_SIZE(th1520_mux_clks),
+	.nr_gate_clks = ARRAY_SIZE(th1520_gate_clks),
+};
+
+static const struct th1520_plat_data th1520_vo_platdata = {
+	.th1520_gate_clks = th1520_vo_gate_clks,
+
+	.nr_clks = CLK_HDMI_PIXCLK + 1,
+
+	.nr_gate_clks = ARRAY_SIZE(th1520_vo_gate_clks),
+};
+
 static int th1520_clk_probe(struct platform_device *pdev)
 {
+	const struct th1520_plat_data *plat_data;
 	struct device *dev = &pdev->dev;
 	struct clk_hw_onecell_data *priv;
 
@@ -982,11 +1110,17 @@ static int th1520_clk_probe(struct platform_device *pdev)
 	struct clk_hw *hw;
 	int ret, i;
 
-	priv = devm_kzalloc(dev, struct_size(priv, hws, NR_CLKS), GFP_KERNEL);
+	plat_data = device_get_match_data(&pdev->dev);
+	if (!plat_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(dev, struct_size(priv, hws, plat_data->nr_clks), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->num = NR_CLKS;
+	priv->num = plat_data->nr_clks;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -996,35 +1130,35 @@ static int th1520_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	for (i = 0; i < ARRAY_SIZE(th1520_pll_clks); i++) {
-		struct ccu_pll *cp = hw_to_ccu_pll(&th1520_pll_clks[i]->hw);
+	for (i = 0; i < plat_data->nr_pll_clks; i++) {
+		struct ccu_pll *cp = hw_to_ccu_pll(&plat_data->th1520_pll_clks[i]->hw);
 
-		th1520_pll_clks[i]->map = map;
+		plat_data->th1520_pll_clks[i]->map = map;
 
-		ret = devm_clk_hw_register(dev, &th1520_pll_clks[i]->hw);
+		ret = devm_clk_hw_register(dev, &plat_data->th1520_pll_clks[i]->hw);
 		if (ret)
 			return ret;
 
 		priv->hws[cp->common.clkid] = &cp->common.hw;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(th1520_div_clks); i++) {
-		struct ccu_div *cd = hw_to_ccu_div(&th1520_div_clks[i]->hw);
+	for (i = 0; i < plat_data->nr_div_clks; i++) {
+		struct ccu_div *cd = hw_to_ccu_div(&plat_data->th1520_div_clks[i]->hw);
 
-		th1520_div_clks[i]->map = map;
+		plat_data->th1520_div_clks[i]->map = map;
 
-		ret = devm_clk_hw_register(dev, &th1520_div_clks[i]->hw);
+		ret = devm_clk_hw_register(dev, &plat_data->th1520_div_clks[i]->hw);
 		if (ret)
 			return ret;
 
 		priv->hws[cd->common.clkid] = &cd->common.hw;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(th1520_mux_clks); i++) {
-		struct ccu_mux *cm = hw_to_ccu_mux(&th1520_mux_clks[i]->hw);
+	for (i = 0; i < plat_data->nr_mux_clks; i++) {
+		struct ccu_mux *cm = hw_to_ccu_mux(&plat_data->th1520_mux_clks[i]->hw);
 		const struct clk_init_data *init = cm->common.hw.init;
 
-		th1520_mux_clks[i]->map = map;
+		plat_data->th1520_mux_clks[i]->map = map;
 		hw = devm_clk_hw_register_mux_parent_data_table(dev,
 								init->name,
 								init->parent_data,
@@ -1040,10 +1174,10 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		priv->hws[cm->common.clkid] = hw;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(th1520_gate_clks); i++) {
-		struct ccu_gate *cg = hw_to_ccu_gate(&th1520_gate_clks[i]->hw);
+	for (i = 0; i < plat_data->nr_gate_clks; i++) {
+		struct ccu_gate *cg = hw_to_ccu_gate(&plat_data->th1520_gate_clks[i]->hw);
 
-		th1520_gate_clks[i]->map = map;
+		plat_data->th1520_gate_clks[i]->map = map;
 
 		hw = devm_clk_hw_register_gate_parent_data(dev,
 							   cg->common.hw.init->name,
@@ -1056,19 +1190,21 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		priv->hws[cg->common.clkid] = hw;
 	}
 
-	ret = devm_clk_hw_register(dev, &osc12m_clk.hw);
-	if (ret)
-		return ret;
-	priv->hws[CLK_OSC12M] = &osc12m_clk.hw;
+	if (plat_data == &th1520_ap_platdata) {
+		ret = devm_clk_hw_register(dev, &osc12m_clk.hw);
+		if (ret)
+			return ret;
+		priv->hws[CLK_OSC12M] = &osc12m_clk.hw;
 
-	ret = devm_clk_hw_register(dev, &gmac_pll_clk_100m.hw);
-	if (ret)
-		return ret;
-	priv->hws[CLK_PLL_GMAC_100M] = &gmac_pll_clk_100m.hw;
+		ret = devm_clk_hw_register(dev, &gmac_pll_clk_100m.hw);
+		if (ret)
+			return ret;
+		priv->hws[CLK_PLL_GMAC_100M] = &gmac_pll_clk_100m.hw;
 
-	ret = devm_clk_hw_register(dev, &emmc_sdio_ref_clk.hw);
-	if (ret)
-		return ret;
+		ret = devm_clk_hw_register(dev, &emmc_sdio_ref_clk.hw);
+		if (ret)
+			return ret;
+	}
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
 	if (ret)
@@ -1080,6 +1216,11 @@ static int th1520_clk_probe(struct platform_device *pdev)
 static const struct of_device_id th1520_clk_match[] = {
 	{
 		.compatible = "thead,th1520-clk-ap",
+		.data = &th1520_ap_platdata,
+	},
+	{
+		.compatible = "thead,th1520-clk-vo",
+		.data = &th1520_vo_platdata,
 	},
 	{ /* sentinel */ },
 };
-- 
2.34.1


