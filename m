Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9D3E88E5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhHKDii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 23:38:38 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55068 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233294AbhHKDih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 23:38:37 -0400
X-UUID: c2681096c0a448e699c16bf4386a4e6e-20210811
X-UUID: c2681096c0a448e699c16bf4386a4e6e-20210811
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yt.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1784548460; Wed, 11 Aug 2021 11:38:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 11:38:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 11:38:08 +0800
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
Subject: [PATCH v2 1/2] dt-bindings: soc: mediatek: add mt8195 svs dt-bindings
Date:   Wed, 11 Aug 2021 11:37:48 +0800
Message-ID: <20210811033749.30490-2-yt.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210811033749.30490-1-yt.lee@mediatek.com>
References: <20210811033749.30490-1-yt.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new binding documentation of the mt8195 svs.

Signed-off-by: YT Lee <yt.lee@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
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

