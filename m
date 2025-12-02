Return-Path: <linux-pm+bounces-39051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA97C9ACD1
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 10:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A71924E2542
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C1309DCC;
	Tue,  2 Dec 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZOfdAPCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD761BC08F;
	Tue,  2 Dec 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666719; cv=none; b=Cq+WKiiS63HO0LsBjRszOEJeVZU1LwcjE6BHZEeEATNCJCrBS5LH0gHquAxjc5aYBPc0gXBotmeQ5rzmUxxNehxO6iAUv8pnIXcamqulFS8hkVNzglqVpdNFZ+9Y4XjvLc2LzshrMM9X9/3CPlvmO7ecHmiKdOju+Fz+2HI7NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666719; c=relaxed/simple;
	bh=u89sEjVKev+yV/JICAqd3mzdl3zOCOhKIP4V1f/ZsPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=raGeTJy6MpTxaJnURd0xYUnkJ8Ka6lGtAB90to4EJzIh78bJp4+8opbNtsPLY49eDTSNjJz47IiY37lp23WtkyLbmlqYTzFj4fJyTR4tju1sqTMKRe06zR6TW8ZLgVJCPIpdDBz6J4OysdR5ozdsTT2VPo0ElW4MU7S09jsXboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZOfdAPCY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f1d1cddacf5e11f0b2bf0b349165d6e0-20251202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/mk32CA9xwsE47WEzmuh6hZXSQvM69vOlFH5g2Jzd/Q=;
	b=ZOfdAPCYvB8Frtx1vdHV5S0auDOxYdBUvrfXH00d2mDTBapMRa8mkkJMapSpzUiFWlvOmluQK3ha0J3U9hFvfWKtyxlRaYo/O+MqEBP+cQDadZyqi2N4rz7mjHbITQ7NrDSDlpNP2bvKcjm3b/+LrTZf61UMxmA4cFoP7BUdpdw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1977ef11-92dc-45e2-ab8d-5ecbd2d4e1da,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:9ef90f28-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1d1cddacf5e11f0b2bf0b349165d6e0-20251202
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 48112873; Tue, 02 Dec 2025 17:11:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 2 Dec 2025 17:11:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 2 Dec 2025 17:11:52 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam
 CHIHI <bchihi@baylibre.com>
CC: <Hanchien.lin@mediatek.com>, <Irving-CH.lin@mediatek.com>, Jh Hsu
	<Jh.Hsu@mediatek.com>, WH Wu <vincent.wu@mediatek.com>, Raymond Sun
	<Raymond.Sun@mediatek.com>, Sirius Wang <Sirius.Wang@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Hanchien Lin
	<hanchien.lin@mediatek.com>
Subject: [PATCH v3 0/2] dt-bindings/thermal: Add MT8189 LVTS support
Date: Tue, 2 Dec 2025 17:10:54 +0800
Message-ID: <20251202091056.1761229-1-hanchien.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the MediaTek MT8189 SoC to the LVTS thermal controller bindings and driver.
Patch 1 updates the device tree bindings to include MT8189 LVTS thermal controller support.
Patch 2 adds MT8189 support to the LVTS thermal driver.

Changes in v3:
- Update patch 1 subject to reflect binding changes (per Conor Dooley's feedback).
- No changes to patch 2.

Changes in v2:
- Addressed function changes as requested by Krzysztof Kozlowski.

Thanks to Conor Dooley and Krzysztof Kozlowski for their valuable feedback.

Best regards,
Hanchien Lin

Link to v2:
https://lore.kernel.org/linux-mediatek/20251201100620.1557608-1-hanchien.lin@mediatek.com/T/#t

Hanchien Lin (2):
  dt-bindings: thermal: mediatek: Add MT8189 LVTS thermal controller
    bindings
  thermal/drivers/mediatek/lvts_thermal: Add MT8189 support

 .../thermal/mediatek,lvts-thermal.yaml        |  27 +++-
 drivers/thermal/mediatek/lvts_thermal.c       | 151 ++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           |  20 +++
 3 files changed, 185 insertions(+), 13 deletions(-)

-- 
2.45.2


