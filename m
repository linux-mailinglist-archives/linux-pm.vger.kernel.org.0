Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC64C733070
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjFPLux (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344520AbjFPLuw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 07:50:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B222D59;
        Fri, 16 Jun 2023 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oLOIF1H6yTDEB/JvSnvMfuJtDFZIQU8yHCwm9funvhI=; b=HJD/bGqXFaP5CTwe5mHusExVjX
        pM5Q+Mg0WqSWMQj13b6woRcnlXI0kk6aEBlDwr2S4LBD42uIEe3gDzaWdvOpc3UeQ8jL5Vseed7i/
        yBg0aedSI8lyKljFvHxOyT0Tm6nznadwV4KPbsNCxQW1In51QX4HbtgjlfdSeTjOBJOr+lvGyUtm1
        OBKI7R6xj7B4nM9GK+jQTebPGIBwYEp0Uh0tBrbesYuT/hi67hsgY7zf57d/FoMmQtw9DreCQoM0u
        PCUH4Lu9u1uGFXgtU4QYLhqcseyIHaBiTvFdNxxsqsBhjUIclDFC5KC16Lnc9iiDpNB3DFuzBbdFM
        usowFtnw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59344 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qA7ya-0004ya-F0; Fri, 16 Jun 2023 12:50:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qA7yZ-00Ea50-OC; Fri, 16 Jun 2023 12:50:47 +0100
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
Subject: [PATCH 3/3] arm64: dts: armada-ap807: update thermal compatible
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 16 Jun 2023 12:50:47 +0100
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

Use the correct thermal coefficients for the Armada AP807 dies.

Signed-off-by: Alex Leibovich <alexl@marvell.com>
Reviewed-by: Stefan Chulski <stefanc@marvell.com>
Tested-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
index 4a23f65d475f..a3328d05fc94 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
@@ -33,3 +33,6 @@ &ap_sdhci0 {
 		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
 };
 
+&ap_thermal {
+	compatible = "marvell,armada-ap807-thermal";
+};
-- 
2.30.2

