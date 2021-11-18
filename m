Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA8455352
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbhKRDVv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:21:51 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42353 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242525AbhKRDVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 431BB5808B9;
        Wed, 17 Nov 2021 22:18:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 17 Nov 2021 22:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=lMPW863LiW5Hj
        W9Ga4lZD9dQLpyhJ/ywHpfyXbiqKGQ=; b=oAH8XyqkU88RtKjGTw1b3hml3zcCU
        f236xiEdXJxDxe3Pw1zwLzcCfCpovrro08paQe/JWK33HiyqT9WFGWf78qDk85xN
        tyLtCqcPMbQey2P7Y5tAJ3M77L8HjNtS/ucyzr7rYiGNlMgowgJSvOcGna6sd6y7
        ALLEShlvFRR9e9YM7kRd9aQXKTZWkGzS13jxDBr4FAjJb5pl0OVird+jpwRKzruG
        ZuqyILoC3JE76IcD9QCNVH/35x64tywEEWrzhxgLXYUIRDDWFs2AH9YypW9dPklg
        MiSpuuumCtrUTtMz8btvtXp9R5mEbMAOhw4Ca7Hy9aTzcL4/AvbbW0IZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=lMPW863LiW5HjW9Ga4lZD9dQLpyhJ/ywHpfyXbiqKGQ=; b=U4bqhvqI
        BqbzJfSvnfMoHHm79IYMAaYIuoU2qtV54mCCmueISQc5oBqD3FZxiQff9tSbJ7Wj
        uVtfxRf+LPxEiCnrckNj9q9/GS7l2aOn4Awfd6dyiu35Lq9UV4WBW3xcNF9lZZIH
        gtcXctnac8ZDsO24mxLbmPNUEKpZ02N8HwrtckkrRpFSoz3GKcJoUUeaNmc2QUGi
        cGB5+FW6i6acf618YoVlJ/qbdy2RYWmpu2P82Z9/qwDEe5Mq5KcS4VzszqvPjXW0
        We//rt5CxJmJl7BmigY1JtTCq8CTBw+E1/sMGZvKnVr3fSBiqHn+BkiflW41ciW1
        oH31CcEwF+oFxg==
X-ME-Sender: <xms:F8aVYZJvQuy1E7sl50Y1XQ43ojwfLMryV5ltqxKcz8k9jCL-QlWoUw>
    <xme:F8aVYVLJFAc3mpQeQ-phLVJBAfCJCSusiq1bCHbdu0CVB1cvSte6qRNzQ1TSbzYzG
    aOp6f3-W6yu0RDcnQ>
X-ME-Received: <xmr:F8aVYRu8sVtPfdCJPjlEwG0plSfdMApRqT-TWRd5YcMZjI8AspS8CzYWKDkzGwgVC32HIdKklFyHsNUo2Ut7xNDDIwlV5i43pCcYIN1Q23w9nZoWuY_c8lCWiIex3jIkdLiY0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:F8aVYabFdNF-bPN5YYLsxFOADS0d9SvEBUIJqv47VtBbF3LUW9gruw>
    <xmx:F8aVYQYQl33PhdxU73gDrZuEu_KfINrchtllwCOJdnEyqEWs3qL-CQ>
    <xmx:F8aVYeDSJax317-JczCrxtyt9-o9a-7dEcn8pCRT-uDMKat-_H3uHA>
    <xmx:GMaVYaBdVs0dpC9lPR1ZG965NfWckRimnAWXuRFnRuhiExEPm5qHgA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:47 -0500 (EST)
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
Subject: [PATCH v3 5/6] arm64: dts: allwinner: a64: Update MBUS node
Date:   Wed, 17 Nov 2021 21:18:40 -0600
Message-Id: <20211118031841.42315-6-samuel@sholland.org>
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 5ba379078500..2d33e71e3740 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1146,8 +1146,14 @@ pwm: pwm@1c21400 {
 
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

