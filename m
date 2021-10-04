Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162D4204B4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJDB3s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:48 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:35719 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232228AbhJDB3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:42 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id A20DF2B0131B;
        Sun,  3 Oct 2021 21:27:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Oct 2021 21:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VcVlHIpR02Sda
        Pzq24T8/onu1V2deGVBvxBFpQB0Hqc=; b=UkhAPctwnEQ9qGz0pjncxFTt+X/3l
        6T0EG3MtYSSvA5oZz5TGjXhj7pKVXw4e4j01yf0Ee8csSBA+9fevE4d+C8/Fw/FJ
        mhj/LJa/uj5dfbKdVbLOZqYwjNTIMqhRZgQdkZXgChSlFeLyQ31eydiZSmI9i5x1
        BDchgf+VGat6U71KzV5yiaudd6YvMBlBETprabWHknmfFyyF/q70OT49CVjyiK6N
        BI0pH4EZm4jf5lHWwqixCzWP1nKGeQtRy0WQTRjGF1aGoDGsXJ9JeZNZJvWrFCp7
        iuNhfA00/4Cumtv9XBUDle6kJmseqNmmn0XNArB3QAGq7pWxMRcYxYZpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VcVlHIpR02SdaPzq24T8/onu1V2deGVBvxBFpQB0Hqc=; b=ioRicfyl
        a3i5JH9X2JMYWoqS9FC0FMrw/gD1M6/b5nx8xWa4bgOwmBLAAwKqcYkbQDGs4vJj
        JbTP0htKAPB83GFyyliF0G4P2nLN/zz4VpfD9K3yIuch8RU8J40qhcE2IoLVv+Aq
        Oh4VRlbBky0fvU6FqihOVqqyRYWMhZh4Xi/hKGFkZRWbGCLl4QURusBbVyz4MynZ
        9W7KhdQY7xmo8pQSrE2l+faCLZcGoXYx5ltOKJ4oKs2uJtwL8XN2i59YPmRL0TMW
        DJJINftegMOTYkaiHOhMBnPY55ucq8X0qhCMvJCyG+cODTVSklvxz2BkW10ZeBuU
        Mxb9cTOQ6hPVkA==
X-ME-Sender: <xms:mVhaYfIMBHjuYnuQFZi0JOYGqeJg0Pj7EWdD9TbeMNgE4YSdGYG3RA>
    <xme:mVhaYTILadAC7u5Iuq6pKJe5V3BgSkHGRKd_K5CgDFLIIF8dOMgqU7DPX1dxq_K09
    oIw6WNOoyyCinBiNQ>
X-ME-Received: <xmr:mVhaYXsIQcKimUTWLS7Fcb7M0UTyMGp6I55eTr8TO2i1iXIAVwEbA-UQlgcQyVvY5Q-hTmZl3hjGrNJErMSg7GC0sKqGwd6jCauK0a87U5USCn2PvIW-OAGKcHn5efuCRF0kXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mVhaYYaKluP2VnnfQaX7s8PHqhhWIM-t_O2qqF4j3_1H0I9A_muXPA>
    <xmx:mVhaYWYjWUsvn-M5frGW2aU3doctsiqKL425VTQ5RLX84VRpfalUlA>
    <xmx:mVhaYcBSsMHGC1xhGd81tTxehoN3J0VRriSpbDU2bpekr1kHht4adg>
    <xmx:mVhaYeoxJVAS2LvJPaszniOlJp_Jr5Ti8i1fZvm7sLGIjLZ7V1b-XGj9cdE>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:52 -0400 (EDT)
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
Subject: [PATCH v2 5/6] arm64: dts: allwinner: a64: Update MBUS node
Date:   Sun,  3 Oct 2021 20:27:38 -0500
Message-Id: <20211004012739.39053-6-samuel@sholland.org>
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
2.32.0

