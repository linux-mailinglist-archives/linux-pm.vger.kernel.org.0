Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E557B552275
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiFTQoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbiFTQo3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 12:44:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8AA13D28
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 09:44:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n20so15480652ejz.10
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zOvxPYyfFpXuLlQu08wcT2FJT3L01kNfiiQIBNw39Hs=;
        b=LPl5Ty5Pxvqg1BSKntIkfTv2Vm4j7b0GOdectZe5G6pjr8YSBtae98r1Y0CLMQmpqG
         Y6yfZ+ref1sWs8GXbLtdWVbb7Y9q2lwRjFYy/7FxysjuCv9gUrsyGZQ3KYIZX2mRH00O
         btqRvlgtxqsXhshfdDKkQ1ZHM0asNYcu6O+BhQYGPs90IqYR0Ao8w2Lzr/OVHWGUOtU4
         30unwZRJO8CB9VyRPemhjPqOu/IUZ5hXJWtD4NIh5up5krnYgANO2MX8Eh7IwDYBUSd5
         kzcvrUvbeGMzEt81BYorI899zXHKATBUF1BZDLDl/YoOvXlCUxM4zQ2kxjzU8dI+CREO
         r+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zOvxPYyfFpXuLlQu08wcT2FJT3L01kNfiiQIBNw39Hs=;
        b=QxuDzUwdBZ3cOt86g0kh4I3gkuRnr9NEkxOPDi60SZjE5pbLXs+M0HTkhu1f/z8sVz
         8w9py7NRkxjU8CVG06cR6TXN1zit/mkPpRNBnDT+obyIpYwQjkRfx/WbcJ0ct4//CfXm
         tcdaRqE3sdUFjXmX5QhEc/a3LwaksUspzR/whxHBz6C4axEJ0gNBJHjqrBqklCRHUi7E
         XVD+KXaZBwE3+bWZ5tMTAsLX79qelRJQr0k/wtG3C6d7x4kRN0QWoMlt9rMc4ptNYiBK
         zNp/IrAsRlzqdl6qKwHZdNb+5ldcfT7kbjMElpYXn6D0qpoj5DYHunXozISyZH4UG8i6
         D9zg==
X-Gm-Message-State: AJIora+vC53dPoaN7zCuy6hok/bUt8NLk/paI8WHUINJrbG2Gbf4WDMJ
        BixqUxRVJYkybIWGqTc7n7ivpw==
X-Google-Smtp-Source: AGRyM1uEPgpX46LVFCkiINaElVOJSQ5K9oX9/OGgzP4xN+TVlIGYPiSReyQkDJdHkA0JtO22GW4d7Q==
X-Received: by 2002:a17:906:7786:b0:712:3c92:4335 with SMTP id s6-20020a170906778600b007123c924335mr21395593ejm.610.1655743465334;
        Mon, 20 Jun 2022 09:44:25 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b00704b196e59bsm6237746ejq.185.2022.06.20.09.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:44:24 -0700 (PDT)
Message-ID: <66ba39e3-5462-59c7-3831-20ba3ceed43b@linaro.org>
Date:   Mon, 20 Jun 2022 18:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        l.stach@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
 <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
 <20220620154810.GB23829@francesco-nb.int.toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620154810.GB23829@francesco-nb.int.toradex.com>
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

On 20/06/2022 17:48, Francesco Dolcini wrote:
> Hello Krzysztof,
> thanks for your comment, let me try to provide you some additional
> background to better understand this change.
> 
> On Fri, Jun 17, 2022 at 06:02:39PM -0700, Krzysztof Kozlowski wrote:
>> On 17/06/2022 00:08, Francesco Dolcini wrote:
>>> Move `trips` definition to `#/$defs/trips-base` and just reference it
>>> from the trips node. This allows to easily re-use this binding from
>>> another binding file.
>>>
>>> No functional changes expected.
>>
>> If you want to re-use trips, they should be rather moved to separate
>> YAML file...
> 
> Fine, this should not be a big deal to achieve. Let's agree on the rest
> first, however.
> 
>> but anyway this should not be done per-driver bindings, but
>> in more general way. Either the problem - using one DTS for different
>> temperature grades - looks generic or is wrong at the core. In the first
>> option, the generic bindings should be fixed. In the second case - using
>> same DTS for different HW is not correct approach and why only thermal
>> should be specific? I can imagine that cooling devices might have
>> different settings, regulator voltages for DVFS could be a bit different...
> 
> Let me try to explain the problem I am trying to solve here.
> 
> Currently the imx-thermal driver harcode the critical trip threshold,
> this trip point is read-only as it is considered a system property that
> should not be changed and it is set to a value that is less than the
> actual SoC maximum temperature. NO thermal_of driver used.
> 
> Because of that there are systems that cannot work on some valid
> temperature range.
> 
> We are currently looking at a solution that would be backward compatible
> with old device tree.
> 
> I proposed the following:
> 1- just increase the threshold to the actual max value allowed according
>    to the SoC thermal grade. 
> 
>    As easy as 
> 
> -	data->temp_critical = data->temp_max - (1000 * 5);
> +	data->temp_critical = data->temp_max;
>    
>    in drivers/thermal/imx_thermal.c 
> 
>    https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
> 
>    It was not considered good enough by Lucas since this is a overall
>    system design question, therefore should be configurable.
> 
> 2- make the critical trip write-able from userspace/sysfs.
> 
>    Daniel is against this since critical trip point is a system
>    property, not something the user should be allowed to change.
> 
> 3- kernel parameter: https://lore.kernel.org/all/20220516190001.147919-1-francesco.dolcini@toradex.com/
> 
>    Initially proposed by Daniel, but Marco did not like the idea.
> 
> 4- New device tree property, fsl,tempmon-critical-offset, ditched also
>    by Marco
> 
> 5- The current solution in this patch, with the existing trip points
>    that are hardcoded in the code exposed in the device tree as trips.

Thanks for the explanation, I see the problem.

> 
> Ideally one could just implement the imx6/7 thermal sensor reading and
> just make use of the thermal_of driver, however that would break
> compatibility with a lot of existing system ... to me this is just a
> no-go.

This I did not understand...  What is not implemented in thermal sensor
which would solve the issue? And why it cannot be implemented in
backwards compatible way?
Your change is also not backwards friendly, which means existing boards
(old DTS) will not receive the update.

> Adding only one set of thermal trip point in the dts (no thermal-grade
> specific set) could work in some specific scenario, however it does not
> work for me since I have the same dts files using different temperature
> grade SoC. I would need to update this in the firmware before starting
> Linux.

Usually the bootloader loads the overlay and this is recommended
approach to runtime tweaking DTB for some variant.

> 
> Krzysztof, what do you think? I would not mind to get back to one of
> the more simpler approach I proposed.

As I said, I see the problem, but I am not sure that solution is
correct. I can also rephrase the solution to a such one: "I want to
support iMX6 and iMX7 with one DTS, so I will embed all properties from
both DTS into one DTS and then during boot I will read soc-id register
and choose some subset of the properties"

No way...

I also brought in previous reply trouble with regulator voltages or some
other electric-properties. I don't want several duplicated properties
per different variants of the same SoC.

1. If the devices are fully compatible, use one DTS. If you can squeeze
different variants into the same DTS without any duplication so that
entire DTS is used 100% by both variants - sure no, problem, less code.

2. If the devices are in general compatible but have discoverable
differences, use one DTS, discover the differences and apply them
dynamically via driver (e.g. read the temperature offset from some
nvmem/OTP).

3. If the devices are partially the same but have differences, you can
use overlays for that differences. This is quite flexible and clean
solution as it also clearly documents the hardware in DTS and its overlays.

4. In all other options devices are different, so I expect different DTS.

We had similar cases already in the past - some SoC versions could work
on higher frequencies with higher voltages
(arch/arm/boot/dts/exynos4412-prime.dtsi). These variants identified as
exactly the same SoC as the earlier/slower one. You cannot use one DTS
for them. We have chosen different DTS.

For Samsung other case, same SoC comes in different bins with slightly
different voltages for CPU/memory. Same frequencies but different
voltages. This might be the closest to your problem. This was detectable
runtime, so we had one DTS and we adjusted the voltages based on static
tables in the driver (exynos5422-asv.c).

> Lucas, are you really that against the simple working solution I
> proposed initially [1]? I feel like I am running in circles ...

Yes, because it is not generic and skips other similar cases, like
regulator voltages or battery properties. I can easily imagine that next
week someone comes with duplicated opp tables, then duplicated voltages,
then duplicated CPU nodes and finally we have one DTS for imx6 and imx7
but everything is in multiple variants. :)
Also I am against because DTS describes one hardware, not multiple
different variants.

Best regards,
Krzysztof
