Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF9250216
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHXQ2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 12:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgHXQ23 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 12:28:29 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4CF20866;
        Mon, 24 Aug 2020 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286508;
        bh=zn6SwQvRqTQI9Av55ZFXzkgJGiEIGN9PfDf4Q2x9mwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lc5v+i6R4868rSns6Pnlf3sYqSq41pDHXT2qEDxgaiUFWD3d3G1R3SANTYpTyO7vO
         fHq1kqFHdq/oZDj2voanWVtglRZaByLbvzfMkHB+k26zkka8r+ETpFbq/4doPDP0RW
         1NbyfLC/2VAAfJwSMAYzmWSCk4XnkNAuljsWtaCM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 11/19] dt-bindings: thermal: imx8mm-thermal: Add i.MX 8M Nano compatible
Date:   Mon, 24 Aug 2020 18:26:44 +0200
Message-Id: <20200824162652.21047-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824162652.21047-1-krzk@kernel.org>
References: <20200824162652.21047-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
    compatible:0: 'fsl,imx8mn-tmu' is not one of ['fsl,imx8mm-tmu', 'fsl,imx8mp-tmu']
    From schema: Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
    compatible: ['fsl,imx8mn-tmu', 'fsl,imx8mm-tmu'] is too long

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
    compatible: Additional items are not allowed ('fsl,imx8mm-tmu' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/thermal/imx8mm-thermal.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
index 38852877b8e3..89c54e08ee61 100644
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
@@ -18,9 +18,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8mm-tmu
-      - fsl,imx8mp-tmu
+    oneOf:
+      - enum:
+          - fsl,imx8mm-tmu
+          - fsl,imx8mp-tmu
+      - items:
+          - const: fsl,imx8mn-tmu
+          - const: fsl,imx8mm-tmu
 
   reg:
     maxItems: 1
-- 
2.17.1

