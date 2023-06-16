Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1912473306B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbjFPLum (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344620AbjFPLul (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 07:50:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBAB2D5D;
        Fri, 16 Jun 2023 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zF7xNAIZVyD+SHJ7ElUd/V4yfLSKIRVfGcSZbSIiZHU=; b=ZYSyTn+vawQRG09DHEa6aEUqCk
        j5WQuEaX3feZ4Ubfvxh2ri6l6WMfCkxj8IBSz5rE65Hv8Ha2YynlVhtKKjYmQ//V23wLSBTpFAQNL
        jomY+k6+wMGUNBLwOiwugW9CJD4QPN6jmUE0fGjBi6DACHKcww4Etwx23bjHOq2wsFm5078jZMgNM
        FYdqx44+PBXIJpRfBYsFowTLQgOtM9db90ZO8DdPX8WJvZsQvXnxKCS9osC5NSvsGSc7VkLEE5e6t
        lDBaZAUn0SIL1+WN3UxDIy672QpstyezVZ/4b4KOPnZXUbPEii/iMCESN+T0H4CSS5/pNkbq8Rvsw
        8qG5TmeA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48892 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qA7yQ-0004xw-3x; Fri, 16 Jun 2023 12:50:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qA7yP-00Ea4o-FS; Fri, 16 Jun 2023 12:50:37 +0100
In-Reply-To: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     Amit Kucheria <amitk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: armada-thermal: add armada-ap807-thermal
 compatible
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qA7yP-00Ea4o-FS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 16 Jun 2023 12:50:37 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Alex Leibovich <alexl@marvell.com>

Add marvell,armada-ap807-thermal compatible for the AP807 die.

Signed-off-by: Alex Leibovich <alexl@marvell.com>
Tested-by: sa_ip-sw-jenkins <sa_ip-sw-jenkins@marvell.com>
Reviewed-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index b0bee7e42038..ab8b8fccc7af 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -8,6 +8,7 @@
     * marvell,armada380-thermal
     * marvell,armadaxp-thermal
     * marvell,armada-ap806-thermal
+    * marvell,armada-ap807-thermal
     * marvell,armada-cp110-thermal
 
 Note: these bindings are deprecated for AP806/CP110 and should instead
-- 
2.30.2

