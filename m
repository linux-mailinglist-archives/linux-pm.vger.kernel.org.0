Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E6648529
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiLIP0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiLIP0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F968F701
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:32 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MRj8s/i5RdqiFE54qQQMtWA9Kdo3GoMylSZp5n0gbB4=;
        b=mPQV+J6KzN6AUysQJA1hGaPICN9iLCWs3KdzEI+OW7WsNa6qw9/GOaIRjfO3NZ8DgDUOvT
        b2FEgSBK83iPFaS/JmNcM8Nv8biTyRSlKQP5dCIWiPBszhJjYZpg6M36XrSpPHz4XmlAQ/
        PuG92D8eCjV5BJIOrGduM/a/yRnH1Cz7huxRxhCvZQfVf5/4z2LdBbPNoPawA/j6ecJTyM
        wAx7SFz8OLK+ZeX46ZUwToui0JngRS7G6qpWn/iiVglSN/hSc7yx+rUo2eeuHcDCpFaWBi
        /JfPoUZtRbc7YhgbyQRaXLFpBhVQNeqBW0TnwWDAj5Mreh67VLktXCQWHokAig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MRj8s/i5RdqiFE54qQQMtWA9Kdo3GoMylSZp5n0gbB4=;
        b=xYs8Jq2qG1/HehVZZii6fX4QIt8nRUPqyCJ56l/oAdadA56q0uPLLUGMSvPOVX2XzQTXjk
        ilz5I6/UeKjE4oBg==
From:   "thermal-bot for Daniel Golle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: mediatek: add
 compatible string for MT7986 and MT7981 SoC
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059958844.4906.2869788614670880099.tip-bot2@tip-bot2>
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

Commit-ID:     071e99848ccc1fbe238c4c9c7cfffd83f1dfe156
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//071e99848ccc1fbe238c4c9c7cfffd83f1dfe156
Author:        Daniel Golle <daniel@makrotopia.org>
AuthorDate:    Wed, 30 Nov 2022 13:20:38 
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

dt-bindings: thermal: mediatek: add compatible string for MT7986 and MT7981 SoC

Document compatible string 'mediatek,mt7986-thermal' for V3 thermal
unit found in MT7986 SoCs.
'mediatek,mt7981-thermal' is also added as it is identical with the
thermal unit of MT7986.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 5c7e7bd..38b32bb 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -13,6 +13,8 @@ Required properties:
   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
+  - "mediatek,mt7981-thermal", "mediatek,mt7986-thermal" : For MT7981 SoC
+  - "mediatek,mt7986-thermal" : For MT7986 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
