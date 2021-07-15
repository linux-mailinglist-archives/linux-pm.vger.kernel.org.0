Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240D53CA180
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jul 2021 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhGOPcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jul 2021 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbhGOPcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jul 2021 11:32:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AAC06175F;
        Thu, 15 Jul 2021 08:29:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u14so9514169ljh.0;
        Thu, 15 Jul 2021 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CdIcOYksg8pHKzRiudEnxrqrqTv11M4NJ2rvZF2H7WA=;
        b=nme9HccGkB0Rg4iueecc8lJqpYtdkf+1N2oSO2tdCeT0oDINOZ0vs7G8YphTgtbCzE
         vA/C8owaAns9B9CsksDXeWbn4+wBz9AcrKXlE4Zw/e9zXECh8DEqEyev5HCwCbTbWD4E
         wGEAOKCmrKAubTQU+ugkBvy8Z+7P/iGVxcZhykLQkQ2NdBeOcj8z/VV1bggKUnQGfw7f
         73T8RwpLPUHC21MYNHzjwdqLcCUBaoZ7MQJtgAeCEFSXISmSnE8V5ynckOwr2+kxKsrV
         xgapFn6rlPS7cIr9g/PekIlptQIVRUkDm+inTxprmBOMTjrkYL+8TzSHSBZ41xdTuCWT
         z/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdIcOYksg8pHKzRiudEnxrqrqTv11M4NJ2rvZF2H7WA=;
        b=W+UkKzt39fAaMEvHeCKdgitWwuXFr7eJbDhIw+NZOLdgUGREslPXWw3h+COmbP9R0k
         Kqgee5hOB4oDx4AMtYKfVzQSXzLRV/SI/OtD0m14h6sa55agwaZWysSeoaWp+lc+v2CB
         fxUivzcIydF6iCb14dJEkoINRZnZXPNjbtrzS8IB/r9Nfrvwjsu332VQp5lO913UJZUy
         SomaC0iq6Dj+jL859XFEyaOJYLcFKn5vaAx9eP2ebx9dROU7zs33+gTZeTg2z0LtJjHn
         VjILdzKUkm9BXrh9rzFKvSGLV00MAU5x8CyORyGitezfNWUJcZ5JNGlN0THBf7rZqaLg
         lFFg==
X-Gm-Message-State: AOAM530ZHdmoo3z0f6IhQwvVGBOlsuztJLv2HsFTIxXkAu3aaUWjfOF2
        4muqzvwuf0++a96QJ8HzdTHZwcHDNxE=
X-Google-Smtp-Source: ABdhPJwhU1r2gnUTo6zmqgpT1R3dIr2OZf855m5yYz9IRQk6uAwjoF6BPFdbhFj4DO84ZiS0mlcukg==
X-Received: by 2002:a2e:bc0a:: with SMTP id b10mr2439427ljf.271.1626362996402;
        Thu, 15 Jul 2021 08:29:56 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id j18sm176347ljq.19.2021.07.15.08.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:29:56 -0700 (PDT)
Subject: Re: [PATCH v3 06/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-7-digetx@gmail.com>
 <20210712153905.GA1980362@robh.at.kernel.org>
 <9032e807-b4d3-bacf-6c39-d3a2c7c57f3e@gmail.com>
 <20210714230140.GA3697673@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bffaea79-92a2-0355-d213-31dbe3d2b0b1@gmail.com>
Date:   Thu, 15 Jul 2021 18:29:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714230140.GA3697673@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.07.2021 02:01, Rob Herring пишет:
> On Tue, Jul 13, 2021 at 03:22:40AM +0300, Dmitry Osipenko wrote:
>> 12.07.2021 18:39, Rob Herring пишет:
>>>> +  summit,inok-polarity:
>>>> +    description: |
>>>> +      Polarity of INOK signal indicating presence of external power supply.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum:
>>>> +      - 0 # SMB3XX_SYSOK_INOK_ACTIVE_LOW
>>>> +      - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
>>>> +
>>>> +  usb-vbus:
>>>> +    $ref: "../../regulator/regulator.yaml#"
>>>> +    type: object
>>>        unevaluatedProperties: false
>>>
>>> With that,
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>
>> I tried to add the unevaluatedProperties + a random unrelated property
>> to the example usb-vbus node and dt_binding_check is happy with that. So
>> the unevaluatedProperties has no effect, is it supposed to be so?
> 
> Yes, until support lands upstream[1].
> 
> Rob
> 
> [1] https://github.com/Julian/jsonschema/pull/817
> 

Thank you for the clarification.
