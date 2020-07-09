Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0115F219D96
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGIKVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGIKVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 06:21:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917DC061A0B;
        Thu,  9 Jul 2020 03:21:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so1797722ljb.0;
        Thu, 09 Jul 2020 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c9zbMy4AnOQ+/YjAvAYQMgY6gfaeIUEQ7HACG2S9D/s=;
        b=hizuVQ/IMvHu+9bat6L8+OM/J/X2U8JnX5+jPLQ2ooxwxMWgtYwZpMwXAb79rWIOq6
         BldLNR1fbtpZnj0Cv2DOI97MWBBdAK+WrBDxSfET4rM/gMqCGKdkuEbla3gM8dMUmoKd
         7YEzJ4lLgUbRvUFgMhaxV8f2FH5JbWJAxM2IL4q4VFZxSgZEWK8DGVF5iBlHA/qY8xG2
         nmly/mnpPS9bB7B9FWtH4w420OXMM4wprmGJFkCKRa+RncbUKm8muesVjjsGfXtXNj0V
         60HE9wXy8vkgsf/uGdD2HT1Zn8ndzAjbTYm5QKuN9WHQxXcR96JWkREH6tiP7i4xY6QF
         wB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9zbMy4AnOQ+/YjAvAYQMgY6gfaeIUEQ7HACG2S9D/s=;
        b=GuUrFJJFgDm6ZhNKzIjiU4gZxnkW/zY0/zXc+eIF+7RCL3dGTRzbe28TnTGVIbq6OH
         QMNXF7gGlUScLN2UtmTsPG2/peAVeHmcPSbLKWMxz1wPC51n5KRMiCR48/4O4HYXjINW
         yvl1xNX6f0sc+JsHialKbFsFbii/QzzIyEbNlpfHiVDVFq5VJ5z8T2Bhs+QHvSyW/xYa
         D3jstuMDz3eN/Rdv42DOkDf8awdADfTF5KfMqs/BOWXoY7CnYmsT8ZwCSFtDdrKuMZpS
         +0r/jjjoN7L+uo+DWcNizbmAQm80aDI/NVKBKBuZjfz9q0i/MQO9zLv0B4FQatqNKaGd
         AI0w==
X-Gm-Message-State: AOAM533utNKt5hFh4VCrL9ZM/5JJyaPHjjzCtbWMjlavXWLZEFpIg78O
        Q+r1K7A57QE/H6Nvir7933Xz8NSa
X-Google-Smtp-Source: ABdhPJzEOnHQiLVmhZQO80nU/P2ObB56X6dD0JicmEvxaE7bMSfuV49lQF1uI5eXRTao+3sPOam8sQ==
X-Received: by 2002:a2e:3507:: with SMTP id z7mr35704012ljz.389.1594290064759;
        Thu, 09 Jul 2020 03:21:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id a17sm751016lfo.73.2020.07.09.03.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:21:04 -0700 (PDT)
Subject: Re: [PATCH v2] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200702001354.27056-1-digetx@gmail.com>
 <4ffff3d8-2d41-3fb2-ed16-c9662d18d261@nvidia.com>
 <3bc2064e-e94d-984c-edab-50b4dc2fd2dd@gmail.com>
 <be99caca-b50a-0e12-29dc-2da0d924af43@nvidia.com>
 <55744bfb-af5e-ed2e-654c-d6de9b26b696@gmail.com>
 <fb6370d9-cae9-15dd-a19b-c3116256b471@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <afe84878-495d-0037-eb5a-ce067235ff6f@gmail.com>
Date:   Thu, 9 Jul 2020 13:21:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fb6370d9-cae9-15dd-a19b-c3116256b471@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.07.2020 12:51, Jon Hunter пишет:
> 
> 
> On 09/07/2020 10:48, Dmitry Osipenko wrote:
>> 09.07.2020 12:06, Jon Hunter пишет:
>>>
>>> On 08/07/2020 15:32, Dmitry Osipenko wrote:
>>>> 08.07.2020 15:34, Jon Hunter пишет:
>>>>>
>>>>> On 02/07/2020 01:13, Dmitry Osipenko wrote:
>>>>>> The enter() callback of CPUIDLE drivers returns index of the entered idle
>>>>>> state on success or a negative value on failure. The negative value could
>>>>>> any negative value, i.e. it doesn't necessarily needs to be a error code.
>>>>>> That's because CPUIDLE core only cares about the fact of failure and not
>>>>>> about the reason of the enter() failure.
>>>>>>
>>>>>> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
>>>>>> the entered idle-index on success. Unlike some of other drivers, it never
>>>>>> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
>>>>>> driver, and thus, there is no problem for the cpuidle-tegra driver created
>>>>>> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
>>>>>> returns a error code.
>>>>>>
>>>>>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
>>>>>> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
>>>>>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
>>>>>> see the error code from arm_cpuidle_simple_enter() today.
>>>>>>
>>>>>> Of course the code may get some changes in the future and then the typo
>>>>>> may transform into a real bug, so let's correct the typo in the code by
>>>>>> making tegra_cpuidle_enter() to directly return the index returned by the
>>>>>> arm_cpuidle_simple_enter().
>>>>>
>>>>> Are you suggesting that arm_cpuidle_simple_enter() could be updated to
>>>>> actually return an error? Sorry it is not clear to me what you are implying.
>>>>
>>>> Hello, Jon!
>>>>
>>>> Yes, I'm saying that *potentially* arm_cpuidle_simple_enter() could be
>>>> updated to actually return error.
>>>
>>>
>>> OK, then I am confused, because after your change, we would now ignore
>>> any error that could be returned in the future. Yes the current code
>>> does not set the variable 'index' correctly, but before we set the value
>>> of 'index' shouldn't we check that the value being returned is not a
>>> negative error code first?
>>
>> Could you please clarify what do you mean by "ignore any error"? Do you
>> mean the error message?
> 
> Yes exactly. We would skip that, which seems a bit odd.

Yeah.. well, I was a bit doubtful about the error message, maybe
arm_cpuidle_simple_enter() could have its own message? :)

But since you're asking about it now, then perhaps it should be better
and more clear to everyone not to skip the error message.

Alright, I'll prepare the v3.

Thank you for the review!
