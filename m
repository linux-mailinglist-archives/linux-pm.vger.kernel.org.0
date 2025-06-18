Return-Path: <linux-pm+bounces-28939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71721ADE8E7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44BF401F10
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031829A9ED;
	Wed, 18 Jun 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hpYusI0q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2D291C0C
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242151; cv=none; b=rI3UzVNSAR9gi3OJe2YPHPNzRRI1Q3nPpu6K9XvcFbOOevKKeMerSTfxpQ6tdc8If8iz6Vr3hPsMkCzzHEJwp5cYBtkWZ4VYD8Lw2n8hSM2QWOaHrziFOAb+jyMqxdxL1GG/tPKlfIM1a+t7zpujdvGrdGFhjTZLg5eCA3aC1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242151; c=relaxed/simple;
	bh=WRlTrsWOi/i85ebZasssiJ4ZtiiHBTtd9LezuNSNDfQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=dTTItHhcJJUAeHOiIw0taBXOrAz2ObvwPo1lLItMAotjXTmbwGhHeuYkDUZji3OKJ9pdAgGqUkWVIO1P6vLZetw32ZWndmUuL/YDgRKuNCWQBxJhOdowZFq07Z7QzFF619YvF3joYD6WuhMOKJjDQ3bQF+OWNF2Z96JhetxHXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hpYusI0q; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250618102227euoutp02700b785ab473cf201c9bde724ba2f606~KG-XcMZsP2430624306euoutp02S
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 10:22:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250618102227euoutp02700b785ab473cf201c9bde724ba2f606~KG-XcMZsP2430624306euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750242148;
	bh=63b01qSumkcLmIEY0xdhZ+QcRoYutlUuGjICSf4+AW0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=hpYusI0qCOndIuRLvKCeZBjC0dnxXjV80+FYxNTKDN6s5FU3G34pYQWlP50+2A9J3
	 LXO+LAXkmmnEoslHpaGTdoZU3CoTg12HvhlXYMQ20mlmKKWp1+zTK8l3fe2a+/m84R
	 3CW94IW9i3XodpoKjEDROtKk4EPDpdxb+LryZGNU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2~KG-W6T4lR2901029010eucas1p2W;
	Wed, 18 Jun 2025 10:22:27 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618102226eusmtip130e43c3ee9d13c7c00906f7347907b07~KG-V8arCD1490514905eusmtip1H;
	Wed, 18 Jun 2025 10:22:26 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 12:22:08 +0200
Subject: [PATCH v5 2/8] dt-bindings: firmware: thead,th1520: Add resets for
 GPU clkgen
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-apr_14_for_sending-v5-2-27ed33ea5c6f@samsung.com>
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
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2
X-EPHeader: CA
X-CMS-RootMailID: 20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2
References: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
	<CGME20250618102227eucas1p26e8968805092c3ce0ecbe84e9724a6e2@eucas1p2.samsung.com>

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


