Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59216359919
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 11:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhDIJ2t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 05:28:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35077 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231127AbhDIJ2t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 05:28:49 -0400
X-UUID: e83d2d72daee45d997e6b37515db3e34-20210409
X-UUID: e83d2d72daee45d997e6b37515db3e34-20210409
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 659312976; Fri, 09 Apr 2021 17:28:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 17:28:31 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 17:28:31 +0800
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
Subject: [PATCH v15 5/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
Date:   Fri, 9 Apr 2021 17:28:26 +0800
Message-ID: <20210409092828.23939-6-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210409092828.23939-1-roger.lu@mediatek.com>
References: <20210409092828.23939-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/mediatek/mtk-svs.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
index a855ced410f8..59342e627b67 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt8183-svs
+      - mediatek,mt8192-svs
 
   reg:
     maxItems: 1
@@ -51,6 +52,13 @@ properties:
       - const: svs-calibration-data
       - const: t-calibration-data
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: svs_rst
+
 required:
   - compatible
   - reg
-- 
2.18.0

