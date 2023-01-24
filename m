Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4167A05F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjAXRqb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 12:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjAXRqb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 12:46:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA34670D
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:46:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so11568067wmq.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/v2GAT/gW1z+AQQeKDDFE3wRS4Dyi8jFMlO2BJzi6HU=;
        b=A0a6WgFqz7DrQif4g1HqvElyktI4Z/cY5HAWnoBk2ke9Z1JMP1cfOqs+TAujzCc3gh
         eOl4ID+MHKyx4Gv1wn67rTNUCNdD43nOL4C5DPt6wvA2eB7xKKO0nS68WlKKlvApVNDC
         RPvVXjVtJW8iPjdtKOmL8Y8PlUaCEx4zjxtZf7Yp/3QcbWnTVCQCUy/W+j/fvb1XpPpV
         TrT09I6N0fPik30/a4R44afvDeA3zLyf3VPkdMujyvMiLFf++XTotE42ymERA+feMT5z
         RtiJdRHsSTuM+xE5kUAH3bUo9yrBt5zkS5JN3xQwjmE/i5Fs/EPq+MrS4PW/D+JuZ4g3
         W85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/v2GAT/gW1z+AQQeKDDFE3wRS4Dyi8jFMlO2BJzi6HU=;
        b=I84DdthH1Y5ViA7+0gTbfV1gZXFTGXCeE982i8K/lmnSdNYvE/jwVyYBDN1QGew9/R
         OOjzKmJhyM/DnEqQ6m/9KdnvgLN6SdLRKFgm/nBMbVB7JmZWf/8lkjrh6HMJOnLvcaSW
         ypcn1lM127YpXGWP3X2Pv2EQyl1TvZx6dViyEGkLbGUAzMycA9Ur9u2f67EjvSSFsthN
         v8EXav2WWMbZ1MIfuPRBtqWwst0oYxqiby/Er1PJDOuVLcDmvHvdi7o4qeFKq5nrj76l
         StjW0y5a1EnoDhpdEo6n1Kc9d3i486WqGCEb3UJrUH2VRIi7xZIZcOmawFWEAkStRZV7
         g7Yg==
X-Gm-Message-State: AFqh2kr4kko3+VwD8e/RNXYg7QQwFKMxu7HWegVLylxFaq4NS8ikXA8Y
        8v2sxD9LTdnClXIbnaegqUmrkA==
X-Google-Smtp-Source: AMrXdXuFSiF40FFxyHPG8XgZAakZ5Xxa9nWm74fz85CKfHOnpPxRnrajry8SoKbxN4RuSUj3gZi6cw==
X-Received: by 2002:a05:600c:1d10:b0:3d3:58d1:2588 with SMTP id l16-20020a05600c1d1000b003d358d12588mr25731882wms.41.1674582387832;
        Tue, 24 Jan 2023 09:46:27 -0800 (PST)
Received: from [192.168.0.20] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c091500b003d1de805de5sm2450567wmp.16.2023.01.24.09.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:46:27 -0800 (PST)
Message-ID: <2950b824-ad2f-2579-a956-a03d157453eb@baylibre.com>
Date:   Tue, 24 Jan 2023 18:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <9f9547a2-69dd-f91d-c587-289156bf9d55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 1/24/23 17:54, Daniel Lezcano wrote:
>
> Hi Amjad,
>
> On 24/01/2023 11:08, Amjad Ouled-Ameur wrote:
>
> [ ... ]
>
>>>>
>>>> IIUC, there is a sensor per couple of cores. 1 x 2Bigs, 1 x 2Bigs, 1 x 4 Little, right ?
>>>
>>> MT8365 SoC has 4 x A53 CPUs. The SoC has 4 thermal zones per sensor. Thermal zone 0 corresponds
>>>
>>> to all 4 x A53 CPUs, the other thermal zones (1, 2 and 3) has nothing to do with CPUs. The cooling device type
>>>
>>> used for CPUs is passive. FYI, thermal zones 1, 2 and 3 are present in the SoC for debug-purpose only, they are not supposed
>>>
>>> to be used for production.
>>>
>> After reconsidering the fact that zones 1, 2 and 3 are only used for dev/debug, it might be best to avo >
>> aggregation as you suggested, and keep only support for zone 0 in this driver. Thus I suggest I send a V8
>>
>> where I keep only below fixes for this patch if that's okay with you:
>>
>> - Define "raw_to_mcelsius" function pointer for "struct thermal_bank_cfg".
>>
>> - Fix "mtk_thermal" variable in mtk_read_temp().
>>
>> - Set "mt->raw_to_mcelsius" in probe().
>>
>>
>> For zones 1, 2 and 3 we can later add a different driver specific for dev/debug to probe them to
>>
>> avoid confusion.
>
> You can add them in the driver and in the device tree, but just add the cooling device for the thermal zone 0.

Thermal zone 0 uses CPU{0..3} for passive cooling, in this case we should register cooling device with

cpufreq_cooling_register() for each CPU right ?

>
>
