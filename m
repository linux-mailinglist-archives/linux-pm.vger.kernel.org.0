Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7994156641E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiGEH2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiGEH2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:28:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB39FED
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:28:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j21so19145879lfe.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BtSob2ANmpucm7jgDzPrzZm9mTZHHtmCG8rQOCvNCKk=;
        b=FjF+vtRtT5mDMaKdXbAvExh5RFrimWNJd2+HVQxm1ZXvNormLjAJgq+P//9OP8sVp0
         TJxtYEwM4quly4oA9K1QNVl/AVwj87NNs9Qi3cr1m7580YggIrP9obxmNwF70Lm/nD95
         n7gxQ6qynzBwKPR1ISPuBWU6tD8C7JZtUbBYAGXmQ6niQLfYKbuZ+cesp+Pd59IsXNXW
         ejUCax+nXvWLSY6YkM1lbynA2+uq9ZNf3yCNJR4sIZgYqEZiAcFn+cmQBLqkohh8SO+c
         8XgzUaDKKJfzm4p10urD3subvYzaxy3o/EQFGfiVesUQToTKVy35wQ3oSSPqptcv46/B
         bV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BtSob2ANmpucm7jgDzPrzZm9mTZHHtmCG8rQOCvNCKk=;
        b=5ErZEClSjVin3E+I/YSflSB7wxd0yJ0iw7Tsoaxk+NmVW4IWspz3bI7uSFaGiv5Pb3
         h3aGtSL1/drF7CHR80QhbmSRg57qaT9CiEvUqVAJrzx5ZGpWBTxawXU+gHED3HXXwjA1
         yfGHR5kHd/HQfisqU057U/VgDWaGXcIB+YbrIC4Je6n0RphHjhBr2I/BbFvMlg5JcmJY
         KevZX4nqTTPKzD0WFfXEw7Vmw57tL4+ARYVk8z4kGdHF3kNMNZgM7bXhI5+GAX2doyUz
         MDe7HKZcZJuVEVw86oDAAu/lUhm4ktbD1DK2qYvdawxvHZfsWMjpVmMHatQpNR1Ma7Gi
         OxlQ==
X-Gm-Message-State: AJIora+5G5k3fN5NYgdMzuqHmPbbemJ9kWgVQNDhzg1v/732bz3sq3M/
        cLP8MzlUbOh1Et6aJ2Q0rVz6Jw==
X-Google-Smtp-Source: AGRyM1swFsHTxqvW5WdNkUU2jKmalru9GN6rlwHny9vGK0TQbxZ7PmJPnfQFa1g6bBgH5MtEOVwtHw==
X-Received: by 2002:a05:6512:690:b0:482:a141:7c2 with SMTP id t16-20020a056512069000b00482a14107c2mr11718951lfe.639.1657006106335;
        Tue, 05 Jul 2022 00:28:26 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id x9-20020ac24889000000b004786d37229csm5537352lfc.155.2022.07.05.00.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:28:25 -0700 (PDT)
Message-ID: <4da347bb-4210-e9a5-1bf7-988b95b1db53@linaro.org>
Date:   Tue, 5 Jul 2022 09:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu from
 txt to yaml
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
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
 <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
 <20220705003955.GO819983@dragon>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705003955.GO819983@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2022 02:39, Shawn Guo wrote:
> On Wed, Jun 29, 2022 at 07:51:06PM +0200, Krzysztof Kozlowski wrote:
>> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
>>>   * Updated according to Krzysztof Kozlowski comments
>>>
>>
>> My comment a about removal of each part of TXT bindings in each patch,
>> was not addressed. Your approach makes it more difficult to read patches
>> and makes sense only if each subsystem maintainer will take the patches
>> (separately). If the patches are going through one tree, then better to
>> remove the TXT gradually.
>>
>> So the question - who is going to take each of the patches?
> 
> I can take the series through IMX tree if that makes the most sense.

Sounds fine to me. Then however each piece of TXT file should be removed
in each commit doing that piece conversion.

Best regards,
Krzysztof
