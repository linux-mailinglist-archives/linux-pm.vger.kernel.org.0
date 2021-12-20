Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9547AB2E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Dec 2021 15:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhLTOTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Dec 2021 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhLTOTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Dec 2021 09:19:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02896C06173F
        for <linux-pm@vger.kernel.org>; Mon, 20 Dec 2021 06:19:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso7452095wmd.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Dec 2021 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sc+7jY7u7JL3gjoK1ONPiTQNSX0Y662aLa89J2Uhm6Q=;
        b=GvOUtgsXbwOppDo6i/VTH9j6pgkj/GVh3MaAqceDl2RuErlaE4xIDrswa9hWC4L4VW
         JQwWeZC5Zyq3r0NgTx81m42ml/LxAly2FS4wFq7EwzA7xQIUsiO49DbcNvp4oqIzWu1J
         iScxmgw3qRri1rD1Mt9azhAcafL5hsdgLNS1s9cp8rPiNiVxWHWYYZAVFX6tD6mybkHL
         tdsfOSx3VZfVvQakWy/TeWnuqCNl3qGposFCsvBCbthGTPWwg7iHZ6ODTnInbh5auj38
         9X3O2RZhDXiwJxSNihYf4rry41bBF4zWSzNbwPe5XomCu0NcQmhZNfbaYHcNtRgyLguX
         rH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sc+7jY7u7JL3gjoK1ONPiTQNSX0Y662aLa89J2Uhm6Q=;
        b=m8RkNWZX0G4zB8V8F4gUAFIpRQCe2K5Jsqpj0BBC2CHXgpgITOHghHcJ2HNfuSSYAi
         RlFrI5KR5br/Xj4o2EYg7QgQgMfBP2svh4cIbuDTvx5gZU2q26cB4Yy8ucrmb6aOCeFU
         5to2ONbrYVSiap6PwbH/n3lj54FwH20LvRNqNNE3lDvKNrk0GFLCjmqCv6ZriPI5t6d/
         BVYjBdrezyPhXMTO6/g6CZfzTye2Nftd7/YtSudg9mRFWcoMo9ebQrGUqvMvFHEGguxJ
         I4CdVaSLD5xi/e1eVPMR+0aVntmH/yr2A0ipZN3NfN+pNoyfc+nu5VOvWuU+/lU/vKvx
         ko1g==
X-Gm-Message-State: AOAM533UZ8rwfA9SrEeAK/I53UljUxb7B9go3BcldPdpSJ4Ie9KcRYF7
        7edMkJuR6gGJ4ugOzEiSRXt01g==
X-Google-Smtp-Source: ABdhPJy/8Z6x62OBpzx2JyHeAdaUAF/0h3nRSDXoHeSzSV1zfT+Pj6SrVxraZs8AbL0VO89RZcJxkg==
X-Received: by 2002:a05:600c:a0e:: with SMTP id z14mr7100429wmp.43.1640009955498;
        Mon, 20 Dec 2021 06:19:15 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ac6:da31:b84c:183? ([2a01:e34:ed2f:f020:ac6:da31:b84c:183])
        by smtp.googlemail.com with ESMTPSA id p13sm4039540wmq.19.2021.12.20.06.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:19:15 -0800 (PST)
Subject: Re: [PATCH] thermal: rcar_thermal: Use platform_get_irq_optional() to
 get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <5f8e2432-1214-3435-fb62-2f407ced0472@linaro.org>
 <CAMuHMdXgRzM4+OjR0or0aTk-ogPcAYajaVALsLF6E=MxEzeRQg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bdec1a89-ad1b-1e16-a248-029f7f02ae80@linaro.org>
Date:   Mon, 20 Dec 2021 15:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXgRzM4+OjR0or0aTk-ogPcAYajaVALsLF6E=MxEzeRQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/12/2021 14:48, Geert Uytterhoeven wrote:
> On Mon, Dec 20, 2021 at 1:29 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 18/12/2021 15:41, Lad Prabhakar wrote:
>>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>>> allocation of IRQ resources in DT core code, this causes an issue
>>> when using hierarchical interrupt domains using "interrupts" property
>>> in the node as this bypasses the hierarchical setup and messes up the
>>> irq chaining.
>>>
>>> In preparation for removal of static setup of IRQ resource from DT core
>>> code use platform_get_irq_optional().
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> Hi,
>>>
>>> Dropping usage of platform_get_resource() was agreed based on
>>> the discussion [0].
>>>
>>> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
>>> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>>>
>>> Cheers,
>>> Prabhakar
>>> ---
>>>  drivers/thermal/rcar_thermal.c | 15 +++++++++++----
>>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
>>> index b49f04daaf47..e4c7bc1bf7ef 100644
>>> --- a/drivers/thermal/rcar_thermal.c
>>> +++ b/drivers/thermal/rcar_thermal.c
>>> @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>>       struct rcar_thermal_common *common;
>>>       struct rcar_thermal_priv *priv;
>>>       struct device *dev = &pdev->dev;
>>> -     struct resource *res, *irq;
>>> +     struct resource *res;
>>>       const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
>>>       int mres = 0;
>>>       int i;
>>> @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>>       pm_runtime_get_sync(dev);
>>>
>>>       for (i = 0; i < chip->nirqs; i++) {
>>> -             irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>>> -             if (!irq)
>>> +             int irq;
>>> +
>>> +             irq = platform_get_irq_optional(pdev, i);
>>> +             if (irq <= 0 && irq != -ENXIO) {
>>> +                     ret = irq ? irq : -ENXIO;
>>> +                     goto error_unregister;
>>> +             }
>>> +             if (irq == -ENXIO)
>>>                       continue;
>>
>> Why not invert the conditions?
>>
>>                 if (irq == -ENXIO)
>>                         continue;
> 
> And this can be break.
> 
>>
>>                 if (irq <= 0) {
>>                         ret = irq ? irq : -ENXIO;
> 
> irq == 0 cannot happen.
> 
>>                         goto out_unregister;
>>                 }

Sorry, I don't get the two comments. May be I missed something but it
seems for me the results are the same with the inverted conditions or not.

if (irq <= 0 && irq != -ENXIO)
	goto out;

if (irq == -ENXIO)
	continue;

Can be changed to:

if (irq != -ENXIO)
	if (irq <= 0)
		goto out;

if (irq == -ENXIO)
	continue;

Can be changed to:


if (irq == -ENXIO)
	continue;

if (irq != -ENXIO)
	if (irq <= 0)
		goto out;

The second condition is always true because the first condition is the
opposite of the second condition, if the second condition block is
reached, that means irq != -ENXIO, so we can remove the second condition
and that results into:

if (irq == -ENXIO)
	continue;

if (irq <= 0)
	goto out;


Did I miss your point ?



> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
