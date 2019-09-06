Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E396AB54F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfIFKFq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 06:05:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11213 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728254AbfIFKFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 06:05:46 -0400
X-UUID: b3a6b3957d3e4cfe992546802938b40c-20190906
X-UUID: b3a6b3957d3e4cfe992546802938b40c-20190906
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 627805015; Fri, 06 Sep 2019 18:05:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Sep 2019 18:05:33 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Sep 2019 18:05:33 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>, <yt.lee@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v5 0/3] PM / AVS: SVS: Introduce SVS engine
Date:   Fri, 6 Sep 2019 18:05:12 +0800
Message-ID: <20190906100514.30803-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

1. SVS driver use OPP adjust event in [1] to update OPP table voltage part.
2. SVS dts node refers to CPU opp table [2] and GPU opp table [3].
3. SVS dts node refers to thermal efuse [4] and PMIC regulator [5].

[1] https://patchwork.kernel.org/patch/11092245/
[2] https://patchwork.kernel.org/patch/10934123/
[3] https://patchwork.kernel.org/patch/11132381/
[4] https://patchwork.kernel.org/patch/11093655/
[5] https://patchwork.kernel.org/patch/11110493/

Roger Lu (3):
  dt-bindings: soc: add mtk svs dt-bindings
  arm64: dts: mt8183: add svs device information
  PM / AVS: SVS: Introduce SVS engine

 .../devicetree/bindings/power/mtk-svs.txt     |   88 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   16 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   38 +
 drivers/power/avs/Kconfig                     |   10 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/mtk_svs.c                   | 2075 +++++++++++++++++
 include/linux/power/mtk_svs.h                 |   23 +
 7 files changed, 2251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
 create mode 100644 drivers/power/avs/mtk_svs.c
 create mode 100644 include/linux/power/mtk_svs.h
