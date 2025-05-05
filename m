Return-Path: <linux-pm+bounces-26642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FFDAA9469
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BE516F518
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A07225A2A3;
	Mon,  5 May 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gLCqE+Go"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22842256C6D;
	Mon,  5 May 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451438; cv=none; b=ptNPddM8+7nCDinPNw0bViDyDCoHNwd71AYVkSS9wPvl1+vCzNmp3mAO2SxezP9BmaeeSsSDt1MfU476VJ5y/8SstpkMf5msWB19ERQ3rqtmoPAr8aYpcNHi62oAN+YpINYWc2jZ7C3i3G9tKGjvgVRhhFH3aAwrnZ8waM+a734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451438; c=relaxed/simple;
	bh=eEJO55YjbQngvVS+dntTpGHmo93HKjd8WwbZDOmlhOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsDk9p0AcIUXt+c4j7VoCBePCVaInNQw5YS8B7B//goS2vW4Rim/Re3CVmpnHoa2RxXcXMe4ThXEistNN+54PwIasO+HALsmsiSRRfjNhzhpeAk2iI3az0ygHqOIiCWPKmdiFgbP45I/r44H8k83GtN05iM3IgM0c2BmL0SQM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gLCqE+Go; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746451434;
	bh=eEJO55YjbQngvVS+dntTpGHmo93HKjd8WwbZDOmlhOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLCqE+GoWXxTw4O2Cw0Iy9LGUMNgTkbP4GTSa5DsyQfs0tQgNCvcnoXFueLf1hMLr
	 cA5nENicyg01HhOYYQiyHL/fOBvZ3Sm+U1wNn491aUEMDH8fXJ0ky2tYqj+yd5HH+C
	 yE+pbnutzxA+5G23cRCuIGLLGaLhDCBqh4MHQYpbmVRENCb1MhJqcYeTv0wYDSWgAg
	 QkqtKcR/rFzHzI0UIcMbfZVAGGBdeodZwunYRmIc4e0Begd01D/spYLnWZfcUrt/BY
	 HzCkfSgjjSUCVs1z3L6d+MG8xuAJrUr/OA29DJs5j2ICj8BCV+4isaQLvr6A3Pvxjh
	 Q9hh1Ejkkbsqw==
Received: from apertis-1.home (2a01cb0892F2D600C8f85CF092d4aF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5918E17E0858;
	Mon,  5 May 2025 15:23:53 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Mon, 05 May 2025 15:23:38 +0200
Subject: [PATCH 2/4] dt-bindings: iommu: mediatek: mt8195 Accept up to 5
 interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-mt8395-dtb-errors-v1-2-9c4714dcdcdb@collabora.com>
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
In-Reply-To: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
To: kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Hui Liu <hui.liu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, iommu@lists.linux.dev, 
 Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

Some Mediatek IOMMU can have up to five interrupts so increase
the 'maxItems' to 5.

Fix the following dtb-check error:

mediatek/mt8395-radxa-nio-12l.dtb: infra-iommu@10315000: interrupts:
[[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long

Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 75750c64157c868725c087500ac81be4e282c829..035941c2db32170e9a69a5363d8c05ef767bb251 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -97,7 +97,8 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
 
   clocks:
     items:

-- 
2.49.0


