Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED51202E92
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgFVC7u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 22:59:50 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54961 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731063AbgFVC7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 22:59:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7791149|0.5429038;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_regular_dialog|0.0643047-0.000806366-0.934889;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.HqMydez_1592794774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.HqMydez_1592794774)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 22 Jun 2020 10:59:43 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v2 01/11] dt-bindings: clk: sunxi-ccu: add compatible string for A100 CCU and R-CCU
Date:   Mon, 22 Jun 2020 10:58:57 +0800
Message-Id: <20200622025907.32574-2-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622025907.32574-1-frank@allwinnertech.com>
References: <20200622025907.32574-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding to a100's ccu clock and r-ccu clock.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 4d38212..3b45344 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -36,6 +36,8 @@ properties:
       - allwinner,sun9i-a80-ccu
       - allwinner,sun50i-a64-ccu
       - allwinner,sun50i-a64-r-ccu
+      - allwinner,sun50i-a100-ccu
+      - allwinner,sun50i-a100-r-ccu
       - allwinner,sun50i-h5-ccu
       - allwinner,sun50i-h6-ccu
       - allwinner,sun50i-h6-r-ccu
@@ -78,6 +80,7 @@ if:
         - allwinner,sun8i-a83t-r-ccu
         - allwinner,sun8i-h3-r-ccu
         - allwinner,sun50i-a64-r-ccu
+        - allwinner,sun50i-a100-r-ccu
         - allwinner,sun50i-h6-r-ccu
 
 then:
@@ -94,7 +97,9 @@ else:
   if:
     properties:
       compatible:
-        const: allwinner,sun50i-h6-ccu
+        enum:
+          - allwinner,sun50i-a100-ccu
+          - allwinner,sun50i-h6-ccu
 
   then:
     properties:
-- 
1.9.1

