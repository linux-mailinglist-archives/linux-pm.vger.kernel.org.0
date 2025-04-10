Return-Path: <linux-pm+bounces-25118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B116A84688
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB523B9103
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B228CF54;
	Thu, 10 Apr 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZmOQdVz9"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FE284B31;
	Thu, 10 Apr 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295997; cv=none; b=Ymq+rI2bk83NKgZnCwtpeLR6dmTqi9YK8ZtM6Z/UOwsStjj2oUBVtAt7tDRfbE/FeDQs0aXoWiK81WNp7m0+CA2g3RA4oG3lGLg/7sk8vqR/cgXQEzkN/8leSqBfKEVVTZ2IlEOazr0UtPxal/tU7eXbE7fe6s/TE/eGT+09z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295997; c=relaxed/simple;
	bh=UM8eRGMMrRlZ9igteIR0+9yJOLiReCR0kDQJdYbv4lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5qWzXLi07NirWeyBdw85q9CUnPCDVsTRG9s5a+WcV/gR+6Vz95YDSk91/hPkeHHKZydTeswOHZWbLMFyxpCW7Fj28jVb2655j7MuS8KXF7JBqWo/8FuL3ZOBlSyNCMVr/BJpGjxZmJHM1DSf+M1S2dueCtUkBB6GrMwe4gBfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZmOQdVz9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744295993;
	bh=UM8eRGMMrRlZ9igteIR0+9yJOLiReCR0kDQJdYbv4lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmOQdVz9NGS7NtFcyLuTddjNxN/VL6lXI10K5TmTGBFSR+g4LggqeFGpH3bYffs96
	 zCVbGjwNHHlKNUictGQELTvAUbebWiIf34aCRUGIuiInyxvI7NFmLqc8fE8A2ZMSSI
	 0c+eqKx4Rv5aqtfEnVli1ceZntCv2/RbvJGr2e6kpuVbLbEjEz/cQHJNIWGU3ZhvmT
	 Ls3Bb5mZnSEMQ6k5aHgu1BKThYHDFzd7cflyMd9pKMivsqHKi7zmvjPnaTQuG0AGZt
	 BBZ0o6uVJpwK2WDqTzftQJrpY4Hsr6yss4Rr/hFGxiJuK17OYFDagSwog/J+/k0Kqt
	 eVGcsYEuJNobg==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 45AD717E0CA7;
	Thu, 10 Apr 2025 16:39:51 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 1/3] dt-bindings: power: mediatek: Support Dimensity 1200 MT6893 MTCMOS
Date: Thu, 10 Apr 2025 16:39:42 +0200
Message-ID: <20250410143944.475773-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
References: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Power Domains (MTCMOS) integrated into the
MediaTek Dimensity 1200 (MT6893) SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../power/mediatek,power-controller.yaml      |  2 ++
 .../dt-bindings/power/mediatek,mt6893-power.h | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt6893-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 591a080ca3ff..9c7cc632abee 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - mediatek,mt6735-power-controller
       - mediatek,mt6795-power-controller
+      - mediatek,mt6893-power-controller
       - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
@@ -88,6 +89,7 @@ $defs:
         description: |
           Power domain index. Valid values are defined in:
               "include/dt-bindings/power/mt6795-power.h" - for MT8167 type power domain.
+              "include/dt-bindings/power/mediatek,mt6893-power.h" - for MT6893 type power domain.
               "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
diff --git a/include/dt-bindings/power/mediatek,mt6893-power.h b/include/dt-bindings/power/mediatek,mt6893-power.h
new file mode 100644
index 000000000000..aeab51bb2ad8
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt6893-power.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT6893_POWER_H
+#define _DT_BINDINGS_POWER_MT6893_POWER_H
+
+#define MT6893_POWER_DOMAIN_CONN		0
+#define MT6893_POWER_DOMAIN_MFG0		1
+#define MT6893_POWER_DOMAIN_MFG1		2
+#define MT6893_POWER_DOMAIN_MFG2		3
+#define MT6893_POWER_DOMAIN_MFG3		4
+#define MT6893_POWER_DOMAIN_MFG4		5
+#define MT6893_POWER_DOMAIN_MFG5		6
+#define MT6893_POWER_DOMAIN_MFG6		7
+#define MT6893_POWER_DOMAIN_ISP			8
+#define MT6893_POWER_DOMAIN_ISP2		9
+#define MT6893_POWER_DOMAIN_IPE			10
+#define MT6893_POWER_DOMAIN_VDEC0		11
+#define MT6893_POWER_DOMAIN_VDEC1		12
+#define MT6893_POWER_DOMAIN_VENC0		13
+#define MT6893_POWER_DOMAIN_VENC1		14
+#define MT6893_POWER_DOMAIN_MDP			15
+#define MT6893_POWER_DOMAIN_DISP		16
+#define MT6893_POWER_DOMAIN_AUDIO		17
+#define MT6893_POWER_DOMAIN_ADSP		18
+#define MT6893_POWER_DOMAIN_CAM			19
+#define MT6893_POWER_DOMAIN_CAM_RAWA		20
+#define MT6893_POWER_DOMAIN_CAM_RAWB		21
+#define MT6893_POWER_DOMAIN_CAM_RAWC		22
+#define MT6893_POWER_DOMAIN_DP_TX		23
+
+#endif /* _DT_BINDINGS_POWER_MT6893_POWER_H */
-- 
2.49.0


