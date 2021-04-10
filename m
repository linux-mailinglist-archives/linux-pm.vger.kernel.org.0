Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5335AB08
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 07:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhDJFKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Apr 2021 01:10:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34911 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229591AbhDJFKk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Apr 2021 01:10:40 -0400
X-UUID: e2a76d7d4bca4848be9b53c49431ff66-20210410
X-UUID: e2a76d7d4bca4848be9b53c49431ff66-20210410
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 46885902; Sat, 10 Apr 2021 13:10:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Apr 2021 13:10:18 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Apr 2021 13:10:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 2/5] dt-bindings: usb: mtk-xhci: add wakeup interrupt
Date:   Sat, 10 Apr 2021 13:10:03 +0800
Message-ID: <1618031406-15347-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618031406-15347-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1618031406-15347-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E17103FB531DAC6961A975A9761F7CACEEA0AA56C5433C513A7E3E175D64DE182000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add an interrupt which is EINT usually to support runtime PM,
meanwhile add "interrupt-names" property, for backward
compatibility, it's optional and used when wakeup interrupt
exists

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add Reviewed-by Rob
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml  | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 45bf4ea00c9e..4fe8a301d03f 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -46,7 +46,18 @@ properties:
       - const: ippc  # optional, only needed for case 1.
 
   interrupts:
-    maxItems: 1
+    description:
+      use "interrupts-extended" when the interrupts are connected to the
+      separate interrupt controllers
+    minItems: 1
+    items:
+      - description: xHCI host controller interrupt
+      - description: optional, wakeup interrupt used to support runtime PM
+
+  interrupt-names:
+    items:
+      - const: host
+      - const: wakeup
 
   power-domains:
     description: A phandle to USB power domain node to control USB's MTCMOS
-- 
2.18.0

