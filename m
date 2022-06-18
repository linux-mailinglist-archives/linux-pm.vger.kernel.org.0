Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CC550174
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jun 2022 02:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380637AbiFRApb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 20:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiFRApb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 20:45:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9069B62
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 17:45:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so5459346pfb.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4UBTCxi8NJwu+bWr0wJOqTsx4bcIPj3/b5hz4TC0hQY=;
        b=eyJ6ww4XQJY6GkTvPtAS8EmgxidGB0tDgomc5hdevWn1R+oGEvtskMEDqeTnlWqIp6
         CdDsoZFGFBOlufromgEEF/gGuhNUqyw3Q/SzoGeLHkw56rC29zUWqSoHAcKt5MUH/ls1
         4VkGt4/kVd+TblxGi4cXck63elJZO4XQwq9h3znyNVdZ8bOncRfYZ2Pe5KeBX2l0yCLu
         QyKdV54XyFEdF+XgtA+sX2e9YpfDbym1N9nVKLqw7dAYQk8Hxyw9ysJeEbeofRuI+rNv
         /JBFdnwenTZC0E5UQwJQR0KyHVjHCWdF3x95DPp+C/te4IEvJqQ83sqSdiecWmcek716
         CN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4UBTCxi8NJwu+bWr0wJOqTsx4bcIPj3/b5hz4TC0hQY=;
        b=ULYtKb7hweoQmAX3Dy29IT6JEGqiB8mia0UHdGvcCmAD9yoWm0c/9Bqz1OsUyk7J2i
         lX/wWM5FcTMGu6vqlr5PbJQYseJqXsKw6JXsfSBNQIDqyU18Vdy7LRipdJqWcm2D2aHX
         G+3OVKRDIaE0cPOBlzIL86az+i+jz6DvP2vuKNgvfE0zFJ6ylDOoGZzYBXRinKYaLVpv
         bIolTDoCFu+gl2noirOWGv7PL1dYCjak9hgtvS+jlVNsxsHpDWNoLrJC1XAigJjuHxnl
         L4/+mlE7wiHBc6TBf04WdLsCHgPC3RVV4V6chnE50elBMvu1GDoUeMv3irmDyAP3iLL8
         R/zQ==
X-Gm-Message-State: AJIora+Ugks54qr8MXeqoFERKJHV1IpNbso7cyeJNo4/X2F9k80J56KS
        fCMWmh+i3QN0AWuaY7s+G+lAcA==
X-Google-Smtp-Source: AGRyM1vPx7U/RB9e0wVTMwzZu9KuNOtp08j+FdGRa9g4rHhb/XAEnR0mYoannyMnwN4UEuV+Ua7ttg==
X-Received: by 2002:a05:6a00:1a8f:b0:51c:2f82:cdba with SMTP id e15-20020a056a001a8f00b0051c2f82cdbamr12876825pfv.85.1655513129981;
        Fri, 17 Jun 2022 17:45:29 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm4080548pll.194.2022.06.17.17.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 17:45:29 -0700 (PDT)
Message-ID: <acbf8ed3-0b8c-a0b2-88ef-7b13ad0908d5@linaro.org>
Date:   Fri, 17 Jun 2022 17:45:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/9] imx: thermal: Allow trip point configuration from
 DT
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220617070847.186876-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/06/2022 00:08, Francesco Dolcini wrote:
> This series allows to specify the imx thermal drivers trip point from the device tree,
> without this change the threshold are hard-coded and this might not be correct given the
> thermal design of the final system.
> 
> This change is backward compatible with the existing device tree, and even
> with this change in by default the thresholds are the same as before.
> 
> Toradex board are also updated to use a system-specific thresholds.
> 
> Discussion on the current design is here:
> https://lore.kernel.org/all/4ba1d7d2-3e8c-ba60-37fd-9598f415c076@linaro.org/
> 
> One side note, after this change the dtbs checker starts complaining with this message
> 
> ```
> linux/arch/arm/boot/dts/imx6dl-alti6p.dtb: tempmon: '#thermal-sensor-cells' does not match any of the regexes: '^(automotive|commercial|extended-commercial|industrial)-thermal$', 'pinctrl-[0-9]+'
> 	From schema: linux/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> ```
> 
> to my understanding this is just a side effect, 

If it starts complaining, it does not look like a side effect but error
needing to be fixed/addressed.


> '#thermal-sensor-cells' is not changed in
> any way by this series. I can fix that, I wonder if I should remove the property from the
> imx dtsi files or add it to the binding yaml definition, not sure about it.
> Anybody can advise?

Depends. Is the device a thermal-sensor provider?

Best regards,
Krzysztof
