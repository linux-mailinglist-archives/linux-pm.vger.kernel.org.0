Return-Path: <linux-pm+bounces-38060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D918C5E778
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F52F4FD395
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE8334C17;
	Fri, 14 Nov 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ocvd5wmd"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D516334C21;
	Fri, 14 Nov 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139274; cv=pass; b=TrtiDbC+uiR/0HnAOumiZgZ3iYX+QmfQSvw8UCHUPQID8kRDAOgVCPP1BAFOXzlJL7DmnogBYRgpHuguAxa29+jS3MsnVXXqt3OqVxvnx9os5bdxkBj4zHQJ8dbKx3eDVzYtI+hkCmppPpYWnE7m/NcwCGf3frsFudEP2/96FCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139274; c=relaxed/simple;
	bh=Gsc4MQY5oPUKV/GP2wKcAMV1AxpIvLZun6+kEyr10Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orX0PvjWxnJAIaEyCvqVw97dNocHQKBTka7eSliiGsZBWOliv0nB3jISG73D30+Vd3+JcmZmM79eOSAk61MHpQYE0ahygpiIr3YouilLOP6Mw12vvFxU53cNtAfv8AXhkl+exCzdFqLBkbThZouvX+num28QlBzABlUwG8fOJCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Ocvd5wmd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139256; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dn+tAaX1gmos74NGLTT7zc8c1cjbAYJalAnp33StQc8ywe+lL9dZcHESlTqobeDiuNjr+nVMDevHUbbzUz4LEYGqY0fNbeldTAkpVQznSeY8/wMqcQ7hGsb3WHY59xR0W+kUHdbLM5TVrLPYSO4yLhIG/NHrHGGKsmebOZTld0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tG1ZM/YEptU2DRU8zPFi7qEjjusi9JCbEwz/DzmZYo8=; 
	b=KyaJtnGkrNQnkbH0ulAMx6sUkF8TBPlUpb5ihwRpra6tItNbiZyu/0yhigYevs821fvNtvL/CiNw3iP+1WjZbY80QlcTiagZnGu9jRLiniMlyQwa6oMR0MMJefTqzONuGI/aDa5ckHO4bhOyWHwwb+n5C+ixVJT59MQ1LNKsKTs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139256;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=tG1ZM/YEptU2DRU8zPFi7qEjjusi9JCbEwz/DzmZYo8=;
	b=Ocvd5wmdD+6lEhKM/rlarRxrR+TwQdGz3fjOTiLgZX+ri5th7Qtc/J6VtLY9ev2C
	qbB7GqeFaqI+hFOXbh6Zmco3V98v5b5IFmakZMm6KlCXTa9fVSn1NSfEnZ6z3u4vlwx
	D+mfQkjm/6BDBFaXnCba0SQQYFoPBNO2kBtE86zI=
Received: by mx.zohomail.com with SMTPS id 1763139255716465.87942509109394;
	Fri, 14 Nov 2025 08:54:15 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:53:57 +0100
Subject: [PATCH 03/13] dt-bindings: interconnect: mt8183-emi: Add support
 for MT8196 EMI
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-3-b956d4631468@collabora.com>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
In-Reply-To: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
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
2.51.2


