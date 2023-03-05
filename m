Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25686AB36C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 00:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCEXMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 18:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEXMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 18:12:48 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA2CA0D;
        Sun,  5 Mar 2023 15:12:46 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEFrX-1pgPaK3LWf-00AHWq; Sun, 05 Mar 2023 23:59:33 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/6] dt-bindings: imxgpt: add imx6ul compatible
Date:   Sun,  5 Mar 2023 23:58:57 +0100
Message-Id: <20230305225901.7119-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305225901.7119-1-stefan.wahren@i2se.com>
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IwT96KuCYihTleCJc6GGzhJZA3kr03QgpvJytzu99LqgSXUcPYZ
 VxEvLQhHH3dkX33xf0KM+M9Z2xOLi8NrW0HXSIM3gw/6KjCFRitXD0XYTldg1dbnfbBKxJK
 Gux3W1XIhXnVeLzubA830PmRA9jdiGZNCuBZc1PcbiDquCtMIqV58NRsJXKhxH1iRyDaISg
 KX+NIOQcC5Jfo3UzDGjeA==
UI-OutboundReport: notjunk:1;M01:P0:9lR6X1DOui4=;XJK/c3uioJtI7hxFroeFkIPRxoz
 fpNHKajRI3qGWJMBUj2RKCfUzM/APfpBNhD3ZwftOSMyFO4/rbzpaP6doK3zlDV8tJAa4vZ8I
 lS/mD+NFCW5t/d3Cj11pAFjUBCs2zryfKl5/pEiNzOhUVAGkjcvnZrPrSu7MPGWMYgLPwhef4
 Jh7E+vW8p808kpots4hsCz7f+WScLeh/BsrST1OHQ37EDNoBVpNB909hNreyjMYgslzZx8yXO
 9+blpetgafO7Hf+ksJmiqu1KVp1evBdOcSqwkc3pNXd0jpKvpAtkwXZwy0IFgEPEckGTXHnfa
 NASx1vPg6MXzExGGU2jPbtRMgEbICtlFbG5PCysTBQ4khicNAt2xY04vjljsbcNL+1mvy14hc
 /7Iwd2EYwsETppCcN9IbyYNzSuzUzBeZWb4FiW7z9YggOIpg+loMVYPezqbA2oMANh9OJlra2
 Mdjc5deEb2OhDTbsEmwzlvKD87hGmURIXsMrgLQIpwkunCkMhD5NzFwYCmSKlReQOthhpLYkC
 fEc/b+AhM/GVON+CyZYuspen8F6LQblXbpVei+GYovHkE9wm9O9laS7V0nDWj1R++x+MNXikQ
 ibpZxYl9PIL7Hk658tB5VmEipNQoxj+LwcSvHs0OGnftAi8IPG2ytrNfzqMEhuUkWOIiuHqfz
 gcjhd1K6Hx9+5Ap10dixaet/ha3VmtluytouQ2MuJw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check for imx6ul generates warnings like this:

['fsl,imx6ul-gpt', 'fsl,imx6sx-gpt'] is too long

Since the imx6ul GPT IP is compatible to imx6dl, add the compatible
to the enum. The mentioned warning also needs adjustment of the
affected DTS, but this should be done in a different patch.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index 716c6afcca1f..8d9e8c1b7dcf 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imx6ul-gpt
               - fsl,imxrt1050-gpt
               - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
-- 
2.34.1

