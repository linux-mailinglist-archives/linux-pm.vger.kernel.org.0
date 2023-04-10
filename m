Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C196DCC7B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDJU7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjDJU7F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:59:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A161BDD;
        Mon, 10 Apr 2023 13:59:02 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mxlmw-1qa4ZY1QhK-00zBrO; Mon, 10 Apr 2023 22:58:26 +0200
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
        linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 4/6] dt-bindings: imxgpt: add imx6ul compatible
Date:   Mon, 10 Apr 2023 22:58:01 +0200
Message-Id: <20230410205803.45853-5-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205803.45853-1-stefan.wahren@i2se.com>
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G6pD2AxTWA9rAaSoDvlxvW1LU38AWMNOI5lOTzaxtJ830HK/Nyy
 IxC/MsXDfj+6KO3TBriwRWjvdfgfjjdzpKJwDaVwxlCdlSd91AmshuqSpxrQea8w4Jf0lPk
 DZk4BKRq0vQlnhWJLbYxDDsFtXgmpfqYBm8e0FIxLoAWiVRkt/NBHGylDW6j6r4uhoJM2fA
 n9b99qvs0DMry1jFF21xA==
UI-OutboundReport: notjunk:1;M01:P0:qWIymvWb9tc=;/QIcySMzRIMAO/gS/LuXZncr8ln
 /j4zd7dFjU8tkkuOL7cZqpC8OBh32VvykaIxtDB1qxTvTSF5QlgDCcSVg967Sjt5+0CeGGzOK
 x46Oo1fb7J3YtJ9gyONPp55eAVseOrm+NmmGvUCS/XiR74XgYtxjyLH06dOzbQTJ3L6IcHr2R
 R7DZcDReWjgpgW9RlWTZyjhEVSPHDi/DeDXM6Cc7ra4TQ8HmOcvQK2rJ/TnCreE5Jk7gFlmYI
 J8inlIk6NYjKUIonrLWW53a5XeeKJDJjQbAs/3TwTyr4LvXFvZKY2vDMUpq8Z9I9MF1ltmQ7Z
 ZxUr7ZS+fWzjqE+tav8HFZ5kSpv7CdjNC4TTECRSdogtI5rawHA/or029qFg1uGJjblgZbEjc
 p+LFgijd7T695YtVIe9KP/26xlWnQTxS8e3i3GdSxnD3Ysp+c/C/sLi+il8e1MAAO02h1fYWV
 pj1H94Pf6YwgPgZWeHiaYQLut2mg/l57A1hB9LEwAyGSEjpghHC2WEIv3SHku1zWvwFv6U2rP
 kKs1PRzUqYAa+V4vLCh2UTCLlmSRJtBeWi3rCwq9e/oZVsqNEE+Ku9WO4yhFl7P58lWzWAO+w
 15VMQjmhxonsahf+OLCNYlf66M4uP4904UR6VLXGwTlpF71RC0j5xVg4VeUzaP/zAQkPB0KAG
 2wR1M78Nadcr1Mv098v5NIGdM84huw99ge4Hco/SPg==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

