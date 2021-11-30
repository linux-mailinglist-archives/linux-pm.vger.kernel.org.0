Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB32A463C35
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbhK3Qul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 11:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244463AbhK3Qtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 11:49:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C1C061757
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 08:46:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so45819624wrr.8
        for <linux-pm@vger.kernel.org>; Tue, 30 Nov 2021 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bu+khVHHIWl+4rKLspyHMRY9OQl0yNPLkMrhXXmlQ/k=;
        b=y+K/Vy2gVgt0eOfWWyC/6AZZb4orulIdbmsYSjzygtrLoHC5h33ij6YxrM5Fo11QOE
         hwM/M6adGottbgLjquHsM1qYHnwobwhuzu3dMhVrjOW5f1Q0l7rilFEp5VdqevQimiSt
         Tf9fMeh7t4VGWPE5wBy2SKFgXuUNjy1I2r2nWcsrH2LO7VMgIFeXfRzILC4L4WCKBDJM
         UOpFfnj+56cNB5Bhn4WnlcXWkIaTHQQ9ixpL1S08+JS7ufMXgA3kcTEvxYoJIGsoEZGw
         fVWdkU54h/YMBVAIEyrVbvwanHtHPmQhsYUjtFc2BuLIDlCK3qZUv5UHyao6Ys8UnVdS
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bu+khVHHIWl+4rKLspyHMRY9OQl0yNPLkMrhXXmlQ/k=;
        b=5aXP+uvnASQ+Srabgy1U6bZ+xR+v2BAFphCvFnK7zDkgO5NO9zie3H6JgmTlfHOGKa
         1Yczc8iu7HqmXyHxbLQTQd6iucF+3SpZ6EkoSHv6rk9iJWqt0TZe5HZx3iCXtf1nlOwR
         j054FZAZlE97sjWITMcax9tadbY21nHCdXgEgC0y0XzT/tg5vQCsBHKXkpaaRoflAtHk
         rers5aCpHjrFGo52zEudW7grsO57SpHuoTWyhl099BvzGcyNvCNE+UVciuqX7US9/uQG
         D3vXHOURnNoAMbEYM527ESfyBV18OTbBgbhJrrzuJaePvXfdyRiZUK8efEg7MHcGZEcH
         9zWA==
X-Gm-Message-State: AOAM5331MyQcRGSQ1UJgbcNMYH5x16asWKS6AKSA7Rsu8vkbQdSOZ+46
        8XUDI84aW6odynirwwZUBvksxw==
X-Google-Smtp-Source: ABdhPJykE43HxEqgvzTKWs/qZ9gI+yERaqcBeSJnaM4Ri/fHfYV2IPBs+Ps9r/nfcHXIO8Ozdk0wTg==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr110685wrw.116.1638290787092;
        Tue, 30 Nov 2021 08:46:27 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ae29:582a:93e5:4eb8? ([2a01:e34:ed2f:f020:ae29:582a:93e5:4eb8])
        by smtp.googlemail.com with ESMTPSA id w7sm17112854wru.51.2021.11.30.08.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:46:26 -0800 (PST)
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org>
 <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
 <CAAYoRsXLTYKGK_doqDqgerQ+uW3UhMYki7FfBy3cAhbfXiCrXA@mail.gmail.com>
 <CAJZ5v0hDa4dmEJD0EYnOzfDBNC-GU99DM_d7bsTCCoSaP-o3CA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <43213ea5-c65a-a7da-e61c-fefcdd0b3281@linaro.org>
Date:   Tue, 30 Nov 2021 17:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hDa4dmEJD0EYnOzfDBNC-GU99DM_d7bsTCCoSaP-o3CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2021 20:29, Rafael J. Wysocki wrote:
> On Fri, Nov 26, 2021 at 8:10 PM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> On Fri, Nov 26, 2021 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> Hi Doug,
>>>
>>> On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> Hi Daniel,
>>>>
>>>> This patch introduces a regression, at least on my test system.
>>>> I can no longer change CPU frequency scaling drivers, for example
>>>> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
>>>> (A.K.A. active mode). The task just hangs forever.
>>>>
>>>> I bisected the kernel and got this commit as the result.
>>>> As a double check, I reverted this commit:
>>>> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
>>>> on kernel 5.16-rc2 and the issue was resolved.

[ ... ]

>> -static int __init dtpm_cpu_init(void)
>> +static int dtpm_cpu_init(void)
>>  {
>>         int ret;
> 
> OK
> 
> This needs to be fixed or we'll need to revert commit
> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c for 5.16.

I've send a fix for that and Doug tested it (thanks) [1]

  -- Daniel

[1]
https://lore.kernel.org/all/CAAYoRsWEXoe_LjuHuQUL3Tdov0JVW887T4ciUTVOC410mZjgvA@mail.gmail.com/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
