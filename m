Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABED29CA4C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902327AbgJ0Uhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:37:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41253 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900490AbgJ0Uhd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:37:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id 126so4035630lfi.8;
        Tue, 27 Oct 2020 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rp8OgTEAWtuKJtMNiLhS1/R8myCG5UhnRurxGX0itc=;
        b=pEIfSei7bmZJp5rQNKjGJ1YAY4mj3MLEzP+ie3m0TBYOMLJH4G156rMIn85hVZgEC1
         azFPSR5gMLIbusPBB46uAK6oGubJ+1BkF77NXjCWGLnWAkNoBt02Urav3PHU/+4KC4Eb
         RnFp8H2pMwIzgCZYTHrP7GCG38Zc3IcYNEioxWgveaZAkVvFlJ5FapUc8FwkCMm/CKmK
         DHObifrr0wVW9tWM2qhI31qxKy3JhBeXM4lxJ7uTP6oz2+cQSJojV8p/CJTvl55n2yEA
         VeUheDR5E3sWn9aD/Tg5eEUkYSq/CeJ5tgW4k9h/t74Ag3xpXjjNcHkbray3nX03mPt0
         1umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rp8OgTEAWtuKJtMNiLhS1/R8myCG5UhnRurxGX0itc=;
        b=bruO25l9MQOnFtYT+0XWoLBEwj0/xVqahmCjaSWyZzlTkCI10dT5dPxP3vqcNtliv9
         Ozw2s02BKHZ1jY9XGfXe2ILmxvIurHtGh113umbkNrUzmglr6Fqk3FP/zGnmoD7eIEQV
         faXJkNi5gV6rfEAoTAsKRg/ug97tc9U6q4kUqwtXu3NVRmkFt5hiawkcDeYAPcOPPg/9
         N689WO+xmx6LXHWQaEwDms+pTD0O3huegL051vqk9mnJyaACcojDnthGCGPXIbsiwrcd
         84yueCwApfCqTKvbMo4BlIdW1WHEdZWO/FgvE+mUWFWta4VNjA+EKDBlgBT849FpADSq
         6+Ww==
X-Gm-Message-State: AOAM531ZAaySDrSMZ4qs5pXUf82iwC3yXzAdcVr6IP99J7V5lNGykaJV
        RbYxMZbjkBFA8E7BOH40gJiMkywJErU=
X-Google-Smtp-Source: ABdhPJym33W/chgtCjkXL4iuOZZNtixcgyiRRX4KlkNwIlFRpM3sMfAYENyAfUzTcy1uJQku22By8A==
X-Received: by 2002:ac2:5207:: with SMTP id a7mr1416790lfl.56.1603831050126;
        Tue, 27 Oct 2020 13:37:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id l20sm162128lfc.274.2020.10.27.13.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:37:29 -0700 (PDT)
Subject: Re: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document
 nvidia,memory-controller property
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-5-digetx@gmail.com> <20201027085417.GD4244@kozik-lap>
 <54191034-dcb9-7cab-333b-5bb2553f0ed1@gmail.com>
 <20201027193039.GA140636@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <90df8e53-6dec-f75f-5f82-539cb0f72583@gmail.com>
Date:   Tue, 27 Oct 2020 23:37:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027193039.GA140636@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 22:30, Krzysztof Kozlowski пишет:
> On Tue, Oct 27, 2020 at 10:17:19PM +0300, Dmitry Osipenko wrote:
>> 27.10.2020 11:54, Krzysztof Kozlowski пишет:
>>> On Mon, Oct 26, 2020 at 01:16:47AM +0300, Dmitry Osipenko wrote:
>>>> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
>>>> reprogrammed when memory frequency changes. Tegra Memory Controller sits
>>>> behind EMC and these controllers are tightly coupled. This patch adds the
>>>> new phandle property which allows to properly express connection of EMC
>>>> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
>>>> par with Tegra30+ EMC bindings, which is handy to have.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>>>> index 567cffd37f3f..1b0d4417aad8 100644
>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>>>> @@ -12,6 +12,7 @@ Properties:
>>>>    irrespective of ram-code configuration.
>>>>  - interrupts : Should contain EMC General interrupt.
>>>>  - clocks : Should contain EMC clock.
>>>> +- nvidia,memory-controller : Phandle of the Memory Controller node.
>>>
>>> It looks like you adding a required property which is an ABI break.
>> The T20 EMC driver is unused so far in upstream and it will become used
>> only once this series is applied. Hence it's fine to change the ABI.
> 
> The ABI is not about upstream, but downstream. There are no other
> upstreams using this ABI. Unless you have in mind that existing T20 EMC
> driver was a noop, doing absolutely nothing, therefore there is no
> breakage of any other users?

The T20 EMC driver was a 100% noop for now. It's safe to change the ABI.

The T30/124 EMC drivers have users, but these are unsafe drivers (with
the known issues) until this series is applied.
