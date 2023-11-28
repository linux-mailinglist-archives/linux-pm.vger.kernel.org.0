Return-Path: <linux-pm+bounces-348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4E7FB556
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 10:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B511C21021
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BF3DB8D;
	Tue, 28 Nov 2023 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPWF35Wg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7397E10DF
	for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 01:13:52 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so709382866b.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701162831; x=1701767631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKyWhsE4YmkQihUdNxWVXRUHnVaAIsib0Sm+z2bLT/w=;
        b=bPWF35WgoPxr0x+Ilmybl2Ax4FYSek9e6CKJ/EoPVgsuZM2iGZytm0Kk5cho4+zQvg
         Qf/vAeX6QOpRDe7PxONuHYdqztmVAD0NMb09lyoqUY8OtPIniNbVFx3Kb4aKLScPuizf
         G/wWdshFaJOiR+aoHmC1KGGla7Iij1q53TNnb+9B3cVqC8RW/6ZTcHKYJN02b3CYfppL
         wxMP4Ms5wRNBSijj9ahPEMiEhN2enY/lH70twvoposnozhN9hOFBKEzDpRBWyuL1QigK
         ssywcsDmKRGr/VGYMP7+HtZPMQr+mrz1ka6mJk9+AbWX7lYzZ+32gckLpe9np0ValLwU
         qPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701162831; x=1701767631;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKyWhsE4YmkQihUdNxWVXRUHnVaAIsib0Sm+z2bLT/w=;
        b=JMOlVij6bUQGKAXH8JEEsMZQTpPaJ7GeA7twmNlLZVQT/J6BozYLcwosYv0HtW3ehs
         CFgQO4Yxiz6+CA4KgIf3g/7BPSy2eBuhc/CgOA5tRRh0pVHyp0c9Wq4AoHd6SV8nVOj8
         95AZU2xcsI/rUqpOb7OXo3rREdHEOTebLecjtniQWIbt2Sc+3hjv0EcucLZBo0D9koch
         SLVIaJFn98IiPItmfbITLgzLKZNn60trit8jJ0l9XBRotqyslqE+NXlGerBkEQbN2rvt
         Y1HIH/paN2qRZlPZfL6FRmeI3vum6NlkR3atBNh/FLGxu6JVelG4yFcfafs7PwvypMBc
         U1Vw==
X-Gm-Message-State: AOJu0YzSqtITK0Mlw+tcrSutJj+z9JPsuFTMu3yYxDFyOhCcPOcAz3f1
	Pmf0C7leDQu/NqzbeCVEeZx6iw==
X-Google-Smtp-Source: AGHT+IGjXv3UdHBG2YMRvepgbPhAMEX50VONOl/YY+7Ok/qqTsHdTylMX86Xj/xQS55nV8HJ/6YnFA==
X-Received: by 2002:a17:906:39c9:b0:9fe:5d39:41c6 with SMTP id i9-20020a17090639c900b009fe5d3941c6mr10411839eje.51.1701162830874;
        Tue, 28 Nov 2023 01:13:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b009de11bcbbcasm6667234ejb.175.2023.11.28.01.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:13:50 -0800 (PST)
Message-ID: <6356d9d1-2110-4195-805c-531bcdbeeb1f@linaro.org>
Date: Tue, 28 Nov 2023 10:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
Content-Language: en-US
To: wens@csie.org
Cc: Andre Przywara <andre.przywara@arm.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20231128005849.19044-1-andre.przywara@arm.com>
 <20231128005849.19044-5-andre.przywara@arm.com>
 <ddceb30f-1778-4312-af91-97813fe3c6fb@linaro.org>
 <CAGb2v66YpYBS78C7H-O3zef2NTs+7=ec3A7jrZ+DxjYEyBmWxQ@mail.gmail.com>
 <9045f837-3370-46e9-8631-7464c796d643@linaro.org>
 <CAGb2v66PFNz++d3_5smYBL_BRirYhu4SvX0j36y0JsmXHT33OQ@mail.gmail.com>
 <CAGb2v66L+sW-GQ4HvR-rXsG=JTi6vKt-9P-y1=vPqh0e5gKiOg@mail.gmail.com>
 <CAGb2v64Om8xqpgacbXV9Qf0tbV5qDcSOs7gW-uqSh2HD3Hhu3A@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGb2v64Om8xqpgacbXV9Qf0tbV5qDcSOs7gW-uqSh2HD3Hhu3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/11/2023 10:09, Chen-Yu Tsai wrote:
> On Tue, Nov 28, 2023 at 5:02 PM Chen-Yu Tsai <wens@csie.org> wrote:
>>
>> On Tue, Nov 28, 2023 at 4:59 PM Chen-Yu Tsai <wens@csie.org> wrote:
>>>
>>> On Tue, Nov 28, 2023 at 4:30 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 28/11/2023 08:50, Chen-Yu Tsai wrote:
>>>>> On Tue, Nov 28, 2023 at 3:43 PM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 28/11/2023 01:58, Andre Przywara wrote:
>>>>>>>
>>>>>>> +static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node *node)
>>>>>>> +{
>>>>>>> +     struct device_node *syscon_node;
>>>>>>> +     struct platform_device *syscon_pdev;
>>>>>>> +     struct regmap *regmap = NULL;
>>>>>>> +
>>>>>>> +     syscon_node = of_parse_phandle(node, "syscon", 0);
>>>>>>
>>>>>> Nope. For the 100th time, this cannot be generic.
>>>>>>
>>>>>>> +     if (!syscon_node)
>>>>>>> +             return ERR_PTR(-ENODEV);
>>>>>>> +
>>>>>>> +     syscon_pdev = of_find_device_by_node(syscon_node);
>>>>>>> +     if (!syscon_pdev) {
>>>>>>> +             /* platform device might not be probed yet */
>>>>>>> +             regmap = ERR_PTR(-EPROBE_DEFER);
>>>>>>> +             goto out_put_node;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     /* If no regmap is found then the other device driver is at fault */
>>>>>>> +     regmap = dev_get_regmap(&syscon_pdev->dev, NULL);
>>>>>>> +     if (!regmap)
>>>>>>> +             regmap = ERR_PTR(-EINVAL);
>>>>>>
>>>>>> Aren't you open-coding existing API to get regmap from syscon?
>>>>>
>>>>> Not really. This is to get a regmap exported by the device. Syscon's regmap
>>>>> is not tied to the device at all.
>>>>
>>>> I am talking about open-coding existing API. Look at syscon.h.
>>>
>>> The underlying implementation is different.
>>>
>>> syscon maintains its own mapping of device nodes to regmaps, and creates
>>> regmaps when none exist. The regmap is not tied to any struct device.
>>> syscon basically exists outside of the driver model and one has no control
>>> over what is exposed because it is meant for blocks that are a collection
>>> of random stuff.
>>
>> My bad. I failed to realize there is a platform device driver for syscon,
>> in addition to the existing "no struct device" implementation.
> 
> Actually that doesn't do anything on DT platforms as of commit bdb0066df96e
> ("mfd: syscon: Decouple syscon interface from platform devices"). All the
> regmaps are, as I previously stated, not tied to any struct device.


Sorry, it's your third reply, so I don't know what exactly you want to
discuss.

This code open-codes existing API. Fix it.

> 
>>> Here the provider device registers the (limited) regmap it wants to provide,
>>> tying the new regmap to itself. The consumer gets it via the dev_get_regmap()
>>> call. The provider has a main function and isn't exposing that part of its
>>> register map to the outside; only the random bits that were stuffed in are.
>>>
>>>>> With this scheme a device to could export just enough registers for the
>>>>> consumer to use, instead of the whole address range.
>>>>>
>>>>> We do this in the R40 clock controller as well, which has some bits that
>>>>> tweak the ethernet controllers RGMII delay...
>>>>
>>>> Not related.
>>>
>>> Related as in that is possibly what this code was based on, commit
>>> 49a06cae6e7c ("net: stmmac: dwmac-sun8i: Allow getting syscon regmap
>>> from external device").


How duplicating a code is related to R40 controller? Duplicating code is
generic problem, not specific and not related to your hardware.

Best regards,
Krzysztof


