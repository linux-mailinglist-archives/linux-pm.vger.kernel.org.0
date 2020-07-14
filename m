Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90721E9B3
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGNHL6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 03:11:58 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:40818 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbgGNHL6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 03:11:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4868273|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00592741-0.000606278-0.993466;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.I1U1W7._1594710707;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1U1W7._1594710707)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 14 Jul 2020 15:11:51 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 07/16] dt-bindings: thermal: sun8i: Add binding for A100's THS controller
Date:   Tue, 14 Jul 2020 15:11:40 +0800
Message-Id: <da4026f02eb93193f63201a9d6654a870ada9dc7.1594708864.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594708863.git.frank@allwinnertech.com>
References: <cover.1594708863.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's ths controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 87369264feb9..9d40fc7ff6fd 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -17,6 +17,7 @@ properties:
       - allwinner,sun8i-h3-ths
       - allwinner,sun8i-r40-ths
       - allwinner,sun50i-a64-ths
+      - allwinner,sun50i-a100-ths
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
 
@@ -61,7 +62,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun50i-h6-ths
+            enum:
+              - allwinner,sun50i-a100-ths
+              - allwinner,sun50i-h6-ths
 
     then:
       properties:
@@ -103,6 +106,7 @@ allOf:
               - const: allwinner,sun8i-h3-ths
               - const: allwinner,sun8i-r40-ths
               - const: allwinner,sun50i-a64-ths
+              - const: allwinner,sun50i-a100-ths
               - const: allwinner,sun50i-h5-ths
               - const: allwinner,sun50i-h6-ths
 
-- 
2.24.0

