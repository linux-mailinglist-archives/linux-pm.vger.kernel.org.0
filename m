Return-Path: <linux-pm+bounces-32844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B58B30915
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB4E04E6066
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33B2EBDC4;
	Thu, 21 Aug 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hAbhCwgF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25702EACEF
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814827; cv=none; b=G4bjswLmVmL4wtxTShqqP+26Z6///MtkBO9UK9e7OodjvMiaWLZD0PMZqcyQo+dMVeaxbiSdYBf9zpREZOF9x0qh2nMHTnpUX60O0KPVLjMg5R83olYBESWc4xsWtEUci709HYwJPAVr55lSsafm0s+Mxuha8hROiG3UUNPie0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814827; c=relaxed/simple;
	bh=D4360NGc5wqsYsaXK9a3mpTlXi2qgyOYm8aoOdUPo+w=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=rXMNO+C+7T/n5iFiQePMicY5iLIkj5FBQAa4OIH2dvqPWvB2aNh0XJTVorL/kPrydizGMBNp68gefFNlxPN3wze20IpXmL2oePdygE+to+RPHJzIrlsBh9x2iE7pY4QhMdhsmRnFKpSrFiR9m3ijp/KJpkPJvREEVsTwBeCWjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hAbhCwgF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250821222023euoutp020b04d518105384b93c2fb9c3c1ad7baf~d6EdqTFH_2894328943euoutp02B
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 22:20:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250821222023euoutp020b04d518105384b93c2fb9c3c1ad7baf~d6EdqTFH_2894328943euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755814823;
	bh=SoNkZnB/ZDH4173ojh3m2tOndFgBpgzx3po9ZkmxTE8=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=hAbhCwgFIrltaMqBAPehYQys9VjBS97uOB5k5fJWh/NBrCaPRMqspRWb+4CeQeqoy
	 mXH+mx6FgVmTosN6cWIjoDLRa3qSwzqRPfUKuX+06oHBxNJclDu/VBfFsJVeXPhGm+
	 jvaQGM40zWkEPtiQ1T4L67t4hFlS/2R7SgYWdBuc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250821222022eucas1p16a85eedbb11598fb0d9403fc41e24da9~d6EcoxKFM2014520145eucas1p1M;
	Thu, 21 Aug 2025 22:20:22 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250821222020eusmtip119b9c25fcb841bb6cbacefcd2f0fa7e3~d6EboXLIj1697316973eusmtip1V;
	Thu, 21 Aug 2025 22:20:20 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 22 Aug 2025 00:20:16 +0200
Subject: [PATCH v13 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-apr_14_for_sending-v13-2-af656f7cc6c3@samsung.com>
In-Reply-To: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250821222022eucas1p16a85eedbb11598fb0d9403fc41e24da9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250821222022eucas1p16a85eedbb11598fb0d9403fc41e24da9
X-EPHeader: CA
X-CMS-RootMailID: 20250821222022eucas1p16a85eedbb11598fb0d9403fc41e24da9
References: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
	<CGME20250821222022eucas1p16a85eedbb11598fb0d9403fc41e24da9@eucas1p1.samsung.com>

Rework the PowerVR Rogue GPU binding to use an explicit, per variant
style for defining power domain properties and add support for the
T-HEAD TH1520 SoC's GPU.

To improve clarity and precision, the binding is refactored so that
power domain items are listed explicitly for each variant [1]. The
previous method relied on an implicit, positional mapping between the
`power-domains` and `power-domain-names` properties. This change
replaces the generic rules with self contained if/then blocks for each
GPU variant, making the relationship between power domains and their
names explicit and unambiguous.

The generic if block for img,img-rogue, which previously required
power-domains and power-domain-names for all variants, is removed.
Instead, each specific GPU variant now defines its own power domain
requirements within a self-contained if/then block, making the schema
more explicit.

This new structure is then used to add support for the
`thead,th1520-gpu`. While its BXM-4-64 IP has two conceptual power
domains, the TH1520 SoC integrates them behind a single power gate. The
new binding models this with a specific rule that enforces a single
`power-domains` entry and disallows the `power-domain-names` property.

Link: https://lore.kernel.org/all/4d79c8dd-c5fb-442c-ac65-37e7176b0cdd@linaro.org/ [1]

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 37 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..c87d7bece0ecd6331fc7d1a479bbdaf68bac6e6d 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -21,6 +21,11 @@ properties:
           # work with newer dts.
           - const: img,img-axe
           - const: img,img-rogue
+      - items:
+          - enum:
+              - thead,th1520-gpu
+          - const: img,img-bxm-4-64
+          - const: img,img-rogue
       - items:
           - enum:
               - ti,j721s2-gpu
@@ -77,14 +82,18 @@ required:
 additionalProperties: false
 
 allOf:
-  # Constraints added alongside the new compatible strings that would otherwise
-  # create an ABI break.
   - if:
       properties:
         compatible:
           contains:
-            const: img,img-rogue
+            const: img,img-axe-1-16m
     then:
+      properties:
+        power-domains:
+          items:
+            - description: Power domain A
+        power-domain-names:
+          maxItems: 1
       required:
         - power-domains
         - power-domain-names
@@ -93,13 +102,20 @@ allOf:
       properties:
         compatible:
           contains:
-            const: img,img-axe-1-16m
+            const: thead,th1520-gpu
     then:
       properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
         power-domains:
-          maxItems: 1
-        power-domain-names:
-          maxItems: 1
+          items:
+            - description: The single, unified power domain for the GPU on the
+                TH1520 SoC, integrating all internal IP power domains.
+        power-domain-names: false
+      required:
+        - power-domains
 
   - if:
       properties:
@@ -109,9 +125,14 @@ allOf:
     then:
       properties:
         power-domains:
-          minItems: 2
+          items:
+            - description: Power domain A
+            - description: Power domain B
         power-domain-names:
           minItems: 2
+      required:
+        - power-domains
+        - power-domain-names
 
   - if:
       properties:

-- 
2.34.1


