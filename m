Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8778747A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbjHXPnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbjHXPnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 11:43:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB501B0
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 08:43:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1c66876aso912045866b.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692891807; x=1693496607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShB/qBaFEyCnDyqEu/IuL2+eMoqWlbW5uwGQYseJkOA=;
        b=C/U292JKOs6/enn3dbhCwMIm2fAQNSmZyU4K8nV2vsRbZDTWfZGpmR0GtzfmGv9xlN
         CvFigm8McnvcHYxorNg8N2FUy75mG1v0GvwLCpx4r9Xw5AehgLTCwsjIksYUJk31+U3p
         gIvdMNaNIekTrmQewUbteT7gHUbGBVCDmXdd+zLs3TIAfBlAnHLptgGbEnEX9DwDlyF6
         bLeYeMNcLyFnNtxqaTtnlRZthSk5JcSL5jpsMCxuAZEe/76StCL62UwY8zFxUCuLjUkW
         UQeFHULWUmTCItfPbchWTIMMcd/TgLatkC/7eziz7JaCqPzDVMJtQbHdohUifMhysczv
         XQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891807; x=1693496607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShB/qBaFEyCnDyqEu/IuL2+eMoqWlbW5uwGQYseJkOA=;
        b=ZeVkagAVtP++SNatc6QhN4A8mp/3WwGGtVgFJ5hkOMJ7dwGxuvtvd7Gho0iM6gD/Fa
         tfy6Ex/PKU5rFMxqkd1Z3KW8BmrRzkW2BvufsmIRUq/o75/z5WML5M8J0ERZwDxbH10c
         t4tyAQM/jufM8UExuppHw0kUNxPJF/K+onMeEN/NrvqvevuOi/8dXhDGkd+SedV1JAXo
         XqU8QSlaBziNSl9g/2F6hxp8sAwoPOqj+/Tkvy+BASx/8wmNHYHPYUlaXgEsxBTWnHA5
         0c6eUfhGjdoaZsKqudZUs1rlT//4bzqC9CqxUNEuNp9/f3uITtWA7PxBUhzVhiMCERe9
         iqpg==
X-Gm-Message-State: AOJu0YxoOmdFfqtnKNcF5RPB6/DDqEKeGSEIVcY8e5Ku4DyQYsvOQMz4
        lFpxRI6azAjhJ3/OKd6PsOCNiF+G/2BvsI8WNnE=
X-Google-Smtp-Source: AGHT+IHGGOgq0B5PuuAcO9YgQ+vMazklvWHF08tjq+1Bzx79ARleMa4x+At66p1asIGy6/7hC/xF0Q==
X-Received: by 2002:a17:906:9bf6:b0:99d:eabc:2ed with SMTP id de54-20020a1709069bf600b0099deabc02edmr12754070ejc.32.1692891807534;
        Thu, 24 Aug 2023 08:43:27 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m11-20020a170906160b00b00992f81122e1sm11174328ejd.21.2023.08.24.08.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 08:43:27 -0700 (PDT)
Message-ID: <e73d8321-9471-bbff-d273-9b53c938655f@linaro.org>
Date:   Thu, 24 Aug 2023 17:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document
 'nxp,reboot-on-critical'
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230823173334.304201-1-festevam@gmail.com>
 <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
 <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com>
 <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org>
 <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
 <36e24244-3382-b6bb-5975-044112d21eed@linaro.org>
 <71a842cb-86c4-cd36-ba4c-0be480f8b16c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <71a842cb-86c4-cd36-ba4c-0be480f8b16c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/08/2023 16:54, Daniel Lezcano wrote:
> 
> Hi Krzysztof,
> 
> On 24/08/2023 14:38, Krzysztof Kozlowski wrote:
>> On 24/08/2023 12:53, Fabio Estevam wrote:
>>> Hi Daniel,
>>>
>>> On Thu, Aug 24, 2023 at 7:35 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>
>>>>> I will try a different approach by introducing a Kconfig option.
>>>>
>>>> Alternatively, the 'chosen' DT node could be used, no ?
>>
>> Any DT property would be a problem, because I don't think it is static
>> configuration. For example board with the same DTS once should reboot
>> (during development) and once shutdown (some customer wants to be sure
>> it will stay shutdown after critical condition). It's runtime feature.
> 
> Fabio described the feature as a firmware feature where the board does 
> not boot until the temperature goes below a certain temperature.
> 
> That does not look a runtime feature but a platform specific one.
> 
>  From my POV, if the firmware wants to take over the thermal boot of the 
> board, it is probably for a good reason (eg. the board will overheat 
> between the boot and the kernel puts in place the mitigation framework). 
> Letting the user to change that behavior can be dangerous.

OK, if this is supposed to be also accessed before user-space or even
before kernel, then it makes sense in DT.

> 
>>> Good idea. I will introduce a module_param() then.
>>
>> Module params are usually discouraged
> 
> Why?

Because they don't scale with number of devices, are poorly documented
and have general limitations comparing to sysfs. You can ask Greg for
more details:

https://lore.kernel.org/all/2023071135-opt-choosing-51dd@gregkh/

> 
>> and it also does not allow any
>> runtime configuration. I think you need sysfs ABI.
> 
> There is already the sysfs ABI with module params
> 
> /sys/module/<name>/parameters/reboot_on_critical

So patch solved?

Best regards,
Krzysztof

