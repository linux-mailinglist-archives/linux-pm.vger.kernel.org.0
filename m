Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A584204B2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhJDB3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:43 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51803 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232209AbhJDB3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 148192B01318;
        Sun,  3 Oct 2021 21:27:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Oct 2021 21:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=CcvFh4HuzkBSe
        qWpoXTdQ8k6kPzZDUz8gpq+d2gNRvM=; b=OgtdLOrYTb1jvdd+BaxODyJD7qmP/
        Nb6mZBPqpumpvRGcSzI+et6IThys821DduwnNUkmnohlwOod7YaIuQMinj9JzWx8
        sJCpqU3+3AmO3DkDrW5YdCwYgYLLJogj6lD1iQwKjMeM0FFeR75XrTEdago3zxql
        tNH4t6sbXpN3UQ6Nbsm9SvjlNunXtn6zo491aK1joXO8cJN06xzRrWtrxfn96MSD
        jdEU2s6M6nr9M7wwFu5qSPUSnwxiLkmUX8Bbm51HJXmstX1iIzH4zHa/rrPgFy+q
        h18eaP1Q2hNWE7KH6CNhsL1/GBiwJYdQnS3qXYrNvrT2hcOAa1ZvIqQNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=CcvFh4HuzkBSeqWpoXTdQ8k6kPzZDUz8gpq+d2gNRvM=; b=fqTMEBLe
        jr/4ZMW6ZbmNsZwftDoSwcqAdF/YHRop+EzCeICSta9H6H29FeMTOXvSuTgQuk8H
        tjluykm/6+WBEFlVsjaf4kbHMH3Pmz7HBNbArHjJMfQeV6+jkgJFfIYi61ruf3Z+
        EQM12zW++k3NvvJNz61pDFt/71AfCdgBUbsJ1tjyaTliSzmzd6P366+zTAIfy+PE
        8NxxdpHdTII1XCPIu/khS+0O+XL9oBuJgDR13cpT5vmgKj1/OtKCxIViyUcLulQv
        s0HUg/80ob9IEyzQOIgm4PS08BOQxczcBMDo2xSDM/tQ/wQwv2NgWds+uYU9pISJ
        t/wi+Itqpiy9cQ==
X-ME-Sender: <xms:llhaYTrydIE23SZOsnnQfyy3EZLP22x3YXPucLQBLF-rjIeyNiHF0Q>
    <xme:llhaYdpa2RGwRiO_XTkkcaG3_6AM97r5owa64FK9ar2NV7mHoJQAMpZM9Ldf7Bq8i
    OsZwIGHQYckF5-aVA>
X-ME-Received: <xmr:llhaYQPjg6WpWWaVZx9y6gUAaEUTvIXWg2u4KbQG0mA_UDmKZscK5KX49i15lInwDP-77O0QUoAZfi69pon4FnfhtB1XbYEP5Gydwhs-Wd2cQzENab42xq_97YEM0DfVDk2xZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:llhaYW7GwxwsuaP4Y8j9GTCVRZrgZrGhVoK8I8GVI3n_TxfPghYJxQ>
    <xmx:llhaYS4VTrFs33sl3ZKAQYGjUTFUYKyA8VnTvQl6tOd2VOSqoPvNLg>
    <xmx:llhaYej0lJBOdfj6PMckjpOoUoD5wJrkZdnHaZniYEpwCCVXFVZ7eA>
    <xmx:llhaYVKuit_BK3fvDEmr_6rsquNu53eZcPNUoX4utwWcliTDMo12UL5cuTo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:49 -0400 (EDT)
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
Subject: [PATCH v2 4/6] ARM: dts: sunxi: h3/h5: Update MBUS node
Date:   Sun,  3 Oct 2021 20:27:37 -0500
Message-Id: <20211004012739.39053-5-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211004012739.39053-1-samuel@sholland.org>
References: <20211004012739.39053-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to support memory dynamic frequency scaling (MDFS), the MBUS
binding now requires enumerating more resources. Provide them in the
device tree.

Since the H3 and H5 have different clock divider limits, they need
separate compatibles.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi              |  4 ++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 11 ++++++++---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |  4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4e89701df91f..43acb98cf390 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -282,6 +282,10 @@ &display_clocks {
 	compatible = "allwinner,sun8i-h3-de2-clk";
 };
 
+&mbus {
+	compatible = "allwinner,sun8i-h3-mbus";
+};
+
 &mmc0 {
 	compatible = "allwinner,sun7i-a20-mmc";
 	clocks = <&ccu CLK_BUS_MMC0>,
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c7428df9469e..3a683e190dab 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -568,9 +568,14 @@ external_mdio: mdio@2 {
 		};
 
 		mbus: dram-controller@1c62000 {
-			compatible = "allwinner,sun8i-h3-mbus";
-			reg = <0x01c62000 0x1000>;
-			clocks = <&ccu CLK_MBUS>;
+			/* compatible is in per SoC .dtsi file */
+			reg = <0x01c62000 0x1000>,
+			      <0x01c63000 0x1000>;
+			reg-names = "mbus", "dram";
+			clocks = <&ccu CLK_MBUS>,
+				 <&ccu CLK_DRAM>,
+				 <&ccu CLK_BUS_DRAM>;
+			clock-names = "mbus", "dram", "bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			dma-ranges = <0x00000000 0x40000000 0xc0000000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 578a63dedf46..35d5d238e313 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -233,6 +233,10 @@ &display_clocks {
 	compatible = "allwinner,sun50i-h5-de2-clk";
 };
 
+&mbus {
+	compatible = "allwinner,sun50i-h5-mbus";
+};
+
 &mmc0 {
 	compatible = "allwinner,sun50i-h5-mmc",
 		     "allwinner,sun50i-a64-mmc";
-- 
2.32.0

