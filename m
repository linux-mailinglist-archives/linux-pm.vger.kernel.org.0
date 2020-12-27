Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC142E30C1
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL0K4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 05:56:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47773 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726156AbgL0K4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2020 05:56:15 -0500
X-UUID: 3153a855ff7c4a1ba0a571b8ba8e165c-20201227
X-UUID: 3153a855ff7c4a1ba0a571b8ba8e165c-20201227
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 374566911; Sun, 27 Dec 2020 18:55:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Dec 2020 18:56:16 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Dec 2020 18:56:16 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v10 0/7] soc: mediatek: SVS: introduce MTK SVS engine
Date:   Sun, 27 Dec 2020 18:54:42 +0800
Message-ID: <20201227105449.11452-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FD6B93BC45DE05FD942C99464D76DEB9833C2EC44C0B92C252F2326DD2A1B2352000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
2. SVS driver gets thermal/GPU device by node [2][3] and do device_link_add()
to make sure probe/suspend callback priority.
3. SVS driver gets CPU device by get_cpu_device() and do device_link_add()
to make sure probe/suspend callback priority.
3. SVS dts refers to reset controller [4] to help reset SVS HW.

#mt8183 SVS related patches
[1] https://patchwork.kernel.org/patch/11193513/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201013102358.22588-2-michael.kao@mediatek.com/
[3] https://patchwork.kernel.org/project/linux-mediatek/patch/20200306041345.259332-3-drinkcat@chromium.org/

#mt8192 SVS related patches
[1] https://patchwork.kernel.org/patch/11193513/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201223074944.2061-1-michael.kao@mediatek.com/
[3] https://lore.kernel.org/patchwork/patch/1356662/
[4] https://patchwork.kernel.org/project/linux-mediatek/patch/20200817030324.5690-5-crystal.guo@mediatek.com/

changes since v9:
- Since MTK SVS is SoC specific driver that doesn't share any code,
move it into Soc specific directory like these.
- Remove unnecessary SVS header file.
- Add mt8192 SVS driver.
- Change linux license to GPL-2.0-only.
- Squash "struct mtk_svs" members into "struct svs_platform"
and remove "struct mtk_svs".

Roger Lu (7):
  [v10,1/7]: dt-bindings: soc: mediatek: add mtk svs dt-bindings
  [v10,2/7]: arm64: dts: mt8183: add svs device information
  [v10,3/7]: soc: mediatek: SVS: introduce MTK SVS engine
  [v10,4/7]: soc: mediatek: SVS: add debug commands
  [v10,5/7]: dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
  [v10,6/7]: arm64: dts: mt8192: add svs device information
  [v10,7/7]: soc: mediatek: SVS: add mt8192 SVS GPU driver

 .../bindings/soc/mediatek/mtk-svs.yaml        |  101 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   20 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   34 +
 drivers/soc/mediatek/Kconfig                  |   10 +
 drivers/soc/mediatek/Makefile                 |    1 +
 drivers/soc/mediatek/mtk-svs.c                | 2554 +++++++++++++++++
 6 files changed, 2720 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
 create mode 100644 drivers/soc/mediatek/mtk-svs.c


