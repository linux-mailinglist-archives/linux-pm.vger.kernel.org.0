Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAD41BE65
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbhI2Eop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:45 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39379 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244078AbhI2Eom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3EBBE580DCA;
        Wed, 29 Sep 2021 00:43:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Sep 2021 00:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=3Zs184ZsknHqO
        8NkjYGi5WOdkUVOwLKPy6eQF8nQjMk=; b=MkNJODeW4ishGnCbz42pC9CwuVElA
        QoZH3Wzt4yDVnjD0uBGQCv5Es2PZ/QgPZ8q3DgUNSmZkMYWznpomRNPyvOfHOsbf
        GZKPzCq3VP7HgwLVlIdyGHwEazR6Z2C1wSTFcNFvjJuCY4uPI0agAXBnm8ywIuxq
        STOBxtjaqYnVh3WeOilA2hMZbYNkAfD8PFIqqDDITrLTrXvou19TpzMrvUL/Ykh9
        9EfvH95ZDzFHdAZ6KwzyanefsQbAHhMdYbcEKlq8AU8QfBF1AIULEcuDqqmaKCzE
        NsoymqE+Ap3BO2/4BBty7e6PGA56MAjH7YObeRvtuMbA4AVNaBBO0bcNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3Zs184ZsknHqO8NkjYGi5WOdkUVOwLKPy6eQF8nQjMk=; b=Tmra8HrT
        qaxdhiLrjJhpId1x+Xn7TttUFhMzazfCuGDIeAsFT/Nvj+ee34tssVSYgDYHFRMU
        29/PeYKJ4nD4adAj7G2y1yHH4hFUGzcOU+s86ykgFzObjLn/Yf7VmXvDaRgkceKK
        pZ3V2p5gv5oVz93EuM68h0xVOEY4cCunbrmAcfx+qF9E1npQJe7TjSDbb+g7vw6J
        EX27f5N3fVuhwcplmJnOI/rM3eYvn9BpFNOKxGDxuFp+3kX0pQO6KB1qL8PY3qKC
        bhPxEJiMySPsBCPqDenCitdNBW1Tfs/71EzXUsjespws2jWrH8kkYgfFuNKml43j
        QSachcZedZybjA==
X-ME-Sender: <xms:1u5TYQ6moTfcS39HTGpVMwgEJ5t4TSkYSeQ4ZX3jKT5rinJNACo0AQ>
    <xme:1u5TYR5k4msbLl6MMtIEpKGaDIa8OSYV6Fzm10vtfHdb9lHW9rOQ07o0NiA-BGcHU
    A-NT-dji5YEUBWgwQ>
X-ME-Received: <xmr:1u5TYffsX5ywbYMzwysLwrxBp6fe6tuY4n6jhB8uU8zP2M7hMG_qNyN8stjTWtmtnXcZ_umcu6jpy1OgmUX6r1uxZsvK0KKGor8O1EfvF1v5wCMqbiXeXuj4NAqagi-vWf_w_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1u5TYVI7Va4_VDSeu_UxtDGiHBYv1RDLw7MUGOMNGic6ms1uNGtN1A>
    <xmx:1u5TYUKycdXvM6EohauAagMvpg2uV6hpy0nyrmaeXnd0UIyAPQ5MFQ>
    <xmx:1u5TYWzOThn3UBdx20uc19sjXfGi_Ig396e2xqeidqZCKJAaI6GGew>
    <xmx:1u5TYXYeKrXy8EtBH1HfqjO4BKO4JUK03E5yNQ9_ovGHWIoO7f4IJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:43:01 -0400 (EDT)
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
Subject: [PATCH 08/10] ARM: dts: sunxi: h3/h5: Update MBUS node
Date:   Tue, 28 Sep 2021 23:42:52 -0500
Message-Id: <20210929044254.38301-9-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
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
2.31.1

