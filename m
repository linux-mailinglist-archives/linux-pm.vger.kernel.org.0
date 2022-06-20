Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4FA552278
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiFTQp6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiFTQpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 12:45:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB713D2C
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 09:45:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h23so22232206ejj.12
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N//kAFyyDrmuL/icOLW9HghcGryQyomtQjF80YO7sK8=;
        b=UYUfNWFZ3gRcP/KIt0ZSIkdDiaRXa9wt77LBZ2b+nvd6n2M8F+KRDlG/xcGFhWUwRl
         Mc4Xhp2DgjwL26Fj/kWXNS9kmkkkfXHhOWigpfwEn8kRCMJ5g2q5mnlI+ZBOjFDHf0NR
         R/q0UWEcNpmojfzIMN3a3RYNfEGIsiOD7mHV41selDn2KV2aqaevkfvllFu3Cy1FFBHX
         YzfSa7SSYiAID/LYzc/d8V2CRdRoX/eL10AC+DCv49U+9NLpeXFdqpcx85uQxEzQuWId
         ewJdzXRHtLVCYABg/i85vXKzH+GrO0UE63TolN81K9Aw/ao8Y31UfP07e3NtABqNaDsK
         Pifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N//kAFyyDrmuL/icOLW9HghcGryQyomtQjF80YO7sK8=;
        b=J+qFYE4uXVQU0wxY+4jNbmyvi3s3nV3hTFOooUb1cMpXM4POAgjV8NcZlPz6MwbtE8
         V9bYM67HtSDzzIeZiWrQHKhJDD9RQ+BfYxxAcGZo3vV/S3feDCC1Ns65QduKTh+0QbMr
         BL+Fxj81Eg9CCVtqjEkZnCRHDy6gK2t2GHW5vk7pU0N3SMcUp2aTnif/uJkEBI7dXGYM
         7bplMZaPnfUwxgc+pCblPWYaB5LV4OSyM8mE9SnH453QRZmg4pKU+0KUz7xHANeJvyJS
         JG/eZd+4pdVTQ4vGDQjt62WJaF4kxV+GgujDsxtphxbSpov7mC1FvPvEbmUZ/AqdIH3D
         VhsQ==
X-Gm-Message-State: AJIora+GCkPMTp+2a3iuv2j7FwBow5hhgnM4383JqLvmrHv0TEqJKOTr
        jDGgFjoW563nrUqI/L2JKmgjbg==
X-Google-Smtp-Source: AGRyM1s8MqQ7R4sGcfpmVQzWbcSYwx4FieK8Nu8wgIxw0sXnXMAftLZOrih19pc5r2Vz3+f60wzHCg==
X-Received: by 2002:a17:906:6a27:b0:708:1282:cbe9 with SMTP id qw39-20020a1709066a2700b007081282cbe9mr22578720ejc.186.1655743543351;
        Mon, 20 Jun 2022 09:45:43 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm7561436edq.63.2022.06.20.09.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:45:42 -0700 (PDT)
Message-ID: <9307a12a-4ccc-8349-9c8a-79b4bf66a190@linaro.org>
Date:   Mon, 20 Jun 2022 18:45:41 +0200
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
> 
> 
> Ideally one could just implement the imx6/7 thermal sensor reading and
> just make use of the thermal_of driver, however that would break
> compatibility with a lot of existing system ... to me this is just a
> no-go.
> 
> Adding only one set of thermal trip point in the dts (no thermal-grade
> specific set) could work in some specific scenario, however it does not
> work for me since I have the same dts files using different temperature
> grade SoC. I would need to update this in the firmware before starting
> Linux.
> 
> Krzysztof, what do you think? I would not mind to get back to one of
> the more simpler approach I proposed.
> 
> Lucas, are you really that against the simple working solution I
> proposed initially [1]? I feel like I am running in circles ...

BTW, the link [1] was missing in your email, so I understood that you
meant this patchset. If [1] refers to something else, then we need to
discuss that something else.

Best regards,
Krzysztof
