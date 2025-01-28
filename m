Return-Path: <linux-pm+bounces-21061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF9A212AD
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E229E166564
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4481F91CA;
	Tue, 28 Jan 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bz9Fa2AF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466961F78FC
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738093730; cv=none; b=ZRCyr7cZUiwQ8e5VIceS0NlDkV7mcCsslmxFGsUtIObsSkteyihsdpypTdVsDstFui3vVo0rGDtIG03WSqlGtYpwBWwOltab6bFwIya8Vc39h+qiG0C3H/s4kv80sd8RmuMU0Knxq1k04HhGD08bWAogAdkO+mHhYkco3QgJOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738093730; c=relaxed/simple;
	bh=/f9RUGuRkg81S+9vEr4rF6E2a7sH/TZ3cI1ZNfn6e/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=iilCsX9ahNrnTUxJRchoQCzN/mpxGSfCbrGH3tr40xNRGG7JGVunBPzfABthNOgK1EAPYDEA5QskQ6GZzR7lRlkrWLFG6/MdGFwXguSDNducm8tkNtJ1dDl2SFoyJJFg/zZ9ZSIu61R8ZzhpnDrcMBW83BICJPabw+1nb2ca4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bz9Fa2AF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250128194846euoutp012b2af20a1c46b875d3a7eeab89f49e48~e8wkjfLBN1604816048euoutp01m
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 19:48:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250128194846euoutp012b2af20a1c46b875d3a7eeab89f49e48~e8wkjfLBN1604816048euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738093726;
	bh=zWpSPctGzB1QFcIv8f8mPGsvFF5oZ87O6t+skARlCj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bz9Fa2AF+PDrgHFJPXeV2fPoIus8rfFI1y/A+ye+HXVRdn+TCeo45QLMR0DPXJfSv
	 GGRluE1hcDAVFPRqnzpOkb62eaRL5M/ZiGki9DSgqhWdz62M/wwcA0PRKVHRqPxC3V
	 2vGOTt3NBlpG4Wh08Fs1v52GyBDoLNR2H9eliknU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250128194845eucas1p1e7750fbf1acc9b3cb14ff9ce8fc3aae5~e8wj0Mgwx1987819878eucas1p1n;
	Tue, 28 Jan 2025 19:48:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 00.C2.20409.D9439976; Tue, 28
	Jan 2025 19:48:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250128194845eucas1p1c05f74ffbfc62da048615f7dd2781b4b~e8wjKaOnV1601016010eucas1p10;
	Tue, 28 Jan 2025 19:48:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250128194845eusmtrp23a9da8adb617d78f4cfd72ad54e856aa~e8wi-9N-i0493804938eusmtrp2D;
	Tue, 28 Jan 2025 19:48:45 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-23-6799349dc4be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.BB.19654.C9439976; Tue, 28
	Jan 2025 19:48:44 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250128194843eusmtip1d6e6f45ebcfc06f9bb3ce796a213e929~e8whrFZtC2620826208eusmtip1p;
	Tue, 28 Jan 2025 19:48:43 +0000 (GMT)
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
Subject: [PATCH v4 15/18] riscv: dts: thead: Add device tree VO clock
 controller
Date: Tue, 28 Jan 2025 20:48:13 +0100
Message-Id: <20250128194816.2185326-16-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128194816.2185326-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+69vfdSVrgUP05008g2WZcNlDByNqYB93XjmJskug/mRrfe
	FCJQ08IEdQjSNiJl6JxsLTCQ6Sg4QBEaIEJDLS2Uz6FUDFCVMCcMhA5wUxRGaXX+93ve87x5
	njc5NC40kGvo+KRkTp4kTggg+YTBcr/n1aJQrXTTeOdrqO1aKYbq5nUU+q2pG0PF5m4ecvTV
	Yujq3BSJqv7opdCdpkwC2fVFFMqyVJNoTOcgkVPj4KErjYUkmsk1A2SYUZKo0jxMoeq5Ygyd
	dtYR6Ex9I0Dq7F956HfbO2jY0UagsSsaHKl1vmjxUj2FFuwXCFRw10ih2okTPGSt/BgpjT8Q
	EevYqQEVxU6MjRHs5aOzFNt0r4RgG3TDFKtp6ARsTUU2yQ7ZL5Hsz+072Rs5Voy9eOYwq6y0
	YGzeo03sVHM/yX5XWwHYvqxr1EfCz/hvSriE+G84efDWWH7cdI4W32ejUquPXCQzQCF5DHjR
	kAmFV9V2/Bjg00JGD+DYfL5HzAJozP8Fc7mEzAyAD7XrH28MKo08t6kMwHyNgXKLCQDN1zWE
	y0UyIfBmWfGyawWjIqCqNRO4BM78CaBh1J3uz0RDdd8Qz8UE8yK81Vy4tE3TAiYC/tMU7I5b
	D40tXbiLvZbGNY/0ywECxg+2a0eXGV/yZNUVLPeGTDkfTnc94LmX34YDzlOUm/3huLXWw8/C
	xYZizM0yeLPub9zNh2CDxurhcDjU/YB09cEZEaxu9PSJhJbxh7hrDBkfODDp567gA783/OgZ
	C+BRtdDt3ghPaXKfhHbrDZ5QFvbMZ2PHwQbdU8fonjpG939uCcArwGouRZEo5RQhSdz+IIU4
	UZGSJA36WpZYA5a+dseCdbYelI07g0wAo4EJQBoPWCHY0/2TVCiQiNMOcHLZl/KUBE5hAmtp
	ImC1oNSokgoZqTiZ28tx+zj541eM9lqTgdWvGxGdlt0Oa0Mxhem4X2pz/gns8PFXrKVlM/bk
	1lRb1WzmKC9iw8lzobaq3DuD+7eUmCJ3bIx5KdNr896qwHNh770b23vvhYQC5cE9I2/gpfBQ
	yydROW2RfbHRB3enOoqy83qHL7C28qz7273luySB1XGarTfiXl9p6SuMOKsSLaj47f2E3fnB
	55JVLc894wjJjdYfieffDvh0pKs0RjOjJXFZQzMRpJVUpvtvWxk+nWYbBLsmd1z+d20dztP3
	726d6/D99q0Pz/91fehu1fnJ5LjA/jBdOCtfFdwTJTJvzyvPOZB2a/4rekvnyZ2pHRMZyrMi
	X+9c0xfp73v7RJU/v0gHEIo48eaXcblC/B9aaJPfSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsVy+t/xu7pzTWamG0zNszhxfRGTxdbfs9gt
	1uw9x2Qx/8g5Vot7l7YwWVz5+p7NYt3TC+wWL/Y2slhcWzGX3aL52Ho2i5ez7rFZfOy5x2px
	edccNovPvUcYLbZ9bmGzWHvkLrvF+q/zmSwWftzKYrFkxy5Gi7bOZawWF0+5Wty9d4LF4uXl
	HmaLtln8Fv/37GC3+HdtI4vF7Hf72S22vJnIanF8bbhFy/4pLA5yHu9vtLJ7vHn5ksXjcMcX
	do+93xaweOycdZfdo2fnGUaPTas62TzuXNvD5jHvZKDH/e7jTB6bl9R7tKw9xuTR/9fA4/2+
	q2wefVtWMXpcar7OHiAUpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJfxoXsmc8Ep9or1TZvZGhjnsHUxcnJICJhI3G7ZzwpiCwksZZQ4elsWIi4j
	ca37JQuELSzx51oXUD0XUM0rRomHqzqYQRJsAkYSD5bPB2sWEVjMIrF3XyVIEbPAW0aJ6zM3
	gnULCwRIbF10FWwbi4CqxMN9c4DiHBy8Ag4S3/fqQyyQl9h/8CzYTE6g8Ka/K1ggDrKXePR2
	Blgrr4CgxMmZT8DizED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT8
	3E2MwNSy7djPLTsYV776qHeIkYmD8RCjBAezkghv7LkZ6UK8KYmVValF+fFFpTmpxYcYTYHO
	nsgsJZqcD0xueSXxhmYGpoYmZpYGppZmxkrivGxXzqcJCaQnlqRmp6YWpBbB9DFxcEo1MDFd
	+5qyQ0w9Nlu5w7r0uFuj+pJz97fu0tq3e797unNoR+vWV9KJCQeleA6uljrwMP7I9kmb9b/r
	2vkfCmSbO4VpweYE1WNb+46EbeGsFPyVor2omXnpqd9S89h4/7Jt6dR0jhDVirvIe6Jt/epo
	NfX9+mm5y69PD3r3cFNA6rIO7T+8Yb9lpDeqm7wMcrlsId3TKParvWPjhU1ejr2zS7L3K227
	b/M3x138wN74LUGPl0s+rOX7qxfXUPH38UOZlbz/M240132NLCw1qdhu/cVE+4rbWtnXZ1vY
	t07IuF7Mb1BpoNfm4XlKTt1l/2K9YBMLP7vDixV4nzAb/qko9/i86oqyyzbzW1d1LKO+KrEU
	ZyQaajEXFScCAA22fAm2AwAA
X-CMS-MailID: 20250128194845eucas1p1c05f74ffbfc62da048615f7dd2781b4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250128194845eucas1p1c05f74ffbfc62da048615f7dd2781b4b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250128194845eucas1p1c05f74ffbfc62da048615f7dd2781b4b
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
	<CGME20250128194845eucas1p1c05f74ffbfc62da048615f7dd2781b4b@eucas1p1.samsung.com>

VO clocks reside in a different address space from the AP clocks on the
T-HEAD SoC. Add the device tree node of a clock-controller to handle
VO address space as well.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 527336417765..d4cba0713cab 100644
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


