Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9557C38E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiGUEhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGUEhF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 00:37:05 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06FD7756C;
        Wed, 20 Jul 2022 21:36:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7FD6CDFFB9;
        Wed, 20 Jul 2022 21:36:58 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Mz-hSBnJr9K; Wed, 20 Jul 2022 21:36:57 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658378217; bh=6y3+NTu0dXrI4QCo6VqX1YmHK03E+ttdfPlbAoyczPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ze+47WMhj54H9O+GFby1oD4C2hEC9e2Syv5AhaN+ux4EVcrF3dDMUflB1X48O3z38
         ficqBE5VNRDv6GF6F+9EOeN+9NRB3MuvDfP8efYZIvYvb5JWx66ki8di5kEa8fMcR+
         vn1Cm0KVnWjPF7u990hc0iPT1/Jkmna/OcyAi/UNIPhs78DMqRKcZbnKujwU8koK1b
         6hWaW/zDMqipysUk/QmzfO7SBI31HRL9aTwr2tXcpq4ADeYfx6nhGyUnulRcSvxIML
         dE6iZedFPSs9V0SiQnJ/klUWgZh2lIOeECBTp9nnmDNM8UOLyKIx4oZLUUakkrg5QC
         RkxHpBulDjTTA==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v5 3/3] soc: imx: gpcv2: fix suspend/resume by setting GENPD_FLAG_IRQ_ON
Date:   Thu, 21 Jul 2022 06:36:08 +0200
Message-Id: <20220721043608.1527686-4-martin.kepplinger@puri.sm>
In-Reply-To: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
References: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For boards that use power-domains' power-supplies that need interrupts
to work (like regulator over i2c), set GENPD_FLAG_IRQ_ON.
This will tell genpd to adjust accordingly. Currently it "only" sets the
correct suspend/resume callbacks.

This fixes suspend/resume on imx8mq-librem5 boards (tested) and
imx8mq-evk (by looking at dts) and possibly more.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/soc/imx/gpcv2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6383a4edc360..e058aed76602 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1337,6 +1337,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
+	if (of_parse_phandle(domain->dev->of_node, "power-supply", 0))
+		domain->genpd.flags |= GENPD_FLAG_IRQ_ON;
+
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
-- 
2.30.2

