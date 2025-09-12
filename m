Return-Path: <linux-pm+bounces-34547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBEB54CF7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 14:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B22EAA29B2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869F30F545;
	Fri, 12 Sep 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cnJoxNks"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F153081B8;
	Fri, 12 Sep 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678731; cv=none; b=RRdJ0bM3WambT+47cJcSEHF5OAQbTHcGf1uylOruIRW1P83f56PT/TeD4DOKViamYh02RkfuNLSOYOeBXxk1ESn0VglwTZkJ9WLYmOrCELgdhtgOdZ6GUWzrvOhfk0H/xZPXdB3mwQ0Ui/PSaMlfsQNocSqCNoXN9Bvr62JNWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678731; c=relaxed/simple;
	bh=+knrYgvIRzYhx6NMYWRI3CQllCLkTMhw9DP6cthmIao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQ9KdzABkUp1GtSdNHPoDHhBKAFnpFsVm0CbTjphR0djn64wfMSfrDotIlkfhZUgnNV1XdO+74ZKznum/UpgSIuY2GrNZvZaUMa0FXzQqW3hG8iD+JYyymkLZhZzT/ZJx0lU0Vt8lq/4DxCslvEVqe4IdoRxm4qYPTapJya+Tls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cnJoxNks; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bde4d0e48fd011f0bd5779446731db89-20250912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zguUP/rKI41td6Qd1x37NGTIr2eKo9bTe8UKCbXqKyg=;
	b=cnJoxNkso4sJcnDHy7hcZraIxd8IQJa0aJruIqq2aYMm2D48aZAzFN52D9ab3wbToTFM3GOuQF6iKKqzky+e/2WngK0K5Ma3XljX5UQCSVIDL/nFYeOC3oieLA4O5tEFmholJE6ThsQTKRwNwaGAZvr2dVi7p30x/eUQFV7auso=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:a9f2bb8b-f07c-4ec4-b9a5-7f177d9ee2fe,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:1ca6b93,CLOUDID:c4c9b884-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bde4d0e48fd011f0bd5779446731db89-20250912
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 981950334; Fri, 12 Sep 2025 20:05:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 12 Sep 2025 20:05:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 12 Sep 2025 20:05:13 +0800
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
Subject: [PATCH v2 0/4] Add support for MT8189 clock/power controller
Date: Fri, 12 Sep 2025 20:04:49 +0800
Message-ID: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

These patches add support for the clock and power controllers
of MediaTek's new SoC, MT8189. With these changes,
other modules can easily manage clock and power resources
using standard Linux APIs, such as the Common Clock Framework (CCF)
and pm_runtime on MT8189 platform.

Irving-ch Lin (4):
  dt-bindings: clock: mediatek: Add MT8189 clock definitions
  dt-bindings: power: mediatek: Add MT8189 power domain definitions
  clk: mediatek: Add clock drivers for MT8189 SoC
  pmdomain: mediatek: Add power domain driver for MT8189 SoC

 .../bindings/clock/mediatek,mt8189-clock.yaml |   89 ++
 .../clock/mediatek,mt8189-sys-clock.yaml      |   58 +
 .../mediatek,mt8189-power-controller.yaml     |   88 ++
 drivers/clk/mediatek/Kconfig                  |  146 +++
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c  |  135 +++
 drivers/clk/mediatek/clk-mt8189-bus.c         |  289 +++++
 drivers/clk/mediatek/clk-mt8189-cam.c         |  131 ++
 drivers/clk/mediatek/clk-mt8189-dbgao.c       |  115 ++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c      |   61 +
 drivers/clk/mediatek/clk-mt8189-iic.c         |  149 +++
 drivers/clk/mediatek/clk-mt8189-img.c         |  122 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c      |  100 ++
 drivers/clk/mediatek/clk-mt8189-mfg.c         |   56 +
 drivers/clk/mediatek/clk-mt8189-mmsys.c       |  233 ++++
 drivers/clk/mediatek/clk-mt8189-scp.c         |   92 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c    | 1057 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c         |  106 ++
 drivers/clk/mediatek/clk-mt8189-vcodec.c      |  119 ++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c      |  145 +++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c    |  280 +++++
 drivers/clk/mediatek/clk-mux.c                |    4 +
 drivers/pmdomain/mediatek/mt8189-scpsys.h     |   75 ++
 drivers/pmdomain/mediatek/mtk-scpsys.c        |  967 ++++++++++++++-
 .../dt-bindings/clock/mediatek,mt8189-clk.h   |  580 +++++++++
 .../dt-bindings/power/mediatek,mt8189-power.h |   38 +
 26 files changed, 5206 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mmsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c
 create mode 100644 drivers/pmdomain/mediatek/mt8189-scpsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h

-- 
2.45.2


