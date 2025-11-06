Return-Path: <linux-pm+bounces-37512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DEC3AEF8
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 13:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEB4E37A2
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BEC33031B;
	Thu,  6 Nov 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XecwvCtJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABC32D0E3;
	Thu,  6 Nov 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433029; cv=none; b=iLj5r89zhmrOdsvzCAU1NRtdiSXNYcnCmrPzoornO0ixdU6yo7F5uCW/oOyC/lcjHA2xrxkoxAB7RKsPoLDqNL+i3X4TskOkHFzygbuEuDUc5fcne8PtjsQiZlQPBe6yIo2z9z2VA5Zmjh77MmgQQXyX1CY0KUpI5Yi1i/OhgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433029; c=relaxed/simple;
	bh=ilcIo41hq2Uu1T+y97qrFSPeUCwBX6x+QLtHvjnX5uE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8gcyzOg+evcTyygjbJqr4Jtxvg5/TupPiujubX2fAfjF+uZE32AONpKBwSx5ZGqgQ7aJlmm6wmZQ40ZRcshg0dWCAJrtnyN8Bc1sGV683IDOB8CMa/sNMYMejkt/yQhWqo1yP5GuJJytFPpm955BilIGTl4z8AHTDJZ8Iaa6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XecwvCtJ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3753bc48bb0e11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TlPuFboA0/+wijz7NoKxg+57Ei+sKSGPYT3mlub2Nzw=;
	b=XecwvCtJYH3ogab3vB7Z0/76qXdS1Pgdj5Jtyz+1X8eZ0UfV2ZC+TlyeG9Mp5TvmcWEOQppcWUMnFwornIp6cJYtZGvVkqKNaq2mPZYasSjMyiL8QlV8Fwq53B9ynjLIqr60iMDomUPf8KddXA2Ctm0H0Yyy1sIxjhN7NwUhoHg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b771fc50-a037-401c-af3b-2faf6d2dfd85,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:d213fc7c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3753bc48bb0e11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1839782819; Thu, 06 Nov 2025 20:43:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 20:43:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 20:43:36 +0800
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
Subject: [PATCH v3 00/21] Add support for MT8189 clock/power controller
Date: Thu, 6 Nov 2025 20:41:45 +0800
Message-ID: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

changes since v3:
- Add power-controller dt-schema to mediatek,power-controller.yaml.
- Separates clock commit to small parts (by sub-system).
- Change to mtk-pm-domains for new MTK pm framework.

changes since v2:
- Fix dt-schema checking fails
- Merge dt-binding files and dt-schema files into one patch.
- Add vendor information to dt-binding file name.
- Remove NR define in dt-binding header.
- Add struct member description.

  This series add support for the clock and power controllers
of MediaTek's new SoC, MT8189. With these changes,
other modules can easily manage clock and power resources
using standard Linux APIs, such as the Common Clock Framework (CCF)
and pm_runtime on MT8189 platform.

Irving-CH Lin (21):
  dt-bindings: clock: mediatek: Add MT8189 clock definitions
  dt-bindings: power: mediatek: Add MT8189 power domain definitions
  clk: mediatek: fix mfg mux issue
  clk: mediatek: Add MT8189 apmixedsys clock support
  clk: mediatek: Add MT8189 topckgen clock support
  clk: mediatek: Add MT8189 vlpckgen clock support
  clk: mediatek: Add MT8189 vlpcfg clock support
  clk: mediatek: Add MT8189 bus clock support
  clk: mediatek: Add MT8189 cam clock support
  clk: mediatek: Add MT8189 dbgao clock support
  clk: mediatek: Add MT8189 dvfsrc clock support
  clk: mediatek: Add MT8189 i2c clock support
  clk: mediatek: Add MT8189 img clock support
  clk: mediatek: Add MT8189 mdp clock support
  clk: mediatek: Add MT8189 mfg clock support
  clk: mediatek: Add MT8189 mmsys clock support
  clk: mediatek: Add MT8189 scp clock support
  clk: mediatek: Add MT8189 ufs clock support
  clk: mediatek: Add MT8189 vcodec clock support
  pmdomain: mediatek: Add bus protect control flow for MT8189
  pmdomain: mediatek: Add power domain driver for MT8189 SoC

 .../bindings/clock/mediatek,mt8189-clock.yaml |   90 ++
 .../clock/mediatek,mt8189-sys-clock.yaml      |   58 +
 .../power/mediatek,power-controller.yaml      |    1 +
 drivers/clk/mediatek/Kconfig                  |  146 +++
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c  |  135 +++
 drivers/clk/mediatek/clk-mt8189-bus.c         |  238 ++++
 drivers/clk/mediatek/clk-mt8189-cam.c         |  123 ++
 drivers/clk/mediatek/clk-mt8189-dbgao.c       |  115 ++
 drivers/clk/mediatek/clk-mt8189-dispsys.c     |  211 ++++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c      |   57 +
 drivers/clk/mediatek/clk-mt8189-iic.c         |  139 +++
 drivers/clk/mediatek/clk-mt8189-img.c         |  122 ++
 drivers/clk/mediatek/clk-mt8189-mdpsys.c      |  100 ++
 drivers/clk/mediatek/clk-mt8189-mfg.c         |   56 +
 drivers/clk/mediatek/clk-mt8189-scp.c         |   84 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c    | 1018 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c         |  100 ++
 drivers/clk/mediatek/clk-mt8189-vcodec.c      |  108 ++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c      |  121 ++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c    |  278 +++++
 drivers/clk/mediatek/clk-mux.c                |    4 +
 drivers/pmdomain/mediatek/mt8189-pm-domains.h |  485 ++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |   36 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |    5 +
 .../dt-bindings/clock/mediatek,mt8189-clk.h   |  580 ++++++++++
 .../dt-bindings/power/mediatek,mt8189-power.h |   38 +
 27 files changed, 4457 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-bus.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dbgao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dispsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-dvfsrc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-iic.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-scp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-ufs.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c
 create mode 100644 drivers/pmdomain/mediatek/mt8189-pm-domains.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h

-- 
2.45.2


