Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D7648528
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiLIP0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiLIP0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C68F711
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Ov17rShqEIdKt5Y10I3tlPzc05UGf6alc0fppan3No=;
        b=jDfxU8V79/OgOcHjt9CsQKekF+gtCPLL1GOZjnPunQBwjG9R3RWAmsrTD59Z09hZzUz7Lp
        +e0ugMJ1+bXd11vgwbV7pXI+rV++aznzianZ0telVovS264bBWIcwudLkRJml8MgiL0Yoc
        G+JYdh6cbJPdOu76XCk1mVEhkov8nBGckcJgvfVYGiOBN1n4uBJOhmE+zHc49Sq/oxiJyf
        oOW3RKwIq229mkf3ya9/35WM4KaXfssXtVWmtWtq5nLywv7OjHK0y7wnvyMrovurWn1KLh
        e52hTScIZT962MF0uvazcY7YT+wZPVsUttxtrUqgCMUaCu2ssdNZxFdodkGosA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Ov17rShqEIdKt5Y10I3tlPzc05UGf6alc0fppan3No=;
        b=GLaWNnSbhrclRDutWypEPyHskfzeWQKLOt+fkzSM9rS1rXSTBGvDqv6dpUfSyB9r9jAIUn
        FptDsijFgO6lEKDQ==
From:   "thermal-bot for Marek Vasut" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: imx8mm-thermal:
 Document optional nvmem-cells
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059958890.4906.13799118120839910102.tip-bot2@tip-bot2>
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

Commit-ID:     d431c3695a71cd33bc66e9d27a82e9d5b7b5fe45
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d431c3695a71cd33bc66e9d27a82e9d5b7b5fe45
Author:        Marek Vasut <marex@denx.de>
AuthorDate:    Fri, 02 Dec 2022 17:23:49 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

dt-bindings: thermal: imx8mm-thermal: Document optional nvmem-cells

The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
calibration values from OCOTP. Document optional phandle to OCOTP nvmem
provider.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml | 7 +++++++-
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
index 89c54e0..b907262 100644
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
@@ -32,6 +32,13 @@ properties:
   clocks:
     maxItems: 1
 
+  nvmem-cells:
+    maxItems: 1
+    description: Phandle to the calibration data provided by ocotp
+
+  nvmem-cell-names:
+    const: calib
+
   "#thermal-sensor-cells":
     description: |
       Number of cells required to uniquely identify the thermal
