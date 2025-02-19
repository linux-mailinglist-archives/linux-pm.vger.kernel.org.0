Return-Path: <linux-pm+bounces-22447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C9A3C1AF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA233BA267
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08067212B2E;
	Wed, 19 Feb 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SSpJtbT/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07A20F07C
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973801; cv=none; b=prZMiJVDmmWMmUxk/JLVYo2OJyhpzGIbnZw/xGFAJwVbb74ARfFTCx53aDuu37HJOW/fzrrcwf2XYrXUmw/aY+2jnsaksWjoE8UaSJtGImFUvJ5+s5/rMtkGaEF7em7NljxgJcLeTguhWCVpAYlIuCBi3ucxtars7+OO4wyqYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973801; c=relaxed/simple;
	bh=CIfx9k1i/uv8sxKnA9JlYpQCB/4yWFFRj3kbrGzVlPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dTK3vnj09uE1xWiz7LM07WP9ePauoxXSx+KD+uoptOkf81BkYRSyQR+Zxyy1sDFgbH+L3pX82XaKKJldUfSdyPC3o3NdBQiAO+9ikR+2WvEnk9Pty+YE3QDAn1zmGlfyg4/z4nJviEKvPsTb42C3RItaYirxqkedIE1rkPz5fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SSpJtbT/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140318euoutp011e941762d11285ef02a2943d82052275~loPNcTogi1473814738euoutp01q
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250219140318euoutp011e941762d11285ef02a2943d82052275~loPNcTogi1473814738euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973798;
	bh=arn7vNGc0C9o+3i6Gdwd/04ZMnEd9KXSldDdvyaiPC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSpJtbT/CYCz296efmEoXzpF4NgHe7u3FntgglEjQiFHnfne5/z7OhSFMFlYX9MFa
	 ip+vX+fPICFYZSpkwRYfYK2MUY7L2nJ59mLaW8Tuw4SmzcNK8EJpJ75OaH/zE4u92A
	 LKIv65Q/V75gS4iZzK5gCvU8z4a+6Hll7b9QwUF4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140317eucas1p1ea70e0d4d29ed0403dcb7e305f86651f~loPM9vlKe2960029600eucas1p1A;
	Wed, 19 Feb 2025 14:03:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.21.20409.5A4E5B76; Wed, 19
	Feb 2025 14:03:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140316eucas1p29a76023868946f090f261bf78d5103e3~loPMW181P2649626496eucas1p22;
	Wed, 19 Feb 2025 14:03:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250219140316eusmtrp167e5a20dece60ac9109c2f0c41a8c2ff~loPMVum702416524165eusmtrp1y;
	Wed, 19 Feb 2025 14:03:16 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-52-67b5e4a52fd4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.A6.19920.4A4E5B76; Wed, 19
	Feb 2025 14:03:16 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140315eusmtip29871bf26f3b3f632c94fabeabd785cef~loPLCkLfh2765027650eusmtip2i;
	Wed, 19 Feb 2025 14:03:15 +0000 (GMT)
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
Subject: [PATCH v5 20/21] riscv: dts: thead: Introduce reset controller node
Date: Wed, 19 Feb 2025 15:02:38 +0100
Message-Id: <20250219140239.1378758-21-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xbdRT2d+/tvZeasrtCtl9gKqs644OHZJNfMoOYPfJbwAAxZtFopMKl
	oJTOlscwKgxoZVAGs25I2XgNhRGRCaVQwiNjHWUb4zkKS1ZGMqYDqwQoyDZB6W6n++873/ed
	852THJaUttN+bHJqGq9OlafIaDFl7r8/HPjDbJsipPziDjQwWUugtodGBv3UPUSgKuuQCE2P
	mQh0Y2WBRj/fHWHQve5jFLI3nGVQXn8zjeaM0zRa1E+L0HjnGRotF1sBMi/n06jJ6mBQ80oV
	gWoW2yhU19EJkO74jyI0evUAckwPUGhuXE8inXEL+qerg0Eb9l8oVPFnL4NMzpMiZGs6jPJ7
	v6MinsULU1oGO+fmKHypwMXg7tVqCluMDgbrLYMAtzQep/EtexeNK6/E4ttFNgK31mXj/KZ+
	Apesh+CFngkanzA1AjyWN8nESD8Qv5nApyRn8Org8DhxUvk9A3Vknj16vneYzgEXmELgxUJu
	N1w6ZaULgZiVcg0A/nUunxEKF4B23U1CKJYBnMk9CR63bFhsHqEeQOtIkaffCWBeYyXhdtFc
	KJyprxK5BV9OS0Ht5WPAXZDcbwCaZ8/QbpcPFwVbc1YeYYp7Ed5ucYrcWMJFwIVBLSXkPQd7
	L14nCwHLem3yPaN+gmUrvFI++8hCblry2ipI93zINYlhpWOVEHr3Q3vxvEjAPnDeZvKcvQNe
	M+g981Vwpm2JFPCX0KK3efBeeGvoAe3OJbmXYXNnsEC/DYfrKoCbhpw3nPpjq7CCN/zWXEYK
	tAQW6KSCexc8pS/+L3SowexZDMOHkxN0KdhpfOIY4xPHGP/PrQZkI9jOp2uUCl4TmspnBmnk
	Sk16qiIoXqVsAZu/fW3D5uoA9fOLQX2AYEEfgCwp85Xosk0KqSRBnvUFr1Z9rE5P4TV9wJ+l
	ZNsltb1ahZRTyNP4z3j+CK9+rBKsl18O8X16Lr/sd18R+NK+RD9nxaIqOmNntar7cNqEf82l
	fRF9v3pl7uJuXG5nE/7OfOqN2E8M4/EKn2/ygkOjS/RiJi5XG713tYPcn2UYejpq9Kh99v2v
	ayMdiUbpHUZS9KoyW8p9fldfjE5ntc6GHbBuhK+l6bCpaR6fcKmcyuU1ouGjpOd9Pixr948s
	SSt4x3wozDvVMgDH1uLX3wooC3/h0O9JMaVlqutfxYVt616Zi8F7fN/tf6bvrDJgdEts1Dp2
	OXqKnbKumsKggKiCqcC4EddSzYU7V/dw2Y7TB3MGH2wLD95tkBgy3vv04NK50LqAitzXbiZm
	r42HnK+L5C1lpclqGaVJkr/+CqnWyP8F9eu8UEoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7pLnmxNN9jXbGRx4voiJoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxuLZiLrtF87H1bBYvZ91js/jYc4/V
	4vKuOWwWn3uPMFps+9zCZrH2yF12i/Vf5zNZLPy4lcViyY5djBZtnctYLS6ecrW4e+8Ei8XL
	yz3MFm2z+C3+79nBbvHv2kYWi9nv9rNbbHkzkdXi+Npwi5b9U1gc5Dze32hl93jz8iWLx+GO
	L+wee78tYPHYOesuu0fPzjOMHptWdbJ53Lm2h81j3slAj/vdx5k8Ni+p92hZe4zJo/+vgcf7
	fVfZPPq2rGL0uNR8nT1AKErPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEvY+aLySwFrzgqVu4/z9bAuIG9i5GTQ0LAROLfzuNMXYxcHEICSxklbl7e
	wwqRkJG41v2SBcIWlvhzrYsNougVo8SGNf/ButkEjCQeLJ8P1iAisJhFYu++SpAiZoG3jBLX
	Z24E6xYW8JHY3PCVDcRmEVCVuL/pDVgDr4CDxPszrVAb5CX2HzzL3MXIwcEJFN93UQokLCRg
	L3Gu7z5UuaDEyZlPwMqZgcqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6
	yfm5mxiB6WXbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd62+i3pQrwpiZVVqUX58UWlOanFhxhN
	gc6eyCwlmpwPTHB5JfGGZgamhiZmlgamlmbGSuK8bpfPpwkJpCeWpGanphakFsH0MXFwSjUw
	xbnrrFVQ7UpZYLdw05XXT5VtJs3MXJD/VTwrsHrn2t6LB361nS5eeU1/UnxgGWN/VRRbLkfm
	j0flIn7Ocy4K7JLJVGjQmHXXv2jmtm2n2SKcyr7vTEptOtMWGb6fUWV/h+Xvh7Lab/zehfKv
	Sjscuf1B7dTQpt38j55+PPS7bu9sjW9MUocvLflSf/FHJ//FjdVPQkR+bCl8qS7AJVXN3mzh
	mcW06Z54RbtBj1ACV/iOt6ZJGc7/JyTz/vn5Z+1/4aq4tb2rxYqKNJI+OFkuazg4l2XyG7Wt
	Rcf+5yx7uUK6e9rJYwZlHywPnBTlOLtNurki76h31MfSk2VvDR9tXMA6W8y0zWxC3PJWn41n
	lFiKMxINtZiLihMBlOv5gbgDAAA=
X-CMS-MailID: 20250219140316eucas1p29a76023868946f090f261bf78d5103e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140316eucas1p29a76023868946f090f261bf78d5103e3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140316eucas1p29a76023868946f090f261bf78d5103e3
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140316eucas1p29a76023868946f090f261bf78d5103e3@eucas1p2.samsung.com>

T-HEAD TH1520 SoC requires to put the GPU out of the reset state as part
of the power-up sequence.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 474f31576a1b..6b34aab4b455 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/thead,th1520-clk-ap.h>
 #include <dt-bindings/power/thead,th1520-power.h>
+#include <dt-bindings/reset/thead,th1520-reset.h>
 
 / {
 	compatible = "thead,th1520";
@@ -497,6 +498,12 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		rst: reset-controller@ffef528000 {
+			compatible = "thead,th1520-reset";
+			reg = <0xff 0xef528000 0x0 0x4f>;
+			#reset-cells = <1>;
+		};
+
 		clk_vo: clock-controller@ffef528050 {
 			compatible = "thead,th1520-clk-vo";
 			reg = <0xff 0xef528050 0x0 0xfb0>;
-- 
2.34.1


