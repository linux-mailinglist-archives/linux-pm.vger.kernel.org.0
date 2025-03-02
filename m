Return-Path: <linux-pm+bounces-23229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B20A4B330
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7693B103C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931041EB18B;
	Sun,  2 Mar 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lCGwz7D8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916BE18C937;
	Sun,  2 Mar 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933072; cv=none; b=idVw/6WLBvCTB/C2BzfFQBKk/dBC/F4qksG1MXz4Bav546TaOKT/8HOZAWgABWbpwjDNkMjQ6lCVEdBpYNS2kEcrh80N5L/gklAQaRe6IgiA/Hdeu8Z1S7pQN1qfJQpeTkkvG3DHnlTUkhrHVn54z7fKMxPdhP1SXFkg8UNqYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933072; c=relaxed/simple;
	bh=osRZAE8iggAuTuQfgUs1urVrp8xOcij0fdpUhTd0IR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqRVl2gB3xtpyZUbtWP5Sc5ZQz1kpf+6QtwASQ9MesTFRc8D4q5Ip6bb0sBefNcjS+SqIRzSqdPKyD0Z0rs+WEydcnkC/W9HG2NtRUPhPt+Kr+GsUaoNWSggq/CkFxrsZgnutZUuCQWz4sE6YvnjPGz7LC3rKYGrkBqbnZbb2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lCGwz7D8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740933063;
	bh=osRZAE8iggAuTuQfgUs1urVrp8xOcij0fdpUhTd0IR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lCGwz7D8/3lHPubSEXZHciP30N4PidM0JcMYbudUAKFRmc2NlQxG84xTM7RkxSOmb
	 iYDx5CNz64b0QBL1k+PZZAKaG+r/nA0hEDPs0+pJfX8QdEqLOsldABbB7jzqJLyo0a
	 gxqjJrSqy8LwG+F06NP+5R/ihhCVyXZP1LTJxGLFocO1XoEam7ZNEYPWY35ovcj75s
	 /UQ/MrtHGGt27rdZnfvYBrKulk6xkvHnmOA27lzvY2Rn8XO1E6u/Wm0ZC12b7ZT1a8
	 IN/r/GwSJ5C2QKvYmBhysDzOp/Hh6e1SV4XNm8PJmE093M9i0597vFlJflZtA26vN2
	 Eaugt7i1rvNOg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 770AA17E0880;
	Sun,  2 Mar 2025 17:30:58 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sun, 02 Mar 2025 13:30:40 -0300
Subject: [PATCH v2 01/20] ASoC: dt-bindings: Add document for mt6359-accdet
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
In-Reply-To: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add dt-binding for the MT6359 ACCDET hardware block.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d08a79301409374714c76135b061e20e8e8acfaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6359 Accessory Detection
+
+maintainers:
+  - Nícolas F. R. A. Prado <nfraprado@collabora.com>
+
+description: |
+  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
+  detecting audio jack insertion and removal, as well as identifying the type of
+  events connected to the jack.
+
+properties:
+  compatible:
+    const: mediatek,mt6359-accdet
+
+  mediatek,hp-eint-high:
+    type: boolean
+    description:
+      By default, the HP_EINT pin is assumed to be pulled high and connected to
+      a normally open 3.5mm jack. Plug insertion is detected when the pin is
+      brought low in that case. Add this property if the behavior should be
+      inverted, for example if a normally closed 3.5mm jack is used, or if the
+      line is pulled low on open.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    accdet: accdet {
+        compatible = "mediatek,mt6359-accdet";
+        mediatek,hp-eint-high;
+    };

-- 
2.48.1


