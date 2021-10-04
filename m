Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409544204AB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhJDB3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:36 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:48611 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbhJDB3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 28B702B01318;
        Sun,  3 Oct 2021 21:27:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Oct 2021 21:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=hZHcadP8uZUPD
        wPmY5Mih70odkWsmmJQlVj53pfEXK0=; b=BEt/bYpyA8CkKM+zDMHNkTGIgREag
        H7eo8/D06rMT83H3hIU9hhH3Z3fSokqxgA8h8DVhxGIka77gj2LpdEX5ZjpxXgxa
        zY/Hr+J0N5vDjdZOqdKDnhyh8nRqBb/YIbWhjmDl1l+bcmuNTj/KGHOGdraBDAPJ
        eRiMffr+T4un67u7ZXoruDcagH1iq8OZlgo1o2rygVct7h57CS4CadQ9xfKxZXgh
        Mi054+ep0cDH3s500Xt1tqHHOrefMkL6NLh5r32yoVXIcO/O8E7TWKw7qRFizfl0
        T2PRjYK7n+lBJS8a+mPWae58hdbBaygpBmdjg2AyEI9gUBaXGLBfzbs/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=hZHcadP8uZUPDwPmY5Mih70odkWsmmJQlVj53pfEXK0=; b=TU1nCYue
        Fy91uvuMBhoDDbPXmsP6NgNp+oxdnTTrUypZThEHPpsnd4n70VzobShaUE5SWpMs
        MqHzPG37bkVWTa01s5dDKOtdT4SeXxp5k0cJFro05iPYEfOvCvPhAV6ebLV04k/n
        IFye0LDu10dnn6xk+Ow9G9LGQ6S7XTY5EYcG+RKpP/9oeWfwAzujx5HRiYOA/lLK
        9HH/gjZfibsYtG2Q3+N82CqWq1jiTNfcQRR7677Gu/DhItqlMRF5MhmZ1p+Ex4tW
        lBRYtRNZf/IyGn2YjeLEdECbBOVpL3mDDbZMhDjP5j3c/0CYnQN8VrZMnxovwV6q
        Xz8AsiB3cff/FQ==
X-ME-Sender: <xms:kVhaYZKuEvx3nI1UYBmhlJ7NeyQOEHPRE3338TVkbaxnOLt-DmpGVQ>
    <xme:kVhaYVKcWe8nQl3mRbiiNlUFKidy3qYBTp3Am_vY0Fyu0I1Vvb-9fk52lobkg4Ro5
    ccUrF8qqLAaS9_Xcw>
X-ME-Received: <xmr:kVhaYRuTkZr9Obp47hfmQVS6wNuIBVNUpJd3bEXF74ZwT-zM_6KZ6QPFS6ttY36O6wth472ZIAXIy3ooiQzESYkH0FF0RSDQiFLQB9A-HKcOAt2i0xyAaph6_lwzD08V8Hh1Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:kVhaYaZQ7eXbTsD-bZqlZCMTK8dcNvd8SatD_64sakljeBi_HeqPBQ>
    <xmx:kVhaYQY_zKXGSvHaUyfzepabXzGhh-5eegFEqIzBNvgpovdfNvwGVA>
    <xmx:kVhaYeDVBOcoV3HGIbaXZ3iNEqPstjobAX-9GH7F40yern3LNtTEjQ>
    <xmx:kVhaYQqCwAtvaMMqYFf5_h9QqZmyGnsPOpwYGDP_PbkgRmdOMwjRZ6bnX2M>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/6] dt-bindings: arm: sunxi: Expand MBUS binding
Date:   Sun,  3 Oct 2021 20:27:35 -0500
Message-Id: <20211004012739.39053-3-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211004012739.39053-1-samuel@sholland.org>
References: <20211004012739.39053-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MBUS provides more than address translation and bandwidth control.
It also provides a PMU to measure bandwidth usage by certain masters,
and it provides notification via IRQ when they are active or idle.

The MBUS is also tightly integrated with the DRAM controller to provide
a Memory Dynamic Frequency Scaling (MDFS) feature. In view of this, the
MBUS binding needs to represent the hardware resources needed for MDFS,
which include the clocks and MMIO range of the adjacent DRAM controller.

Add the additional resources for the H3 and A64 compatibles, and a new
example showing how they are used.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 75 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
index e713a6fe4cf7..c1fb404d2fb3 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
@@ -33,10 +33,33 @@ properties:
       - allwinner,sun50i-a64-mbus
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: MBUS interconnect/bandwidth/PMU registers
+      - description: DRAM controller/PHY registers
+
+  reg-names:
+    items:
+      - const: "mbus"
+      - const: "dram"
 
   clocks:
+    minItems: 1
+    items:
+      - description: MBUS interconnect module clock
+      - description: DRAM controller/PHY module clock
+      - description: Register bus clock, shared by MBUS and DRAM
+
+  clock-names:
+    items:
+      - const: "mbus"
+      - const: "dram"
+      - const: "bus"
+
+  interrupts:
     maxItems: 1
+    description:
+      MBUS PMU activity interrupt.
 
   dma-ranges:
     description:
@@ -53,13 +76,42 @@ required:
   - clocks
   - dma-ranges
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - allwinner,sun8i-h3-mbus
+          - allwinner,sun50i-a64-mbus
+
+then:
+  properties:
+    reg:
+      minItems: 2
+
+    clocks:
+      minItems: 3
+
+  required:
+    - reg-names
+    - clock-names
+
+else:
+  properties:
+    reg:
+      maxItems: 1
+
+    clocks:
+      maxItems: 1
+
 additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/sun5i-ccu.h>
+    #include <dt-bindings/clock/sun50i-a64-ccu.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    mbus: dram-controller@1c01000 {
+    dram-controller@1c01000 {
         compatible = "allwinner,sun5i-a13-mbus";
         reg = <0x01c01000 0x1000>;
         clocks = <&ccu CLK_MBUS>;
@@ -69,4 +121,21 @@ examples:
         #interconnect-cells = <1>;
     };
 
+  - |
+    dram-controller@1c62000 {
+        compatible = "allwinner,sun50i-a64-mbus";
+        reg = <0x01c62000 0x1000>,
+              <0x01c63000 0x1000>;
+        reg-names = "mbus", "dram";
+        clocks = <&ccu CLK_MBUS>,
+                 <&ccu CLK_DRAM>,
+                 <&ccu CLK_BUS_DRAM>;
+        clock-names = "mbus", "dram", "bus";
+        interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dma-ranges = <0x00000000 0x40000000 0xc0000000>;
+        #interconnect-cells = <1>;
+    };
+
 ...
-- 
2.32.0

