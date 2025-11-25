Return-Path: <linux-pm+bounces-38623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C7C85ED9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 706B235133B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312A25782D;
	Tue, 25 Nov 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iNbRyOAM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424278F51;
	Tue, 25 Nov 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087462; cv=none; b=bVMN2KOQVrUqQbN9Y8BmbFUSyLXNdycHnR10DhxWtaV0kpAukfb621W9DOBuTiwp29skH2xKFoMm5cMpzptnw0BI6Z+lf0KbRBxGks4jJd6Ac6Z5xKeyfKC9zWEYkUs4G7528rjcINrSsq15rjAkU/v2QH5FTFWnCI4wqWFh7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087462; c=relaxed/simple;
	bh=wA3DIGO1oIoEB6lNDjSI7psqvT6nGHbhXESVUEEIA40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E977kscWI59dMDtoXDqCf1nq6yOpazGTTpE0y7JLQ5l7TdmpqE/OKxSjaCX9O8YiqdNy6IQJMYwoxYkRvrzUiOnMjjVMzGB2de60IILHCylLQkUWtIlGH0zaNjZBzyBtg1UPcix7M8sCxgPlRwchn6RL5UigKHTSXqvhdWLlBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iNbRyOAM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087458;
	bh=wA3DIGO1oIoEB6lNDjSI7psqvT6nGHbhXESVUEEIA40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNbRyOAMQh38tdj75MP0NNuwgPM8OdZVrXIskWaix9m9LTcbMoSKWus+lfLXECudS
	 iKtiMhfbnWwOOXUrr8iKMX/g4X1O48GtPwGhDSC30hFinVJpEMBLkbjeV30l7/9bP5
	 yK7uzzrh7jZ1WxndSqto7igFVH5oq/lBDDEmsAPGmPI/lliqSX2mH2uSKUSFPqjmZe
	 gLNb7domjMX7y/4Qys0e4ShVAf+a8Zxvyda2RC9uW8ipBCTudGO0TIP/2gdMmcqJQ3
	 qjWiHVouKt6t9mDJs/uGhgI1pWfKck+xA56Qi3jxV1w6liOSDMfNxgl5LWwbrzra5j
	 ROD0U3DkwMLcA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0159C17E10E7;
	Tue, 25 Nov 2025 17:17:36 +0100 (CET)
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
Cc: nfraprado@collabora.com,
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
	wenst@chromium.org,
	fshao@chromium.org,
	Laura Nao <laura.nao@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/8] dt-bindings: thermal: mediatek: Add LVTS thermal controller support for MT8196
Date: Tue, 25 Nov 2025 17:16:51 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-1-6db7eb903fb7@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add LVTS thermal controller binding for MediaTek MT8196.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |  2 ++
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    | 26 ++++++++++++++++++++++
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

