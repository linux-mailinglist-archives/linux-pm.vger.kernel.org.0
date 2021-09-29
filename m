Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EB41BE6E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbhI2Eoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:54 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39817 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244133AbhI2Eoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E694E580B80;
        Wed, 29 Sep 2021 00:43:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 Sep 2021 00:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=efuiFrtjndofu
        Egsj8FZPu6HgWCshxeWqk8FHljRCbQ=; b=k39JyxxxhODLljXlvg2D/LDnVzdR0
        wkhJMffEy3bjSTFSdl1HCUfvxCZbTc1PKGwiOvpf68hsos4GZStM0u6t0C67oJ1N
        5hMQy3/tAFzenf64n5mgNX5xj5Azi40ZBnAaAfHq7jtD85uqFFhJjpyCrtSiVQPO
        QXo2d1VnK2DEYkrM9RkPj7PVIgnzegNxJD7Xy0MI9oJCtHDijILmZzLjuAB1R+Ul
        HfdLSSwXWSutK6yTSYJiPrg5jmMIQ4U5E+mUU42ibEWOry31tB2/hO+OynyrT9Ki
        uIv6vMNjE/5W6AQlNFP5T1oiU2Buej/j1VeKSmAZW47sLLqfjJi/HApaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=efuiFrtjndofuEgsj8FZPu6HgWCshxeWqk8FHljRCbQ=; b=ZOPui9Bw
        09y6zBXbyqII/MGnVmgn5Tqg9TfpV+z1kKfrij8MvJc+PnbkKj8M6vqP+zErPBvt
        /8+PdGvoWxE+VbGT5Daa9gLAc6BjWTBeMPVZt71AGQ6g42S931U4I4I9HVDLoyvx
        XpkDP8M2lxaBojgu0t801bMnbSK8i3yX18NxB8yLhE+M69hMkLINiIFt/qE6XfJC
        JQYDMFx94EpDh0Z2LYUDnRW1EbP7R215JQVUBlpn0QI+g+j/bxzaoeBCSUAgg1ym
        ARJH+PixpaB1oSBHSfTmHSUQYL9jRTp1q4chtKpx4JyQ6gaPgb9qyWRi/+0mQbBQ
        GejR2JM6A22qlQ==
X-ME-Sender: <xms:1u5TYZDhZUpIShzd8WtUZwS0obs7nyktoC_keS2X3W4_kEQGPYv6IA>
    <xme:1u5TYXiGvk5vovD0pArrtwsUGDbklv5fbxpuB1X7nV3dQrxwYBm70nruYkISxnGOy
    JIHh1M9JFA6SDXOFw>
X-ME-Received: <xmr:1u5TYUlp77E5kAzzZJtL8_BHlWBHSPKYWdVxaPOm1yIOcZ4lC-MnhMvI8tjik8t7_NVonU1w3eY9KDY2n441ckKgzhkHQpwKG_p330qDrjlIAicKf7N1oX-NCanpeKlZQRApxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1u5TYTzWtn1o2jkqdluH9qWlgUD5kv754eBSc5DgpjPLsdV4TV2u7Q>
    <xmx:1u5TYeTj5o4J2XjtXeDhrZmRWyM5FamCxjJ3kA2OkLwU1LQK6S35HQ>
    <xmx:1u5TYWZ8JJi2QFK6zeJT-8hQsDxj7Q6MAPo11Y0xe25pVkcKvxGwdQ>
    <xmx:1u5TYYA0KZB6ZyGuWp1Ao7HZ_iCf5X89KO74a5m862HbfcF6pyW6yw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:43:02 -0400 (EDT)
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
Subject: [PATCH 09/10] arm64: dts: allwinner: a64: Update MBUS node
Date:   Tue, 28 Sep 2021 23:42:53 -0500
Message-Id: <20210929044254.38301-10-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6ddb717f2f98..609a59c6c778 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1129,8 +1129,14 @@ pwm: pwm@1c21400 {
 
 		mbus: dram-controller@1c62000 {
 			compatible = "allwinner,sun50i-a64-mbus";
-			reg = <0x01c62000 0x1000>;
-			clocks = <&ccu 112>;
+			reg = <0x01c62000 0x1000>,
+			      <0x01c63000 0x1000>;
+			reg-names = "mbus", "dram";
+			clocks = <&ccu CLK_MBUS>,
+				 <&ccu CLK_DRAM>,
+				 <&ccu CLK_BUS_DRAM>;
+			clock-names = "mbus", "dram", "bus";
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			dma-ranges = <0x00000000 0x40000000 0xc0000000>;
-- 
2.31.1

