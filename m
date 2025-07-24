Return-Path: <linux-pm+bounces-31385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2683B10D47
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62D71CC493D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4982E4273;
	Thu, 24 Jul 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mp8nJ1dm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50E2E2F01
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366758; cv=none; b=VwHBw3NQWl9zzCt4hvgIkgePfDXjJ2x6dRTL1bbef3h+F+bTGF4/B33bP7wtuQqMUdCDJWtBVTWUZ0LHs+jdxkzGyp0IMu+AM60aGXHxglUlaOiAzGDm0bzvZZy0Si2hxXWzuEy3hgbBpNnk6GpRAxYJ4K8yTWOcoZQiB9zAmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366758; c=relaxed/simple;
	bh=gAaau3A5BbXqAbIwaZvdrHpG2iArYv2vAWW10B6BkI0=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Nei0fj69H8tQMu1LaiW78c3O+2nDM3uagJRPLKKRqCOjvasqyfAjrmKe/DGpmMmGUJ5ogfNWoXjjE1YbD2n90yGcGTV/2JLQV4ujsNg7weyymyOD2/v9oYFo3d9MJXnfiLEN7kOzXIbWqPUUE5WUntzGxWg5cvJSja06fAIahl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Mp8nJ1dm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250724141912euoutp01437aec4f18f23a3aaea22bbce04084a5~VNcV-4n0i1183511835euoutp01G
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 14:19:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250724141912euoutp01437aec4f18f23a3aaea22bbce04084a5~VNcV-4n0i1183511835euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753366752;
	bh=CBTIoTUh/JK2Ij3TR8T6JZaiVwSrQaeq4RIFydAsf+s=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=Mp8nJ1dmBQmQDEwCWlyE6Hn4/nK4ZPjq8rQAQp+KNrIi3QywGIie3DpTXkBOtDDPj
	 xf1D80+YpLbc77Ni4STOPM9Eogvbg9WFXuvMsmz0FE0GvMKWCHx8TcJQQU+wnu40Bu
	 HxPnDjUEw0R9qWh+OkGW5dCoYdtC3EgkCUzu5SIY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250724141911eucas1p17071ea620f183faff7ca00cad25cf824~VNcVa5bj52680726807eucas1p1k;
	Thu, 24 Jul 2025 14:19:11 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250724141910eusmtip2a5cd8181dd521e8058bd91caf82ae834~VNcUU-_Gm0090400904eusmtip2x;
	Thu, 24 Jul 2025 14:19:10 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 24 Jul 2025 16:18:59 +0200
Subject: [PATCH v8 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-apr_14_for_sending-v8-2-0714bef83c59@samsung.com>
In-Reply-To: <20250724-apr_14_for_sending-v8-0-0714bef83c59@samsung.com>
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
	<krzysztof.kozlowski@linaro.org>,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250724141911eucas1p17071ea620f183faff7ca00cad25cf824
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250724141911eucas1p17071ea620f183faff7ca00cad25cf824
X-EPHeader: CA
X-CMS-RootMailID: 20250724141911eucas1p17071ea620f183faff7ca00cad25cf824
References: <20250724-apr_14_for_sending-v8-0-0714bef83c59@samsung.com>
	<CGME20250724141911eucas1p17071ea620f183faff7ca00cad25cf824@eucas1p1.samsung.com>

Update the img,powervr-rogue.yaml to include the T-HEAD TH1520 SoC's
specific GPU compatible string.

The thead,th1520-gpu compatible, along with its full chain
img,img-bxm-4-64, and img,img-rogue, is added to the
list of recognized GPU types.

While the BXM-4-64 GPU IP is designed with two distinct power domains,
the TH1520 SoC integrates it with only a single, unified power gate that
is controllable by the kernel.

To model this reality correctly while keeping the binding accurate for
other devices, add conditional constraints to the `allOf` section:
 - An if block for thead,th1520-gpu enforces a maximum of one
   power domain and disallows the power-domain-names property.
 - A separate if block applies to other B-series GPUs
   img,img-bxm-4-64 and img,img-bxs-4-64. A not clause within this
   block excludes the thead,th1520-gpu compatible, ensuring this rule
   requires a minimum of two power domains only for non TH1520 B-series
   GPU's.

This makes the binding strict and correct for both the specific TH1520
implementation and for other SoCs that use the B-series Rogue GPUs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..2c5c278b730145a983d1ddfa4014b3c5046bcd52 100644
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
@@ -84,11 +89,29 @@ allOf:
         compatible:
           contains:
             const: img,img-rogue
+      not:
+        properties:
+          compatible:
+            contains:
+              const: thead,th1520-gpu
     then:
       required:
         - power-domains
         - power-domain-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: thead,th1520-gpu
+    then:
+      required:
+        - power-domains
+      properties:
+        power-domains:
+          maxItems: 1
+        power-domain-names: false
+
   - if:
       properties:
         compatible:
@@ -105,7 +128,14 @@ allOf:
       properties:
         compatible:
           contains:
-            const: img,img-bxs-4-64
+            enum:
+              - img,img-bxm-4-64
+              - img,img-bxs-4-64
+      not:
+        properties:
+          compatible:
+            contains:
+              const: thead,th1520-gpu
     then:
       properties:
         power-domains:

-- 
2.34.1


