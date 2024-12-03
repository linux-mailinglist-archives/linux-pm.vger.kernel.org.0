Return-Path: <linux-pm+bounces-18460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A852D9E1DE9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4C4283B07
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5541F12F6;
	Tue,  3 Dec 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dPo+T0rd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDDF1F4271
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233327; cv=none; b=CgMN+bRLFYyG7YC+A8dvtdBmXClvQtza1grDY+8bclOvFdaJ7ZF6AP64ctZXpTw/CyYxqHKoSQj/EbACStPcn/BUjQJssUpCytZJjLF82Cu2DlZbtL4Mef9g4PqXawBywsLcC0kodGIujrP7S4ILTcPuJHw/WQvD17AlKoRHRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233327; c=relaxed/simple;
	bh=Nqyna1A9VacqtygRVnIGLEVKoTV2UL7pR34DW34RArY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ZmpDrray56WJJOt+fwpACAV0E2Jgu70vrxT6qtn08KtfasdlW1uwDb2zTPXNxSfOb/xRNoodxadQT9ZMt72MZKvSPQhsrbD9m+TQqlTk1kKpRy3k/kgyaw5+ctoM/V7iGP39uMSBadVOv4PsQoQLSzFKi1UsvnjC84Y43prKaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dPo+T0rd; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241203134156euoutp02729590d55246986b616a2a2ff38c7583~NroSoGzBx3035730357euoutp02e
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 13:41:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241203134156euoutp02729590d55246986b616a2a2ff38c7583~NroSoGzBx3035730357euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733233316;
	bh=oC+R2AH5wsqjet5ieb6+rxFp1u3nZ9Z07QmkpORzdC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPo+T0rdkn45cMrQ0jm8Wk68x/51nKYFsWCfxjcXwXzxO8hNluqZ+bNekjTxg25M2
	 b2A4WmUf/rNntP1/Pfdt5buqOCP3Y/0sCrjq3OJIxrnKhNtpj/h+qzAxKS21P7QA1N
	 jT0OfDLgP79B2U62XG8Ruds92UaGgh9b6y80zIkU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241203134155eucas1p294a7b3f321d9cfa02c1aad2d8fa8d87e~NroSMRyE71760217602eucas1p2r;
	Tue,  3 Dec 2024 13:41:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 56.CA.20821.3AA0F476; Tue,  3
	Dec 2024 13:41:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7~NroRwtF5v1266212662eucas1p1w;
	Tue,  3 Dec 2024 13:41:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241203134155eusmtrp1407a8f487afcd4c15fd63225fc616274~NroRv7CKL0888908889eusmtrp1C;
	Tue,  3 Dec 2024 13:41:55 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-6b-674f0aa3a1bb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.F6.19654.3AA0F476; Tue,  3
	Dec 2024 13:41:55 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203134153eusmtip2eceb173357aae7426c9f6aa66d4a47de~NroQX2oFo3160631606eusmtip2D;
	Tue,  3 Dec 2024 13:41:53 +0000 (GMT)
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
Subject: [RFC PATCH v1 05/14] dt-bindings: clock: thead,th1520: Add support
 for Video Output subsystem
Date: Tue,  3 Dec 2024 14:41:28 +0100
Message-Id: <20241203134137.2114847-6-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203134137.2114847-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjed87pOaVZ8VBc+qXg2FgwMjIuuixfcDKmgx2iCc4sIdsypIyz
	YsbFtCAgJkOLTKDdxi3MUi4OFNaAXbFlXMpQ6KhaYBsqoAHGiHWrIKRctilaRjl189/zvs/z
	vO/7fPn4uMhASvhHMrJYeYY0LZAUEB2DD0deaxTEy8JPd4Wjq+PfYsi0pqFQa+8IhuotIzw0
	PWrE0M3VRRJdtP9CoT97TxJorKWWQspBPYkcmmkSOVXTPHSjW0uiZbUFoI7lQhK1WaYopF+t
	x9A5p4lATZ3dABUVX+ChX6/HIMcNFY6KNFvQurmTQq4xA4FqFvooZJwv4yFrWwIq7Kskorcx
	ixOnKWbe4SCYgTMrFNP7VwPBdGmmKEbVNQSYdl0xyUyOmUmm7tp7zG+lVoy51PQ5U9g2iDGL
	P94imS+NOsCMKscp5pIt/6DPh4I3U9i0I8dYeVhUkiB13TZKHB0Q51aNv1EAbolKgBcf0q/D
	ldovyBIg4IvoFgAHrWbAFSsAunoWPcwygCvLp6inFofGRXBEM4DlP9+juGIewK4a86aKpHfC
	meZ6npvYSs/hcGL19uYsnP4DwI67WtKt8qVTYcmAGndjgg6Clkn7pltIvwXtlx+Q3L4A2Hdl
	eFPjRUfDuaoSHqfxgdfO3iXcGN/QKE01OKf/TgAbe2I5/A78qu5vjMO+8L7V6MngD20VKoLD
	mXDGtOTxnoBdKqsH74aTI482buBvzA+G+u4wrv02vGptodxtSHvDiQc+3AXesLyjGufaQnim
	yPO+22GVSv3f0pGWDs8xDJz93kR8DV7WPJNF80wWzf97GwCuA2I2W5EuYxURGWxOqEKarsjO
	kIV+kpneDjZ+tc1lXeoEtfedof0A44N+APl44FZhs36/TCRMkeYdZ+WZh+XZaayiH/jxiUCx
	MCglgBXRMmkW+xnLHmXlT1mM7yUpwKIPTVrL/Cr+8Y/cgxmS/WNOCYy7vGOX7IlbYkPq3p15
	nDeaElBaY26/rd/jzYq1zkRFTLfA8jtmM79iUDfk6lZlF5+futxn3dFZoRM/UkaF1xlCatVr
	5uIDzav4wrG4A5LI7ezZ+DzJc+qChW/27aoc+DSo3y/HmnCubN/JO1l7g2201+E7ZtHazQR1
	clRd2GNV8pNWOKsaiqh+QRzXnrtCz+y990GO7sRPwT/EzWEP4z/edl63Yy0yxDksm9dW98Y7
	9OUN8Pr+vHw62Tk6bJpPtw+dj5ndqe12ReTnv3iwuicpqfUJeyW7MtFXqbV81ERKjlONhvXd
	yCeotPGl9wMJRao04lVcrpD+C1022ddEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xe7qLufzTDf7eELQ4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVq8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPN7vu8rm0bdlFaPH
	pebr7B6bT1cHCEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZfw/fYml4LB4xdTrZg2MV4W6GDk5JARMJF7O+scCYgsJLGWU+LZPFSIuI3Gt+yUL
	hC0s8edaFxtEzStGidY/NSA2m4CRxIPl81m7GLk4RAQ6WSTebl7LCOIwC7xllLg+cyNQNweH
	sECaxI79kiANLAKqEkfuPGUHsXkF7CWeHnjLBrFAXmL/wbPMIDangIPE66ldrBDL7CV2/D3M
	ClEvKHFy5hOwg5iB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
	GIEJZduxn1t2MK589VHvECMTB+MhRgkOZiUR3uXrvdOFeFMSK6tSi/Lji0pzUosPMZoC3T2R
	WUo0OR+Y0vJK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCUamBqsePT
	dIlyDRQ8P2ObSqDNrp2asydliV4uOs2wWfngNKvpxc22HlwRa2u3pcQmntfh/Lrg0fzJJ73D
	7LR1fkuYhu97rmrPlh6461fMQRdfgyO3uhb6PeVKbnrL1XrROWSWUWD3vFL5KMEtaVPb7rQy
	Ktfa/mSY3ZW9XHf5nHczvc/UKoqf232KU99cp6Vp/q4SQfeqzz/OehVLaj6cIMIbYXOa41+q
	m8/S26ubcn5Eqs9Ie3Uh8ATfk5kaa3Jk91qJrZq8O8GSP8A609MzJnfXEitdoaaPz60u622y
	Dln+1XWB88OtG2/52F48O/X0qWlmleEc3Q0Pl//0iF+4SUTp0alP6ySf7j/fJD7lbrESS3FG
	oqEWc1FxIgDl0upfsQMAAA==
X-CMS-MailID: 20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
	<CGME20241203134155eucas1p1e90c71c4f8eb5da41d2cc8a500f54dc7@eucas1p1.samsung.com>

The device tree bindings for the T-Head TH1520 SoC clocks currently
support only the Application Processor (AP) subsystem. This commit
extends the bindings to include the Video Output (VO) subsystem clocks.

Update the YAML schema to define the VO subsystem clocks, allowing the
clock driver to configure and manage these clocks appropriately. This
addition is necessary to enable the proper operation of the video output
features on the TH1520 SoC.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml   | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
index 4a0806af2bf9..5a8f1041f766 100644
--- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -4,11 +4,13 @@
 $id: http://devicetree.org/schemas/clock/thead,th1520-clk-ap.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: T-HEAD TH1520 AP sub-system clock controller
+title: T-HEAD TH1520 sub-systems clock controller
 
 description: |
-  The T-HEAD TH1520 AP sub-system clock controller configures the
-  CPU, DPU, GMAC and TEE PLLs.
+  The T-HEAD TH1520 sub-systems clock controller configures the
+  CPU, DPU, GMAC and TEE PLLs for the AP subsystem. For the VO
+  subsystem clock gates can be configured for the HDMI, MIPI and
+  the GPU.
 
   SoC reference manual
   https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
@@ -20,7 +22,9 @@ maintainers:
 
 properties:
   compatible:
-    const: thead,th1520-clk-ap
+    enum:
+      - thead,th1520-clk-ap
+      - thead,th1520-clk-vo
 
   reg:
     maxItems: 1
@@ -29,6 +33,17 @@ properties:
     items:
       - description: main oscillator (24MHz)
 
+  thead,vosys-regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to a syscon node representing the shared register
+      space of the VO (Video Output) subsystem. This register space
+      includes both clock control registers and other control
+      registers used for operations like resetting the GPU. Since
+      these registers reside in the same address space, access to
+      them is coordinated through a shared syscon regmap provided by
+      the specified syscon node.
+
   "#clock-cells":
     const: 1
     description:
@@ -36,8 +51,6 @@ properties:
 
 required:
   - compatible
-  - reg
-  - clocks
   - "#clock-cells"
 
 additionalProperties: false
@@ -51,3 +64,9 @@ examples:
         clocks = <&osc>;
         #clock-cells = <1>;
     };
+
+    clock-controller-vo {
+        compatible = "thead,th1520-clk-vo";
+        thead,vosys-regmap = <&vosys_regmap>;
+        #clock-cells = <1>;
+    };
-- 
2.34.1


