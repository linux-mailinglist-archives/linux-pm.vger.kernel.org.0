Return-Path: <linux-pm+bounces-27123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9532AB65BB
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43F73A2A05
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722021C9F0;
	Wed, 14 May 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VuKgwCUP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F21CEAC2;
	Wed, 14 May 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210811; cv=none; b=SxP37ixXo+tNvko3aIyTdFLxXjQhVcGoPCQK+iTd7MGn/G05KtDkKFpd922IovTib2sSo8qQN8xr1QERCQ6QIVayv6cMSYPi8tjvOYRLn2KQtIaodHdVXJFmpVEDqoLYnYaPeCD+yHgbY9BDZ/c9B8SUTjT+KDFKUwN44hz5OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210811; c=relaxed/simple;
	bh=eVS8ASAPWXFPs7zmXnVv2z4AjK5YrBRmxmYDS53TpiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhV7Bzxf1yA2l9+I4ZdfnM6QDMXMdOeU5Ywi/iIM55YVMWcTC9wAEldvB/M6uCGieMUXAvTga+CSD5B/L0xpQZqcApFc9ikS50uYFePs6eIxvtJdQjWWScEuFB8VeUVPZqRHVhNnmVGPimYaW5HrQRietiEiH/cQNNd//PSNzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VuKgwCUP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747210808;
	bh=eVS8ASAPWXFPs7zmXnVv2z4AjK5YrBRmxmYDS53TpiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VuKgwCUPuoiMh63fAsWJcXFb+WTCyzT4zkxvrNgRY9oEZFDc9cmfr2oKNbD4dKlbQ
	 2KWMQka1r81eUxmi4+Fpss7PUUi5XIy8XEFbnwEbeuB3cI+7cFSpwEKWNV4oX/puZC
	 ERSGUAucgOHC5yL4wIornVzg5z8bpXuFnh+To4fJHnsdXJ0M9Z0wYf7gdJIqkblSM2
	 mRhdQ1D9oyGxnUcIRH+0e2zIyRYqPgIWwUsYhZlrNqqJ2vDlXIy1ZpKgwuUCa0AcfP
	 ocVCkuCm50Q6JLHXBXOEpJKS+D08SlNucQJKi7C7PK2XCCpM4sWB9SprBVGBVJS1CV
	 212ICctrS7Nkg==
Received: from apertis-1.home (2a01cb0892F2D600c8F85Cf092d4AF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2729417E07C9;
	Wed, 14 May 2025 10:20:07 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Wed, 14 May 2025 10:19:56 +0200
Subject: [PATCH v2 1/3] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-mt8395-dtb-errors-v2-1-d67b9077c59a@collabora.com>
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

The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
Add the corresponding property to the binding to fix the following
dtb-check error:

mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

Fixes: 9bc8353be720 ("arm64: dts: mt6359: Add #sound-dai-cells property")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..9580c4ec1ae00f1dd1182357d8b0a5035a1b7f82 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -30,6 +30,9 @@ description: |
   See the following for pwrap node definitions:
   Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
 
+allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -53,6 +56,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  '#sound-dai-cells':
+    const: 1
+
   rtc:
     type: object
     $ref: /schemas/rtc/rtc.yaml#

-- 
2.49.0


