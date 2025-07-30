Return-Path: <linux-pm+bounces-31624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93020B16391
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77263173E03
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633A2DCF63;
	Wed, 30 Jul 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ivjxfbL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54CD1AF0C8;
	Wed, 30 Jul 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888951; cv=none; b=Fw9B+/TAR0CLaQuB4gqcA4dr65qLw5XLzU7nCGvTq6rVdXyGex9ntMeKxDY2ugkpS/VFpr9mWVstsLkC3WOh0mM7jsrtX7t3mpk1r9yxtHChu2jXWl+yM9/LC0LJBWRyOJWJ02uTWC0VG5G8S/vQltPaz+sC/j6zeTCnw0RbIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888951; c=relaxed/simple;
	bh=cPTYsX4JtWbb6aA+SrahhA+I0oaokRqbu1BNrJ3xzRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QaQf8+BqRdgqn0mpPNK+003i7siytW7VeW8Sj+iGUMSfxRNNS1VWq5Vj88rB+QTZHGcaVKZhlumS0QbIXr3kaO6gIM2XyQgil0EUm5o5+0NE096vknIqMzZA0N3RTPnD03by/npBQBkG0iPJ5psd3QFFfSYPklk8r3DMnsXqsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ivjxfbL3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753888947;
	bh=cPTYsX4JtWbb6aA+SrahhA+I0oaokRqbu1BNrJ3xzRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivjxfbL3IgjNp42OxmD6oE5KnRv/CBWH/eOuA71P0MUfPvnWIB4VuWJssWkRHdidK
	 Ygb/XMCAlZJ2Pnnm6Y3Q1+U64V8JbDWM7GyiFpF+ZqbFpsmKxXSgTjhE/DDsknpgFg
	 KY0vyZIxdW/dQPTzJ8sVmUXb7QkgDPPoxlVBap6ekOWGFyzNY3NTTaQNHCTP0bNWPc
	 7yPv7T4s7sy+T+JACLRIOo13cd/5qSWwiTjriNswIAch+DEAq8Mp7t2Vlh3md9cvv/
	 FFwJxO0If3QNurjnZLamNeukOZpMRtD0RqZjbXg2xYGERUPGg250jvNll8Ka7TGKrF
	 ++YHwDHTJ2iNg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:41d5:bfd6:7c6f:85ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E72417E130E;
	Wed, 30 Jul 2025 17:22:26 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: wenst@chromium.org,
	nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/9] dt-bindings: thermal: mediatek: Add LVTS thermal controller support for MT8196
Date: Wed, 30 Jul 2025 17:21:20 +0200
Message-Id: <20250730152128.311109-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730152128.311109-1-laura.nao@collabora.com>
References: <20250730152128.311109-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LVTS thermal controller binding for MediaTek MT8196.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        |  2 ++
 .../thermal/mediatek,lvts-thermal.h           | 26 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 0259cd3ce9c5..beccdabe110b 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -26,6 +26,8 @@ properties:
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
       - mediatek,mt8195-lvts-mcu
+      - mediatek,mt8196-lvts-ap
+      - mediatek,mt8196-lvts-mcu
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index ddc7302a510a..0ec8ad184d47 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -80,4 +80,30 @@
 #define MT8192_AP_MD1   15
 #define MT8192_AP_MD2   16
 
+#define MT8196_MCU_MEDIUM_CPU6_0        0
+#define MT8196_MCU_MEDIUM_CPU6_1        1
+#define MT8196_MCU_DSU2                 2
+#define MT8196_MCU_DSU3                 3
+#define MT8196_MCU_LITTLE_CPU3          4
+#define MT8196_MCU_LITTLE_CPU0          5
+#define MT8196_MCU_LITTLE_CPU1          6
+#define MT8196_MCU_LITTLE_CPU2          7
+#define MT8196_MCU_MEDIUM_CPU4_0        8
+#define MT8196_MCU_MEDIUM_CPU4_1        9
+#define MT8196_MCU_MEDIUM_CPU5_0        10
+#define MT8196_MCU_MEDIUM_CPU5_1        11
+#define MT8196_MCU_DSU0                 12
+#define MT8196_MCU_DSU1                 13
+#define MT8196_MCU_BIG_CPU7_0           14
+#define MT8196_MCU_BIG_CPU7_1           15
+
+#define MT8196_AP_TOP0                  0
+#define MT8196_AP_TOP1                  1
+#define MT8196_AP_TOP2                  2
+#define MT8196_AP_TOP3                  3
+#define MT8196_AP_BOT0                  4
+#define MT8196_AP_BOT1                  5
+#define MT8196_AP_BOT2                  6
+#define MT8196_AP_BOT3                  7
+
 #endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.39.5


