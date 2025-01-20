Return-Path: <linux-pm+bounces-20715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE0A17182
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 18:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7044B162E70
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CE1F1914;
	Mon, 20 Jan 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W8MAtYzm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A941EF0AA
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393702; cv=none; b=WOBoYFVHkEvBfHWL8P/0RbLrvwxhgOLPhLwSkqaL7KMow06kL9BsnhOWG3+a4ka1o+lFxalivRyII24mihkEnmfiEHLKUhg6kA2r8MxLgrhIZkkAHCCedGyWmginyG198Wzn2fLyg/JL6fMUc0Ziq3uMx6iaKzEOXTWCICDgObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393702; c=relaxed/simple;
	bh=yvqdxfg7wgNvj7FoNhNkqhiUpLVYc5MRzR+cM6Yscs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=npcgxQqrFxvFMKNnONmp9Jm/Zeb2JRzc8GQwpSSEit5Zv/EHp5HaaDy3ILLxAqnhvY/WMcavA40jwAMUHqKG/a25q1VR/R0Sm/SFiyK6vxXz6VLBmSHU2q1rkd7TmG3gwdHk6ctuA/9J9PWBbMDsToAcqUeaQwOwYRN/heNeauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W8MAtYzm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250120172139euoutp01860376dde68ce4848cfba20e48c0a074~cdl1Lo5_j2441324413euoutp01c
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250120172139euoutp01860376dde68ce4848cfba20e48c0a074~cdl1Lo5_j2441324413euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737393699;
	bh=p1n/0uk3piG1h+o5F2Ndg4sz3c3AchdOqWD3da4OL+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8MAtYzmepQ0Aoz+mdoRdazGM+AaKpeBAzlka6PNP6LwekLp1TiDJ1o6LTXD+k+T6
	 P1VAd5aDD515i+wdYEUAO/ekCeyOfhIoMUDSOBweuilDUsW6nuskqnVj0LtjGjdi2R
	 mlU8msOoImvLm22Wyax+O6Rcjw+O59wzDH1UbtMU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250120172138eucas1p2f6d8794a862b5ec8c210c6850579ea91~cdl0us-RW1091210912eucas1p2y;
	Mon, 20 Jan 2025 17:21:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.66.20397.2268E876; Mon, 20
	Jan 2025 17:21:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250120172138eucas1p294698126686b5d3a9281c0a5428f2cf6~cdl0PmTrE1088710887eucas1p2F;
	Mon, 20 Jan 2025 17:21:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250120172138eusmtrp255084ed0d414c9b060bac63e946d42cc~cdl0O2wji0490804908eusmtrp2F;
	Mon, 20 Jan 2025 17:21:38 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-68-678e86223bec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.A5.19654.2268E876; Mon, 20
	Jan 2025 17:21:38 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172136eusmtip1e9c6acac091371dd6cdf44efec214b8c~cdly4yg4m1013910139eusmtip1Y;
	Mon, 20 Jan 2025 17:21:36 +0000 (GMT)
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
Subject: [RFC v3 14/18] riscv: dts: thead: Add device tree VO clock
 controller
Date: Mon, 20 Jan 2025 18:21:07 +0100
Message-Id: <20250120172111.3492708-15-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120172111.3492708-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH99x7e++ls3Atbj5BlIzBXthEx0x4MliRbGZ3iR/ww9gy3aQb
	NwUHpbaC05CIFBpeiuBmMas4XibQsCEBWgQCdlSgVKAIjBcJrejACUGQYQeC4Citm99+55z/
	Of9zkkPjQj3pQ8dLT3ByqTjBn+QTDZ1PrLv9Vecke1cf7UZdI2UYMqxqKfRbqxVDxe1WHrIP
	6DH0h2OeRFenblHoQetZAg3rLlNI2VlDommtnUQLajsPDTYXkWgxrx2ghsUMElW32yhU4yjG
	UOmCgUBXGpsBUmVX8FD/zQPIZu8i0PSgGkcqrRd61tJIofXhWgJdmjNSSD97nofM1Z+jDOMF
	Yv8udn40k2Jnp6cJ9kbWY4pt/aeEYJu0NopVN/UAtq4qm2THh1tI9mfLIfZOrhlj66+cYTOq
	OzE2f20vO399iGTP6asAO6AcoaKEX/LDY7mE+BROvkcUw4+73tGLyW5S39eO/QnSQBGZAzxo
	yOyDtjYHngP4tJDRAaix9bmDxwDazErCFSwC2NaRQT1v6SvQuAuVAI6la3FnQcjMAtj0O3Iy
	yYTAicpinlO0jckkYGbHWeAMcOYvABsmXe7eTBRcvzG4OZZgAuHdpeUNEU0LmP1QN/KRy80P
	Gtt6Nw08NtJLQ62bcgGzFVp+miScjG9olIZLuEtfy4fTyiAXfwzLnowTLvaGM2a9+wJf+Kyp
	GHNxEpww/O3uTYVNarObw+C4dYV0roMzb8Oa5j1OhEwkrCnFXegJRx9udS3gCX9ouOhOC2CW
	Suia8QbUqPP+87TqGtyeLMwu7eYVgNe0L5yifeEU7f+2JQCvAtu5ZEWihFO8L+VOBivEiYpk
	qST426TEOrDx2N3rZkcj0M0sBJsARgMTgDTuv03wyiO1RCiIFZ86zcmTjsqTEziFCeygCf/t
	gjJjpkTISMQnuO84TsbJn1cx2sMnDau5axl9s3+LqlIbRF6UHZH53TILJeHvnr5aeNLhe23n
	8cNTfSNH8QBr6Ceqxp1jIUs9ByKt+7IrDFMvnUqpiC6KWL3tRUVntRC8h3JZm+h+bvrr4/iU
	1+GoCROb/7JFU/HVA9HXsyu+wl+Mn0bc65amBqTdER25fWZELsqh8+NqLal+ax6Tx85/kTr2
	wZaZmF8L29OUAXm7FsOW7SmB5V36tQHimx3l3nO5cdUHw46V1DdHoDXJ8cyn9fh6b929t57W
	39f46qMXDStwNH44pLDcs+DQauxcLt3vIwiVer0TMZT+4fKrJh26/FkkqMgPuRYRmNfSc9A7
	vKA65kd9aIklzZ9QxInfC8LlCvG/btA/AUcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xu7pKbX3pBqefclqcuL6IyWLr71ns
	Fmv2nmOymH/kHKvFvUtbmCyufH3PZrHu6QV2ixd7G1ksrq2Yy27RfGw9m8XLWffYLD723GO1
	uLxrDpvF594jjBbbPrewWaw9cpfdYv3X+UwWCz9uZbFYsmMXo0Vb5zJWi4unXC3u3jvBYvHy
	cg+zRdssfov/e3awW/y7tpHFYva7/ewWW95MZLU4vjbcomX/FBYHOY/3N1rZPd68fMnicbjj
	C7vH3m8LWDx2zrrL7tGz8wyjx6ZVnWwed67tYfOYdzLQ4373cSaPzUvqPVrWHmPy6P9r4PF+
	31U2j74tqxg9LjVfZw8QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
	SUnNySxLLdK3S9DL2Hf0LFPBKfaKjbceMzYwzmHrYuTkkBAwkTg/YSoLiC0ksJRRYtfhEoi4
	jMS17pcsELawxJ9rXUD1XEA1rxglvi88DpZgEzCSeLB8PiuILSKwmEVi775KkCJmgbeMEtdn
	bgQrEhbwk1i1/weYzSKgKvHw+w/GLkYODl4BB4kV150hFshL7D94lhnE5gQKf7+6lx3iIHuJ
	O1e7GUFsXgFBiZMzn4CNYQaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al
	6yXn525iBCaXbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4RT/0pAvxpiRWVqUW5ccXleakFh9i
	NAU6eyKzlGhyPjC95ZXEG5oZmBqamFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnV
	wLT6B/t+mZyD0jf9ilxEOYpnWbxX4zB48finbayOl5bSgdyE3F9+ZzMP3RY52MjtvvxEWdX2
	CTLXP9zjStI5vDvqc87iPXPSvrSer/6sL57YtFjFRLFJ0CFpT9pHxqJvTYdWOsWqXNX6+ivv
	n9+HR2xna9vWnONX215xJPHkp+lOXv877xXObmita396ZNmvTMONvYKeBluKn7ycUr2WQfaP
	33pOHY7w94KplneXC65dNeuLBHN72jybySliVd0znJ9Ge65vP/1YuHfZ3ViWq9PO7RLlmPDc
	el9ld/G26b1b0s4+y1rnzcizJu7brHUvdqjz3V43u0dEoOP81ckty7unZE/44bn/Zlz03tA9
	u14osRRnJBpqMRcVJwIAxmV81LcDAAA=
X-CMS-MailID: 20250120172138eucas1p294698126686b5d3a9281c0a5428f2cf6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172138eucas1p294698126686b5d3a9281c0a5428f2cf6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172138eucas1p294698126686b5d3a9281c0a5428f2cf6
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172138eucas1p294698126686b5d3a9281c0a5428f2cf6@eucas1p2.samsung.com>

VO clocks reside in a different address space from the AP clocks on the
T-HEAD SoC. Add the device tree node of a clock-controller to handle
VO address space as well.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index acfe030e803a..5e515a9d69b2 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -489,6 +489,13 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		clk_vo: clock-controller@ffef528050 {
+			compatible = "thead,th1520-clk-vo";
+			reg = <0xff 0xef528050 0x0 0xfb0>;
+			clocks = <&clk CLK_VIDEO_PLL>;
+			#clock-cells = <1>;
+		};
+
 		dmac0: dma-controller@ffefc00000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0xff 0xefc00000 0x0 0x1000>;
-- 
2.34.1


