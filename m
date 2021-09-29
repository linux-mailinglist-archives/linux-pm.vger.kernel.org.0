Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8641BE5F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbhI2Eoo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:44 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39379 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244035AbhI2Eol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D5F58580DE0;
        Wed, 29 Sep 2021 00:43:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 Sep 2021 00:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ybub729T/Cjfw
        ayZ+WJmNLp/2DPQ83BAzIInc4+TvE4=; b=W8pPIrqIVhNmpK4E40XmbuJjRSTQ1
        ySTYRxzvbRqQESOCYb/OqKXW1KA485Gx3B6sQzVGdAqENbscgAVPoUSv4G5sjhUw
        hw1t0ROjZIUK4wEeu6oNx2DVz+zQyJitwcF3LrBTS7UOpkB752QMYhzmiW3Z9JJ7
        x6747tiv74yJNqnBJ0w85I0JhmNtwxLPBSOIjEm5E2m20cGZMPW3mw2dqxEZzf8F
        C1U8Gx2a3lAfbT56aN2XYGFmmle9cTsKn+AMOYBvyznUsatnOFq+xxrLohHt1awN
        QLWcemMjNgRszap/zl0Ti5JADSqQKvpYm/I7C4beoznJb3Ahwq3amimWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ybub729T/CjfwayZ+WJmNLp/2DPQ83BAzIInc4+TvE4=; b=vmx9Dwe2
        awcnu/r97QXK12drrX2rkX4/dxUVf6aAQ/a4jYhbGU2eElrCfhhj9L9j2BPXEKef
        Z298XYO0K+fPqm4bwQj3hGELPQ9r3QyFXYl0bpesHLfnZcbSARulKznXAaWW/CMZ
        /LJ7t5EavLLMZO8/eSJWj0ScnDIvDRQtZxYa+x+URAWVllpBnfYtNnwG1E/U2F9p
        NgoFCFY5XDzW3L7vnOHnElsZvx8pwEqP0f2yP1c8fX8UtJSvhpVF7c/t3Uc2dJ2t
        llc+KZ9PNsA4tzNSPJECzJSHnTYcyTC4Wfdl8oxXSkla6TNIMaJA4hTrf03wo/4/
        +ur55IMI7ujrRg==
X-ME-Sender: <xms:1O5TYe-rk9yDMeaV4Nz1tJ-GpG1CPTaKV6-vDqbUfaOepuUfSgur5g>
    <xme:1O5TYesKo6EkHAyjPd5nSAAtpJMIVSN8f5FbWU7rQ_19_8TxorZY6WruKWkn7JcqX
    5btHu8AcfEaN87V3Q>
X-ME-Received: <xmr:1O5TYUAgPyA7INzlWOKdnwlyvkzHHBeA-nP7fwS3-yRe6dYmt3Sz_Ycz9ntHeEXKCXYHUCvWwFuN04sD3NXSfmFkSnPKZdyS-rBP8sQmCGi6jyk-y7qUrP11lVPrpZ892x9IBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1O5TYWenvfFeJotjCbnPin5tH2ndm5j6tXM1SZ64sfeihUGsyZqGHw>
    <xmx:1O5TYTOVXjOXRH-aomDvXbUuEVX8mvNI_75nkVuvj05jjRjj9OmEmg>
    <xmx:1O5TYQn1Ox8nLxc6PKG9jBu9KZ76PCuPrjv803FpQRMEIIr9U0KGXw>
    <xmx:1O5TYRv6QytUZ4K66u5xn3YGh1Vjn6kouLQ3wityrXphwy-KqcQjYw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:43:00 -0400 (EDT)
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
Subject: [PATCH 06/10] dt-bindings: arm: sunxi: Expand MBUS binding
Date:   Tue, 28 Sep 2021 23:42:50 -0500
Message-Id: <20210929044254.38301-7-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
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
2.31.1

