Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277A53F2D9D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhHTOBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 10:01:20 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36064
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240739AbhHTOBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 10:01:19 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 10:01:19 EDT
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 54A5E4079D
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629467621;
        bh=L6n8EwvoF0TqxFnTQHNETcblmy409V9jfAs/6ldvq4k=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FeilRYNz1W5Jqhafz4g+znI3Wce/mZtgWiB5qSiU1qXQjTAPqV/4iZAC+NkC34/Cs
         s6HCXvkhXMj1qUQi4FWYqCCU+puaYyVjbAO6323gUIjDPodAX7Zt/e6d7Rgs1hjT+y
         hz/e6bh9m6xsVKrLGhh2secEtD8qZqJ3MsFBuG+/611tYI84PqxC9nwqNas7o+INF1
         VYdOVgT4VntJN1uYfWiQZBRG07uCo0frxtg7pDh5Xc1WxAUcRBPdxvJmKbOj+ZpAF7
         njLMHRvQRk0G1Tw/MB2iNi9pmxvCiWzjyi530b6+TmL5Tewc6/bVlPF6pgp9+AJ82P
         hQL1KCArKSDYg==
Received: by mail-ed1-f70.google.com with SMTP id ee19-20020a056402291300b003c0149781ecso587259edb.23
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 06:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6n8EwvoF0TqxFnTQHNETcblmy409V9jfAs/6ldvq4k=;
        b=W6xDozPqHGjp2wVdlJzZXpXNomUM1mTbleKLHsEaptzvaNk8bsip5vcDwoEH+Z8pV8
         FSw/jbKkkbR05gtS0rX2cLdr6iHyl6Z850NlIB+ZwDFamXeyVmXH3u4tKSWvEKowGU/I
         y/jf9/6x4elx8OlVQScLt6Zj2d0wZn6SN1yzKHWYpNHO0mFtGJ8+jRWsgxR8uBFACkSD
         Adi9XeyunKKfw+v2raDInvFh5XejHNhOkyoUhQLMp9LRjao4QAvNgNSjoMgrwcXW5Aa7
         ipqOsa544ekturiosTc/QKSxzHWKaY+N3p2z3fBiMAz7BmBFvwrvyNYO3uv151o7iTjj
         TglA==
X-Gm-Message-State: AOAM5324h+95qL7vnwCoREWzEJ5x2Iw04WvMN4l/B91GiQiSmu6IQxAT
        uyC5CAP65zzsH/EGtofRGepydUEnYk18mjzGBZZDeHQr4rfvBmiPXjrGhKgsFi0jx+9iAqVs7aL
        14kplL19+F+nSst6eFDou/qIHjIADC75fKtNi
X-Received: by 2002:a17:907:2168:: with SMTP id rl8mr1189843ejb.42.1629467620848;
        Fri, 20 Aug 2021 06:53:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRnazCb0WSvIZUIOXuiwlWppcOzwDCP8XkmoOFIi4wo1QoT4XNNQeCS37G86Ssi7hlQsUy1w==
X-Received: by 2002:a17:907:2168:: with SMTP id rl8mr1189834ejb.42.1629467620713;
        Fri, 20 Aug 2021 06:53:40 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id bm26sm2914357ejb.16.2021.08.20.06.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 06:53:40 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory: convert Samsung Exynos DMC to
 dtschema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
 <73eebe7b-46da-137b-1938-09a5b453320a@arm.com>
 <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
 <CAL_JsqLOHY0P=Y8-Ss0cYr54SWgpV0zktEg8p-Cj_F+juDQNoA@mail.gmail.com>
 <aaa53a2a-c15b-8017-4e44-dd3f883b2378@canonical.com>
 <CAL_Jsq+iG1t=yxsyp2whd_L4p=9udrSvZMiy-y75ppcLYK9acA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d3cf3485-6996-5cb9-6a8a-9b868f86bbea@canonical.com>
Date:   Fri, 20 Aug 2021 15:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+iG1t=yxsyp2whd_L4p=9udrSvZMiy-y75ppcLYK9acA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/08/2021 15:31, Rob Herring wrote:
> On Wed, Aug 18, 2021 at 9:43 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 18/08/2021 16:31, Rob Herring wrote:
>>> On Mon, Aug 16, 2021 at 3:32 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>>
>>>> On 16/08/2021 09:53, Lukasz Luba wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
>>>>>> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
>>>>>> Dynamic Memory Controller to DT schema format using json-schema.
>>>>>>
>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>>>> ---
>>>>>>   .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>>>>>>   .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>>>>>>   MAINTAINERS                                   |   2 +-
>>>>>
>>>>> I'm not an expert in this DT scripts and why it complains. Maybe it
>>>>> complains because the "samsung,exynos-ppmu" is defined in the .txt
>>>>> file... (?)
>>>>> Although, in general looks OK.
>>>>>
>>>>> Acked-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>
>>>> I think the warning (triggered by DT_CHECKER_FLAGS=-m) can be ignored
>>>> because it complains about compatible in example which is not present in
>>>> the bindings. Usually it means someone wrote example not matching the
>>>> bindings (e.g. a typo in compatible) but here it is on purpose.
>>>
>>> Ultimately, it will mean the binding is undocumented (or a typo). But
>>> right now, it means the binding is undocumented with a schema. It's
>>> off by default because there's still about 80 warnings. It's turned on
>>> for the bot so we don't add more. So please don't ignore it.
>>>
>>
>> By "Ignore" I meant here that it is a false positive, so it can be
>> ignored. The warning is about compatible "samsung,exynos-ppmu" used in
>> the example. However this exynos-ppmu is not part of this bindings and
>> is documented elsewhere:
>> Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> 
> Yes, I understood all that. Let me be clear. I don't want examples
> which don't have a schema. So drop the node or convert
> exynos-ppmu.txt.
> 
> First, when we do add a schema, then we likely have to go fix the
> examples. It happens a lot and is not caught with folks using
> DT_SCHEMA_FILES. Second, I don't like reporting errors that users
> should have gotten by default. We can't turn this check on by default
> until the 80 or so cases we already have in the binding examples are
> fixed.

Understood, I'll send both of these bindings.


Best regards,
Krzysztof
