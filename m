Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A865252048
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHYTgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 15:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgHYTgn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:36:43 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062442075E;
        Tue, 25 Aug 2020 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384203;
        bh=6pQee/lEOtd6XVjbMxZhh087Cotb2fe4tMAUouVEZXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuZ8wpSH8ZxNJeaDZ9YPkq4WRh/FgzFB65KrG/V8H46eZwNAD9VCLEf8BZAXqx1WM
         GMvU1WaU3R1fVUrNgygVIt4aLnCHFV9xiLRz7ZqBu9UwTdmD+/vDc7++Hb3yLlCYO3
         Sm8Hk6bMrhY6+Nzl3cn9vZ5raF4BAJTozB2hAWP0=
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
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 05/19] dt-bindings: perf: fsl-imx-ddr: Add i.MX 8M compatibles
Date:   Tue, 25 Aug 2020 21:35:22 +0200
Message-Id: <20200825193536.7332-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
References: <20200825193536.7332-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: ddr-pmu@3d800000:
    compatible:0: 'fsl,imx8mm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
    From schema: Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: ddr-pmu@3d800000:
    compatible: ['fsl,imx8mm-ddr-pmu', 'fsl,imx8m-ddr-pmu'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: ddr-pmu@3d800000:
    compatible: Additional items are not allowed ('fsl,imx8m-ddr-pmu' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Handle also fsl,imx8mp-ddr-pmu
---
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 9ed8f44adabe..5aad9f4e0b2a 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -11,10 +11,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8-ddr-pmu
-      - fsl,imx8m-ddr-pmu
-      - fsl,imx8mp-ddr-pmu
+    oneOf:
+      - enum:
+          - fsl,imx8-ddr-pmu
+          - fsl,imx8m-ddr-pmu
+          - fsl,imx8mp-ddr-pmu
+      - items:
+          - enum:
+              - fsl,imx8mm-ddr-pmu
+              - fsl,imx8mn-ddr-pmu
+              - fsl,imx8mq-ddr-pmu
+              - fsl,imx8mp-ddr-pmu
+          - const: fsl,imx8m-ddr-pmu
 
   reg:
     maxItems: 1
-- 
2.17.1

