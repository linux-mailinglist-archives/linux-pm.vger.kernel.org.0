Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3036D340
	for <lists+linux-pm@lfdr.de>; Wed, 28 Apr 2021 09:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhD1HfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 03:35:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53384 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229478AbhD1HfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 03:35:14 -0400
X-UUID: d1c9e61e84f54e3484e7332fbdf65fd4-20210428
X-UUID: d1c9e61e84f54e3484e7332fbdf65fd4-20210428
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1687296803; Wed, 28 Apr 2021 14:54:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Apr 2021 14:54:42 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Apr 2021 14:54:42 +0800
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
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v16 0/7] soc: mediatek: SVS: introduce MTK SVS
Date:   Wed, 28 Apr 2021 14:54:33 +0800
Message-ID: <20210428065440.3704-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8A017A44F8733E750C40E683018EB1E5CFA6C167E86658109DCCEFA8E6B206AA2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
3. SVS dts refers to reset controller [4] to help reset SVS HW.

#mt8183 SVS related patches
[1] https://patchwork.kernel.org/patch/11193513/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201013102358.22588-2-michael.kao@mediatek.com/
[3] https://patchwork.kernel.org/project/linux-mediatek/patch/20200306041345.259332-3-drinkcat@chromium.org/

#mt8192 SVS related patches
[1] https://patchwork.kernel.org/patch/11193513/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201223074944.2061-1-michael.kao@mediatek.com/
[3] https://lore.kernel.org/patchwork/patch/1360551/
[4] https://patchwork.kernel.org/project/linux-mediatek/patch/20200817030324.5690-5-crystal.guo@mediatek.com/

changes since v15:
- Put (*set_freqs_pct) and (*get_vops) in struct svs_bank because they are part of svs bank's operation
- Add define "SVSB_INIT02_RM_DVTFIXED" and "SVSB_MON_VOLT_IGNORE" to make control clearly.
- Remove unnecessary parenthesis

Roger Lu (7):
  [v16,1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
  [v16,2/7] arm64: dts: mt8183: add svs device information
  [v16,3/7] soc: mediatek: SVS: introduce MTK SVS engine
  [v16,4/7] soc: mediatek: SVS: add debug commands
  [v16,5/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
  [v16,6/7] arm64: dts: mt8192: add svs device information
  [v16,7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver

 .../bindings/soc/mediatek/mtk-svs.yaml        |   92 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   18 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   34 +
 drivers/soc/mediatek/Kconfig                  |   10 +
 drivers/soc/mediatek/Makefile                 |    1 +
 drivers/soc/mediatek/mtk-svs.c                | 2524 +++++++++++++++++
 6 files changed, 2679 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
 create mode 100644 drivers/soc/mediatek/mtk-svs.c


