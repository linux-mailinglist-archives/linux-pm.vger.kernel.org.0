Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB96DCC7F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDJU7K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDJU7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:59:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464D1BD9;
        Mon, 10 Apr 2023 13:59:03 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0nvJ-1qXbbO3SlR-00wikr; Mon, 10 Apr 2023 22:58:23 +0200
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
Subject: [PATCH V2 0/6] ARM: dts: imx6ull: Fix dtbs_check warnings
Date:   Mon, 10 Apr 2023 22:57:57 +0200
Message-Id: <20230410205803.45853-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XdkOV61ksLSZtrlonvh6FpUglprFQYh8we1Z9a1smKkM61WGGKL
 l9lfGj7qHDXOar1nDRo/Zpoacgv6qmrSB7uJpYJsBh4hSb/Zf+jhTpyhkHekdaCsEmUNP8K
 5nq4hI6eXuU3ctgDiajlXhWxzNBq7t8sIh8MlD52wcymz3z0BCBd+FKFLw3v1oT5wag+1CS
 u+U2wJ8FFziHoEM5W8khg==
UI-OutboundReport: notjunk:1;M01:P0:7vWcb7TeIFQ=;AhkpwLufc1X/9dgTkPUEPG0JE1P
 91acookKLxUcDdaSia2GmB+tzjFNap06FOlMBk6Evf2oZZK6XhNupAabmbo0STqSLzRpuCoxt
 TPnXsg6F2iDW+FGIkjINax3Mb7HdbOIDkfLjf10eReWvPBxpC8jpa9citKVqObAkmTpQHzsaB
 QTy2Ojk8r/HEvJ6p+5lC3JzxGoFXQhC5pm1T5IFcy+fJRmSGGXqzUURFVx3OWURJQZ7zbeHwN
 AYji52Gy/ZiBQBkRgmrJ902oZ87W4EUbmgsQuf7a9FFrKCfg0oxgtaRmopXkQk6LIeXVkvlOT
 Y0ZOpHgl3cZ4XJVKQcnQ71fqmW6gs8YQXP9GxIxFs/LT/3aaSX9sld+HhaY5VAnP5ITt0whji
 EfEArolCSCmz5kJOYgoYv18tt7eqUxdY/VXzqV1Mnm7uPoHOVoqqe2uaAW77xnfrq2bWwOWrx
 mzzkEj0TmeED3r79l93lYCJVW41LlpMlhIp+cZVSphTl0QlhfZzy1S31T49uJPfVcXYlAQt+k
 zW9CCYQ4EKW0iQs4sFc8DY54rwSJMG8d/bg2xGzky1UCEtGOr5vm0rqddPckiS8iod4sfkAmL
 mHOqHbpBZJdEzx2MTfRHJbauFLn2ML/PPH9cJx3zRl7ZCaQxdnD1/kq1Rw/pvOG0501CIBl9e
 2BdlKqKnVS16uDR7t4z4j44BB9ifmRZ2ysB3M6skWg==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series tries to address some dtbs_check warnings on i.MX6ULL.

Changes in V2:
- new patch to fix fsl-imx-uart warnings 
- fixed GPC typo found by Fabio Estevam
- keep enum in bindings as suggested by Krzysztof Kozlowski
- make imx6ul GPT compatible to imx6sx

Stefan Wahren (6):
  dt-bindings: serial: fsl-imx-uart: add missing properties
  dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
  dt-bindings: imx-thermal: add imx6sll and imx6ul compatible
  dt-bindings: imxgpt: add imx6ul compatible
  ARM: dts: imx: Adjust dma-apbh node name
  ARM: dts: imx6ul: Add clock and PGC node to GPC

 .../devicetree/bindings/crypto/fsl-dcp.yaml   | 12 ++++++---
 .../bindings/serial/fsl-imx-uart.yaml         | 25 +++++++++++++++++++
 .../bindings/thermal/imx-thermal.yaml         | 14 ++++++++---
 .../devicetree/bindings/timer/fsl,imxgpt.yaml |  3 +++
 arch/arm/boot/dts/imx23.dtsi                  |  2 +-
 arch/arm/boot/dts/imx28.dtsi                  |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                |  2 +-
 arch/arm/boot/dts/imx6sx.dtsi                 |  2 +-
 arch/arm/boot/dts/imx6ul.dtsi                 | 14 ++++++++++-
 arch/arm/boot/dts/imx7s.dtsi                  |  2 +-
 10 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.34.1

