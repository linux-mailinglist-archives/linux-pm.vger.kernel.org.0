Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5879922BEB1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 09:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXHLn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 03:11:43 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:51437 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbgGXHLm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 03:11:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4688674|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00592741-0.000606278-0.993466;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.I6q0SNp_1595574693;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I6q0SNp_1595574693)
          by smtp.aliyun-inc.com(10.147.42.22);
          Fri, 24 Jul 2020 15:11:38 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 07/16] dt-bindings: thermal: sun8i: Add binding for A100's THS controller
Date:   Fri, 24 Jul 2020 15:10:57 +0800
Message-Id: <8280af8ad82ed340c0ef1c171684aaad91600679.1595572867.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
References: <cover.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's ths controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
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

