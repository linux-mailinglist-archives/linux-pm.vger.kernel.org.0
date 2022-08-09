Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0A58D411
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbiHIGwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiHIGwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 02:52:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC6320BFC
        for <linux-pm@vger.kernel.org>; Mon,  8 Aug 2022 23:51:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so15696267lfm.12
        for <linux-pm@vger.kernel.org>; Mon, 08 Aug 2022 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YKNZDEH28vo2hOp+yO+5ohq8JvJ2Azq963eWNXEueng=;
        b=YPnO3aOsjoKfoky+lJWcp8X+Ot6taMNcOMdzc20QiXMA0XVsHV1mF8SfHypERbMgvP
         VLvqaGFDuOXjroTO4Hx9SOM085qQ/9ApiXpvQPfFym/MYjpM6pkGvsVF3P4eNl6x2RCV
         2ahSiq+69pCAiV7nHTCTi3JCjFVsIAbm35PlGTw58/e6sqlHCKPsLce5yPlNeVh/2N/2
         oycRIeUbS9c+iuD7xVdk9eZyFxtpRNuch3gWt00CIF9BnyKKBQrcuO+SGS5HbSfFrht6
         satS+5Yclxa/Ni7BmrC5osAGmGdykqzgU2zr9yfxwRS+9dlJ2c401Eih5kyHfgNZV+yA
         snBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YKNZDEH28vo2hOp+yO+5ohq8JvJ2Azq963eWNXEueng=;
        b=iPd/iFP5N5v8GyMHuEYEeN0CYvUIM/1sIA59BNV/kEK4aff9G3L/EOEpEdka8HSI3M
         W9x8HqtZRSfwmQBIBL+jd+1xvJQXdWyDX4vSCJ4+fzqCSjblNC/gZSWyNhX36WZD+IUM
         ZaKXSPvPcUTTbmJfLA4ZbeKadSlttxOk274ZBpJMfj4MTA3NJZyISnuUyQ12i0Nak9Wn
         R5Qv8CeV/l78+tj5pvW/KfdoxsOackqEOIEzM1MNqOnENlzMi7WW/gI+BbH1jySMYLTS
         7NjCf2fUtWGLcO2bgRhnG/aonvrEx0LDrG1UnVovr+APyEdLrqmDLlVDnzSkat2CeTGi
         s4WQ==
X-Gm-Message-State: ACgBeo2EI/2mbTqrZz0Z9jVB+bamEFqRvumX5shJVA+TZJFgIR5MDz6E
        oq5hEFe0KvlOlKbMuRsQh/ZbHg==
X-Google-Smtp-Source: AA6agR5JNym3jZqwEXK+XRc6gZGTBrm4grb5Lt43yb7sd2tQ2mwtU0gNBV8G9SDZYNmBeRsUMlQVjg==
X-Received: by 2002:a05:6512:3fa0:b0:48a:c45:275f with SMTP id x32-20020a0565123fa000b0048a0c45275fmr7180583lfa.566.1660027917050;
        Mon, 08 Aug 2022 23:51:57 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j16-20020ac25510000000b0048af3154456sm1653751lfk.146.2022.08.08.23.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 23:51:56 -0700 (PDT)
Message-ID: <a35dc076-e33f-1b31-2a01-27bb37301039@linaro.org>
Date:   Tue, 9 Aug 2022 09:51:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: leds: Describe optional 'reg' property used
 for Qualcomm LPG nodes
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220721195502.1525214-1-bhupesh.sharma@linaro.org>
 <CAA8EJppGS38aP7gyd1c3kNgraAVJDoqUef2cDfZpu2aL_iwW0g@mail.gmail.com>
 <YvFZgr1RRq6tYaVC@ripper>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvFZgr1RRq6tYaVC@ripper>
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

On 08/08/2022 21:44, Bjorn Andersson wrote:
> On Thu 21 Jul 13:19 PDT 2022, Dmitry Baryshkov wrote:
> 
>> On Thu, 21 Jul 2022 at 22:55, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>>
>>> As Bjorn noted in [1], it is useful to describe the optional
>>> 'reg' property for Qualcomm LPG nodes as it is used in
>>> some Qualcomm dts files.
>>
>> I don't think this is correct. LPG block maps to several regions, so
>> using just one of them in reg doesn't look correct.
>>
> 
> I agree, but I also like the uniformity of having unit addresses for the
> devices on the spmi buses.

regulators also do not have reg, so I guess consistency is already gone.

I vote here to reflect the real hardware/device which means:
1. IIUC, the design of entire SPMI bindings and its implementation is
around parent device sitting on SPMI bus and children using its
regmap/io space.
2. The children are not really re-usable for different cases/devices
(e.g. standalone WLED or LPG, outside of PMIC).
3. This means entire design is tightly coupled and LPG (or wled,
regulators) bindings describe the piece of PMIC, thus I find appropriate
skipping "reg".
4. If we want to keep the "reg", then it should rather reflect reality,
so if Dmitry said - multiple items for separate IO address ranges.

> 
>>> This fixes the following 'make dtbs_check' error reported for
>>> pm8350c & sc8280xp pwm nodes:
>>>
>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
>>>  pwm@e800: 'reg' does not match any of the regexes:
>>>  '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
>>
>> I'd prefer to follow the existing schema and to drop the region from
>> those files.
>>
> 
> I'm fine either way, but we have more of these nodes, so I would like to
> hear from the DT maintainers on the direction to take. All nodes on the
> spmi bus has an (at least one) address, so it would be accurate to state
> this in the node.
> 
> It does however not seem like devicetree@, nor Krzysztof is Cc'ed on
> this patch, so I've added them...
>

Anyway this patch has to be resent to properly reach DT patchwork.

Bhupesh,

Please use scripts/get_maintainer.pl to Cc relevant folks and mailing
lists. While resending, add appropriate device prefix to subject, so:
dt-bindings: leds: qcom-lpg:


Best regards,
Krzysztof
