Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688A2733068
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 13:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjFPLuQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbjFPLuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 07:50:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6347295B;
        Fri, 16 Jun 2023 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MbwrDoAUbff9Hrh1LZWVBAun+O4wMXvNsZ8kJJGYQ04=; b=dX6xJdkQx3/pcMqBP7FPTXn4Py
        08+1Pgj0Lo4jlvTikx25qxu4fWQ60EuhPw3tMLIRDUc/qbSDsudEawq+9LIWsGNlzaqYgJ+qey00B
        1RH9XIvEns+FzDI3GG//N6EpcK6Rg+iKFFNKYKyJdYzwkzHw1tJlNukZ87I1QzC8KA5fAkNTcpkTv
        3SAwSrYxFUknAK6hKziG0ZaUdWbksDHF5at9fWKad3P5EfEhnyrIbMwBl9zl7wJPX+nePz9KsJh5b
        Mi2Jql+dP6MBJjblCsnDJm1llsz+2avxWSqCYtCdTxpYFxNSs+LJ3bloCHSoAIZ0Yc4dEK3Jy1Hpd
        MQRXXlMA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43656)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qA7xj-0004xg-JI; Fri, 16 Jun 2023 12:49:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qA7xh-0002U8-8p; Fri, 16 Jun 2023 12:49:53 +0100
Date:   Fri, 16 Jun 2023 12:49:53 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Amit Kucheria <amitk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/3] Update for AP807 thermal data
Message-ID: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series updates the thermal data for the AP807 die, which has
different coefficients to the AP806.

These patches have come from the SolidRun CN913x build repository
which can be found at:
https://github.com/SolidRun/cn913x_build/tree/master/patches/linux

 .../devicetree/bindings/thermal/armada-thermal.txt |  1 +
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi      |  3 ++
 drivers/thermal/armada_thermal.c                   | 32 ++++++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
