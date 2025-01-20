Return-Path: <linux-pm+bounces-20711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D86FA1717A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD38C3A2BF0
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290381F130A;
	Mon, 20 Jan 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bLSpcbg+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B431F0E37
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393700; cv=none; b=kP7uBvykdF9n2455baF9YAbd/MAp9QrQC+mwMK8HAWmzE6/A/W7e8tBZlA4gjzHjqJk+dLD4zuvXXhxe1rU+sYs8qYRJ0Myr6Pm4dzm/68T/jn4p/j+5jayBCmEd0JkMQyrYolrl8nj23lBLwSIXjP5O9FJ16agzxLjf5LP+Mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393700; c=relaxed/simple;
	bh=Mm2DUSTa19sWrg1SxdYfUELJBx6LFLVkQtXc5CWKLLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Q1/4puMH7Iz5Sk5HIkT63KldqazRWeKIgtGqGkZZZNPZc1f9b3H6uVN1nIgPJ5SecvnaCJDmGvfGgtaE+GHcA6Y5Dwg1hqzm5Zc/bIkS9l7I3P0IMiefOu1Z2Lfryje/8yP4VP5ZnMSrimPJ/ttlvaqK72m6vEZG8mpIlXPCm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bLSpcbg+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250120172135euoutp01b342d12d3ebcf860d66ad0fcf1f1233c~cdlxlgZ6I2524325243euoutp01D
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250120172135euoutp01b342d12d3ebcf860d66ad0fcf1f1233c~cdlxlgZ6I2524325243euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737393695;
	bh=0x+jTDBCnw7vZtDxONZ6MIeE0FCrGQ60p2jf1xVr5xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLSpcbg+gkQHOLImcRiVqnQ+mL676KDWvBQ8CbaxSibEKDfdWs+YTbDLAT7F/6IkC
	 dX1JJWINNtzGb8WHVmNzMsl7T2phUdsO5lblsxUQQuWmk1RrZ/1alzU5zg/GChM+yq
	 WxwtW9QEg6m2NPy9pVARTJ6W6wuHrAK77fGWs6NU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250120172134eucas1p2c9fc996f9cc98a55ee75a6020144181e~cdlxF2ypK1089910899eucas1p21;
	Mon, 20 Jan 2025 17:21:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.66.20397.E168E876; Mon, 20
	Jan 2025 17:21:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172134eucas1p18cbf29a4ade281df10efce210cc8893e~cdlwl6DU-1576915769eucas1p1K;
	Mon, 20 Jan 2025 17:21:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250120172134eusmtrp216e6d41bb4e2de16eb778a67912c1e27~cdlwlK2wf0490804908eusmtrp24;
	Mon, 20 Jan 2025 17:21:34 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-5c-678e861ed9be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.A5.19654.E168E876; Mon, 20
	Jan 2025 17:21:34 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172132eusmtip156c00c2a165f8d99eb90bc0451aa709c~cdlvRl8za1308113081eusmtip1b;
	Mon, 20 Jan 2025 17:21:32 +0000 (GMT)
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
Subject: [RFC v3 11/18] dt-bindings: gpu: Add compatibles for T-HEAD TH1520
 GPU
Date: Mon, 20 Jan 2025 18:21:04 +0100
Message-Id: <20250120172111.3492708-12-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120172111.3492708-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTdRjn+77v3vdlNXwZGN8To4sSgU6Y0tVX9BA7Pd8zCfmjg9JOZrw3
	LBi2QUVkYcBOcIBpXDB+DD0uJhetzW3xe4Bjg9JJkINKFpx4MSQQgTzqkhgvlv99nufzeT6f
	57l7aFxsJjfRJ+TZnEIuzQglhYTFvnxjW4iqTCYxuiWof+QShsx/ayj0dacTQ1qbU4DcQyYM
	/bQ0R6Jv7gxSaKrzNIFculoKFdj1JPJo3CSaV7sFaLithkQLpTaALAuFJGq2jVFIv6TF0MV5
	M4EaWtoAUhV/JUA/fr8fjbn7CeQZVuNIpdmAVjpaKPTQZSBQ9ayVQqaZzwXI0ZyMCq1fEPEh
	7NxoEcXOeDwEe/XMIsV2/llPsK2aMYpVt14DrLGpmGRvuTpItm4gif3trANjrzR8yhY22zG2
	/B8JO9d1k2TLTE2AHSoYoQ6L3xTuTuMyTrzPKaLjUoXpjRX5gpP9QR/W2luwfNDOlABfGjIv
	wva71VQJENJiRgdgXV8/4ItFAId+6VlnFgC0Xq7BHo3MuysJLxYzjQDeHk/jRTMA2jzGNRHJ
	7IDjjVqBlwhkighY1Hd6zRdnfgfQMllDlgCaDmCSYPGoyDtAMFug06YHXixi4mFJYz3Bpz0D
	rT3XcS/2Xe0/uNlJ8Rp/OFA1uabBVzUF5mrc6w8ZgxDqZr0EvVrsg2VqCe8TAKcdJorHm+FK
	q3b9miw4br6P8/hj2Kp2rONd8Jbzr7U1cSYC6tui+fZeWFtXifPufnD0D39+Az943vLlelsE
	z6jEvDoMVqhL/wt16izroSw0Dd7AzoFnNY/donnsFs3/ufUAbwJBXI4yU8YpY+TcB1FKaaYy
	Ry6Lejsr0whWP/uHh46lFqCbno/qBRgNegGk8dBA0cZ7aplYlCbN/YhTZB1T5GRwyl4QTBOh
	QaJL1iKZmJFJs7l3Oe4kp3jEYrTvpnws/r1Q5wvlO9PDfZqnj4V8qw2/HZczMRzzhnE+5Wr5
	g4wL+b8W7znSro9MTnidqTokSSVcPs3329vOxSYcfOfl7pSjkuXuprqVxJjsvJFX9aYn8sI3
	z01PWiwTeWyH71sVW4MvJh/1fzK2gMoNIKYqVWD5acOpHRPBT+1e0iaZlgK7fbYMR1xPlCce
	VNCL9bUJssFOfLvJlRjth11JOjKQcffCa9bUQ4o9kfHpYRUNhsuvkAcMBtFQVeHx2J+3fnZv
	13nF88rnpnX6TzxxG1X2wwIOk6ecmhOV7ZstvVYd+5KQKBL6c3s3TGBdB/ZHnE3IntrpyO3a
	Fi/t8wzK7xy3hX3XE0oo06XbI3GFUvovUa0VuEgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xu7pybX3pBr2z+S1OXF/EZLH19yx2
	izV7zzFZzD9yjtXi3qUtTBZXvr5ns1j39AK7xYu9jSwW11bMZbdoPraezeLlrHtsFh977rFa
	XN41h83ic+8RRottn1vYLNYeuctusf7rfCaLhR+3slgs2bGL0aKtcxmrxcVTrhZ3751gsXh5
	uYfZom0Wv8X/PTvYLf5d28hiMfvdfnaLLW8mslocXxtu0bJ/CouDnMf7G63sHm9evmTxONzx
	hd1j77cFLB47Z91l9+jZeYbRY9OqTjaPO9f2sHnMOxnocb/7OJPH5iX1Hi1rjzF59P818Hi/
	7yqbR9+WVYwel5qvswcIRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehlLJ/awFpwQrxi7rEdTA2MuwW6GDk5JARMJD7em8HSxcjFISSwlFHi6adf
	bBAJGYlr3S9ZIGxhiT/Xutggil4xSpxde40dJMEmYCTxYPl8VhBbRGAxi8TefZUgRcwCbxkl
	rs/cCNYtLOAv8ePAUiYQm0VAVeLckfWMIDavgINE1/IFUBvkJfYfPMsMYnMCxb9f3Qu2QEjA
	XuLO1W6oekGJkzOfgNUzA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1
	kvNzNzECE8y2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIryiH3rShXhTEiurUovy44tKc1KLDzGa
	At09kVlKNDkfmOLySuINzQxMDU3MLA1MLc2MlcR52a6cTxMSSE8sSc1OTS1ILYLpY+LglGpg
	WnP0fl7Bt+zvRYedHlufcJ9hy3/qTWSz9fI9oWHmMvWbJgeHNqu1i8yYYf2hwz5o/xPVc3a9
	6ww0Os7VHFuV8GTOzU+5UpsfTJyScPC86RTVqz5pU2OlTN3aLf6tWfVobvfyFOkJ0/85qV6b
	L7y0Yz/vyvQ3jziuKRn8WJVt/KrC8k/chb+mgX82bE7nP53ssu6fdUnP7u9S+y6L60rOmvCh
	je/YxvJDM2SO7I58KLQ78cx2TZ4TGfdeHUqwZv8UqZtWq3cn6PH7pqsLZNueb/Y7r71pgsF8
	DQ+eX0Lun8ujFrOa3FdYxnTCfeYkJYa8AKeXxxu337g1Ve7FHdO16le/P7r8I7A/86Pjxsa9
	XuuUWIozEg21mIuKEwFhmFEIuQMAAA==
X-CMS-MailID: 20250120172134eucas1p18cbf29a4ade281df10efce210cc8893e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172134eucas1p18cbf29a4ade281df10efce210cc8893e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172134eucas1p18cbf29a4ade281df10efce210cc8893e
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172134eucas1p18cbf29a4ade281df10efce210cc8893e@eucas1p1.samsung.com>

Add a new SoC-specific compatible ("thead,th1520-gpu") for the T-HEAD
TH1520 GPU, alongside the Imagination BXM family compatible
("img,img-bxm").  This documents the GPU integration on the T-HEAD
platform.

Also adjust clock name constraints to accommodate a second clock named
"sys" instead of "mem" for T-HEAD. This is achieved by using allOf. For
now there are no users of 'mem' so remove it.

Provide example of the new GPU node.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/gpu/img,powervr-rogue.yaml       | 55 +++++++++++++++----
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index bb607d4b1e07..3c0eaa0ae827 100644
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
+          - const: img,img-axe
+      - items:
+          - enum:
+              - thead,th1520-gpu
+          - const: img,img-bxm
 
   reg:
     maxItems: 1
@@ -25,11 +30,8 @@ properties:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: core
-      - const: mem
-      - const: sys
     minItems: 1
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -47,8 +49,6 @@ required:
   - clock-names
   - interrupts
 
-additionalProperties: false
-
 allOf:
   - if:
       properties:
@@ -58,7 +58,28 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 1
           maxItems: 1
+        clock-names:
+          items:
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: thead,th1520-gpu
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: core
+            - const: sys
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -74,3 +95,17 @@ examples:
         interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
     };
+
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/firmware/thead,th1520-aon.h>
+
+    gpu: gpu@fff0000 {
+        compatible = "thead,th1520-gpu", "img,img-bxm";
+        reg = <0xfff0000 0x1000>;
+        interrupt-parent = <&plic>;
+        interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk CLK_GPU_CORE>, <&clk CLK_GPU_CFG_ACLK>;
+        clock-names = "core", "sys";
+        power-domains = <&pd TH1520_AON_GPU_PD>;
+        resets = <&rst>;
+    };
-- 
2.34.1


