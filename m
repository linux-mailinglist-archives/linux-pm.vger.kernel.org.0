Return-Path: <linux-pm+bounces-22442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2AA3C175
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC17D1888704
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCF1FF617;
	Wed, 19 Feb 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DQeWsjcW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3D1FE469
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973795; cv=none; b=uEqcYDAzV9K6PVL+py6eu02Ejagi+TGVcqOYbnNOhAYNapZQMuGD0yV1dUe86KPhEI/dDE6Bn8XWR5CniGiGvg+DITnVLEehXBYNI6cV/SIXAjx9/s0OeoBNBy0ZpinuSrsazBdbmQTUgh2I/omsgdER7cvJgHI5cbaW0CfctdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973795; c=relaxed/simple;
	bh=sUfECY4mh9bIPUqSm/k+KW9gXgOW7f8w1bdqePlquiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jfy7l1tCxH7lbcQnL9A7IkCQvnlOeRNiUku7b1nc7+G3jsOvcwWxr7P+E62Qrqa5ELzlGCWX7CHvyu3EFhMr06fMX2YEwIuI054pOkpwR3fPJg3HPPsifC0dcTpKyopDXk8Yf2A1YX5glas8UNAxi12vpkZAuDl6m6Bo1CGljpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DQeWsjcW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140311euoutp02fe33663680c5d8efeea96e2fd61f45c0~loPHQN_pZ0195001950euoutp02I
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250219140311euoutp02fe33663680c5d8efeea96e2fd61f45c0~loPHQN_pZ0195001950euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973791;
	bh=zVWGqQ/Us1vb0L8Nqr12EBbUqYTxiCOVfIHvuCCwVWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQeWsjcWA08NQSnTBqt/mk3Zq9olNA2lwhHqZOtOCPQI1F0hjgUIomY68T2XeFPPG
	 bJ6GcvJ23zV0X0f1WxiUcKPVDgJiV/wEI7et6Nm14LMrar0Rf7fM837vjUCeDQVlYc
	 CuWtF3fmjXeTGe2RLsEUdcJQHtnC9qJjyDUW0vik=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140311eucas1p19bf166de2cd9bd9e8b60f2e0ce183b2b~loPG1ENL02256322563eucas1p1e;
	Wed, 19 Feb 2025 14:03:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.83.20821.E94E5B76; Wed, 19
	Feb 2025 14:03:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250219140310eucas1p1297441a3da276569cd86b6b9e4544242~loPGaVxzP1847218472eucas1p1l;
	Wed, 19 Feb 2025 14:03:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250219140310eusmtrp23afeb1a6ee652e5aeb4a79ce933a20fb~loPGZjLys2432224322eusmtrp2S;
	Wed, 19 Feb 2025 14:03:10 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-6d-67b5e49eb9f3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.62.19654.E94E5B76; Wed, 19
	Feb 2025 14:03:10 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140309eusmtip251472ade004dd5be738468c1ae6e60fb~loPFJXPpw0723207232eusmtip2I;
	Wed, 19 Feb 2025 14:03:09 +0000 (GMT)
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
Subject: [PATCH v5 15/21] dt-bindings: gpu: Add support for T-HEAD TH1520
 GPU
Date: Wed, 19 Feb 2025 15:02:33 +0100
Message-Id: <20250219140239.1378758-16-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRy/533fve8YTV8GF8+R6TFOTCQQortH0qA7qzfvutSu6w4LXfoy
	qP3QDQqMU35thzhSFJoMBFQIWhAnsrHtgJ0LGD9kBdKglB/XAQkRCEipFMR6sfzv8+v7/Tzf
	u4ePi8xkAD9JkcyqFBKZmBQQ5o5HrhfLxk3SnQvOaNQ5eBVDpmUDhWpbXBgqb3Px0Eh/I4YG
	luZI9O3EDxS615JJIHfNZQpld9STaMowQqJ53QgP3baVkmgxvw0g82IOierahilUv1SOoSvz
	JgJVWmwAac98xUN93a+j4ZFOAk3d1uFIa9iIVpstFFpxXydQyaydQo0zBTzkrHsf5dgLidjN
	zNyQhmJmpqYI5rvcBxTT8kcFwVgNwxSjs94CTIPxDMncdTeTTFnXAWb0rBNjblSeZnLqOjDm
	3N87mbnWH0nmi0YjYPqzB6n9ojjB7mOsLOlTVhX+6hFB4kPnfd5xiyj1QvclXgZoFuYBLz6k
	o+C0NpfKAwK+iK4BsHbcgnHkAYCd5+wERxYBLJswkk9GhvQNJGdUA/i9Qb9OZgA8X2jjeVIk
	HQnHqst5HsOP1hBQ054JPASnfwXQPF767y5f+h14P6sNeDBBb4XfLA6uFfL5QjoWLtUkcXVb
	oP1mL+6Rvdbk1r4AjyykfWBX8TjhwfhaJNtUgnvWQ9okgFXuKYyb3Qsdq0bAYV847WykOLwJ
	rlrL1zNKOGZawDmcDq065zp+Bd51PSY9vTi9Hdbbwjn5NejscwKPDOkNcOh3H+4JG+AFsx7n
	ZCHM1Yq4dDAs0uX/V+qqMa+XMrBhthY7DwINTx1jeOoYw/+9FQA3An82RS2XsuoIBftZmFoi
	V6copGFHlfIGsPa1e1acCxZweXo+zAEwPnAAyMfFfkLt6UapSHhMknaSVSkPq1JkrNoBnuMT
	Yn/hVbtGKqKlkmT2E5Y9zqqeuBjfKyAD02uF0TFLO5TLH25vPXHtDeEdOQgNuHRgd9Z8VN+u
	IqMs8k1jiZc0QTwRl7dSvG9LpHcqLA1t7d60p3tSFx9U3eS6cSI2rv+QPvyln58NORtoV2xM
	S6B7Ht97d9vMex/7yg+OBVWMBJX8krq1VzB5ZNaYvu9WcZNAExEdcUrfZeo5JfM+mftncgUp
	/TogLWc0dECJHh1OD5YnuDXx/hdDu9/+8qNETUimw2eHZOKaX9VyRv6sdXCzT1XpC0g5eaXA
	e09gSX17cXBsYF3hrpffOtokrjx087eiZ2zumTvPD8QH6wp+yg5uz68Oa45yjH4uSph8qJDE
	fDC5Hxvo3etfHvNXVsx1MaFOlESE4Cq15B+pDEKGSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xe7rznmxNN2j8K2dx4voiJoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbK48vU9m8W6pxfYLV7sbWSxuLZiLrtF87H1bBYvZ91js/jYc4/V
	4vKuOWwWn3uPMFps+9zCZrH2yF12i/Vf5zNZLPy4lcViyY5djBZtnctYLS6ecrW4e+8Ei8XL
	yz3MFm2z+C3+79nBbvHv2kYWi9nv9rNbbHkzkdXi+Npwi5b9U1gc5Dze32hl93jz8iWLx+GO
	L+wee78tYPHYOesuu0fPzjOMHptWdbJ53Lm2h81j3slAj/vdx5k8Ni+p92hZe4zJo/+vgcf7
	fVfZPPq2rGL0uNR8nT1AKErPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEv48fxD6wFO4QqJp2awdrAuIe3i5GTQ0LAROLG9E1sXYxcHEICSxklJjx6
	wwyRkJG41v2SBcIWlvhzrQuq6BWjxP0NL5hAEmwCRhIPls9nBbFFBBazSOzdVwlSxCzwllHi
	+syNYN3CAr4Sbz6cBGtgEVCVWP35OlCcg4NXwEHi64pMiAXyEvsPnmUGCXMChfddlAIJCwnY
	S5zruw82nldAUOLkzCdgE5mBypu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5xaV5
	6XrJ+bmbGIHJZduxn1t2MK589VHvECMTB+MhRgkOZiUR3rb6LelCvCmJlVWpRfnxRaU5qcWH
	GE2Brp7ILCWanA9Mb3kl8YZmBqaGJmaWBqaWZsZK4rxsV86nCQmkJ5akZqemFqQWwfQxcXBK
	NTBp2117emvx5Gun7yQwXtZz3HVNpFfxV5zIsmibZx2TOlOXp0z/8sW4z+v6u1V+PdP/2lvr
	Pgjm++18+sBlXXaLPazWQe1n1u++ICNzI/MSz/l/V3eLB11SvXm6SGadecL2lo6iy3e6OTh1
	Npf8f82vUzFv3mH+Jc/feG+/t6pKOHiF7ELZtZIcrxIv2l74+L/IseWPv/ELPukLM7Yk9X//
	+7nimGD/Q8n5d6UWhD1ck3pj6/OrQfbcy+ZJ3MhytFz18eGlKX3vAp4yn/2q+E3aZ9HUwL2z
	VpfO4AjZMEdn8aaaZUwN2raZB2en3t7L8fMm8/K5fz95agfaXVHY/jzdq+X5+cecnBeOqT8U
	5/lYM0mJpTgj0VCLuag4EQCNO9AQtwMAAA==
X-CMS-MailID: 20250219140310eucas1p1297441a3da276569cd86b6b9e4544242
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140310eucas1p1297441a3da276569cd86b6b9e4544242
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140310eucas1p1297441a3da276569cd86b6b9e4544242
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140310eucas1p1297441a3da276569cd86b6b9e4544242@eucas1p1.samsung.com>

Add bindings for the PowerVR BXM-4-64 GPU integrated in the T-HEAD
TH1520 SoC.

Add a dt-bindings example showing the proper usage of the compatible
string "thead,th1520-gpu" along with "img,img-bxm".

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/gpu/img,powervr-rogue.yaml       | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index bb607d4b1e07..2005dcefcaf9 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -12,10 +12,15 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - ti,am62-gpu
-      - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
+    oneOf:
+      - items:
+          - enum:
+              - ti,am62-gpu
+          - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
+      - items:
+          - enum:
+              - thead,th1520-gpu
+          - const: img,img-bxm
 
   reg:
     maxItems: 1
@@ -60,6 +65,16 @@ allOf:
         clocks:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: thead,th1520-gpu
+    then:
+      properties:
+        clocks:
+          minItems: 3
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -74,3 +89,19 @@ examples:
         interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
     };
+
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/power/thead,th1520-power.h>
+    #include <dt-bindings/reset/thead,th1520-reset.h>
+
+    gpu: gpu@fff0000 {
+        compatible = "thead,th1520-gpu", "img,img-bxm";
+        reg = <0xfff0000 0x1000>;
+        interrupt-parent = <&plic>;
+        interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk CLK_GPU_CORE>, <&clk CLK_GPU_MEM>,
+                 <&clk CLK_GPU_CFG_ACLK>;
+        clock-names = "core", "mem", "sys";
+        power-domains = <&pd TH1520_GPU_PD>;
+        resets = <&rst TH1520_RESET_ID_GPU>;
+    };
-- 
2.34.1


