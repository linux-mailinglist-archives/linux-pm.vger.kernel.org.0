Return-Path: <linux-pm+bounces-31899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE1B1A349
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08CF3BBA6E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0026B97E;
	Mon,  4 Aug 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OoTahuH0"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62572522BE;
	Mon,  4 Aug 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314361; cv=none; b=J1AUxfCkfD+RDMJKl2izUPXNgqg083A3R2ZMr84iihGE+uVVQuabaJtlJfWmI9bSAnaoFuIA1tWHbzDmYgFsQhEgKQO2XQk9lxBXyxwohSg/I62Ihn6cxkJSA3BoMLpNXae6FOXnvZrAJeg9jnjFgOMBfyC/zJhUFJwCFnHEj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314361; c=relaxed/simple;
	bh=XAybBYmR7h7F7zb2Ub4Edx4t+muG85usYjalyXOHf+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/3yZga0vteRmZfb4IB9dirlH09+fPXCCI62jhY4bwdvDbjOCv+/aRKXudLp8GosDL7/BVZ9cQLRDktcxXDJWXuB3QUZ99MdVT5dhElVBECOy7ukv5h9R09TV1f0meTS/sflXkT/dCoojBXH2gap7wtcfYNYk+fSOw0O61C2r7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OoTahuH0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314358;
	bh=XAybBYmR7h7F7zb2Ub4Edx4t+muG85usYjalyXOHf+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoTahuH0JEl3wrl5TdIRRbH0I68D4omapVMTyXrVMtO4Aa6Ta2ZYXThg5h5E34JwV
	 Qj7+FdjKC8JWuaRJLUCtJJxy6RJ/jy0Kv2Y25YJdHJEC/JauG5e2DEzWYTvLm30Jvh
	 EpNRn+GSN7Aiuv6Rc5ZdTDOlbZzggbyfKL/xZGFHytzdO+7jNHQwvbqm4n4NAahW5q
	 gdfQ1MJZ2rvMmULlI2/Fw2XPqs3qXSzxnHBGZaHzYPxlo33aJ9yYID9RR1Us2jUGO4
	 6MLchZptUIUTPhtd1plIXwPmSHYfDFtOTBaMui2jCRTZvmARqc5fO/UWS0GIm3aIQn
	 tsv2pPNgISJaA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:865e:547d:4830:837d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B6CCC17E01F5;
	Mon,  4 Aug 2025 15:32:36 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/9] dt-bindings: thermal: mediatek: Add LVTS thermal controller support for MT8196
Date: Mon,  4 Aug 2025 15:30:27 +0200
Message-Id: <20250804133035.309990-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804133035.309990-1-laura.nao@collabora.com>
References: <20250804133035.309990-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LVTS thermal controller binding for MediaTek MT8196.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


