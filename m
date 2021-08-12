Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6763EA13B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhHLJAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 05:00:49 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37280 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235447AbhHLJAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 05:00:49 -0400
X-UUID: 2328df363348403a9c2e7321a40d8671-20210812
X-UUID: 2328df363348403a9c2e7321a40d8671-20210812
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 79671751; Thu, 12 Aug 2021 17:00:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 17:00:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 17:00:21 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [V11,PATCH 02/19] dt-bindings: mediatek: add compatible for MT8195 dvfsrc
Date:   Thu, 12 Aug 2021 16:58:29 +0800
Message-ID: <20210812085846.2628-3-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210812085846.2628-1-dawei.chien@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds dt-binding documentation of dvfsrc for Mediatek MT8195
SoCs Platform.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
index f2b67b99921b..ec3feaf1ef73 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
@@ -25,6 +25,7 @@ properties:
       - mediatek,mt6873-dvfsrc
       - mediatek,mt8183-dvfsrc
       - mediatek,mt8192-dvfsrc
+      - mediatek,mt8195-dvfsrc
 
   '#interconnect-cells':
     const: 1
-- 
2.14.1

