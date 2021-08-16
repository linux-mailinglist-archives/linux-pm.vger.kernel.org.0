Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38A3ED9E8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhHPPdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 11:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPPdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 11:33:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26230C061764;
        Mon, 16 Aug 2021 08:32:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k5so7425483lfu.4;
        Mon, 16 Aug 2021 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jji36Y1LnDODoev0Avwliy2xCTIsB97zZRauZf075VA=;
        b=mq21gBQ8hLGp/4Yem98VGS4lu+97ERbV+BdyANot4LQDqDEn6yV6pZEgs57D3sBn8i
         AKhumVMRQWlu3qOa+7tpEimZck8FBr/kBmcU+2n48Q8uoIrV+MMFS123XL05FkUXFxf+
         /0JYZrlk0tn7e/TMCqzihJV02rInAjFKP9Y6RuET+6LdEogLckQHhRmxR5S4u3ZdBcjs
         4hC7LfjWHb16c0dtkPcxHJuPtTRthmlm5m5uVc9kaK/Wek6OZfECLD26a2zzVDOJ649r
         QSb8DuWk2bejZTMCyF6y1QvH2ianxDE/uJHV7XTkHUPWUE6PX4U3XNbtFUvOKAj+sD1f
         HZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jji36Y1LnDODoev0Avwliy2xCTIsB97zZRauZf075VA=;
        b=PFhrLkjU5y7rd3SXMBQ5I85n4FYR0TdMmgGLOwpkTKhQmxZFz8VA21uuxnAj4SN+Sw
         JLFDOYwlGUiCjWClFTgzewLN9yYeoS6nPh9GN7eQO3MeL46OJKIVZID9jBsb4ApjJs9v
         fYl9s2BGTrYV7qXsxtao0bW/COdJCB+052XV5di8Lt1YO9B07GgB3Qnec5ToOaI1lFXR
         wmylTZlhnk/Wq27uJEIfev/tRRoJsl5UVCLF/3qZjdZ1HUbFTcpLnDiRdlEy1VRMCH8i
         u0+IADuXSrGugsNs8p0zaPc7Sxi4pC/z1P1ASXEeBFk7cNWJweWtyyltMukPG6wXsu+R
         Ejxw==
X-Gm-Message-State: AOAM533e990pD+gZjcoEjkyDXRfIGHIZs8nst06KNP2MpGHQSm34kn/b
        /J9eNgArlM/xZXMlpuCTJUJPJng0kYQ=
X-Google-Smtp-Source: ABdhPJwrfG+4glx/MIR0iQjCsOWrCk7lJWJpozxMy17cyAj+4ybUrvU9zFV8aaBEA/EiyPngthUS/w==
X-Received: by 2002:a05:6512:3e06:: with SMTP id i6mr11877182lfv.81.1629127962417;
        Mon, 16 Aug 2021 08:32:42 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id l26sm974295lfh.247.2021.08.16.08.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:32:41 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-3-digetx@gmail.com> <YROdQXO4aVLQ8DkP@orome.fritz.box>
 <8d61d4d5-8e4b-5c18-923c-eceb954e8d5d@linaro.org>
 <8f22c97d-63f7-6d2a-7b1e-92b0b80a5275@gmail.com>
 <YRo1hK/KnS0oA1vj@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1fb32fd0-97c0-9215-6e38-c53c5155f27a@gmail.com>
Date:   Mon, 16 Aug 2021 18:32:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRo1hK/KnS0oA1vj@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.08.2021 12:53, Thierry Reding пишет:
> On Sat, Aug 14, 2021 at 04:45:42PM +0300, Dmitry Osipenko wrote:
>> 14.08.2021 13:37, Daniel Lezcano пишет:
>>> On 11/08/2021 11:49, Thierry Reding wrote:
>>>> On Mon, Jul 19, 2021 at 12:27:06AM +0300, Dmitry Osipenko wrote:
>>>>> Check whether PMC is ready before proceeding with the cpuidle registration.
>>>>> This fixes racing with the PMC driver probe order, which results in a
>>>>> disabled deepest CC6 idling state if cpuidle driver is probed before the
>>>>> PMC.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  drivers/cpuidle/cpuidle-tegra.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> Rafael, Daniel,
>>>>
>>>> would you mind if I took this into the Tegra tree? It's got a dependency
>>>> on the PMC driver, which usually goes via the Tegra tree already, and
>>>> there's nothing cpuidle-specific in here, it's all Tegra-specific
>>>> integration quirks.
>>>
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> I got another thought about how it could be solved. We could move the
>> creation of the cpuidle platform device into the PMC driver. Thierry,
>> what do you think?
> 
> Looking around a bit, it looks like we've got two "virtual" platform
> devices related to CPU on Tegra20 and some of the later SoCs. A little
> while ago when we introduced the CPU frequency driver for Tegra194 we
> had a similar discussion. The problem at the time was that there was no
> way to create a virtual platform device from platform code, and adding a
> device tree node for this wasn't really an option either, since it does
> not actually describe the hardware accurately.
> 
> What we ended up doing for Tegra194 was to add a compatible string to
> the /cpus node ("nvidia,tegra194-ccplex") which was then used for
> matching a CPU frequency driver against.
> 
> I imagine we could do something similar for these older chips and
> perhaps even have a single driver for the CCPLEX that either registers
> CPU idle and CPU frequency scaling functionality, or have that driver
> register virtual devices. I slightly prefer the first variant because
> then we associate the driver with the hardware that it's actually
> driving. It's slightly unconventional because now CPU idle and CPU
> frequency drivers would be implemented in the same driver, but it isn't
> all that exotic these days anymore, either.
> 
> If the maintainers prefer we could always keep the code split into two
> source files, one per subsystem, and call into that code from the CCPLEX
> driver. I think even then it'd still be the cleanest solution because we
> don't have to "invent" a new device just for the sake of fitting the
> driver model that we happen to have.

It's doable, but it's a bit too much effort for a little problem we have
here. It also doesn't solve the root of the problem since PMC isn't a
part of CCPLEX. Should be better to stick with this patch for now then.
