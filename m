Return-Path: <linux-pm+bounces-27124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE4AB65BE
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FE117944F
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904E220698;
	Wed, 14 May 2025 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nYrXrWSV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF520FAB9;
	Wed, 14 May 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210813; cv=none; b=FRMWdTYmh67MtCbIfVNLv6p1EwKbvDNR2mFQFdJrI/lwZ5fXBeHIAH3U9w1aiT0btKAn66Ihl4kphs/o0tPFqcELCyzdJswXtwI6ehWe/ShVtcaRrhPFMFepyC+KH9UGpsJqk7fE79/5z1YOrDKvj8amLrr7YwDpSG21G9A+Irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210813; c=relaxed/simple;
	bh=9R7sv5oMll/MHroR0RXX+GKrqQL+VOwFRqNH0B+C/Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7wqDeulOc/5vmjf5NHbzivLr74ALF+eZr9WI5gtB8MnMsl6yIUsGHFl52K8PbYz9Nif3IUfOETcgSDwq+uiSaMkzATfXnPWsfHiw5NmITWk6Y0ThJmk2MHpCXUsllkD6VPa2SCy1YVwIaoeVoAxO49CgDLfM9+eoC0PVvQd2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nYrXrWSV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747210809;
	bh=9R7sv5oMll/MHroR0RXX+GKrqQL+VOwFRqNH0B+C/Do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nYrXrWSVQiyUbR2rX52wDp9qRN+t6YeVDUial7bDiqnR8rxZlIie/aAiAhtNtJz6e
	 ivD3qd0t/Ku5RhdwaGRnth+SBczrl0u64fwDFAZf1IjB+UR56bM/bDXLTB8Ncw3Kh3
	 WiinlpIyy2QojXihdIHpSxcQODAPdr/1p13DS6N/Kl+ol+Se7UbZCtvptIzYfrKmUc
	 jTs/ij8z1ObdQtvXSchOp2Mv0kdonQrmaRXF1GNdmvi4eUr/6O9PMfJCgBr1V3/ZWy
	 hkABQbUWmidyExM27gf3ABC+ZLCiCBiKx7qjW3uVQbjOiJx0C/s2YQlBK8BczkW/aR
	 F6H2bsluoa7fg==
Received: from apertis-1.home (2a01cb0892F2D600c8F85Cf092d4AF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 589C317E07F2;
	Wed, 14 May 2025 10:20:08 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Wed, 14 May 2025 10:19:57 +0200
Subject: [PATCH v2 2/3] dt-bindings: iommu: mediatek: Support 5 IRQs on
 MT8195 infra IOMMU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-mt8395-dtb-errors-v2-2-d67b9077c59a@collabora.com>
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
In-Reply-To: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
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

The MT8195 Infra IOMMU is currently the only Mediatek IOMMU instance that
uses five interrupts instead of one.

Update the binding to allow either one or five interrupts, depending on
the compatible string. This avoids dtbs_check errors on platforms like
the Radxa NIO 12L using the MT8395 SoC:

mediatek/mt8395-radxa-nio-12l.dtb: infra-iommu@10315000: interrupts:
[[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long

Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 75750c64157c868725c087500ac81be4e282c829..5068617a5146c8a8d61234d83c19d2848d5e708f 100644
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
@@ -201,6 +202,21 @@ allOf:
       required:
         - mediatek,infracfg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8195-iommu-infra
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:

-- 
2.49.0


