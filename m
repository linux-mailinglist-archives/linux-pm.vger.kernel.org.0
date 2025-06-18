Return-Path: <linux-pm+bounces-28941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6FADE8CC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C506170C08
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3AA2D130C;
	Wed, 18 Jun 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VO0BF2Bn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36652215F4B
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242155; cv=none; b=jtHuMVQPJ3TRRbDRe3LJysZgFTXghvtLnoSIt8rVbtGlWfdv0F0CopnyyLEGzetKFQZ0+7FmA9+p7wXghw3He8AzXza0CZKGV4gIAWkVJUHd6DNTIX3KlovNQXqdeAww9l/uXsEAtYE8foNVwZoJGGZ5CA7poMEBLb/wAkzeRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242155; c=relaxed/simple;
	bh=eR9cdrCin/2WwM2JFOAyF853o0XIv/Jp7dJICn3jmFA=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=NerYAqK/N9jc4FFcyFZd+f9YvK4E82UDtCOD/7dUz4V39nt0pO2ZwrcM2XDli6tOngPYYpsbmnAdcVIErabj1BGFFT/9p5wDgRlqJeB5WqoCiV4TpDMgnfB6/buxdPtt4gJMu1e6/NOEYOJObB2EGhi+UqrLSH9saIrqbkBkyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VO0BF2Bn; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250618102231euoutp02f17d86c2ba61dee3f1075688ca347ac4~KG-ap1NIj2862228622euoutp02F
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 10:22:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250618102231euoutp02f17d86c2ba61dee3f1075688ca347ac4~KG-ap1NIj2862228622euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750242151;
	bh=4SD9BrnW26vlYTv5xxgtljWZoRvQzpufshnL3EiSwm8=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=VO0BF2BnvZ6uKfjXzvjt5cjA01QcqVHTCEYqmHPHfB1VWytIKBci7OAdR8W3Bqdc2
	 ABIowxMHjmZ5o2QHYpE9RE1p3IxhNrHb59C1KTXrSOEXasbuRdKuyCcQ/w0K9jxAvc
	 IkQx78D56Fy5IT0U0KOX/3GazEd+7sbW9ilW7K8o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250618102230eucas1p2573610db9d4a9f3543d0048c30b2df9e~KG-aEi6uN1803418034eucas1p24;
	Wed, 18 Jun 2025 10:22:30 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618102229eusmtip132bf2e8d5ca6d3dcb5878ee5cd672b4c~KG-ZDGa291490514905eusmtip1I;
	Wed, 18 Jun 2025 10:22:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 12:22:11 +0200
Subject: [PATCH v5 5/8] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-apr_14_for_sending-v5-5-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250618102230eucas1p2573610db9d4a9f3543d0048c30b2df9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618102230eucas1p2573610db9d4a9f3543d0048c30b2df9e
X-EPHeader: CA
X-CMS-RootMailID: 20250618102230eucas1p2573610db9d4a9f3543d0048c30b2df9e
References: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
	<CGME20250618102230eucas1p2573610db9d4a9f3543d0048c30b2df9e@eucas1p2.samsung.com>

Update the img,powervr-rogue.yaml to include the T-HEAD TH1520 SoC's
specific GPU compatible string.

The thead,th1520-gpu compatible, along with its full chain
img,img-bxm-4-64, and img,img-rogue, is added to the
list of recognized GPU types.

The power-domains property requirement for img,img-bxm-4-64 is also
ensured by adding it to the relevant allOf condition.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..9b241a0c1f5941dc58a1e23970f6d3773d427c22 100644
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
@@ -93,7 +98,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: img,img-axe-1-16m
+            enum:
+              - img,img-axe-1-16m
+              - img,img-bxm-4-64
     then:
       properties:
         power-domains:

-- 
2.34.1


