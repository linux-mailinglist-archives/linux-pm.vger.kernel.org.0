Return-Path: <linux-pm+bounces-31750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7FB18037
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 12:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A49517E100
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924223F41A;
	Fri,  1 Aug 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YAGO7dEH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1A23C4E7
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044273; cv=none; b=p3p8A6Kvs07bVb2x9aBeCySlaYf0rv/o2QRW2ee2E9XQhIkVDlGD+G2+yhz2gQPwwDQyALiJddsoYAuDWQvDVy1N6XUlK0pUvUG4DanLfwWLHEf4PYUMrvlQON36DlIKRldMYYtnqO65XoBGSXJaMJLQuE+sfyMuTvBObY/a8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044273; c=relaxed/simple;
	bh=CPoVVJ9kAR/zf/dGjMW6fp3zTGBZ3OFKWXzguL6Iy6Q=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=ZuKpBHPrwvMRy8QSz/XL9A1z3lheNe7sa0Pp2iv3qGIANCitATjuliSeirU8Z505UaUMetK1ckq2dDApK9zXp4U31EA674dzhUnvwDfQIFa1ksGIUKH9u4Gf6nPflCwcQOaCgZvVNw8GU4F40IP5xoeslGIGhQ96t9LNHT/1RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YAGO7dEH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250801103107euoutp021b69e9ca748927017b911edc09c9216b~XnffY6d391049310493euoutp02c
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 10:31:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250801103107euoutp021b69e9ca748927017b911edc09c9216b~XnffY6d391049310493euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754044267;
	bh=yom+vqSiiKyOWV1plhd7ys8Xc1MwodRUoON3fPIoh/0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=YAGO7dEHfAEfjeXxBfEdJJiFHzWBTLym0YmJ3hJELhNiHneg0SZC26ltTtbaMltT3
	 D9ynGJVp4iHyzEY6eYYzgor3QBMvsnpXxcs3591Gw8hibyW+kpJnbnnSide0rHjwQk
	 QoMRtV9Z+SAR5yAE04YCaji4Y5nz3uqrFThHLfOE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250801103106eucas1p11c945f612fcf56ad2521151962d745b8~Xnferpw2y2792827928eucas1p1j;
	Fri,  1 Aug 2025 10:31:06 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250801103105eusmtip167bcd983d0f5d710a249d449f44b570f~Xnfdfh4YF0468904689eusmtip1Y;
	Fri,  1 Aug 2025 10:31:05 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 01 Aug 2025 12:31:02 +0200
Subject: [PATCH v10 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-apr_14_for_sending-v10-2-e85802902a29@samsung.com>
In-Reply-To: <20250801-apr_14_for_sending-v10-0-e85802902a29@samsung.com>
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
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250801103106eucas1p11c945f612fcf56ad2521151962d745b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250801103106eucas1p11c945f612fcf56ad2521151962d745b8
X-EPHeader: CA
X-CMS-RootMailID: 20250801103106eucas1p11c945f612fcf56ad2521151962d745b8
References: <20250801-apr_14_for_sending-v10-0-e85802902a29@samsung.com>
	<CGME20250801103106eucas1p11c945f612fcf56ad2521151962d745b8@eucas1p1.samsung.com>

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

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 33 ++++++++++++++++------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..dc53ed59331bedee2d7438288f482870714bbf46 100644
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
@@ -93,13 +102,16 @@ allOf:
       properties:
         compatible:
           contains:
-            const: img,img-axe-1-16m
+            const: thead,th1520-gpu
     then:
       properties:
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
@@ -109,9 +121,14 @@ allOf:
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


