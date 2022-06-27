Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417AA55E0D9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiF0MIW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbiF0MHo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 08:07:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DB8DE85
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 05:06:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so353185wrc.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 05:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Vr70S1itQTBF/3bCew+jxqxaJK1aORpqchqJlIulN8=;
        b=nj5oQcZi8JzRsGM3DFad9Xybe6hpa6FG+MoP8L51KifR9Vnx9eDEerY0sFLxcH32pP
         yh2DJfqgWpq2zpXtrzs4dP+HhJVpTk5m0rTdKps26yOU5SUfkbzy/DhlLyYaSC+Ocq2j
         H3cMckzKhtqrZnldgDo9v8nChVSAtAKLitLXMZObAYq0T3IoOVCt5uiwdmKFyMacY5kl
         FdlOqE9NXg1fkkJPIyCBNCNntcZWm+sNt4zl5IY81kL60mqK4eJnz6Hpt6TLaEC137rb
         exNw3wpIXASEHPhT6/6P7i5ajW9wGdM3C5LjbdfGViBQtJSbFlgSIPKIxOaBshjymIB6
         ZoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Vr70S1itQTBF/3bCew+jxqxaJK1aORpqchqJlIulN8=;
        b=BqCoKr/i0g7lPYVApGTn55L2/1KbBhuo/ODl5S2Hw9yxsKL6xVcXYsBiTyJ3X25ndK
         J+63lvfCIVChClj3wi4CtV32KbxJ2i2JB4umeCzqVe7iLadqheWuB4+PIR0AM4F0O6JG
         Zb/kjQOHoiQ1ca6xST20tKWuTCPycRkqqLnqe20ziykD9VIwn0wJrxzjwHc4MYyaZ+Yc
         kzOjSiBc1qgNbOHnZ89WRwVW4WntQP2d9MhEcgJEMDZ/MmgW0tXh5baQUdHRXSKwshK3
         1URFFIZ28OqWpBegOqd0XRTYjZHc/2kN9g3mJJXKI5w5edfqLTKVnXTElZZSQ+zgny/l
         0JyA==
X-Gm-Message-State: AJIora9iGtbEHkoe263L4N6wJMdlS1Mx3pL6LWUqydES9kDMmVIokR8E
        jMXLQ5lIMZ9+TNJk4+pR/ShDtw==
X-Google-Smtp-Source: AGRyM1v4mipmlBAmPoKRfrckMoNmVytCsUsuVXsuKFVR2SVoD35b+p0iU2bhx9v38CDsNf6vGT/67A==
X-Received: by 2002:a5d:5c11:0:b0:21b:a9a2:7eec with SMTP id cc17-20020a5d5c11000000b0021ba9a27eecmr12101736wrb.579.1656331582103;
        Mon, 27 Jun 2022 05:06:22 -0700 (PDT)
Received: from [192.168.0.249] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f8-20020a1cc908000000b0039c99f61e5bsm16608790wmb.5.2022.06.27.05.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 05:06:21 -0700 (PDT)
Message-ID: <dca6534e-2601-a943-b6a8-2593f7fc64eb@linaro.org>
Date:   Mon, 27 Jun 2022 14:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 10/14] dt-bindings: firmware: Add fsl,scu yaml file
Content-Language: en-US
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
 <20220616164303.790379-11-viorel.suman@nxp.com>
 <b653d7af-f846-abb2-d260-3ce615b070a4@linaro.org>
 <20220627114949.pg7az36fz4jrwebp@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627114949.pg7az36fz4jrwebp@fsr-ub1664-116>
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

On 27/06/2022 13:49, Viorel Suman wrote:
> On 22-06-24 12:25:44, Krzysztof Kozlowski wrote:
>> On 16/06/2022 18:42, Viorel Suman wrote:
>>> From: Abel Vesa <abel.vesa@nxp.com>
>>>
>>> In order to replace the fsl,scu txt file from bindings/arm/freescale,
>>> we need to split it between the right subsystems. This patch adds the
>>> fsl,scu.yaml in the firmware bindings folder. This one is only for
>>> the main SCU node. The old txt file will be removed only after all
>>> the child nodes have been properly switch to yaml.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>>> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>>> ---
>>>  .../devicetree/bindings/firmware/fsl,scu.yaml | 170 ++++++++++++++++++
>>>  1 file changed, 170 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> 
> [...]
> 
>>> +properties:
>>> +  $nodename:
>>> +    const: 'scu'
>>
>> Why enforcing node name? Second point is that node names should be
>> generic, so I wonder what "SCU" exactly means and whether it is generic?
>>
> 
> It stands for "System Control Unit" - looks generic to me.

Nope, it's specific, just like other scu - Snoop Control Unit. What's
more, reusing the same acronym leads to confusions.

If it was generic, then I expect it to be present in several other
places, but it's not (except the other SCU).

Generic name is for example "system-controller".

> I guess a reason to enforce it - need to check with Abel - might be
> the need to group multiple SCU implementations under a common known name.

Device bindings do not enforce the names, unless it's really needed, and
I doubt there is a need here.  Just drop it and rename nodes in DTS to
something generic.


Best regards,
Krzysztof
