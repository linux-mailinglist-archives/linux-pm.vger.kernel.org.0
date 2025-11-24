Return-Path: <linux-pm+bounces-38443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE0C801C2
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364EA3A8DF6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23EE2FD670;
	Mon, 24 Nov 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="V1FiJuho"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF22FB999;
	Mon, 24 Nov 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982448; cv=pass; b=RZ/w7c8eFEUVCJqVp5cHfnBcrgfs88JpKJpDQwJ3eJwclrbnT/lbYT96ENPjlYj6yx1C5loEbRgGJx3PtsIxMygZTW7YAbpJYaV4Mo3ggWTDREMJ37WdNMTlDMvc0la2SG8KWzfyvJDNYaqZsfUXp352grwaoBWWuur+GfLfY8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982448; c=relaxed/simple;
	bh=vJQ/dOYU1k8uyx3cFU7cVl8Rmi1oZJTa71aPTxpA8XU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5scsdLnM10zkPtFZrDATXcfGUJ2+z86UDMatFlSrrSwzV3jr00r56zLbdYFDtWJgj/krQ9OLXYeQWaVthZVCUoOiJdCA+3lIoMRL9uaTrdQBL0kTe1+CQirHFBO2u3MrYnn5gVxjF9fbKmcrr90B9bDIxcND5Ekk+Lw+P+ZqYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=V1FiJuho; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982429; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bFfbTLZfWfaFRzQkfyCkVjo2MZlYw4vaD/R5LoEC8aL4QASSsbE3xZG0EJ6WrFMX8LqWWXXcGaVAeO15iMUcbiJ3vvZMnF6Xs7CWxNAwXAMfBcmwAPyAbyr7JflPJMe+Y9AinrTeTBOv51prp4ewyBLzZ8opVFBgYbndIxnOi14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982429; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Zlmg1xkb7zZ5qt1lQzDBttMbvIYcJyKcwVMP6LG+6Dc=; 
	b=WQVXY+aATl+94dOiXyjf/nTMbVaLf+mro1cBXcFowQDXKO6oUliVPftsEVz+RF7U0Ly55Q1NtlsoBkTsqRCbuO91mxpeJhS/OhQfTrxfWn//wRYMpAuZ7pSH5NogKhC1VWv8BIvv9z1OI+WqsdmKHCuH9K0tj6r4FwyCI1vzp2s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982429;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Zlmg1xkb7zZ5qt1lQzDBttMbvIYcJyKcwVMP6LG+6Dc=;
	b=V1FiJuhojXdSc/Lp5LfrkqnNi/N8EHUgWdTOHaM8OE5YafmSysvzD6c+Squ/t2oh
	Sx0q0a+0H9bxGtFFbgr9PuowFFUSpxDfkIchFFN/MANwZnd1Ph4dAL7aaLewo/ZZiK6
	9rze27RJd3frip5SsLylUZicelRsG5WA/Ihrz5w8=
Received: by mx.zohomail.com with SMTPS id 176398242729632.7829396468984;
	Mon, 24 Nov 2025 03:07:07 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:52 +0100
Subject: [PATCH v2 03/13] dt-bindings: interconnect: mt8183-emi: Add
 support for MT8196 EMI
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-3-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add a new compatible for the External Memory Interface Interconnect
found on the MediaTek MT8196 Chromebook SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/interconnect/mediatek,mt8183-emi.yaml |  1 +
 include/dt-bindings/interconnect/mediatek,mt8196.h | 48 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
index 017c8478b2a7..1fb8ccb558fb 100644
--- a/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
@@ -40,6 +40,7 @@ properties:
     enum:
       - mediatek,mt8183-emi
       - mediatek,mt8195-emi
+      - mediatek,mt8196-emi
 
   '#interconnect-cells':
     const: 1
diff --git a/include/dt-bindings/interconnect/mediatek,mt8196.h b/include/dt-bindings/interconnect/mediatek,mt8196.h
new file mode 100644
index 000000000000..de700fa73223
--- /dev/null
+++ b/include/dt-bindings/interconnect/mediatek,mt8196.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MEDIATEK_MT8196_H
+#define __DT_BINDINGS_INTERCONNECT_MEDIATEK_MT8196_H
+
+#define SLAVE_DDR_EMI		0
+#define MASTER_MCUSYS		1
+#define MASTER_MCU_0		2
+#define MASTER_MCU_1		3
+#define MASTER_MCU_2		4
+#define MASTER_MCU_3		5
+#define MASTER_MCU_4		6
+#define MASTER_GPUSYS		7
+#define MASTER_MMSYS		8
+#define MASTER_MM_VPU		9
+#define MASTER_MM_DISP		10
+#define MASTER_MM_VDEC		11
+#define MASTER_MM_VENC		12
+#define MASTER_MM_CAM		13
+#define MASTER_MM_IMG		14
+#define MASTER_MM_MDP		15
+#define MASTER_VPUSYS		16
+#define MASTER_VPU_0		17
+#define MASTER_VPU_1		18
+#define MASTER_MDLASYS		19
+#define MASTER_MDLA_0		20
+#define MASTER_UFS		21
+#define MASTER_PCIE		22
+#define MASTER_USB		23
+#define MASTER_WIFI		24
+#define MASTER_BT		25
+#define MASTER_NETSYS		26
+#define MASTER_DBGIF		27
+#define SLAVE_HRT_DDR_EMI	28
+#define MASTER_HRT_MMSYS	29
+#define MASTER_HRT_MM_DISP	30
+#define MASTER_HRT_MM_VDEC	31
+#define MASTER_HRT_MM_VENC	32
+#define MASTER_HRT_MM_CAM	33
+#define MASTER_HRT_MM_IMG	34
+#define MASTER_HRT_MM_MDP	35
+#define MASTER_HRT_ADSP		36
+#define MASTER_HRT_DBGIF	37
+#endif

-- 
2.52.0


