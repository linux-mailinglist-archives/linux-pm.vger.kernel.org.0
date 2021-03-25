Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8D348715
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 03:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCYCvr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 22:51:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39753 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229822AbhCYCvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 22:51:24 -0400
X-UUID: 15287ade5a4b42bdaf70bf19f34c6687-20210325
X-UUID: 15287ade5a4b42bdaf70bf19f34c6687-20210325
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1643467707; Thu, 25 Mar 2021 10:51:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Mar 2021 10:51:14 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Mar 2021 10:51:14 +0800
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
Subject: [PATCH v14 0/7] soc: mediatek: SVS: introduce MTK SVS
Date:   Thu, 25 Mar 2021 10:51:07 +0800
Message-ID: <20210325025114.25842-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CCF7532FFE7D28D9056E8883632CDEB3DB4D8251430ED60D9E3CCB9A9AABCD842000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device(). After retrieving subsys device, SVS driver does
device_link_add() to make sure probe/suspend callback priority.
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

changes since v13:
- Fix "mtk-svs.yaml: properties:nvmem-cells:maxItems: False schema does not allow 2"
- Remove wrong maintainer "Nishanth Menon <nm@ti.com>"
- When turn_pt = 0, SVS HIGH bank fills FREQPCT74 / FREQPCT30 with 0 and SVS controller won't run normally. Therefore, we initialize SVS HIGH bank's FREQPCT30 with svsb->freqs_pct[0] to avoid this issue.
- Change SVS GPU opp count back from 14 to 16 because GPU DVFS has a better solution

Roger Lu (7):
  [v14,1/7]: dt-bindings: soc: mediatek: add mtk svs dt-bindings
  [v14,2/7]: arm64: dts: mt8183: add svs device information
  [v14,3/7]: soc: mediatek: SVS: introduce MTK SVS engine
  [v14,4/7]: soc: mediatek: SVS: add debug commands
  [v14,5/7]: dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
  [v14,6/7]: arm64: dts: mt8192: add svs device information
  [v14,7/7]: soc: mediatek: SVS: add mt8192 SVS GPU driver

 .../bindings/soc/mediatek/mtk-svs.yaml        |   92 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   18 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   34 +
 drivers/soc/mediatek/Kconfig                  |   10 +
 drivers/soc/mediatek/Makefile                 |    1 +
 drivers/soc/mediatek/mtk-svs.c                | 2495 +++++++++++++++++
 6 files changed, 2650 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
 create mode 100644 drivers/soc/mediatek/mtk-svs.c


