Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2445534B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhKRDVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:21:46 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44269 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242114AbhKRDVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8D6EA5808AA;
        Wed, 17 Nov 2021 22:18:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 17 Nov 2021 22:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=zey352EFCpsFQ
        pqj1nsFmQZoXQ/t7UNQSJE2e/lgDm4=; b=MpTZCQ0tHirR8jEXL/ZVwMAfxSKbp
        t2V6avAZ13Wi45ubHr1YwqWdWxGfk3e9IfPL0kIEP79/2n+k6tHv+dgKxZ8S74Hv
        Ebj8LLDlJCzWR63q/kuKAD0Dg1OMjGHMj/X4T+QFEgzQ8mlK/I9gcTAHzAbegJLc
        6EUWPwOSklY41SmwpW06RYcPF5klA9U27io027xyIaVpJ50g4sA5oQt0l64dOvmk
        3drEC8yKTD8e2bpCAiRWlwfDP1ss4W9I6AEyOskEeM5EaDBrvGiPMs/Kg1iq1MQE
        sGymzquvGE93wnvBn2EWyTMEgNHuqRrjxa88aF0H4Ij06KXkinYcOpouA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=zey352EFCpsFQpqj1nsFmQZoXQ/t7UNQSJE2e/lgDm4=; b=Snc57GjG
        lhJWn1HDHCST5Jdz2C3yQkn1m1kzECqVZgEtZohD0izCrNtRwoqNje91C1jrsMmu
        VBuyHm/v4G/WbYdxWx++uO5aseZ6h5yPiAnw5kWdZdQmHeNH/QN7kZTm/F6XiZlX
        nDonYd94ZlKyct53iOfKP5VY95Iy4f5EjAivK/mTdy35tTb/vaHBgmpWEd429Xav
        uF0y+XNodsudUpCbBLTvi4k3o//P3PgfFcSjGQgpNh0xKnRjvJrxLXl5wYNLkDQS
        eenaSB3dq1TnIW9H3nbZIZYs44Ed7AzOSjSgqb+9I+zi4yXElldf5JMquvSN+II3
        m9CSKxAMJoLqsQ==
X-ME-Sender: <xms:FcaVYWEY9pPqHc-XH_syAgLn_vxbuM26jPfIlS2y1OIWSqkSDwUQIw>
    <xme:FcaVYXWjEfn4p0lJ3Jaw8E3hiqnGFWLbtQgX-kMEGk9YXAWCpeFAA0YOrMEKF2qDT
    BdnQUN43CoVKSg93A>
X-ME-Received: <xmr:FcaVYQIPmgLD3A0xfTCVLXtdfH34tqNoLX_ZrY2h8yUKsm5Zy2V8mtP7sjRjvNB5tdbDjrcrDu1l7t3qa3QYhm_nXEP2tHocWqrYa-hkhCLkTM04eYM9t3ejT-e-pcv2qQc1HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FcaVYQGcz1s5CCv6qpxv1_Tx0oHRj6x0NAz3fJA6ZryT_7kaFNRciQ>
    <xmx:FcaVYcUWvog3kjDjX6LOiJYNM_Ve3b2bztIns_nh_KBSCRR1sfwujQ>
    <xmx:FcaVYTNM51X3_JIHXFg5i4wC2APMBUfyjv_OML_54NT8i2rYtAY1kw>
    <xmx:FcaVYbPRBIQV4ZZhgO2RNjCar9jZuSRoYQy77IsYWmvnFO_F7HeBaA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:44 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/6] dt-bindings: arm: sunxi: Expand MBUS binding
Date:   Wed, 17 Nov 2021 21:18:37 -0600
Message-Id: <20211118031841.42315-3-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118031841.42315-1-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org>
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 89 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
index 29c9961ee2d8..2b3829e0e240 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
@@ -34,10 +34,35 @@ properties:
       - allwinner,sun50i-a64-mbus
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: MBUS interconnect/bandwidth limit/PMU registers
+      - description: DRAM controller/PHY registers
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: mbus
+      - const: dram
 
   clocks:
+    minItems: 1
+    items:
+      - description: MBUS interconnect module clock
+      - description: DRAM controller/PHY module clock
+      - description: Register bus clock, shared by MBUS and DRAM
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: mbus
+      - const: dram
+      - const: bus
+
+  interrupts:
     maxItems: 1
+    description:
+      MBUS PMU activity interrupt.
 
   dma-ranges:
     description:
@@ -54,13 +79,54 @@ required:
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
+    reg-names:
+      minItems: 2
+
+    clocks:
+      minItems: 3
+
+    clock-names:
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
+    reg-names:
+      maxItems: 1
+
+    clocks:
+      maxItems: 1
+
+    clock-names:
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
@@ -70,4 +136,21 @@ examples:
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

