Return-Path: <linux-pm+bounces-29280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC914AE3E52
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2C2188EFF6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E2248888;
	Mon, 23 Jun 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mOx5eqim"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACD246BD1
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679080; cv=none; b=BNrfedH/UHaCY793nmQ2q2UzBq9f14Jq/1HLaVo8A5hdgBPCoSRH3jJgbrKCdR+mijvG7K/lFPBRJgFC7xbCd3Ntgs8AZu0QeAqHtEHAubSC2gCdZ7ZHdBXnLy15q9KjgkZXnVKCbXsxj5ILwPBIR7kDThFXhWMASr8VvX5NT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679080; c=relaxed/simple;
	bh=hh0yfnQUKhiTf5bjsq6MDQVxmkCOxIApaADjJF4CNQg=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=ID9Xek7qeeA7OMpAB7Au/A+2V7BnJmuwVhtij4bAC7pd4p/S8I0itTZjgEfiR3oRVQTDcfYlu+aZAJmpD+URapTpfSu5Ps6qOUIzQMvcJdRZrlFK8moGCO2SFFPk5VF26Be3sCtWNe8Yd76LSzG85GZV9l1wOJ6US2hufFd4vDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mOx5eqim; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250623114437euoutp01da9c4660ddad76dad13710d9b867de53~LqVhZ5kcK3199831998euoutp016
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 11:44:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250623114437euoutp01da9c4660ddad76dad13710d9b867de53~LqVhZ5kcK3199831998euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750679077;
	bh=H1rGnOtR74xeJYKxpm+NO1laK19Izpd1vlfX7eD26VQ=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=mOx5eqimlZ+gVjVSPRyaCHXhHMjcdG+cfvwt1k9HIk98ctc+LouADYW79NrPSKZJt
	 bdF706t1+rRkiJQ6Gxp4lAJPVPg4T81CV+oq2VdFk//mHB7WvhbA4AzDWAekCa/t43
	 Tw3gzy+GcJ/CTGZ5x81NGc9q0lVWyH42Rmzoo48k=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250623114436eucas1p1ab8455b32937a472f5f656086e38f428~LqVgykXd71399313993eucas1p1c;
	Mon, 23 Jun 2025 11:44:36 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623114434eusmtip1190a72352b897b95137ce69ce4a96d8a~LqVeloFza1638616386eusmtip12;
	Mon, 23 Jun 2025 11:44:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 23 Jun 2025 13:42:43 +0200
Subject: [PATCH v6 5/8] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-apr_14_for_sending-v6-5-6583ce0f6c25@samsung.com>
In-Reply-To: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
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
	<krzysztof.kozlowski@linaro.org>,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250623114436eucas1p1ab8455b32937a472f5f656086e38f428
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623114436eucas1p1ab8455b32937a472f5f656086e38f428
X-EPHeader: CA
X-CMS-RootMailID: 20250623114436eucas1p1ab8455b32937a472f5f656086e38f428
References: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
	<CGME20250623114436eucas1p1ab8455b32937a472f5f656086e38f428@eucas1p1.samsung.com>

Update the img,powervr-rogue.yaml to include the T-HEAD TH1520 SoC's
specific GPU compatible string.

The thead,th1520-gpu compatible, along with its full chain
img,img-bxm-4-64, and img,img-rogue, is added to the
list of recognized GPU types.

The power-domains property requirement for img,img-bxm-4-64 is also
ensured by adding it to the relevant allOf condition.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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


