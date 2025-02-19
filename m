Return-Path: <linux-pm+bounces-22445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB2A3C190
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8671891B15
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4871FECD9;
	Wed, 19 Feb 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JvpQxDzu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED8209F3F
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973800; cv=none; b=J06zAq2KlN0tfy/wyBqBiofBziL/Zuavn17fCRJAVV6+HDgscwLyznqi9SkR0e6XTQeTlBLouvDZ8y4L9CaGglON0hlo6+JbykRjciTNmcrRlog30o3Dou51hejbJVqG8cX8mfzs5QoFzx5OoT3MKXSh9Sy81gANXgGJB2Dg5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973800; c=relaxed/simple;
	bh=kN5mV8LEe9QFzYNvJnbQgMnASzf1OYGBbpY7op5mMf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=NdBpos/sou/ifltmPf5i0Id9s8c/62ujS4FjxRixvc0zIkM9KNeC7etdDRNmJIlkMJMTioSJu4f8VxnuSw1XF2BDnfY+BL9uAnlUuoB3vWzWtpE9N9y1eeCV/YhOd53OEs3zF637wr2RqPDboyjHn4F+jSL/sm8xey1Xh0uXltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JvpQxDzu; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140316euoutp013b9798d14fbac7b7556fa87fb61288cb~loPMGSGse1464314643euoutp01x
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250219140316euoutp013b9798d14fbac7b7556fa87fb61288cb~loPMGSGse1464314643euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973796;
	bh=E1zJumBGEhU08Fgunm11x/aZblHVc773/qz1x5SMe2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvpQxDzu9cNaNdBEBOx/gWQmpBNXbZiN3wvDvIn3no3kmbM0LqR7ZLvZijvgvuvF1
	 BNI2Bg/Yb52bv3lcaotnbb9mzotFwB0Izkuom/F3HcdKvIgp6J/hOiuw6L7mH50CfC
	 Frnvidxm56vubAyhaSD6lnRmrjYWQ/mFv0CpUU+M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140316eucas1p164a6d8297aeedf001d6a6b5e22170952~loPLpY6bu2959629596eucas1p1_;
	Wed, 19 Feb 2025 14:03:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 80.A2.20397.4A4E5B76; Wed, 19
	Feb 2025 14:03:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d~loPLIgJDP2129421294eucas1p1s;
	Wed, 19 Feb 2025 14:03:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250219140315eusmtrp1ec8ac420be7e9c649195915122aae2cb~loPLHlW_V2395223952eusmtrp1k;
	Wed, 19 Feb 2025 14:03:15 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-25-67b5e4a4bccd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.96.19920.3A4E5B76; Wed, 19
	Feb 2025 14:03:15 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140314eusmtip25dd0e4371c8e2f5b6ae8d0407dc74335~loPJ03h2l0642206422eusmtip2R;
	Wed, 19 Feb 2025 14:03:14 +0000 (GMT)
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
Subject: [PATCH v5 19/21] riscv: dts: thead: Introduce power domain nodes
 with aon firmware
Date: Wed, 19 Feb 2025 15:02:37 +0100
Message-Id: <20250219140239.1378758-20-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbZRjG/c45Pac0Fs/KCJ/oQEkgGXGAbi6fcRGIOI8xLui2YBYWVt2x
	wGhpWhgyJ4NwEWi3wS4yC4zLyCjEjo21TbmUS7kURO4OmIOKWXEUuhEGbCrKpJ5O99/ved7n
	zfO9ycfHRXrSl58gS2EVMnFSACkgjL1/DO+osRskYRc2KNQ3WY0hw7qGQt+bhzBU0T3EQ7Yx
	PYZ+Wlsi0bW5EQrNm7MINKEtp1B2bwOJHBobiZbVNh4aby4j0crpboCMKzkk0nXPUKhhrQJD
	VcsGAtWYmgHKK7jKQ6M/vIdmbH0EcoyrcZSneQE9aTVRaGPiBoFKH7RTSO8s5iGrLgbltF8g
	IvyYpalcinE6HATTlb9KMeZHlQTTpJmhGHXTj4BprC8gmemJVpK53P8x84vKijE3a04xObpe
	jDn7dxiz1HaLZM7o6wEzlj1JRYsOCfYcZZMSjrOK0HeOCOJHF3fKezy+7LsywssEa1Qh8OBD
	ehfML1BhhUDAF9FaAM2DdwlOrAJoLS/CObGyOamrwJ6ujDZ0uFdqAfz1UTHFCSeAPWt9wJUi
	6TfgbG0FzzXYSucSMLcnC7gETt8D0GgvI10pL/owrFwt/JcJOhC2Py7muVhIR8DesVqc6/OH
	7Z2Dm8zne2z6baO+XGQL7P/OTrgY34xkG0rd8ToBnNZEchwF7a1V7ku94IJV7+aX4cB5NcFx
	Mpw1PHTvnoRNaqub34bTQ3+Srlqc3g4bmkM5OxJODswRLhvSnnDq/hbuBZ7wnLEE52whzM8T
	cekgeFF9+r/SIa0R4yIMzHIqisCrmmdO0Txziub/2kqA1wMfNlUplbDKnTI2LUQplipTZZKQ
	z5OljWDzYw9sWNdMQLuwHGIBGB9YAOTjAVuFeaf0EpHwqDj9BKtIjlOkJrFKC3iJTwT4CKvb
	cyUiWiJOYY+xrJxVPJ1ifA/fTMy7Zia2wy/wVqdn1N6FBMVf9ojpfar9H11zJJ7tOPJkv1ye
	GnDwq/qo2A9bVrebymb8w3ZfeXiwpasrXhXdn5MmU4UdLw3e+CBmI3b4fkZrbIJZeiB3cM+l
	xp9/hzc6VxavD2dQPgqjY0fp19sIw4l1HdVp//a5x6o74ap78quJN3UwZT0ufiDaQ6uVnvNL
	V6S/Ypt7LcUyFbct0vyWs9xy+1i1VhgeeFtV1/HbN/PV74fDkfK267PyT6Iu+09GBwVXYXe8
	nYlvvqjyqmKa0syHpuZDD0wsRt8tMTXPdQ86Tb3vqopijIKW8chdz188E/TZ+eyTD2wl3iG7
	Dxu/2Lv4aVtGZgChjBe/HowrlOJ/AHNk9ZJHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsVy+t/xe7qLn2xNN9jbomhx4voiJoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxuLZiLrtF87H1bBYvZ91js/jYc4/V
	4vKuOWwWn3uPMFps+9zCZrH2yF12i/Vf5zNZLPy4lcViyY5djBZtnctYLS6ecrW4e+8Ei8XL
	yz3MFm2z+C3+79nBbvHv2kYWi9nv9rNbbHkzkdXi+Npwi5b9U1gc5Dze32hl93jz8iWLx+GO
	L+wee78tYPHYOesuu0fPzjOMHptWdbJ53Lm2h81j3slAj/vdx5k8Ni+p92hZe4zJo/+vgcf7
	fVfZPPq2rGL0uNR8nT1AKErPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEv4+Jr44KjnBUnFl9gbWD8yt7FyMkhIWAicXH9ASYQW0hgKaPE5ndOEHEZ
	iWvdL1kgbGGJP9e62LoYuYBqXjFKPDg6BSzBJmAk8WD5fFYQW0RgMYvE3n2VIEXMAm8ZJa7P
	3AhWJCwQLfF7/UqwbSwCqhL7v08Ea+AVcJA4dmk5M8QGeYn9B88C2RwcnEDxfRelIA6ylzjX
	dx+qXFDi5MwnYCOZgcqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5
	mxiBqWXbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd62+i3pQrwpiZVVqUX58UWlOanFhxhNgc6e
	yCwlmpwPTG55JfGGZgamhiZmlgamlmbGSuK8bpfPpwkJpCeWpGanphakFsH0MXFwSjUw2Rbt
	yNO7fPVcFwczz0/5k3ZrfJdxlOxp/Zu1a6sUx60LBz9MOH7z1dcp/iandoZx521Inqpx9xnP
	Uo0P/m9CAgo6P4cqTe2TY5z6bHW3toW3zszVVYz7H3mXFYW5Sfj+Yorn3ep1fuLJA04mHRZz
	Nq0zc705O/92svqfa5aLnpqv6o1/f6HlUGasxoaaSu9Ic9HjxccUFug6bJOeXeDJnBqVofPM
	k7Pj5tPLe4Jm3eXReS15U3mpsqxzZW/ImoDiT6rarNp5XawBPJfmnXx7/a38XRntrc+Dlkja
	Sy8wjY2v//R5Tt+xhRa3k3PlpkjOad41cZrY3wmeFkdtpl9LOnlGYXpT1ZITL4TEL+4LVmIp
	zkg01GIuKk4EAEd0C8K2AwAA
X-CMS-MailID: 20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d@eucas1p1.samsung.com>

The DRM Imagination GPU requires a power-domain driver. In the T-HEAD
TH1520 SoC implements power management capabilities through the E902
core, which can be communicated with through the mailbox, using firmware
protocol.

Add AON node, which servers as a power-domain controller.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 197df1f32b25..474f31576a1b 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+#include <dt-bindings/power/thead,th1520-power.h>
 
 / {
 	compatible = "thead,th1520";
@@ -229,6 +230,13 @@ stmmac_axi_config: stmmac-axi-config {
 		snps,blen = <0 0 64 32 0 0 0>;
 	};
 
+	aon: aon {
+		compatible = "thead,th1520-aon";
+		mboxes = <&mbox_910t 1>;
+		mbox-names = "aon";
+		#power-domain-cells = <1>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
-- 
2.34.1


