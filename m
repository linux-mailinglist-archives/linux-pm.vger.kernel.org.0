Return-Path: <linux-pm+bounces-27825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3AAC8439
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511629E0C5C
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F21242928;
	Thu, 29 May 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Br6LqUE7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157021FF49
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557458; cv=none; b=e/AdBkKqT04Elztq1vuYojayN+tvCqA55F6j4FFmR6ZgIzNn7gI/yUVFgsKsGICS0EBk/7bUXanhR3iq6DlGgOxrcro8Tqra9RDrOzTuWfiLHRNRY8l0CRVNJ8IIX52BrDWB3njB+wBdrG/aldnpcCyrrqKpblTpfaLGDK7q8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557458; c=relaxed/simple;
	bh=hoW1ePKj+9Kt2vDJuZuku3nkno6cEQvJM0OL3LmjDt4=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Eu2nCZVjOSi888ezWfWRxE880tUhZHY4rLURgVZZQDtVqEbRL72W6Sknbb73mi2VvhYh/Lbrb6y23z6JyDT3306nYNBEoleeJQy3N3Q/vvUpTbBeMoEXxN6Fydwj1WZmvN0+k45G33XhKnWeufu+AHRfjpUt2ohP6xPd2I/XAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Br6LqUE7; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222408euoutp02ffa78e0a8a5df6e1efe21b9bc1ae0b3f~EH7wip13h0242202422euoutp02K
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250529222408euoutp02ffa78e0a8a5df6e1efe21b9bc1ae0b3f~EH7wip13h0242202422euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557448;
	bh=N+9Ly84haaDNbayhjJ5K7mS9nQgacJUjkY7dLk4JuAo=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=Br6LqUE70WYogOLypvJQ71L+3ybXj/0elULdf8i6w9h8W5fYRmnNnOc10/J5LDZIT
	 haJjVpIINhbSXhQHeNxxYJCHKtBA7YOmwe+wgaaSjKB2RzhmQgzPyVQ/VAz7maNGIm
	 IMqar0BvUK9GADMJQWVsXYxPxYVPy4+NWWkDPYRw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529222406eucas1p117082ce4f06921f71bbc442c47e58574~EH7vRuKw80315603156eucas1p11;
	Thu, 29 May 2025 22:24:06 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222405eusmtip225dbe36b13806921f0a6fd4e8c8f3ad1~EH7uV3wY02867928679eusmtip2U;
	Thu, 29 May 2025 22:24:05 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:51 +0200
Subject: [PATCH v3 4/8] dt-bindings: gpu: Add TH1520 GPU compatible to
 Imagination bindings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-4-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
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
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250529222406eucas1p117082ce4f06921f71bbc442c47e58574
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222406eucas1p117082ce4f06921f71bbc442c47e58574
X-EPHeader: CA
X-CMS-RootMailID: 20250529222406eucas1p117082ce4f06921f71bbc442c47e58574
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222406eucas1p117082ce4f06921f71bbc442c47e58574@eucas1p1.samsung.com>

Update the img,powervr-rogue.yaml device tree bindings to include the
T-HEAD TH1520 SoC's specific GPU compatible string.

The thead,th1520-gpu compatible, along with its full chain
img,img-bxm-4-64, and img,img-rogue, is added to the
list of recognized GPU types. This allows the Imagination DRM driver
to correctly bind to the GPU node defined in the TH1520 device tree.

The power-domains property requirement for img,img-bxm-4-64 is also
ensured by adding it to the relevant allOf condition.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..c12837a0d39b8c3043b9133d444cc33a59135c33 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -26,6 +26,11 @@ properties:
               - ti,j721s2-gpu
           - const: img,img-bxs-4-64
           - const: img,img-rogue
+      - items:
+          - enum:
+              - thead,th1520-gpu
+          - const: img,img-bxm-4-64
+          - const: img,img-rogue
 
       # This legacy combination of compatible strings was introduced early on
       # before the more specific GPU identifiers were used.
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


