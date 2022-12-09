Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961BF64851B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLIP0j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiLIP0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794898E5B8
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:30 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrTsD7f8T4Ib/2maaoVFAVoJYcrXLocdaH+Av7Hn3UM=;
        b=4ATpnibeOiKVEOVX+6UKcTVQH68zgRZXZhZftPzHFrcE9dOMqi9m/+GmjziiCR4eN7eX/V
        XnqipyXU2h+yaMvcKk6CMNHlsZN8sFLwCGFs0lCeiU0WtzJDZt8CKbk1YX6zl8BHwhUSvf
        3AZzl9eq9QfAy/aA3KWrJf/ZdyMK2i63OPEOFXKWzyY+74tHgxlxnFgX+7XCq9FG722yhe
        6aXWcysFQZyokKq8w6AFei90kpfuDW9uhO4m3PtF7tM+ga+uysMla6kftJmkMm+VjXvQRt
        zB0ylj26y/Hl0w2P0bOFWQCDTflDcVQ/vH0/w58rPkJJnXknVaiQ0gB87E0l2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrTsD7f8T4Ib/2maaoVFAVoJYcrXLocdaH+Av7Hn3UM=;
        b=q8GrlTMYIIbGFkrJEwcu33vCdshI1yQBYUsiB9wsfPlCw9SOObGV2IZgtcVUedJe6Dsw6B
        dCHF9zp8wtFpDfBg==
From:   "thermal-bot for Bryan Brattlof" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: k3-j72xx: elaborate on
 binding description
Cc:     Bryan Brattlof <bb@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221031232702.10339-6-bb@ti.com>
References: <20221031232702.10339-6-bb@ti.com>
MIME-Version: 1.0
Message-ID: <167059958636.4906.1160725216881406686.tip-bot2@tip-bot2>
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

Commit-ID:     999bb9737533c3b512ebb880f5f0e4803b65516b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//999bb9737533c3b512ebb880f5f0e4803b65516b
Author:        Bryan Brattlof <bb@ti.com>
AuthorDate:    Mon, 31 Oct 2022 18:26:56 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

dt-bindings: thermal: k3-j72xx: elaborate on binding description

Elaborate on the function of this device node as well as some of the
properties this node uses.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221031232702.10339-6-bb@ti.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index c74f124..3bb870a 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -9,6 +9,19 @@ title: Texas Instruments J72XX VTM (DTS) binding
 maintainers:
   - Keerthy <j-keerthy@ti.com>
 
+description: |
+  The TI K3 family of SoCs typically have a Voltage & Thermal
+  Management (VTM) device to control up to 8 temperature diode
+  sensors to measure silicon junction temperatures from different
+  hotspots of the chip as well as provide temperature, interrupt
+  and alerting information.
+
+  The following polynomial equation can then be used to convert
+  value returned by this device into a temperature in Celsius
+
+  Temp(C) = (-9.2627e-12) * x^4 + (6.0373e-08) * x^3 + \
+            (-1.7058e-04) * x^2 + (3.2512e-01) * x   + (-4.9003e+01)
+
 properties:
   compatible:
     enum:
@@ -19,7 +32,11 @@ properties:
     items:
       - description: VTM cfg1 register space
       - description: VTM cfg2 register space
-      - description: VTM efuse register space
+      - description: |
+          A software trimming method must be applied to some Jacinto
+          devices to function properly. This eFuse region provides
+          the information needed for these SoCs to report
+          temperatures accurately.
 
   power-domains:
     maxItems: 1
