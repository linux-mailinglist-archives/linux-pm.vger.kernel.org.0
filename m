Return-Path: <linux-pm+bounces-32540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E219B2A10F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C81188FEC0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6731B107;
	Mon, 18 Aug 2025 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bAD+s/8/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06227B33E;
	Mon, 18 Aug 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518292; cv=none; b=YHL9xquSsuq8N409eEz02ZcdCiBBJ8YqDfyKjgJYKXb8s5rz4Kdk1Y0FLAItTIuUIF7Pnp5BDn/82sfvwN+uw2WFgmHgxzluVyxzxl6Kcvpr15IycETf6HfDUg+0mKAFHpJ7YLvbKvMYdVcavZyoYWiNhz+/exmQx6+7HV7Dmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518292; c=relaxed/simple;
	bh=OOH8NZCnkhqlWqa9Cch+uJAXeO2gmuacgtEMkJwDGh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4ECm3BQzoORmvpZjlAo02Uam6yee8L48aQyrCzoLkh0HCoONnPjWI6oxFAPjfD5nifok1BSkjs7HrtoxWFsyOi5VEfg46pFfWiY0mB/m7FBFe6IoFVOhYiHoPK4Ydsga6e8BlUGd0faLSRSPLu3Repduf5f576EfospUjSysXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bAD+s/8/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96f38ad47c2a11f0b33aeb1e7f16c2b6-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tsppUKQF9rqc+9Ll4r7wwePICudQwVz94tGzhGrTstg=;
	b=bAD+s/8/b9aEbiHaiJ2VEgbmjrEkXZhKZy12C6aQ9k6lQ829fP987ZdSFBsdTUa5f5OWoSqCVIuJQFmOTwZTeSxTqSAEs2OcmQmvzngrUIoUYfVRn8qTXqutcQn1NqEsk8m0MPpLNx85kPIy6HpKamUL2oCWMiRYeoyp41jRe38=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:5c0566ba-a878-474e-9bed-ab818525ef91,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:e80c417a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96f38ad47c2a11f0b33aeb1e7f16c2b6-20250818
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2016991669; Mon, 18 Aug 2025 19:58:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 19:57:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 19:57:59 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH 4/6] dt-bindings: power: mediatek: Add MT8189 power domain definitions
Date: Mon, 18 Aug 2025 19:57:32 +0800
Message-ID: <20250818115754.1067154-5-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Add device tree bindings for the power domains of MediaTek MT8189 SoC.
These definitions will be used to describe the power domain topology in
device tree sources.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 include/dt-bindings/power/mt8189-power.h | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8189-power.h

diff --git a/include/dt-bindings/power/mt8189-power.h b/include/dt-bindings/power/mt8189-power.h
new file mode 100644
index 000000000000..70a8c2113457
--- /dev/null
+++ b/include/dt-bindings/power/mt8189-power.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8189_POWER_H
+#define _DT_BINDINGS_POWER_MT8189_POWER_H
+
+/* SPM */
+#define MT8189_POWER_DOMAIN_CONN			0
+#define MT8189_POWER_DOMAIN_AUDIO			1
+#define MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT		2
+#define MT8189_POWER_DOMAIN_ADSP_INFRA			3
+#define MT8189_POWER_DOMAIN_ADSP_AO			4
+#define MT8189_POWER_DOMAIN_MM_INFRA			5
+#define MT8189_POWER_DOMAIN_ISP_IMG1			6
+#define MT8189_POWER_DOMAIN_ISP_IMG2			7
+#define MT8189_POWER_DOMAIN_ISP_IPE			8
+#define MT8189_POWER_DOMAIN_VDE0			9
+#define MT8189_POWER_DOMAIN_VEN0			10
+#define MT8189_POWER_DOMAIN_CAM_MAIN			11
+#define MT8189_POWER_DOMAIN_CAM_SUBA			12
+#define MT8189_POWER_DOMAIN_CAM_SUBB			13
+#define MT8189_POWER_DOMAIN_MDP0			14
+#define MT8189_POWER_DOMAIN_DISP			15
+#define MT8189_POWER_DOMAIN_DP_TX			16
+#define MT8189_POWER_DOMAIN_CSI_RX			17
+#define MT8189_POWER_DOMAIN_SSUSB			18
+#define MT8189_POWER_DOMAIN_MFG0			19
+#define MT8189_POWER_DOMAIN_MFG1			20
+#define MT8189_POWER_DOMAIN_MFG2			21
+#define MT8189_POWER_DOMAIN_MFG3			22
+#define MT8189_POWER_DOMAIN_EDP_TX_DORMANT		23
+#define MT8189_POWER_DOMAIN_PCIE			24
+#define MT8189_POWER_DOMAIN_PCIE_PHY			25
+
+#endif /* _DT_BINDINGS_POWER_MT8189_POWER_H */
-- 
2.45.2


