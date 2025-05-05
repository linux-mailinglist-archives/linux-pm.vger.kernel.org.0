Return-Path: <linux-pm+bounces-26643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036EBAA946A
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C4716F911
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F125A2A7;
	Mon,  5 May 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HUfr6toV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6421A2C25;
	Mon,  5 May 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451438; cv=none; b=e7AWN3EQ74A+cNNywl90iHkuqCrsjmwLkvo0GV1+6Tn8EI0hj9KaTh1daGjbO3ahgAG+3kfOgtGxZzW5MalAQeFF5Unf2B7MhlTfoqRNYOKBEb66CCkgdwYyDycdgd53wxkIfjFMG1+JHOuwO9Bmr8NmgFH1MRCCC0kV1zoJr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451438; c=relaxed/simple;
	bh=HggPxWEvci0Nw3XAAZKOgbcYb9Y2yMgNjUUita5XUCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqTH6EKJjFbPLMUncFhz7OzugpZhtxFNIhDPW0DZc/bSKHhnfVJgVxoBhg+mO5O/c4xHMXCKS3cKX1ztegXqwrgXNA1oLWQUkJZwVImALE5DpLVGL92j/L68sfwykFxrISiwt9YeSLZIArsvXN7N98GX/i2ioIOld+tpRzthbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HUfr6toV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746451433;
	bh=HggPxWEvci0Nw3XAAZKOgbcYb9Y2yMgNjUUita5XUCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HUfr6toVPCb2SnWE9VrHyTk2xrXVXTrZlrlQW2m6hLe64AEUaAb7mw51ftkQOpdD4
	 cLy1Laj9ZY4Ctp/ElIDwr7HZPcGFitvBGFiYZRq7LlYYYDTbFHcJeq4jVLrNpE5zm9
	 bvsB7p+TMmuq24KAhyO2XuKEIRVVaJo+J+wATKPgwyDH4D6xo8DTIIhS1HOTHNdg6U
	 r22JS7do5w8XzJ4RuFJ2uvNcUQYlwCI9V1ZX6DKHs0Y6xMFSNaPPOYPKjJHc7P/orQ
	 IrLkcFOOtyofx2PD5OIeZR6DpGM+UHAvOaDP0jGCDjxhhgyEJvlJIXscF2mtAlK1pc
	 uzZ+wud4+mF6A==
Received: from apertis-1.home (2a01cb0892F2D600C8f85CF092d4aF51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34BF217E07F2;
	Mon,  5 May 2025 15:23:52 +0200 (CEST)
From: Julien Massot <julien.massot@collabora.com>
Date: Mon, 05 May 2025 15:23:37 +0200
Subject: [PATCH 1/4] dt-bindings: mfd: mediatek: mt6397: Add
 #sound-dai-cells property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-mt8395-dtb-errors-v1-1-9c4714dcdcdb@collabora.com>
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

The 'mt6359.dtsi' file already uses the '#sound-dai-cells' property.
Add the corresponding property to the binding to fix the following
dtb-check error:

mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

Fixes: 9bc8353be720 ("arm64: dts: mt6359: Add #sound-dai-cells property")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..86fc1b5db3b075ea0f6e35f58ecbca7956d230c4 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -53,6 +53,9 @@ properties:
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


