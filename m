Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC6455351
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbhKRDVu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:21:50 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44269 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242485AbhKRDVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4414F5808B6;
        Wed, 17 Nov 2021 22:18:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Nov 2021 22:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Y9sSSBeFlVLX4
        JrewLnoOiGdWQCPKekjfffjVNrp3zo=; b=K30ZgmQkoups+x6B8w6h6Vzdejozo
        +AFXJhM8YbZtjIb1E7ouO2yE6mI5EKtIR5DOc2tponBPqlEVnWOWEsmWH9f+kwQV
        5TfR2SqJfjBcBWEkbsu+yVkxk96ddaAepTCT9DY52zn1039MRne3iZpIYaNTGOJM
        qoUAhyeFWQxqZm0Ohsw5Vq5sK53fTlvFA69BPXfTmVE5zyZ/GU6bNEN0gyF5kA4L
        Aqn8bDmylyyyMRFM1dfNM++FUrCWqArCaPKe1aUal+vfqy630+Vn5kDwI/FVfeKJ
        +DCh8++oCg0vq7uF3F8073gq6Qa99GRJciez9zAN0lmTFZy8eU6XLVscw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Y9sSSBeFlVLX4JrewLnoOiGdWQCPKekjfffjVNrp3zo=; b=A7kpBdna
        j+6IkfjNllU3YFu10uYA4rjfohMu5nhvJ2hWf4ZyZrKvvzSk9IB4pF+Iuw8Nyrxc
        1u6tArPSE3lHPC9CCX5s92xB/E8qvO45JQNmj8vniXHAsQJWrmy+ZElL/ITQF18o
        EPyrN37Q4qPyJg7RKASCmQzoAOzq5CfyHNKSGxiRbinvWdRZlq32JZ2xjRuurTK0
        SgtrqfhXlUsbq1VcGvPEULaYb7caS2Het/27n/KU1p0STb1OHcX77x+4jMKCp0Ch
        Dxy+1Tys2xpShaQfpfG1Matde7nKJ69P+YD9pF8fatGuZVeHsNj74AJhery7LHBn
        szBq8kYZMHsmgA==
X-ME-Sender: <xms:F8aVYWFXlNUd_iRQtS_boiJiaqJn67PLuVptzvB7EVyn-flIy0ngiQ>
    <xme:F8aVYXV2DCqWsbnQK4TbPE7602AEyTmrjsNY5NbCofPiLWhzUnQV4NpmH72QzKGEk
    AADe-_pdEpeH9TVzQ>
X-ME-Received: <xmr:F8aVYQLm97pGVSvadMzRAxHBVYSSc20J-v_vju49aNY4uyrXGk4yMrFfHkRT15TrwxLJdZBxV0X1gaE9Tp8_eUyzFgIhP4fMzvtaKDzTjEyjRRFVITjTM76qbo8LLQ2dq5Cd1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:F8aVYQEn7l6UvLus-aa1TdJCQUQAtlB8JF7DlwJXGGqm7bjs_nkP-Q>
    <xmx:F8aVYcVFoXFXnKfSXVI4is4LLkr5oJMcwJFBtxnfp2x6FK7SngDdOA>
    <xmx:F8aVYTNP3O5avfJRAPkZulbvAw-Z9YeP1bijMhL8yoI4Z5ytGrjPjg>
    <xmx:F8aVYbOUQKD9rOnzAjfxXZGXVYxB0J1JcMqoecPKBDyqmdzT3lVeUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:46 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 4/6] ARM: dts: sunxi: h3/h5: Update MBUS node
Date:   Wed, 17 Nov 2021 21:18:39 -0600
Message-Id: <20211118031841.42315-5-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118031841.42315-1-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org>
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi              |  4 ++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 11 ++++++++---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |  4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index ae4f933abb89..845f25235407 100644
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
index 9988e87ea7b3..a56fae761a1f 100644
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

