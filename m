Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4324204A9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhJDB3d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:33 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37615 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhJDB3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 93F452B0131A;
        Sun,  3 Oct 2021 21:27:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Oct 2021 21:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=K3ztzcGIJRQA2
        i14m+NN5p4mb3bayApw/5zcCVEE87c=; b=E2icTyS3WcsTltpWkzopB35ArJL7h
        3sqrYi0/6CYeyIayp35p4jnrfyuXO798gPLP8bR5jvEihwPj8CoIS0Ar79yWv8c7
        ynoa+4SXtdC2kwftH7n/FEDeea4PIuYInKWn4GjKxlk0wyF6BZ+IulDz49l9KX7m
        EvlUfBX5EV5BLlesvlLDwo/ja80dm1L1rpY1z2zYFBRTTOiCfKGHIdNH2Uoej8lN
        GaCxCuDD06OpBnoYDoFBNvARHvMtf2c2uNhZ9mPi96x42Wzk9KEWUyhX6mjdSOD3
        FtHKZ4p1MsQykeNl6nQS+CJ9/D3l9+1O8TLczdGY86M7+dYy/hHhzguxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=K3ztzcGIJRQA2i14m+NN5p4mb3bayApw/5zcCVEE87c=; b=Xxbh9ZUT
        u76ocYZZ8vRKR/oNxSV8v6gB96eld1/qE+N0A8s9Gu59mb2Dr4EzRNvqNxgmD7t+
        YX0ZI847eeUgy6aq37wGTff8o3ssF3woFu/I6zUS5BjhJnVvNrOlokt8IQnhPl7p
        TXu5QtOJxoXMO6uxLrV99CS/VVDZgZyjK8q9al72zbfBH/wA4IteNYjsawn7LjOB
        SFlhvchFa+DUkrCuH3ReUTRhndQ1W2BzJVp0I6mrONW5saNvyx5nJYeFBpsQAtlv
        nimay0TtQB4ZEb/6q0j9tGMO4/gpDjrinUXqjLnI5Q8Cl28x05ejtewNlMWnVvz7
        56MHQtbWTdLOBQ==
X-ME-Sender: <xms:j1haYbKa1qKoDVxQj_QZIRHQP4yiknD4V4hMYS2nnxrkXn_z7GT9Hw>
    <xme:j1haYfLlaWROBoIH3LcCk4zQVKkK4d9H7x7NciUacYRWwMwpeEOOnZw1K3x7lmpLh
    llT82wOeJLJQS_agg>
X-ME-Received: <xmr:j1haYTusJrQS0RAm3nsm4FA87pOdvIqR4Rd72MpcKB_v28mj_nY1ZJV0AK0nJloNY3SfwLmegnddheUgqzOp-pM4Qz4fVkTKyyCR8ziG3BxqcOdOylRHCYllrr3YzLhut1IjHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:j1haYUbDe6jakbJKCtr1-_SuCZ2FecDtz9PRQ20n5V0nBQhJ8G9AJA>
    <xmx:j1haYSbN7uKrd5aal3X01PLXh8ANMok2KSpH86L7-Tm2Bph1xUPVgw>
    <xmx:j1haYYAZ7L88v33fiY-hj5jlq517zQTxt2bXtc0gUMJrKAdb098MCg>
    <xmx:j1haYarmdz2NTmVBRqmuoxACEcRhXn5oF4wEx8MQzeabyOQ4ZOfo-hOZA54>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:42 -0400 (EDT)
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
Subject: [PATCH v2 1/6] dt-bindings: clock: sunxi: Export CLK_DRAM for devfreq
Date:   Sun,  3 Oct 2021 20:27:34 -0500
Message-Id: <20211004012739.39053-2-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211004012739.39053-1-samuel@sholland.org>
References: <20211004012739.39053-1-samuel@sholland.org>
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
2.32.0

