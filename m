Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3770524FB0E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgHXKJk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXKJj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:09:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BCFC061573;
        Mon, 24 Aug 2020 03:09:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j15so4152179lfg.7;
        Mon, 24 Aug 2020 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TnwDlneP2UZtVlEQhysmfSvHezCSDrN8G2LhQEcQugo=;
        b=SgL8BaC0EUT6PlHtbx3519wL1zJHhA2Ar8pUf3ZGn4A7sva56+Ipnq2ofzertBoj+u
         Y+pL64XuQGbwdXP+4ITktd9FfsR9eCwMYFLqfW2WeKRGS/2GWy7vqvStf3HIGFiIOA5G
         aaKaCfsdI3mWBt6OG0+ReDa9CCkkM1I0Xfl209ZXeDbi545qD9Onfyr2gt0avLPD4vQP
         6vSjcfeBxElv33ZtPWE/kCQP3HEaVXNBwjoG0iScpLhBj8B2xnGm2eiuG09P+C0xCR0J
         JqkEdUJN7UvczbpWIuqImq+LlzIkMYSgAJCYyXN15lxSahYTsegMsWC1l4ojSoirymQb
         llwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnwDlneP2UZtVlEQhysmfSvHezCSDrN8G2LhQEcQugo=;
        b=qTnOSAd5KX3GOAIAiYY6pTdo/ZdBLLZzP1o2elBfCM1rGUiXHIpar8nBdTpGk+en5J
         XKYzBjBK3mtLOj9ZFyTbautHTcDMpaMhAZMR6oBBISqV+X5YraErB3CZs7sWmfFKlxfP
         MJp6d/CRRCHbv17HvHDdmETYt7itURhcJ1T95IkOLNqUizb3HONgX1tG40qG8SZ4130F
         gEzztrtJ/V0vEg2opPuA3jaBHExOCmg0N28AdQr44aAahZmGO3oqa4tYWdQ2IhnQ6yMS
         WunMVZY+rSspJPeuCWx27fOIz/pvoS1rg2GQO3Y6A0wsU3ZdrVEFAB1cOLW94R56/pO4
         UOBA==
X-Gm-Message-State: AOAM532MdG3kotaEtZG6jA+HUjXLGhiEUte1IfkOOkVAHEyAeWFsDY87
        pmNmadi0PakJLO7tsYwOzn6lbdEejfM=
X-Google-Smtp-Source: ABdhPJw7h6vKI7v6J6NoEpktTMZ1qqxY6ab6GBroVJYg+Zh7AXbqlRrMtomXshEU3F1rtiWjoCfYcA==
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr2249755lff.164.1598263776681;
        Mon, 24 Aug 2020 03:09:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id z3sm2082872ljz.109.2020.08.24.03.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:09:35 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for
 KB930 and Acer A500
To:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-5-digetx@gmail.com>
 <20200823182050.GA210632@demiurge.local>
 <b91b96d2-89e1-feb7-a4d0-6fd19a173ab4@gmail.com>
 <20200823211629.GA240555@demiurge.local>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c536557c-de42-d6bd-890c-ef71ca0e3116@gmail.com>
Date:   Mon, 24 Aug 2020 13:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823211629.GA240555@demiurge.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.08.2020 00:16, Lubomir Rintel пишет:
> Hello,
> 
> On Sun, Aug 23, 2020 at 10:31:36PM +0300, Dmitry Osipenko wrote:
>> 23.08.2020 21:20, Lubomir Rintel пишет:
>>> On Sun, Aug 23, 2020 at 05:08:44PM +0300, Dmitry Osipenko wrote:
>>>> The ENE KB930 hardware is compatible with KB3930.
>>>>
>>>> Acer A500 Iconia Tab is Android tablet device, it has KB930 controller
>>>> that is running firmware specifically customized for the needs of the
>>>> Acer A500 hardware. This means that firmware interface isn't re-usable
>>>> by other non-Acer devices. Some akin models of Acer tablets should be
>>>> able to re-use the FW interface of A500 model, like A200 for example.
>>>>
>>>> This patch adds the new compatibles to the binding.
>>>
>>> I've responded to patch 5/6 with what should've been said here [1].
>>> Sorry for the confusion.
>>>
>>> In any case please consider adding a new binding file instead of
>>> modifying the kb3930 binding doc. It would also remove a dependency on
>>> my patch set which should have slipped out of maintainers' radar.
>>>
>>> [1] https://lore.kernel.org/lkml/20200823180041.GB209852@demiurge.local/
>>
>> Hello, Lubomir! I was doing some research about the differences of
>> KB3930 and KB930 before created this patch and my understanding is that
>> the controllers are mostly identical. I've seen posts from people who
>> replaced KB3930 with KB930 (and vice versa) on various notebooks and it
>> worked, although not always.
>>
>> It's a very common practice to re-use binding in a case of a sibling
>> hardware. Do you know what are the exact differences between KB3930 and
>> KB930 which could justify having separate bindings?
>>
>> The firmware implementation varies a lot from device to device,
> 
> It sometimes does. The ENE's downstream driver suggests there are parts
> that run more-or-less stock firmware that are comatible with each other.
> That is why I grabbed the generic kb3930 name.
> 
>> and
>> thus, each device needs to have its own driver in order to talk to the
>> firmware, but hardware description (i.e. DT binding) should be common
>> for all devices.
> 
> Note the DT is not the hardware description. It's the description of how
> the hardware presents itself, from the software's perspective. As far as
> that is concerned, the devices don't seem to have anything in common at
> all (other than the bus address). The fact that you need an entirely
> different driver implies this.
> 
> This would be the case even if the A500 EC was based directly on a KB3930.
> 
> A good reason to keep bindings for different yet somewhat similar devices in
> a single document is to avoid duplication. Yet here there's very little to
> share here. If you've done your bindings correctly, you'd need to
> conditionalize the monitored-battery and power-supplies properties for
> acer,a500-iconia-ec, complicating the binding too much. It makes more
> sense to just add a new document.

Alright, I don't mind to separate the bindings. Although, before doing
that, I'd want to get opinion from the device-tree experts, i.e. from
Rob Herring :)

Rob, will it be fine to have separate bindings for each firmware version
of the ENE controller given that firmware is individual for every device
and given that FW has no compatibility with other devices?
