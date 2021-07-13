Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496D23C685F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 04:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhGMCIv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 22:08:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33522 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230074AbhGMCIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 22:08:51 -0400
X-UUID: 1bd1741149134731b85bb61609e9189e-20210713
X-UUID: 1bd1741149134731b85bb61609e9189e-20210713
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yt.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 42046542; Tue, 13 Jul 2021 10:05:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Jul 2021 10:05:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 10:05:56 +0800
From:   YT Lee <yt.lee@mediatek.com>
To:     <yt.lee@mediatek.com>, <roger.lu@mediatek.com>,
        <matthias.bgg@gmail.com>, <eballetbo@gmail.com>,
        <khilman@kernel.org>, <robh+dt@kernel.org>, <drinkcat@google.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>
CC:     <srv_heupstream@mediatek.com>, <fan.chen@mediatek.com>,
        <xiaoqing.liu@mediatek.com>, <charles.yang@mediatek.com>,
        <angus.lin@mediatek.com>, <mark.rutland@arm.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux@roeck-us.net>, <louis.yu@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: soc: mediatek: add mt8195 svs dt-bindings
Date:   Tue, 13 Jul 2021 10:05:51 +0800
Message-ID: <20210713020552.18667-2-yt.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210713020552.18667-1-yt.lee@mediatek.com>
References: <20210713020552.18667-1-yt.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new binding documentation of the mt8195 svs.

Signed-off-by: YT Lee <yt.lee@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
index 59342e627b67..fdd656448454 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
@@ -23,6 +23,7 @@ properties:
     enum:
       - mediatek,mt8183-svs
       - mediatek,mt8192-svs
+      - mediatek,mt8195-svs
 
   reg:
     maxItems: 1
-- 
2.18.0

