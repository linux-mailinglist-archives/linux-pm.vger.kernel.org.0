Return-Path: <linux-pm+bounces-29276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C4AE3E4A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794917A2C76
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5A245031;
	Mon, 23 Jun 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YltEA3z+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3C23C390
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679075; cv=none; b=GQ+Lz6fmbFbttKpOcJtSIkFUO1fhSAId1xYkxixa5D6fIjihtS7kyddwIspLukxaAWI4aY59TyS2iTAwitgNH9cKanEdUnxQZ4JNyUp05x9FhxEJo6Q8GivO7roMKbok6roCSthdptW5rJaOXe/tC1ze0gWzPfJaOBUsdVgo2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679075; c=relaxed/simple;
	bh=bGfQixIths9UEkoJwYSWUAD/PNjVNrl5JxSmr5DABww=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=UjbXxypkcdHjB2d92H16Gb3/Klzjgc2NDETxW8Zsw2u/hS5qoW+2jzXXPW4KG4bE7Fh1vzzNc2HZf+eC4kyxcDfUQ6dmrjlxOfysfMDp9FsWE43HmqF3sBvEHOYRsVXurdJ5bvEwnFcRXbVWOh+wQMhJXOGfuHgBhi+riH/IzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YltEA3z+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250623114432euoutp01a544130a90f4d73b578025d8d4d41ede~LqVc9wsmK3256132561euoutp01w
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 11:44:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250623114432euoutp01a544130a90f4d73b578025d8d4d41ede~LqVc9wsmK3256132561euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750679072;
	bh=snLx4JRv75lRpgWYDV6hSgEiKwVBWVcVe6z8ZUMZE/4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=YltEA3z+bkmNQeBYA3x7KNCLdOm2IeVJU0//HuAEIbeZYT+1s817n8sgbulWFkFfd
	 jA5NeLWTt+Mt+YNiwute9jn492A546Jf1pZKOcAM3VDd3UBcrzpjN9/oi94rjItfXp
	 wVY3z3gqj2QLMNbk9iMtyM76iCv0IJhfQvOd21X0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250623114431eucas1p23e8afc09574e2c2026b0e05323db821f~LqVcSGMCD2915729157eucas1p2i;
	Mon, 23 Jun 2025 11:44:31 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623114430eusmtip1b8811fa83d3fe7951975aa26c0c678b2~LqVbKVMve2309023090eusmtip19;
	Mon, 23 Jun 2025 11:44:30 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 23 Jun 2025 13:42:40 +0200
Subject: [PATCH v6 2/8] dt-bindings: firmware: thead,th1520: Add resets for
 GPU clkgen
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-apr_14_for_sending-v6-2-6583ce0f6c25@samsung.com>
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
	dri-devel@lists.freedesktop.org,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250623114431eucas1p23e8afc09574e2c2026b0e05323db821f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623114431eucas1p23e8afc09574e2c2026b0e05323db821f
X-EPHeader: CA
X-CMS-RootMailID: 20250623114431eucas1p23e8afc09574e2c2026b0e05323db821f
References: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
	<CGME20250623114431eucas1p23e8afc09574e2c2026b0e05323db821f@eucas1p2.samsung.com>

Extend the TH1520 AON to describe the GPU clkgen reset line, required
for proper GPU clock and reset sequencing.

The T-HEAD TH1520 GPU requires coordinated management of two clocks
(core and sys) and two resets (GPU core reset and GPU clkgen reset).
Only the clkgen reset is exposed at the AON level, to support SoC
specific initialization handled through a dedicated auxiliary power
sequencing driver. The GPU core reset remains described in the GPU
device node, as from the GPU driver's perspective, there is only a
single reset line [1].

This follows upstream maintainers' recommendations [2] to abstract SoC
specific details into the PM domain layer rather than exposing them to
drivers directly.

Link: https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc@imgtec.com/ - [1]
Link: https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/ - [2]

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Drew Fustini <drew@pdp7.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
index bbc183200400de7aadbb21fea21911f6f4227b09..3365124c7fd4736922717bd31caa13272f4a4ea6 100644
--- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
+++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
@@ -32,6 +32,13 @@ properties:
     items:
       - const: aon
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: gpu-clkgen
+
   "#power-domain-cells":
     const: 1
 

-- 
2.34.1


