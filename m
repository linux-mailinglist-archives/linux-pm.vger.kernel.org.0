Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68F777B26
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjHJOpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjHJOpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 10:45:05 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF8211C;
        Thu, 10 Aug 2023 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1691678703; x=1723214703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0UAbxXWAQNdssPmXVzrxzDw2c7hP+0NfZiyE8xtXXA=;
  b=Zn7LNtlp+aiXRDitP+q8mny+2RZRb7oZ3QQUKdFQhAGjP0apEQZEYbaT
   JV0JsYp2yZVGGvxLp7eZdgcqUVRFFdUTojakyxxCnRRuSd4z3dzWQ4MGA
   NcpPpstdIiC8mU0btkALAApZtAY73h6P00tJQ5Y4g9jo7TJN0RLVM2ppy
   +1AOJgyvqsKeeQHS6kjsKu8OQ3s4PHzR1rkhj83AjG38KpleluvLMboCP
   GM10aE2oZhe0scf4N7/Uh/Mo0ZYpdF8fBzol5M9sX/JX3mZ0chWPujNzY
   zPjCfGTiRDDPIwJAyhNgUTJQtFMlmXhfP6XKQtXL25VentgstiHbXMV8L
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="32396725"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Aug 2023 16:44:59 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6140928008D;
        Thu, 10 Aug 2023 16:44:59 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 6/6] dt-bindings: timer: fsl,imxgpt: Add optional osc_per clock
Date:   Thu, 10 Aug 2023 16:44:51 +0200
Message-Id: <20230810144451.1459985-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit bad3db104f89 ("ARM: imx: source gpt per clk from OSC for
system timer") osc_per can be used for clocking the GPT which is not
scaled when entering low bus mode.
This clock source is available only on i.MX6Q (incl. i.MX6QP) and i.MX6DL.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---

Notes:
    osc_per is only used in arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi, so I assume
    this is the only platform supporting this source.
    
    I had to use minItem:2 and maxItems:3 in the constraints as fsl,imx6sx-gpt
    and fsl,imx6sl-gpt are also compatible to fsl,imx6dl-gpt, but only provide
    two clocks. Maybe this the compatible list needs some cleanup, but I do
    not know which hardware is compatible to what. The driver
    drivers/clocksource/timer-imx-gpt.c also gives no clues because it's totally
    mixed.

 .../devicetree/bindings/timer/fsl,imxgpt.yaml | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index c5d3be8c1d68..e2607377cbae 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -48,14 +48,18 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: SoC GPT ipg clock
       - description: SoC GPT per clock
+      - description: SoC GPT osc per clock
 
   clock-names:
+    minItems: 2
     items:
       - const: ipg
       - const: per
+      - const: osc_per
 
 required:
   - compatible
@@ -64,6 +68,29 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6dl-gpt
+              - fsl,imx6q-gpt
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 3
+        clock-names:
+          minItems: 2
+          maxItems: 3
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

