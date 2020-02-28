Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89944172EAC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 03:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgB1CPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 21:15:13 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:35808 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgB1CPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 21:15:13 -0500
Received: from droid13.amlogic.com (38.121.23.132) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 28 Feb 2020
 10:15:33 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND] dt-bindings: power: Fix dt_binding_check error
Date:   Fri, 28 Feb 2020 10:14:59 +0800
Message-ID: <1582856099-105484-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [38.121.23.132]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Missing ';' in the end of secure-monitor example node.

Fixes: f50b4108ede1 ("dt-bindings: power: add Amlogic secure power domains bindings")
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index af32209..bc4e037 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -36,5 +36,5 @@ examples:
             compatible = "amlogic,meson-a1-pwrc";
             #power-domain-cells = <1>;
         };
-    }
+    };
 
-- 
2.7.4

