Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0567A08C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 18:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjAXRzY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 12:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjAXRzX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 12:55:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A72EFAD
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:55:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so11560589wmc.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdCDxw9M+4W0xFySyeUJf90dqwb2v7zc2Ewn7qbXfQc=;
        b=nTV6D3WxyzREC9gAUBj88qhd6dsVubBwo+bua+KcqQsi8SCAXCmgRE6bDc1Z2+f7Zd
         SIqicVlq3EwfcpB94fJJFj6QTA4hpd2Jcoo2bM5rPUKJ2JrJ+83qH2mdkkn9KgF1lZxV
         Miqwkx3iUyDPH4bXFO+pJsYQOYHvoXkXxiBOhUVnFUtPhcwNkIS/EipwFcSUN19P849A
         E5XbPyCcrW+5BMoY4L+mXW63eC1PyK6cSUb/yo+MrU3IXz9+NidcsaJXDRnnXpssnlUr
         e2ojOuSj3BuTojAhZoql+/SptDHxKhkCeUhrfMghNpytbFbqrMLWs14AzMkYTxtig9Ux
         Q3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdCDxw9M+4W0xFySyeUJf90dqwb2v7zc2Ewn7qbXfQc=;
        b=vZZjR2BH3FHLNBOml3nhnR/OZx9YQGY+CpwtUHog8FcIVW4ry/wpKZ6K0bEZ5XTMrv
         RHlvhYG4q6ugRugxYdaJm4pNzXzNlxdKYOPRFTP8NNBJBwqyeNXP6jjtvg0AMjVoj00o
         RH/HZUpSUf7YHv2Ysb1/yRpPjjlcJ5ntW6Z9HidbGWXJ53ynOys+HpljX313H2DE1qEQ
         nd/pm9YQbydvcbdUX0HwbokOZRJl+dBRjtqnY0hE//O5yHy4kBhrtxBEtYGM+tTyxLsK
         Bei1r0UBqikmPEswlIyMCOfDGvmnjpan2URg6II8pwq5vezRq7nYs16ELVS09+s0a47u
         s1Iw==
X-Gm-Message-State: AFqh2kqDVN/WauQU1LgpT7ij24gI0D2vqimOmIlaCzrEXv/ADiG92Ymr
        D/SVoc/MpgyHJaubQsKal9poHQ==
X-Google-Smtp-Source: AMrXdXu5BjwW7IFLRR4MJylMvG6n0IIZ5Qgl14oQlDbA4IA8jBRxv1Dcpy/srHrBN7IZmO+kRvOodw==
X-Received: by 2002:a05:600c:600e:b0:3c6:e62e:2e74 with SMTP id az14-20020a05600c600e00b003c6e62e2e74mr25728996wmb.15.1674582921045;
        Tue, 24 Jan 2023 09:55:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm19579059wmg.27.2023.01.24.09.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:55:20 -0800 (PST)
Message-ID: <c1fad818-1858-2e81-84fd-03cfb54d8938@linaro.org>
Date:   Tue, 24 Jan 2023 18:55:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
 <20221018-up-i350-thermal-bringup-v7-4-ebf08ff2eddb@baylibre.com>
 <4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org>
 <COTTJX635TNF.1WL2TEZN7VW9O@amjad-ThinkPad-T490>
 <adfe41f7-00e5-876b-7803-3127919fba13@linaro.org>
 <COUMF3IZ9Y63.LA3KFHJSUZIC@amjad-ThinkPad-T490>
 <0644aede-c281-3919-50e0-4466f6587d81@linaro.org>
 <187b0fe1-1f14-d8b8-c827-1e824da0b1d3@baylibre.com>
 <d3daece0-ed23-fae7-9bc8-c6e53b84e8e7@baylibre.com>
 <9f9547a2-69dd-f91d-c587-289156bf9d55@linaro.org>
 <2950b824-ad2f-2579-a956-a03d157453eb@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2950b824-ad2f-2579-a956-a03d157453eb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/01/2023 18:46, Amjad Ouled-Ameur wrote:
> 
> On 1/24/23 17:54, Daniel Lezcano wrote:
>>
>> Hi Amjad,
>>
>> On 24/01/2023 11:08, Amjad Ouled-Ameur wrote:
>>
>> [ ... ]
>>
>>>>>
>>>>> IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 2Bigs, 
>>>>> 1 x 4 Little, right ?
>>>>
>>>> MT8365 SoC has 4 x A53 CPUs. The SoC has 4 thermal zones per sensor. 
>>>> Thermal zone 0 corresponds
>>>>
>>>> to all 4 x A53 CPUs, the other thermal zones (1, 2 and 3) has 
>>>> nothing to do with CPUs. The cooling device type
>>>>
>>>> used for CPUs is passive. FYI, thermal zones 1, 2 and 3 are present 
>>>> in the SoC for debug-purpose only, they are not supposed
>>>>
>>>> to be used for production.
>>>>
>>> After reconsidering the fact that zones 1, 2 and 3 are only used for 
>>> dev/debug, it might be best to avo >
>>> aggregation as you suggested, and keep only support for zone 0 in 
>>> this driver. Thus I suggest I send a V8
>>>
>>> where I keep only below fixes for this patch if that's okay with you:
>>>
>>> - Define "raw_to_mcelsius" function pointer for "struct 
>>> thermal_bank_cfg".
>>>
>>> - Fix "mtk_thermal" variable in mtk_read_temp().
>>>
>>> - Set "mt->raw_to_mcelsius" in probe().
>>>
>>>
>>> For zones 1, 2 and 3 we can later add a different driver specific for 
>>> dev/debug to probe them to
>>>
>>> avoid confusion.
>>
>> You can add them in the driver and in the device tree, but just add 
>> the cooling device for the thermal zone 0.
> 
> Thermal zone 0 uses CPU{0..3} for passive cooling, in this case we 
> should register cooling device with
> 
> cpufreq_cooling_register() for each CPU right ?

No, the OF code device tree does already that. You just have to register 
the different thermal zones.

Do you have a pointer to a device tree for this board and the thermal 
setup ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

