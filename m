Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1F41BE5E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbhI2Eon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:43 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46255 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244007AbhI2Eok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2BF33580DDC;
        Wed, 29 Sep 2021 00:43:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Sep 2021 00:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=RPTx2E3/dPvDB
        zeSLOXZzTgLrgyxEOS9XlZaR7l0qTk=; b=NevG6tn+zFbzzZgiitMs3HO5pTpg1
        YIRCTHiNzP8x/HxNLUehFB55CU3P3ITzq6Z5L5HDmfOmhM6mfZMannqvTVJwtViv
        s8XDFL9PuUdzL3jqNTWuxupUs5MWHUIZsLtooK+ZUrPKv+Yc9xJZ0btWBJSr9Z97
        IHfV7lzYvyFfZ+UsaCZYIpblK5PfPQKc+uaRlRQNe1oC/JZpWdMZR9n8+7djmIpc
        Z5nyMYTCm/A4JUZcuBJjDEqFwGolTtasVFBfiNLji5tPj6NqA1kau7J7my3wK0b0
        OLpAaI54ctENxQl1NVIxiBmge+XzTRe8wX7Fhcj1UBhmU0qEJ2y1oAXsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=RPTx2E3/dPvDBzeSLOXZzTgLrgyxEOS9XlZaR7l0qTk=; b=ahax2TnM
        0DbB2G6bsV/dSceacz87i69rnYfkyWATVb5KZITpTIeRiHEO+mf3dsZ0uKjeUefL
        XTVdmMctawS2/UFNfB6BCyiXTZR9Yh6xgUD68W/YEEdhW9Pnt/Fp5eNR8ZsXbry4
        XoVNR//vUICdfBwJuLVX9mkRM8GX8gPNLzireJHVZrQBMIIEdxrBUMtAoBrdXB0A
        70OTsnuBPgqX+u3NwpuHltVnx8MaTImgy7gvju7QqokkZsg+ZishhQ5DHuNy2YdN
        A+9cfWmEwhgrgcL8hinGwoNV0LQleyLsCw/NjvWCtJe6SGgk2rjH+IsuT+9aoqce
        KCm7+Pt3Pr9IYw==
X-ME-Sender: <xms:1O5TYd26-9dC0AM2lELdpTd1ngPnR_U-FZsTmyOI1GsvFGHVqsSP6A>
    <xme:1O5TYUE6w1FBcbIcMqlCcUsROPLPaMo4-hMCPLq20xsCmGmHoOTxn11UfjQOWiwoI
    SLrDyhjRxfM2OIVxg>
X-ME-Received: <xmr:1O5TYd6Lwj8qjS-5_aBXkgwCquOwGpWzQ20hBNnH5OyF-yew17aJKNpiakt6TVu19g0dzUA-iiVeZcoKPZxqYh8qr2kKvIoisayzbDILZDeUaXxqQvobUYMpTvEoco7Lo5a7QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1O5TYa1tCqlMKOPlAzTJJlW8rQKnTVlG8z0UPJoy6naaHjPYMSuXAA>
    <xmx:1O5TYQHlubWCnoFvPde0BtsxnHue1zlK-227OP2g9tXrLgLO9uqy2g>
    <xmx:1O5TYb8DuN_zmQbJSMWBRJdb3S6oWIhsBEV6l_g0uaBDTQgZj23mhg>
    <xmx:1O5TYUGUw6XzFQioAuGJ2xJ4ld9I1SX2AvnK1LwnPKHg7oppfP_YLg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:42:59 -0400 (EDT)
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
Subject: [PATCH 05/10] dt-bindings: clock: sunxi: Export CLK_DRAM for devfreq
Date:   Tue, 28 Sep 2021 23:42:49 -0500
Message-Id: <20210929044254.38301-6-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MBUS node needs to reference the CLK_DRAM clock, as the MBUS
hardware implements memory dynamic frequency scaling using this clock.

Export this clock for SoCs which will be getting a devfreq driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h        | 2 --
 include/dt-bindings/clock/sun50i-a64-ccu.h | 2 +-
 include/dt-bindings/clock/sun8i-h3-ccu.h   | 2 +-
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
index 54d1f96f4b68..a8c11c0b4e06 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
@@ -51,8 +51,6 @@
 
 #define CLK_USB_OHCI1_12M		92
 
-#define CLK_DRAM			94
-
 /* All the DRAM gates are exported */
 
 /* And the DSI and GPU module clock is exported */
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
index d8c38447e11b..e13f3c4b57d0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -42,8 +42,6 @@
 
 /* The first bunch of module clocks are exported */
 
-#define CLK_DRAM		96
-
 /* All the DRAM gates are exported */
 
 /* Some more module clocks are exported */
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index 318eb15c414c..175892189e9d 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -113,7 +113,7 @@
 #define CLK_USB_OHCI0		91
 
 #define CLK_USB_OHCI1		93
-
+#define CLK_DRAM		94
 #define CLK_DRAM_VE		95
 #define CLK_DRAM_CSI		96
 #define CLK_DRAM_DEINTERLACE	97
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index 30d2d15373a2..5d4ada2c22e6 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -126,7 +126,7 @@
 #define CLK_USB_OHCI1		93
 #define CLK_USB_OHCI2		94
 #define CLK_USB_OHCI3		95
-
+#define CLK_DRAM		96
 #define CLK_DRAM_VE		97
 #define CLK_DRAM_CSI		98
 #define CLK_DRAM_DEINTERLACE	99
-- 
2.31.1

