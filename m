Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29C45D0A2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbhKXXAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 18:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbhKXW77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 17:59:59 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E2C061574;
        Wed, 24 Nov 2021 14:56:49 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q25so8543496oiw.0;
        Wed, 24 Nov 2021 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ym7SSXFOXHKmdp9dwzO3oZrUWy1H5UXNNo/RbDIeXMY=;
        b=Atnf9WB3EextNwSurC2CpGwZ33hreMciie6Ui2eUsCDi4uNnkilRWFAoEsvYmzfRvc
         nq0RnhXW6wvcbvTk59Y7tw5fozOCqfq93vAHpEaz/44sjznu5axREXWi314clCMhhu+1
         W6pHoXLr2AFw1oDjwJKAB/HgFlmE5lUhs8dpcJakiYrcy1I4nhz/gSBCT9ZiSnlLkIXj
         3gW+mSHJO1eyfCy27IJqQA+P1LuCAHAy2XvS2RTD9HzjZefT6wyDLRf6Nawx+B+IbBLL
         h+TP4LZ13YLz8/rPfDrl37b9UcbWvjvHX8wflnVshWLq5BlXTiNwtUhkxdf39GGBLxjA
         ZOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ym7SSXFOXHKmdp9dwzO3oZrUWy1H5UXNNo/RbDIeXMY=;
        b=TGesu/g0HvUVD2xjhRu/xB9tpOSugo5w7P8zMe6gyPAbPATD23m1C1ji467QaxEDt+
         jVX23km/8Yy2pp39mHJRIYFlkkOT8+zxqm2doCFYsx31XF6CU8eUBhERh+i5GM0/JBm6
         TtwrqSBFG5UuoG9HN9z7FX7bkPUsqJ6FG5RqzUcZgt2Nzuok7GwymHVCNb+kjA9cmnh1
         NjnQO/9YeyFK+EdG2bj3YYIZLFTm4+pJsNy0A3PTl568V0E7pnl5KvwtqneOXXoC/Fe3
         1XTJmKO1b0ffpiCOxlVnDfG+sbFbEyge1PxcS53ypt054ulIY9+p5luLnNXfUSTkcZkV
         nueA==
X-Gm-Message-State: AOAM530QH+t1ycdE/l3ZTI9i8SpTqHcpLRdjTlD2lkWxnQjUfcI1WX1y
        WBA29lAFVoc1ehFEldMwxl0=
X-Google-Smtp-Source: ABdhPJxBkN1wbfXoeBZddsjP80A6XITDn32egYUrQYITIiWg1sGTW7JQeQCfyvrxbgz+d3bIYgPnhg==
X-Received: by 2002:aca:2205:: with SMTP id b5mr10172857oic.177.1637794609144;
        Wed, 24 Nov 2021 14:56:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r26sm206143otn.15.2021.11.24.14.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 14:56:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-4-alistair@alistair23.me>
 <20211116000634.767dcdc0@aktux>
 <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
 <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
 <20211124203532.30577a50@aktux>
 <a2fd5089-14a5-e36e-63ce-d73be3cd99a2@roeck-us.net>
 <20211124235041.2840a770@aktux>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <39b586c1-aba7-4d82-2c96-9f4ca9db4f11@roeck-us.net>
Date:   Wed, 24 Nov 2021 14:56:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124235041.2840a770@aktux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/24/21 2:50 PM, Andreas Kemnade wrote:
> On Wed, 24 Nov 2021 12:09:44 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 11/24/21 11:35 AM, Andreas Kemnade wrote:
>>> Hi,
>>>
>>> On Tue, 23 Nov 2021 07:39:05 -0800
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>> On 11/23/21 4:14 AM, Alistair Francis wrote:
>>>>> On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> this all creates a lot of question marks...
>>>>>> One of my main question is whether sy7636a = sy7636 (at least the
>>>>>> driver in the kobo vendor kernels does not have the "A" at the end,
>>>>>> whic does not necessarily mean a difference).
>>>>>>
>>>>>> https://www.silergy.com/products/panel_pmic
>>>>>> lists only a SY7636ARMC, so chances are good that the letters were just
>>>>>> stripped away by the driver developers. Printing on chip package is
>>>>>> cryptic so it is not that helpful. It is just "BWNBDA"
>>>>>
>>>>> I don't have a definite answer for you. But I think it's sy7636a
>>>>>
>>>>> The page you linked to above lists SY7636ARMC as well as SY7627RMC,
>>>>> SY7570RMC. That makes me think that the RMC is a generic suffix and
>>>>> this actual IC is the SY7636A.
>>>>>       
>>>>
>>>> Almost all chips have an ordering suffix, indicating things like
>>>> temperature range or packaging. The datasheet says:
>>>>   
>>> yes, they have. The only question is where it starts. So did you find a
>>> public datasheet which you can chere
>>>    
>>
>> I registered an account on the Silergy web site, and I was subsequently
>> able to download the datasheet. The document has a "confidential"
>> watermark, so I can not share it. You should be able to register an
>> account and download it yourself, though.
>>
> ok, did so.
> 
>>>> Ordering Information
>>>> SY7636 □(□□)□
>>>>                | Temperature Code (C)
>>>>             | Package Code (RM)
>>>>           | Optional Spec Code (A)
>>>>
>>>> The datasheet otherwise refers to the chip as SY7636A.
>>>>   
>>> so there is no indication of something like this where the A really
>>> makes a difference:
>>>    
>>
>> I may be missing it, but I see nothing in the datasheet that would indicate
>> that or if the "A" has any relevance other than "Optional Spec Code",
>> and I do not see an explanation for that term either.
> 
> well things seems to match with things I got from analysing the kobo
> sources. So at least the thing in the Kobo Libra H2O seems to be that
> one described in the datasheet, so we can have one sy7636a driver for
> it.
> 
> BTW: If I search for a sy7636 on aliexpress I get some SO-8 lithium
> charger ICs.
> 

The datasheet says "PMIC for Electronic Paper Display".

Guenter
