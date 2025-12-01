Return-Path: <linux-pm+bounces-38957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A690C968FF
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51B93A2B02
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49AC302166;
	Mon,  1 Dec 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mshZJ17h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052EA2FCC17;
	Mon,  1 Dec 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583598; cv=none; b=TCBPh2h4t8p+wObEpFkxdJyn7gAF1clrF+EguT9rgF4nzHhVdVCQrnefz8VYDiw82us6+Ll6JrAzkALU+PDmtNf4tLV4vDbbnc/8t/Mh1cJh6Ms/JreN0iQHiJvSFj7BklqKp+mWGCtSQrzCZpFdfHn3VcRhfBNkXizbbhqcN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583598; c=relaxed/simple;
	bh=1Hhy9Z10s6Ia/Um6xZzmDQ4UvtsAYtMrUT+GsEsbawo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdmrA7KMDpI9QCzjFixhQI73lkJ49RCJf7IdY9ZTqtIBJz5cT/fg5frJu0mUakfbimndLl0yi0QjhQmYRmBKOKmXr83KIT2m8UURvf40+uqlPo6qpYGa5kjPfcUFlKHllfx8URCxcmGjcDr9cgkMuWORdC4tUL6fRUQko7kc5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mshZJ17h; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 651f8326ce9d11f0b33aeb1e7f16c2b6-20251201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QswTmhmm9cxp2zJRf5Xns5t1jSqZYBVvb7gt5exo6yw=;
	b=mshZJ17hBt0Fx2EZ7lCU/obt7tVqqHT0j6Ojv90mHe1pWBh9HnReuTzgY7q+2AjzO25OM1inUjKfRUNofLR3ZaEF5evFkT73yxIUAOB4v4gkKWTYa7UWC1mt0+qnXJYe2wwvvLNe7oRDIBNYX7orqfJSzqw52YlWt/X3zMu3JS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8bee4415-2740-41d8-af73-c9eb21b96162,IP:0,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:0e6ce6a7-1697-4a34-a2ba-2404d254a770,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:1|19,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 651f8326ce9d11f0b33aeb1e7f16c2b6-20251201
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2059682994; Mon, 01 Dec 2025 18:06:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 1 Dec 2025 18:06:23 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 1 Dec 2025 18:06:23 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Balsam
 CHIHI" <bchihi@baylibre.com>
CC: <Hanchien.lin@mediatek.com>, <Irving-CH.lin@mediatek.com>, Jh Hsu
	<Jh.Hsu@mediatek.com>, WH Wu <vincent.wu@mediatek.com>, Raymond Sun
	<Raymond.Sun@mediatek.com>, Sirius Wang <Sirius.Wang@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <hanchien.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 0/2] arm64: dts/thermal: Add MT8189 thermal controller and driver support
Date: Mon, 1 Dec 2025 18:06:18 +0800
Message-ID: <20251201100620.1557608-1-hanchien.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the thermal controller on MediaTek MT8189 SoC.

Patch 1 adds the device tree node for the MT8189 thermal controller.
Patch 2 adds MT8189 support to the LVTS thermal driver.

Link to v1: https://lore.kernel.org/all/20251110094113.3965182-1-hanchien.lin@mediatek.com/

Changes in v2:
- Change reset functions from devm_reset_control_get_by_index to devm_reset_control_get_exclusive from reviewers comment.
- Change some use of line breaks and commas for coding style from other mediatek drivers.

Hanchien Lin (2):
  arm64: dts: mediatek: mt8189: Add thermal controller node
  thermal/drivers/mediatek/lvts_thermal: Add MT8189 support

 .../thermal/mediatek,lvts-thermal.yaml        |  27 +++-
 drivers/thermal/mediatek/lvts_thermal.c       | 151 ++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           |  20 +++
 3 files changed, 185 insertions(+), 13 deletions(-)

-- 
2.45.2

Thanks,
Hanchien Lin <hanchien.lin@mediatek.com>

