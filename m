Return-Path: <linux-pm+bounces-22448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D5A3C1A2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9200718965C7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D62135B8;
	Wed, 19 Feb 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GwygPMBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D6211A0C
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973803; cv=none; b=MedSdNffViGGXVCOijyZkcuDEafr+DxwahHzn7EZaZf9MP4laX33y6ReewV5duufQdr0MxB6v+11k+2gBeF08poA4RNfsaiBdvg0k7/GNgbmh9aXi9l4YlbD5qIgTdrAi0wz2ZADaJQHLcmUeEa7v99BVBODBnzptluHfyuZ+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973803; c=relaxed/simple;
	bh=mPNJ48aDPqdFg1ECdW+dKYVom+swah7vyuEFQYmv82E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Fm/fV6BM+ndn0aoBIZlu0NpgUvLTRRiJx7MaiaRwV9khh9eAJuY3/2lkQ5zDSZ+8KDnEBcbf1U9UPbXCuVM25Ohatt8GkBTgaR025at9Mq2q211XUYvGrO0DR/+RC6ZfI3+6EgATCVHbyKtmtf8TdZf+rir4x4NApFLwxnaBoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GwygPMBA; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140319euoutp010d5c13555a1e803b8d34fa3e6498e8d9~loPOqVEgD1495814958euoutp01Z
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250219140319euoutp010d5c13555a1e803b8d34fa3e6498e8d9~loPOqVEgD1495814958euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973799;
	bh=PsAB+JOgcxnXBZ0RJoudGrm4LQ1wEP+2yNk/4fwQIHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwygPMBAIwrdjEo7uvTOCLeB5Sn0RNiLBSgqfWgo7r/clZHUPJDqKamuHY+MEgOn+
	 J5TbRdELtbNind9dJ5d9TzuqqhCJxMK8nWM67/S8rgsbUiFL79ZnIMuqeBOGlVMe4Z
	 7SyCnpJ6NRWZFlEUgkNfmo9oXRnlULIV9gndBygg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140319eucas1p1ecfb22946c7f4617d5f74daf7dc47c4b~loPORRSwq2213222132eucas1p1g;
	Wed, 19 Feb 2025 14:03:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.93.20821.6A4E5B76; Wed, 19
	Feb 2025 14:03:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250219140318eucas1p1db0d55468b1958f9d41963cb789e4f29~loPNxaRGl1654516545eucas1p1B;
	Wed, 19 Feb 2025 14:03:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250219140318eusmtrp2029534af637e6839596fe5c3ea02185c~loPNrxAUV2481124811eusmtrp2F;
	Wed, 19 Feb 2025 14:03:18 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-8e-67b5e4a609c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.62.19654.6A4E5B76; Wed, 19
	Feb 2025 14:03:18 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140316eusmtip2a5c7a24083fa3ce8351ed5c3f9fdaa14~loPMPVwmE0697306973eusmtip2J;
	Wed, 19 Feb 2025 14:03:16 +0000 (GMT)
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
Subject: [PATCH v5 21/21] riscv: dts: thead: Add GPU node to TH1520 device
 tree
Date: Wed, 19 Feb 2025 15:02:39 +0100
Message-Id: <20250219140239.1378758-22-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGfXtv773UFa6F6BvKhjRxmS4imsnesPmVzO1uyTKJmil/CEXu
	ipEvW9DpSKDQMmRUNmFbKLiqQQRi7ZS2AqNUC7blQ1YQqoigbhAtQ4FSRpxDRrls87/fOc9z
	3uec5KUwUT0RSh1Ky2TladIUCSHAzfbn3eurR0yyqF9/iEHOO+d5yPRCS6JLlm4e0rV189Fw
	r5GH+mYmCHR51EWiJxYljtw1Z0iUbzcQyKMdJtBU8TAf3W6qJNC0pg0g87SKQPq2IRIZZnQ8
	dG7KhKOqhiaACk5W81FPx040NOzEked2MYYKtEFovrmBRC/dV3BU8cxKIuP4d3zk0H+OVNYy
	fPsbzMRdNcmMezw401roIxnLn2dxplE7RDLFjV2AuVp3kmDuu5sJ5qf2WObBNw4eU1+Vw6j0
	dh5TMhfFTLT0E8wpYx1gevPvkLtEcYL3k9iUQ0dZ+YatCYJk36CKzNAs/9JzbZTIBYUBRSCA
	gvQ7sKXcTRQBASWiawDsKLUQfkFE+wAsrYznhGkAy5v1/CJALU6c/i2c618EcKAzH+OKcQAf
	m9sWpwl6E3x4Ucf3CyG0Gofqm0rgLzD6MYDmkcpFVzAdC2/UuoCfcXoN9PZoF1lIb4cNvn6c
	WzAcWm/cwvzRAQv9lp5QzrICtpePLFqwBUu+qQLj7FcEcORRNMcfwJtdGoLjYDjmMJIch8H5
	Rh2P43T40ORdms2GjcWOJX4P3u/+i/DHYvRaaGjawB2/A/oGszgMhHefruAWCISnzT9iXFsI
	CwtE3Btvwu+LNf9ldteYlzIZWKi8jH8LIrSvnKJ95RTt/7FnAVYHVrFZilQZq9iYxh6LVEhT
	FVlpssiD6alXwcK/7nzp8DaAM2NTkTbAo4ANQAqThAgLcowykTBJevwEK0+Pl2elsAobEFO4
	ZJXwvFUtE9EyaSZ7mGUzWPm/Ko8KCM3lAVcXii853L/2dV2iO6Ek8ci6steuD3x9ITps/9Nr
	gXm79n2RB9tLJkPstc9QNjy+cj6nNXdZtZc5EN8SxoZvTnPRc8p3xQLTp0fnJSeOCCPq2sRV
	sVsSbJ/MbJlc9tUs7S7fU1LWdz3GZ8+Y2+3d5BFuntWv0ZqPjUkqDLtX703QZOpsefcsITvW
	x4xGS2bjnEFJnZEZOz9O7nMc6Aihrb/Y9eG+lak/w61iFPfZk9Bt9aqKR7ZtrefqXlAXDhbs
	10T98UBc61QEv039vXr5vY8CIib35M5aYkyMcfhUqbK9SbZ33qVNfB444My6la0etNZOmX/f
	pwz68JLY0PuWt0WCK5KlG9dhcoX0H62cehFGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsVy+t/xe7rLnmxNN7j6VtDixPVFTBZbf89i
	t1iz9xyTxfwj51gt7l3awmRx5et7Not1Ty+wW7zY28hicW3FXHaL5mPr2SxezrrHZvGx5x6r
	xeVdc9gsPvceYbTY9rmFzWLtkbvsFuu/zmeyWPhxK4vFkh27GC3aOpexWlw85Wpx994JFouX
	l3uYLdpm8Vv837OD3eLftY0sFrPf7We32PJmIqvF8bXhFi37p7A4yHm8v9HK7vHm5UsWj8Md
	X9g99n5bwOKxc9Zddo+enWcYPTat6mTzuHNtD5vHvJOBHve7jzN5bF5S79Gy9hiTR/9fA4/3
	+66yefRtWcXocan5OnuAUJSeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJexpfbLewFvdwVL7c/ZWtg7ODsYuTgkBAwkZj0SL6LkZNDSGApo8TP0+wg
	toSAjMS17pcsELawxJ9rXWxdjFxANa8YJT5+vwSWYBMwkniwfD4riC0isJhFYu++SpAiZoG3
	jBLXZ24EKxIW8Jc4PHEyM4jNIqAq8eniLEYQm1fAQWLHl6tQG+Ql9h88ywxyECdQfN9FKYiD
	7CXO9d1nhSgXlDg58wlYOTNQefPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQv
	XS85P3cTIzC1bDv2c8sOxpWvPuodYmTiYDzEKMHBrCTC21a/JV2INyWxsiq1KD++qDQntfgQ
	oynQ2ROZpUST84HJLa8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6p
	BiYFxtSv/z69nynU46ls9//3zZ/Vz71Snr/SzNy2oWeC/7as2wWi/XvlEj7e/JtnGXh1eRBz
	zY7a+XWPizWZ5zw9aP8upF77RsKf5PznSukpWyc4X1ogWeuSzxmStHTWWfuAOdctTlsV7fwZ
	snNS17mmDZmGjreevw5+qC9RNJWve5JD3FYZpi22Xw2ZeHfHzb3wcdH2rzN+bp/wxfhDbWhk
	wOq4x+W/pvPsu2Q5adKDdTZHruqJp/VI7uN49Ejy8oNJnH2h1/ZyLhWrcj+5cqOVw573WuEO
	+gEZFqu/rs5aJ2Js9nFVM1PBd5+bjlzfWpw8rIPzZqyQeSjnVjLvSXF7/Wovxh1JDyZpujP8
	8WFVYinOSDTUYi4qTgQAOTMmP7YDAAA=
X-CMS-MailID: 20250219140318eucas1p1db0d55468b1958f9d41963cb789e4f29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140318eucas1p1db0d55468b1958f9d41963cb789e4f29
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140318eucas1p1db0d55468b1958f9d41963cb789e4f29
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140318eucas1p1db0d55468b1958f9d41963cb789e4f29@eucas1p1.samsung.com>

Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
the GPU using the drm/imagination driver.

By adding this node, the kernel can recognize and initialize the GPU,
providing graphics acceleration capabilities on the Lichee Pi 4A and
other boards based on the TH1520 SoC.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6b34aab4b455..c4fa616efac8 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -498,6 +498,19 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@ffef400000 {
+			compatible = "thead,th1520-gpu", "img,img-bxm";
+			reg = <0xff 0xef400000 0x0 0x100000>;
+			interrupt-parent = <&plic>;
+			interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vo CLK_GPU_CORE>,
+				 <&clk_vo CLK_GPU_MEM>,
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


