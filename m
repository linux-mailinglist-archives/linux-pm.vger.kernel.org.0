Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F11560809
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiF2R6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiF2R61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 13:58:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF019299
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 10:58:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so34177566ejb.4
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TO3Gnama9Pcg2SO6IJJkDI3yQUm4nzzhBUaaJ+8u4m4=;
        b=U8P7GVcN+mATksB0WZAJBG7FkirhJVc/r4XngwH4+Rwlp/CzQUDTIxArRCnf9ypdWX
         Co0dkneIn9UEGH4ZQBLz9BT8WJ8+R7q2L9DDQFwbiqbcTUMfsnlB8M4/9M5a3gBVVLrY
         mMrGrpayYYOco0L2HjOuwJlI16VbMSZ9JC9pLZAwvOLq+u+qfrOihjvbmV3Bi5LNjAre
         DwKTjYEwyfloNuIwtu0w7ObutFzBca500iyf0oTxLyhaTxT3ozVUzWgJejS0ydHY6L4j
         mmZ/Wcvk6WTTJyQdlGItRoda+2+ECGHS9P8AFRgcBwGQ4K1kmga/XpbD43MZ6fdODgv/
         8BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TO3Gnama9Pcg2SO6IJJkDI3yQUm4nzzhBUaaJ+8u4m4=;
        b=bk6CpuCn9AF7W1v8gp19ZHs8oUABcCXJzKbgavOgh7qG0ts09zlP52aemTuPV5hTa4
         Pr1bBILyJQ3MQ0YgcFkEyLlNd0jMt1bZ9T9NAw1ejqMTspWfatR0ohZRDCacxF9TEvcv
         UN49aW0dOf0f6K03D/8O9uqb6H0zT1X3SO6qiWj7Rbr4QH+Kx+JumI+fYEbpxF4E80v4
         l5RSUbRYHOIQ+HuzmlXGWovDIA5SGv810GvrBkrgorzfcGHLm/TntiR3wDVndrXUtUwb
         25bhrrKRYmMPeGNkG9UFEPq6O55cTJG1g6TktE/1T81r5QPGkoxwqxxAx0ljohpqcpb6
         FOtA==
X-Gm-Message-State: AJIora9nbMIE6QZ30n4W5fqEsxADXQWiwOu/ccwaCPzcgriWJNNvHdRX
        ZanJmErqTsfR7MQYfEQcfX9NLQ==
X-Google-Smtp-Source: AGRyM1v+gAf4AWv37It7Rky/E4URQVzb6RJirGLCOYcVKDVk8+2jdsLHkGdkPyRS78jkOTTaGVKnpQ==
X-Received: by 2002:a17:906:5d0d:b0:726:be8f:becc with SMTP id g13-20020a1709065d0d00b00726be8fbeccmr4459339ejt.323.1656525500445;
        Wed, 29 Jun 2022 10:58:20 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lu4-20020a170906fac400b006fec69696a0sm7884910ejb.220.2022.06.29.10.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:58:19 -0700 (PDT)
Message-ID: <ba3289b0-6c1f-6601-9f91-3f9e727459e5@linaro.org>
Date:   Wed, 29 Jun 2022 19:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 06/14] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-7-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629164414.301813-7-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'rtc' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> new file mode 100644
> index 000000000000..940588e278fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +allOf:
> +  - $ref: "rtc.yaml#"

No need for quotes.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
