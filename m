Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA16E1F3E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDNJ0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNJ0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 05:26:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769122100;
        Fri, 14 Apr 2023 02:26:11 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHndY-1pbil01MKE-00ExRq; Fri, 14 Apr 2023 11:20:12 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 4/6] dt-bindings: imxgpt: add imx6ul compatible
Date:   Fri, 14 Apr 2023 11:19:45 +0200
Message-Id: <20230414091947.7831-5-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:egH7C3VWWiwX5h70heHyF3Hbrr2woAXkBy8iCnJcYjcN37pLXtw
 8N4bFakSW1kRpwArx6vnh5b9DBGDCC/Ks36ZGsVvBe1e01TvR0EX0JbGf8QKVzPITSPX6pv
 xnLz1LzTTDWlG8jjPY8Xw6ZnlTcJvGxw4DEkJQ6hG4b9Pq5Q0fFbANatjsq2Fb7j8UMcsvw
 hVsexP3i2sFjBaVtFXibA==
UI-OutboundReport: notjunk:1;M01:P0:HkTdbiXyVe4=;tQfg1yApb1BMGE1b4c4DobBApSF
 ZSsjtTCuf602XInLNIxl7DZHJG1x2d+XrNKZmZ1w3n35NtrDO6/gdE0ydOFx/IVy7j6xB+wGK
 0t/aSI4GiiojPh6MWWeSIBoXaCep4+QRfC1s1lLfdChabebe8Pv4KmgyF7FLBy01tNN+n4/xh
 jCYxDvquvAqWgXAiYG3X9LIZqotWbCVWW0u7OiTUUttEbZ/Ub/hOmZFsV8oXwC/u/FcNjkgpC
 EjVuWcLF0Yq1zhzQOLsAB7j9xvqY6rETKbkMIkGnyR/Dn0LKSxTjGm4zf7p+LTzrn82F2CU4H
 /vdA6VNG9e6HoUbAIi2cII6eX7wC7+NXVQBxAWVEQKUsRoITxHiGwJDsLDRMfGUgRwCkf6p5S
 SAVg//rHhz+V4iEGt15yT1vUInMBYHiTOGTtHCsemMN2LNOZAKLIOMg130qvC1gvicEiHiXiZ
 0LwqSJyg/ZekLHhgBZU8nUDynMi1c8Z9Hhcq1T6zQPgRuFvCZj01SktLXCEcoyYw/+N4GBCRY
 bSmpBOrYOp3GBY15RAFakD8iSNaqlcyWYiPvymfiYMk+Ikp8xCccy76FVmxIAKlxH5/tbKhCd
 zB4jio0f/zoOAym0GRsfFvJptuJiaF4XT9O+4dEfISpQGt6SCIVgJD5O5Y7pbOwVUOO5jCzoU
 n0miRL7VlmEFdvTyVC4QqnPjZbK9YiJRQdm9bbYXSbo5lnNFGIAreOIyRQS8aZI0uYXlIBSBX
 lyA4l6bIiQuUmY+UioT4TO4OoeH8Q2sHA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check for imx6ul generates warnings like this:

['fsl,imx6ul-gpt', 'fsl,imx6sx-gpt'] is too long

According to the timer-imx-gpt driver all imx6 use the same imx6dl data,
but according to the existing DTS files the imx6ul GPT IP is derived from
imx6sx. So better follow the DTS files here and make the imx6ul GPT
compatible to the imx6sl one to fix the warning.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index 716c6afcca1f..685137338ac9 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -34,6 +34,9 @@ properties:
               - fsl,imxrt1050-gpt
               - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
+      - items:
+          - const: fsl,imx6ul-gpt
+          - const: fsl,imx6sx-gpt
 
   reg:
     maxItems: 1
-- 
2.34.1

