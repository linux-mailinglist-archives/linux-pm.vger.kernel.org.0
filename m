Return-Path: <linux-pm+bounces-23589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C91A55ECD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F6A3A4C5E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2418FDD0;
	Fri,  7 Mar 2025 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s1YqEYFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263C187872;
	Fri,  7 Mar 2025 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319107; cv=none; b=KN1E1dmIJ3mMwqwgd3Y4i2k+LMaP3MP5VzSspvDgMSx5mo2N0dH3yxwXcMoQcJBOQQbxXbTf4BdPptQeXiTQhMcWynxmWCN3EFryiB0PE0wzmFxNHIMWYSjefff3hawiaqVtgI7D+k5manCEcaY8LYTkokvjYtnyBaHr7BN4flM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319107; c=relaxed/simple;
	bh=QAudi0vbwHorwbjwLc/y9hhLGMJKGpkcbFkupOp6/BY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBlE57jLC0yZ5KfxhuolaAeRBfiUj4lnyPFd7KIE+Wd3AgbpaHi4inTR4H5Y4mXIxKh1NQsO/p/ElyJDb6ZPHaCM8DvttltoVHqo1TexnQg6XXgSGZVcX/hQy0szciFUB445Dg5Y3zzN3g5rAje93Q+Kw7ZB+FXAmWApWeSpVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s1YqEYFY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8a7518aefb0611efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bubgnY0zrmF8D2EJUSPC+Gnryw9Y+zgy2Y+PYLhxYXg=;
	b=s1YqEYFY2FOwhBBaVlqT8HtPvQSxHcAk0K+91TylI5O4+WStuAYnBRFc3ZJj2Ph5WYcQpDzU2H9RGXP6K4/NN3k5DwRsJxj+Px/Y/JwEWEZRtA1IkMXQ2hOjsKwuMUC6FJ5xC1YnTG/MBtc7oaG9qrB/GbeYw8IA9siZ6AXkdrc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6a164fc0-6fd5-469b-929e-f519744d5451,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:1297108c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8a7518aefb0611efaae1fd9735fae912-20250307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1822769354; Fri, 07 Mar 2025 11:44:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:44:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:44:56 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, Guangjie Song <guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 00/13] pmdomain: mediatek: Add MT8196 power domain
Date: Fri, 7 Mar 2025 11:44:24 +0800
Message-ID: <20250307034454.12243-1-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series is based on linux-next, tag: next-20250306.

Changes:
- Update mtk-scpsys driver for MT8196
- Add MT8196 power domain support

Guangjie Song (13):
  pmdomain: mediatek: Support sram isolation
  pmdomain: mediatek: Support sram low power
  pmdomain: mediatek: Support power on bypass
  pmdomain: mediatek: Support check power on/off ack
  pmdomain: mediatek: Support voting for power domain
  pmdomain: mediatek: Support trigger subsys save/restore regesters
  pmdomain: mediatek: Support power domain irq safe
  pmdomain: mediatek: Support power domain always on
  pmdomain: mediatek: Refactor parameters of init_scp
  pmdomain: mediatek: Support bus protect with table
  pmdomain: mediatek: Add post init callback
  dt-bindings: power: mediatek: Add new MT8196 power domain
  pmdomain: mediatek: Add MT8196 power domain support

 .../mediatek,mt8196-power-controller.yaml     |   74 +
 drivers/pmdomain/mediatek/mt8196-scpsys.h     |  114 ++
 drivers/pmdomain/mediatek/mtk-scpsys.c        | 1276 ++++++++++++++++-
 include/dt-bindings/power/mt8196-power.h      |   57 +
 4 files changed, 1483 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
 create mode 100644 drivers/pmdomain/mediatek/mt8196-scpsys.h
 create mode 100644 include/dt-bindings/power/mt8196-power.h

-- 
2.45.2


