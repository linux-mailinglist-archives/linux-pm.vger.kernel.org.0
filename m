Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53993F06ED
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhHROo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 10:44:27 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53240
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238896AbhHROo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 10:44:26 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 1B3F2412EC
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629297831;
        bh=Ym2NH7kLd3Wo06ZfZyv8MWAmg9zO0sWLSjyMTnIEUB0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=tsyCXCS3jjP/uA6QXrlZh8/PRXo1cLOqTpgksj743ld5xP8ZcTSz4a75XAh9HaPdZ
         zaF1ZEIURfhL/55xvLArGB5RbgFSqI15j/06rC8KX7+XXGzghpxOOkQfa6tam8IX01
         GjbLudaXVKbtANdGNzJAnUXrPmgMqMfEZEdYvFv2ipEOwmehDd8pN2NxfX8wy+o2Gr
         rfvvhhNZeFlGOufhBtFNwTRJGYX5yVYNAi/MGcoxO0ILIMMuGEcOilF+1TghDPFHKi
         0p0h68Go+cWiNp5L7jjuxWWJnBftH3qZUfv3+cF5TJxZXBjyLucCnY4MmwYGARZbgC
         LQ7TC/TmHxB6w==
Received: by mail-ej1-f72.google.com with SMTP id x5-20020a1709064bc5b02905305454f5d1so948631ejv.10
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 07:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ym2NH7kLd3Wo06ZfZyv8MWAmg9zO0sWLSjyMTnIEUB0=;
        b=poJGCCS6twT6jE/zca7oZ4HLSXLZCFURRsA3cFTd5cUISi2sVoGMUXOi2pexLTVBZq
         gS7mpJFDUqxvAoqfkW4LP2ICafCkONso4wVBh2I3Nepx22LvRePcBLn8BBZWNU9FqFP4
         T3hoZDVRqDokTdMlrmyki7NQMipnx8yWTVS4OL+FfXiADLxsZ9Ww/JOPh2c8q5yzWRFK
         HaeQPPA+lTyYRZV/VeQl3tNYHK9t3YWZYi1eWfgPZZLeWwEa2FfUHQgB2YerPIgnB8H9
         jce2Nn3qt7h5pjrJqyEjdI1vhwNQRM44qZBSDNxP2SRTILsrUz9a+5F2KVifvcELcQFp
         esCQ==
X-Gm-Message-State: AOAM530WZnKU6AR3PMC+ZUORUx8LioFRqNzwF849VKBhnzZiHZLO5DVj
        AG+Orb+Fey8FxjWNShUX7CwsOjv4sOOTvkIzcKw2FpmXVxQ1TZx+0Ic47FK695iSjBlGaX8x4tj
        UevRrIcOrzKpJYpuKjkJXTsZgvmwkD292MziX
X-Received: by 2002:a50:eb95:: with SMTP id y21mr10368728edr.5.1629297830699;
        Wed, 18 Aug 2021 07:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzChPEIgyhED0qbDqb7annT/YZib35pAtXfFKjieVRsRdjPmve/sr9l695zsiB4e2LvNRwzsg==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr10368717edr.5.1629297830603;
        Wed, 18 Aug 2021 07:43:50 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id g9sm2139187ejo.60.2021.08.18.07.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 07:43:50 -0700 (PDT)
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <aaa53a2a-c15b-8017-4e44-dd3f883b2378@canonical.com>
Date:   Wed, 18 Aug 2021 16:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLOHY0P=Y8-Ss0cYr54SWgpV0zktEg8p-Cj_F+juDQNoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/08/2021 16:31, Rob Herring wrote:
> On Mon, Aug 16, 2021 at 3:32 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 16/08/2021 09:53, Lukasz Luba wrote:
>>> Hi Krzysztof,
>>>
>>> On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
>>>> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
>>>> Dynamic Memory Controller to DT schema format using json-schema.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> ---
>>>>   .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>>>>   .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>>>>   MAINTAINERS                                   |   2 +-
>>>
>>> I'm not an expert in this DT scripts and why it complains. Maybe it
>>> complains because the "samsung,exynos-ppmu" is defined in the .txt
>>> file... (?)
>>> Although, in general looks OK.
>>>
>>> Acked-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> I think the warning (triggered by DT_CHECKER_FLAGS=-m) can be ignored
>> because it complains about compatible in example which is not present in
>> the bindings. Usually it means someone wrote example not matching the
>> bindings (e.g. a typo in compatible) but here it is on purpose.
> 
> Ultimately, it will mean the binding is undocumented (or a typo). But
> right now, it means the binding is undocumented with a schema. It's
> off by default because there's still about 80 warnings. It's turned on
> for the bot so we don't add more. So please don't ignore it.
> 

By "Ignore" I meant here that it is a false positive, so it can be
ignored. The warning is about compatible "samsung,exynos-ppmu" used in
the example. However this exynos-ppmu is not part of this bindings and
is documented elsewhere:
Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt


Best regards,
Krzysztof
