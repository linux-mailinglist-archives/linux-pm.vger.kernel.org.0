Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F964851A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLIP0j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLIP0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B18E590
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltQRNpKcbMvbatGcs9wd9W5OuEFruwa3ZCdsU4PE8jw=;
        b=U5MuayQlRcGfR+1TxeCsHUrQeGOPC6+RaVfpABwks1HRseZkfkuSlTU7nGMA2Jt/Dco71z
        Usmfx6QxDBz1DKGMDbvMEAtr1Q11EbrEQzb49lCb9JC+tgKcTJFwE945soFL0Ab6KbCEad
        unPcCNyx2hvVUUzMCCDycTybI+4GGatsO5WSM2VOOl0+rb3tjTbRaqtZtZxbBmNhNwDFMw
        5YHu9hBA8Oq8GEq6Arn55/g8JYBaLegEsmmAABfKQlR337ir1Jtkq0Z8qx7Bdz4xiqsRXl
        Pda5pTRz3tGqSYFRyiLMQrbWcZYGzqNYYfSAoXL3KvHHrPxQPXh1BaPNn/XBlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltQRNpKcbMvbatGcs9wd9W5OuEFruwa3ZCdsU4PE8jw=;
        b=DVeUpXV9WnpEaNlQ/5fOHTx2fscCWN1E+0Ke+bbTtf0PxX2XufywaCTTnmrsysnBrljZ8j
        tJrlSzRWt9Q/HuAQ==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: k3-j72xx: conditionally
 require efuse reg range
Cc:     Bryan Brattlof <bb@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221031232702.10339-7-bb@ti.com>
References: <20221031232702.10339-7-bb@ti.com>
MIME-Version: 1.0
Message-ID: <167059958614.4906.15938066618701959081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f4bc0e20e998af03099c11b1b4b92528dde2f9b4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f4bc0e20e998af03099c11b1b4b92528dde2f9b4
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Mon, 31 Oct 2022 18:26:57 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:45 +01:00

dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range

Only some of TI's J721E SoCs will need a eFuse register range mapped to
determine if they're affected by TI's i2128 erratum. All other SoC will
not need this eFuse range to function properly

Update the bindings for the k3_j72xx_bandgap thermal driver so other
devices will only need two register ranges

Signed-off-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221031232702.10339-7-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index 3bb870a..0509c9c 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -37,6 +37,7 @@ properties:
           devices to function properly. This eFuse region provides
           the information needed for these SoCs to report
           temperatures accurately.
+    minItems: 2
 
   power-domains:
     maxItems: 1
@@ -44,6 +45,21 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,j721e-vtm
+    then:
+      properties:
+        reg:
+          minItems: 3
+    else:
+      properties:
+        reg:
+          maxItems: 2
+
 required:
   - compatible
   - reg
