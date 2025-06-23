Return-Path: <linux-pm+bounces-29294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFEAE3F77
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3DB3A4BD6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2A24DD11;
	Mon, 23 Jun 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K1GIhk6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD1266EFC;
	Mon, 23 Jun 2025 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680133; cv=none; b=srwcUNlWD2N3qDMqNuUcOX7V1xZJW1mhjbqmGGud6bZXRIIk9IxRmqVd4gLIlQ0MR+mwtpXvQNkDAB8wcvp+bfjFMyjxVCi8BNx8PiWExlXi7qF2DGCwHCQF2RKzh0u8aKWj5UI/KaKBB9dzFEEp9oueN/WSnaM1ZMlVu7NnD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680133; c=relaxed/simple;
	bh=4dKUDczoGa8qRf5DezoFpKNCqMG6eX7Drv2Hgw9/NU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thBafs1ZFgArPyynJflfdwdsGMVs3ULTH30SxMkZNjjMZiTOiCszh4gohS4aCyD6vg83wCrq1M2vV7Aq+lcFjxGdNnwRvdWhM4WSNPZQjwCOBYXCW1vm8ltIwt1QbDIpKI9OW6QMj7f0N2CV2D/nyxhUmYe5uf0MLweAAU2jyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K1GIhk6h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680129;
	bh=4dKUDczoGa8qRf5DezoFpKNCqMG6eX7Drv2Hgw9/NU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1GIhk6hefmyESPFFNmpyVCTUjipAWfpTZ6FhEgKsIL72MJ63mobznJmA8+udb+V1
	 N6RLlAbzhfb/35KcZhk8WqOADYXgg9eSK4YJnXpeIcn0Dvc4ZVwY0acXEEkUh44PWD
	 fWIlY6ofF5c4cdH8KdoCF/In7D5ee2uj1Zb8AwUQ44JqghmM/LLmWx9nGBkytjA4Ss
	 B6OAV61/tQ378rSi9O3PY+BdBWP9iMCtCRLVCrNotCwjJF4YAFcxdnrThRXlvvIUqc
	 zeZHr279I1LOg18e9cbv0z38ak0XQ4SJSg2ECaJqpJjrEPsYXuxz0ywIKJDBC978PJ
	 wDGZg4EmGnptg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C6EAA17E0342;
	Mon, 23 Jun 2025 14:02:08 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	y.oudjana@protonmail.com,
	fshao@chromium.org,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 11/13] dt-bindings: power: Add support for MT8196 power controllers
Date: Mon, 23 Jun 2025 14:01:52 +0200
Message-ID: <20250623120154.109429-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the power controllers found in the MediaTek MT8196
Chromebook SoC.

This chip has three power controllers, two of which located in the
SCP subsystems (where one can be directly controlled and the other
can be controlled only through the HW Voter IP), and one located
in the Multimedia HFRP subsystem, controllable only through the HW
Voter IP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../power/mediatek,power-controller.yaml      |  4 ++
 .../dt-bindings/power/mediatek,mt8196-power.h | 58 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt8196-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 2530c873bb3c..f55fe2c3060d 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -33,6 +33,9 @@ properties:
       - mediatek,mt8188-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
+      - mediatek,mt8196-hwv-hfrp-power-controller
+      - mediatek,mt8196-hwv-scp-power-controller
+      - mediatek,mt8196-power-controller
       - mediatek,mt8365-power-controller
 
   '#power-domain-cells':
@@ -160,6 +163,7 @@ allOf:
           contains:
             enum:
               - mediatek,mt8183-power-controller
+              - mediatek,mt8196-power-controller
     then:
       properties:
         mediatek,bus-protection:
diff --git a/include/dt-bindings/power/mediatek,mt8196-power.h b/include/dt-bindings/power/mediatek,mt8196-power.h
new file mode 100644
index 000000000000..c12f0fe8f4c1
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt8196-power.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8196_POWER_H
+#define _DT_BINDINGS_POWER_MT8196_POWER_H
+
+/* SCPSYS Secure Power Manager - Direct Control */
+#define MT8196_POWER_DOMAIN_MD				0
+#define MT8196_POWER_DOMAIN_CONN			1
+#define MT8196_POWER_DOMAIN_SSUSB_P0			2
+#define MT8196_POWER_DOMAIN_SSUSB_DP_PHY_P0		3
+#define MT8196_POWER_DOMAIN_SSUSB_P1			4
+#define MT8196_POWER_DOMAIN_SSUSB_P23			5
+#define MT8196_POWER_DOMAIN_SSUSB_PHY_P2		6
+#define MT8196_POWER_DOMAIN_PEXTP_MAC0			7
+#define MT8196_POWER_DOMAIN_PEXTP_MAC1			8
+#define MT8196_POWER_DOMAIN_PEXTP_MAC2			9
+#define MT8196_POWER_DOMAIN_PEXTP_PHY0			10
+#define MT8196_POWER_DOMAIN_PEXTP_PHY1			11
+#define MT8196_POWER_DOMAIN_PEXTP_PHY2			12
+#define MT8196_POWER_DOMAIN_AUDIO			13
+#define MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT		14
+#define MT8196_POWER_DOMAIN_ADSP_INFRA			15
+#define MT8196_POWER_DOMAIN_ADSP_AO			16
+
+/* SCPSYS Secure Power Manager - HW Voter */
+#define MT8196_POWER_DOMAIN_MM_PROC_DORMANT		0
+#define MT8196_POWER_DOMAIN_SSR				1
+
+/* HFRPSYS MultiMedia Power Control (MMPC) - HW Voter */
+#define MT8196_POWER_DOMAIN_VDE0			0
+#define MT8196_POWER_DOMAIN_VDE1			1
+#define MT8196_POWER_DOMAIN_VDE_VCORE0			2
+#define MT8196_POWER_DOMAIN_VEN0			3
+#define MT8196_POWER_DOMAIN_VEN1			4
+#define MT8196_POWER_DOMAIN_VEN2			5
+#define MT8196_POWER_DOMAIN_DISP_VCORE			6
+#define MT8196_POWER_DOMAIN_DIS0_DORMANT		7
+#define MT8196_POWER_DOMAIN_DIS1_DORMANT		8
+#define MT8196_POWER_DOMAIN_OVL0_DORMANT		9
+#define MT8196_POWER_DOMAIN_OVL1_DORMANT		10
+#define MT8196_POWER_DOMAIN_DISP_EDPTX_DORMANT		11
+#define MT8196_POWER_DOMAIN_DISP_DPTX_DORMANT		12
+#define MT8196_POWER_DOMAIN_MML0_SHUTDOWN		13
+#define MT8196_POWER_DOMAIN_MML1_SHUTDOWN		14
+#define MT8196_POWER_DOMAIN_MM_INFRA0			15
+#define MT8196_POWER_DOMAIN_MM_INFRA1			16
+#define MT8196_POWER_DOMAIN_MM_INFRA_AO			17
+#define MT8196_POWER_DOMAIN_CSI_BS_RX			18
+#define MT8196_POWER_DOMAIN_CSI_LS_RX			19
+#define MT8196_POWER_DOMAIN_DSI_PHY0			20
+#define MT8196_POWER_DOMAIN_DSI_PHY1			21
+#define MT8196_POWER_DOMAIN_DSI_PHY2			22
+
+#endif /* _DT_BINDINGS_POWER_MT8188_POWER_H */
-- 
2.49.0


