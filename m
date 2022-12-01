Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5263FA1D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Dec 2022 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiLAV5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Dec 2022 16:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiLAV5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2022 16:57:21 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB32C3FE1;
        Thu,  1 Dec 2022 13:57:18 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 18BA9852C9;
        Thu,  1 Dec 2022 22:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669931835;
        bh=M8jxou5Ih3ACa0IH738SbtcqIaUolW8P9EpwvwrdXvE=;
        h=From:To:Cc:Subject:Date:From;
        b=GYYpSQPu8sg4R03fq0KfFr2bcgMPGeoAyQ7+i+0/Ml2zffLmuGLZcqfooQnJD/8D1
         Q6597vbBtC1l145rl4foYzgPPOIkKMfNVagQs47G+4O2VkAX+e32cpAjg/08iHcfGc
         fMIbrUNPdxpwzFHraG7hSbdwLZxVbPew+nWmSg6Ep5Fv68F7ZoMqcXYiuo2fJUidoi
         kKvNr60E59sNqAmrhtWVQq8SyiWxHo7mPD8jKnCtFI53EzWwQaEUgH2k7oodBUVcN3
         jAS+iWsFHLdqvLc1EEu8/kfqDZQEWZdLEa6ZKNOKZ1dYMT/ZTT4IU//46M3CI4mSsq
         lOFZyc3hYQ6eQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: thermal: imx8mm-thermal: Document optional nvmem-cells
Date:   Thu,  1 Dec 2022 22:56:47 +0100
Message-Id: <20221201215651.152497-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
calibration values from OCOTP. Document optional phandle to OCOTP nvmem
provider.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Li Jun <jun.li@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org
To: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: Add AB from Krzysztof
---
 .../devicetree/bindings/thermal/imx8mm-thermal.yaml        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
index 89c54e08ee61b..b90726229ac9c 100644
--- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
@@ -32,6 +32,13 @@ properties:
   clocks:
     maxItems: 1
 
+  nvmem-cells:
+    maxItems: 1
+    description: Phandle to the calibration data provided by ocotp
+
+  nvmem-cell-names:
+    const: calib
+
   "#thermal-sensor-cells":
     description: |
       Number of cells required to uniquely identify the thermal
-- 
2.35.1

