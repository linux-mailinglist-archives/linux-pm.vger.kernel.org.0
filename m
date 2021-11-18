Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E914455349
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhKRDVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:21:45 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49687 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239873AbhKRDVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 675515808A2;
        Wed, 17 Nov 2021 22:18:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 Nov 2021 22:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=YohY0ULq+cZY3
        n/h85Xt4ofAPSEuFUmFJOTXV6vVrMs=; b=UI4ZUzSuVecytvBeueEaydHEVUwmT
        L5LqaSVwMJB52jS2cPzUlxkEYw4RvMvM1j8w1ONDnDLySN3JqN5ZzQfUXCVlyuWb
        +7TB2c+zfcKHaw+knxam+rTgq8haZnIDXHmYEEtpmDBtWQFRHF8k0DibJqrhp4r8
        yjBjdy2XwoDPYtrYPJRVDn3bhTjA6/Kg4EFWefCwrmQeR3The8vXI1LoooXjsC2J
        7VcnBZwYLKBXG3UapqUNRExPPEK5WsgTRZxQSHN8Je08NVSuipPXi6CDLIXQ6Qzh
        yDZO0/Cc3Rc3COUdEYkJXaVHvh0LKNOHF5XoxPnMasVlXVi+8GRZg7ZLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=YohY0ULq+cZY3n/h85Xt4ofAPSEuFUmFJOTXV6vVrMs=; b=Lm9cPGMY
        mOcbbCZkIdIB/RjUF5YI9tG9moEhDDoxxMfbh3OAYWFWl2/x+swBdt0zFHWIXPRO
        s6wBbTSJutC/LKORZi5yTCyYd4JHKctlTtY13X2JX1mOuyZy5GTQ/2wnDdV12ke7
        7m+t0iHqcYyiLRVWNtlvsTw20r5Fvb/6f43oOCtrk6aH9aSwTfFMAHeCt5M9HFq1
        fQB+clRtE+hlYF8PkVycK934gL9//LDsoLooWGKxGuX5LuW5WppbtYGm4qaxFdjy
        28I5EgF1GSwsVueBIzG8Uzc/t4QKe+SP/zRJPz/FcTOktcla4B3JYC+cGINhHKoH
        2oUM6UH9dBjXbQ==
X-ME-Sender: <xms:FMaVYTORSlczjQ_NqIO6VQDWISTo6EgxUv-DTEsh4f3-SkUwKdirfQ>
    <xme:FMaVYd_ALYYP68nduvz7GrGi60JBQ-fxr1Isbn0J2RV-4YhgpMUJBQjrVuafmly8d
    aqUitGTSUO-OSWBXQ>
X-ME-Received: <xmr:FMaVYSTRt2MtWq24ZHLakd98ANxRg9qLRdlE9pqPOzN7isz1Mhu92okDfo5ioNVP_8IDTxCNx8mxAehAxNaju7ojdfIADgfil3XwrzJYPUJW944Yh3_YoK1rt3PuZyzMSFquWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FMaVYXvQPeWMv42JWhGzfFwCuDL7BEGLVrGFGH14D5svyT5o96RByA>
    <xmx:FMaVYbcKSDyLS3ojrBzblef-x2G4f6jOzRdSyKkXWCV8VR__zMcF_Q>
    <xmx:FMaVYT2W53dl_tzqV-M38DenEBuh5o6bSjWazfvPi9MlGWPSnKm4RA>
    <xmx:FMaVYZ01LJ5hnlrz099vEV3ex27Hcw2qCvPJDesAmNFQRuU1H1Nmew>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:43 -0500 (EST)
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: clock: sunxi: Export CLK_DRAM for devfreq
Date:   Wed, 17 Nov 2021 21:18:36 -0600
Message-Id: <20211118031841.42315-2-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118031841.42315-1-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MBUS node needs to reference the CLK_DRAM clock, as the MBUS
hardware implements memory dynamic frequency scaling using this clock.

Export this clock for SoCs which will be getting a devfreq driver.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes from v2:
 - Remove unnecessary quotes from binding
 - Fix issues with overall minItems/maxItems limits

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
2.32.0

