Return-Path: <linux-pm+bounces-32700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA64B2D753
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51A81C2085F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF82D979D;
	Wed, 20 Aug 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ibfp1KnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BB2DAFA5
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680174; cv=none; b=Pt72bo/Ypt+lDBgC+ayD5s4eGfX8atzgD0ecEDUYGjkVv0U66EXMmeBq2Ax+y/QdDx4PktFuh7S5VR5iHvd55xorRulZ/z4aYEyXHnFY1yqNr1mUgvpOgX1yzaJUo786PprOn2qJ0Weewz5a5WT5lgLEsRM7xWDYq3s0yzVwNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680174; c=relaxed/simple;
	bh=J9nSoGIUUBX/RwJcPgs11RnLDI8Wd23qmgJoOPrObJk=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=L3j5yJiqIJkbKy2tqsq3S7Zk3vwqvvHFNYmE/2Bm7xAf2FwnGHGUTi8uDPuqvZ6a54QmQvDB8cyJOTP+iEBaTslIkebnFZWnM5P9HuoeFAN6ew8wO8lJUFEGERiDt54XIbcPkj3DACJOtIgSgSkFOugOjD1LAuxgW/SByqFncUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ibfp1KnS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250820085610euoutp01b000ddb750626994a2c48ab49567b2b7~dbdAwHJYO0819808198euoutp01v
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:56:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250820085610euoutp01b000ddb750626994a2c48ab49567b2b7~dbdAwHJYO0819808198euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755680170;
	bh=7wXhsNFx7wk73mU27MUzNudMLyhrgEdd1dRIZ0ZRJc0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=Ibfp1KnS3xfP/49DpumEKZd9nvhU0X/fQDIlBvp+AkOPIvgZc3kTGkeg1xH7yOY6O
	 Piz3hZgPJ61FPV4x4AJFaKGFRg3uy8ijwXlTWwjE2SZiojqggIE4lkGkRBvhsitmfN
	 JL40LXGDMs3EyAYTY8zkfqljpovXM1M7HpSrgmQc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250820085609eucas1p25d7c6d67318b6c332e3f238705544b19~dbdADgYjP1096710967eucas1p2p;
	Wed, 20 Aug 2025 08:56:09 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250820085608eusmtip1fe63a9a679f2b0803c655110ee6a272d~dbc-DyyjL2656126561eusmtip1R;
	Wed, 20 Aug 2025 08:56:08 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 20 Aug 2025 10:55:54 +0200
Subject: [PATCH v12 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-apr_14_for_sending-v12-2-4213ccefbd05@samsung.com>
In-Reply-To: <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com>
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
X-CMS-MailID: 20250820085609eucas1p25d7c6d67318b6c332e3f238705544b19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820085609eucas1p25d7c6d67318b6c332e3f238705544b19
X-EPHeader: CA
X-CMS-RootMailID: 20250820085609eucas1p25d7c6d67318b6c332e3f238705544b19
References: <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com>
	<CGME20250820085609eucas1p25d7c6d67318b6c332e3f238705544b19@eucas1p2.samsung.com>

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


