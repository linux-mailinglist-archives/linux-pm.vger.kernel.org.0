Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2D4204AE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhJDB3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:42 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:59493 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232181AbhJDB3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 74D8F2B0131A;
        Sun,  3 Oct 2021 21:27:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Oct 2021 21:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=OSyUKqUS0Bf/W
        N+jBk7XnzZgBpUsMJ5MFDdoJJnN3Gk=; b=HTf95sgGkUAMGmsoOM6ciHbmn9D8U
        mkpBo4wMtIJOjqB4zmorpQcRfknjlOIPNw+zUAIMVja1fwaZQ/BdygDxl38nFY57
        DVIFO7rdJKTZ68kmuLy6A7FN8+pNSh3EDZjKgNXycPXzT1A65AWGL4VfzUm0bpJD
        FZ4hhbaPC9sj2b+IQ2ANEisQPKKg7HEXFFSu91teQXgIPCBXlbpalIHuhh5pqO0I
        OCcvqumnH+GQyL0bUfLhixviQ8YTiZ3rCDycaS3N+OtYmLVIZIPHXbwyoih/tgXQ
        92bqrcXPTzyc9oPrvdNdKxMtWCFTYLBUspNt7kCW+ht64mb70cNQ7Rd6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=OSyUKqUS0Bf/WN+jBk7XnzZgBpUsMJ5MFDdoJJnN3Gk=; b=AheGZcDf
        sxZtrC3aLh8wqNVpM374jWnlaM0Q4WqOX5uPYP1bcfkr62+o3rcDyNo4I39lxT/e
        7Geh5UvAvSWYbyZKQNorvfO1v5On2Kib0bKr1MStZdQDRDY9L+fEmjamg1PRGE+Q
        yh70PXrrihNkARGNMl5CnwrQ/qHL52k9mkzcQulpDL3SCQFTvZptloGsyhApfK5Y
        xbqOLdiMQ2z7OGnUD53WGfgd5fGQpI/y9vga0KRCgAHkBR7B0JTboJuTyf8nL3DA
        Pi4DzMowQALmGJPrljXN2FHPWbGRnjq/+yBZFwQU9zR0b0PVLo6lZxln6FK/NQoE
        G9ufoCqHbhAY6Q==
X-ME-Sender: <xms:lFhaYYr-hppEVBJ7189nX-0if0nfUNXx3jBmSHWNT92bkMav4ikPLA>
    <xme:lFhaYep4WK8dHh_9e2MY6pwvR-trkKtpQnNI7wYERgITQNSUuS422zIHlDrWL9wE6
    BSQzfYAYkTwDkcklw>
X-ME-Received: <xmr:lFhaYdMPZoCrqQhXhullrIpWQq3LHyhu3uBymvtnWUxRIiqOq3Jw9Vkuh7mU3LTGlhb6RUzruMcbf7XlS4-nxm_cmytp1f4TjViqJV-IbvKiO82pVgMumrS3DStmBSFDIL2r1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lFhaYf66EzMhGiuYlqK-GFHjtza3JIDFRIR7oENHot-FdqeY2avepw>
    <xmx:lFhaYX6W0ltOrlSlS0sxZNtgVZewSwwQ_9qySAzpfHT3jUJRjVXKfQ>
    <xmx:lFhaYfjj7cxvv7BdfT6H-nEgHcONXMEUx0LthlDgjUwfC7eO165cUA>
    <xmx:lFhaYeLfITqSw5RRQza_sJhhOnRFGL-9-8k9ZqCDYh6laT8bFT0kP_VyuE4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:47 -0400 (EDT)
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
Subject: [PATCH v2 3/6] dt-bindings: arm: sunxi: Add H5 MBUS compatible
Date:   Sun,  3 Oct 2021 20:27:36 -0500
Message-Id: <20211004012739.39053-4-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211004012739.39053-1-samuel@sholland.org>
References: <20211004012739.39053-1-samuel@sholland.org>
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
2.32.0

