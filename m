Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78F41BE63
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhI2Eop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:45 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46255 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244065AbhI2Eom (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8B571580DBB;
        Wed, 29 Sep 2021 00:43:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Sep 2021 00:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=6pGw74HM3oNay
        KhQckYKrpHTiDlID+ZtuVM5siRc4Zg=; b=WBKw3hXnT39sVvG0+q2EcHHe8xwIc
        pCTRztAaT3Gnq30FVZM1HPzliVrJnVjTw9i6MudCCTQgqncyZRBy+nkoCnMY1LVo
        5xBiPNdXd9WwAsaeEKwJJywvRlLb59dIO0ck9rsfmf6X0rdyscmjautJbaUTGGcn
        xIdFGT8LcGIxeD+EYEcgH78NztrXnwLI9V4pOPGruGHjIu0IlzweUpUHiQsrPam1
        9uSc8cNQnKbGCEA6lxq73K/sH1PCD2Wec0vTOV7pTmLo646tH3RrfDfMV+jbORlo
        /bkwXenbO0KmDvtSqwGKyxFc8ujwhKA+q6W2B0XogIou13l54jnIE1IGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6pGw74HM3oNayKhQckYKrpHTiDlID+ZtuVM5siRc4Zg=; b=X/O5+nUS
        V7ZoQN4qAX1jDw4QGAi4Cwj6Ok9TFZXe9gLr4RnRRacud8gFCQh8xywzwAfctdyN
        4LxOpKJ+mHia4v9bYRewkIJVpirg9rvLyLfXKEfct4bqtIAYQf2EJpaiLDwDxi8w
        7mKsptqY2+8sgf0yk6pgqG2+Bdkzs70IO9zwFUoqfhQ7zKKGM3R+7Xb+gkUzTCse
        knayXZYJFau80RqwiumGK3aRKxbH2JwQECrom48EzKmh0Wgus62BjzLA7PrZvOpW
        Su4DNH22jLqt3BE2zcHl7riOMI/o37JVPS48gzvhc5Eduu7z+s/O+cKd7imBfdLS
        W6oJIHeVOsOfSw==
X-ME-Sender: <xms:1e5TYferUCfySI9EtvBBSq7HNG_o0RJB8-aOyKdW6XkQUO9v36xSFw>
    <xme:1e5TYVM-gzmPLXh_TSd563J4S-K-79E76tDox2SBXd8GSYT5D80E-YEEij6yq5VUN
    ewin6hTtPq4xhU6wg>
X-ME-Received: <xmr:1e5TYYhzxMwBO5zFg9o8lEYm-N1DUbM_EXxaVwoJLLBSoWD_4am4R6OAaaKwFhpqCOUl_Ssv7cBBLk0c_HIAtEHx48QZc76gAG6ESN5baLAJe-6l7BMJdWkzFmLVlGzRWmZcDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:1e5TYQ_NtGVQRWbNY6uozB300AnJ6vDRZLNioRmSc-jMX9VTpk4pUw>
    <xmx:1e5TYbuNTgZ2EHz6cVu-Hb-ndNjBPqoXQXJyVMoT80AAB7J-k9Kjlw>
    <xmx:1e5TYfH2EpZFvCZ3ElY51B2jum5mE8zSskV3elttEThQFa3UAdQZag>
    <xmx:1e5TYUMsDW-wkeyFG0qH0mwRyrBIH4aUz3ql31iLuetcYqTtHZ4v9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:43:00 -0400 (EDT)
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
Subject: [PATCH 07/10] dt-bindings: arm: sunxi: Add H5 MBUS compatible
Date:   Tue, 28 Sep 2021 23:42:51 -0500
Message-Id: <20210929044254.38301-8-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The H5 SoC has a MBUS very similar to the H3 SoC, but it has a smaller
MDFS divider range (1-4 instead of 1-16). Add a separate compatible for
this variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
index c1fb404d2fb3..c070f99e0bb7 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
@@ -31,6 +31,7 @@ properties:
       - allwinner,sun5i-a13-mbus
       - allwinner,sun8i-h3-mbus
       - allwinner,sun50i-a64-mbus
+      - allwinner,sun50i-h5-mbus
 
   reg:
     minItems: 1
@@ -83,6 +84,7 @@ if:
         enum:
           - allwinner,sun8i-h3-mbus
           - allwinner,sun50i-a64-mbus
+          - allwinner,sun50i-h5-mbus
 
 then:
   properties:
-- 
2.31.1

