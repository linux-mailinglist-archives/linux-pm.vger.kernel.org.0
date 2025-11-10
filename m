Return-Path: <linux-pm+bounces-37704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C09C45B05
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71BB94E3DE0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B582FFFB6;
	Mon, 10 Nov 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ixp4jR4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270332FFFA2;
	Mon, 10 Nov 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767688; cv=none; b=MBZKpSflXU6i4+NF6UReeDSRexFxif5dxKo3/mH07azDXT33VfNBJ7ujnoa/yBZySJUUdzYPl+EeEvBvFKfJ9T4aR9EdBQGlvsMI9kPcVI/Eu6Gwn1F906GcL0gD/neGai4p8zVkAH/pQtvRovwmEonrWlZuup5XY5N+KS4waD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767688; c=relaxed/simple;
	bh=gLj2cPxRN9CtHdNcql73JdedyYuqWcqJKw2vsGfE7fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nkOarpkZ9CYxRuqPw5eW9t0KycYpGafh9n6SD3OlkdZGYR+Xrj+YTEpHP8VhFJO8krEwPtq5YN+EomOoxXFNd1A1Yeq/DDDKxvilIPBFLKQ9o88yyxJ4tg147dKEDubSfDJkAcJAM+iwqVMJ7zN/dXiVkXmrEwrPWJphjHWQEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ixp4jR4R; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 695a537ebe1911f0b33aeb1e7f16c2b6-20251110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nqpj+uo11Rm1HYYL5ztqdJwKIU7oUJ9VEIdxvf4qDNI=;
	b=Ixp4jR4RNq5pA7HmFF7vxpJKLklxTCCxFiY20e8pftp4fvvTIxysj1bL4QSvMm6HEnGf4TyHe8yTMlGpX3O9vd6eyzL/3qnfXY/kY1bGFLAMobOKv/9U2153Da1foemuytq4ZN68eKVC7ijoPK7S671Qem3EJUHys7bGxtYhVjA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1c5e7bef-7d26-4e55-8381-2ce864fe2975,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:79cfee63-6377-47fe-8022-3226f0b92c45,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 695a537ebe1911f0b33aeb1e7f16c2b6-20251110
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 786824231; Mon, 10 Nov 2025 17:41:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 10 Nov 2025 17:41:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 10 Nov 2025 17:41:18 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam
 CHIHI <bchihi@baylibre.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <hanchien.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<raymond.sun@mediatek.com>, <Irving-CH.lin@mediatek.com>
Subject: [PATCH 0/2] arm64: dts/thermal: Add MT8189 thermal controller and driver support
Date: Mon, 10 Nov 2025 17:40:37 +0800
Message-ID: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
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

Hanchien Lin (2):
  arm64: dts: mediatek: mt8189: Add thermal controller node
  thermal/drivers/mediatek/lvts_thermal: Add MT8189 support

 .../thermal/mediatek,lvts-thermal.yaml        |  27 ++-
 drivers/thermal/mediatek/lvts_thermal.c       | 155 ++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           |  20 +++
 3 files changed, 189 insertions(+), 13 deletions(-)

-- 
2.45.2


