Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038B63028C3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbhAYRYf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbhAYRYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 12:24:30 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD71C06174A;
        Mon, 25 Jan 2021 09:23:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l12so13721973ljc.3;
        Mon, 25 Jan 2021 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PDmoePdkcTATph/ecYdNBykNHaaRTyctLLJHD91rTGE=;
        b=exF3fEWdcuPq7Pd4pTmzq/hugZ9b0dlXVnYtwldbNYWrbqp863aE4KmXYzqwJlqjHy
         M24fZ4YTMuy9TuaQxBzaM1VUGCw+KBM+ThICAGo42NiYYsV162A12lBN815yFexCGgD9
         lWwiOyZfcznVtUlzwT28PmzFERfii25nBoxGoXzQlHirWTWVSJcYROL7zsgvVBl74WRS
         D4fLyvBtgEYBH4E7IEF9/pFbFmi2UqD9Rl9y4ASR7qtny9bXGW0xgS+WdrOf/QRDnEJr
         rNJe6D1GxZj5+AjF/mS5Swwdr2IFJvEhn3ekaVqaCfkaUPF6x6gVBRC1YWKHnw5E32Kh
         /+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PDmoePdkcTATph/ecYdNBykNHaaRTyctLLJHD91rTGE=;
        b=ARjoQ5SFnWhn0GEZUDrQZudf6bdli3M09hyhFE7FGviNe/77ZlNGE+1UPHUwK5Uz49
         XMLsEsV8aKnvnb0YZWwgon+Vs0+IRrR1t4VY5b8shRwH+q7/l/LvQEt6rLvg68HSMqtg
         kw+aPtLWpTWm5TiNHLtCi1Y0h0nxSAuMvwz+9ozUwwUTQ8bLPrAnJ1nmXd2OfOywoFSh
         Xpj2MVNMo7gDkUJFi11Bhl6thX/ZMvW13AGLX7YQ1iEoMklqmuYfM9HMjcS3VGrCKbol
         8KAGyDe6VT6s+p0zz07FV9ZGgP3yjeTaoV71UHRT09zm2uEZgEZNfWqwzTLrLcrPkMbD
         nTcQ==
X-Gm-Message-State: AOAM530KLGkwuaMZ4O7v0871AHGKKVvt6uesieIchwXtoa4IY8uVSBt+
        k/8P28MoxUieTvBHr/CGaVU=
X-Google-Smtp-Source: ABdhPJxxd0OH2B6y5fzqSlWyBg+X6/G+z2WV4CFUxuy+iFSJ4eQKI24pyEHCPT1po98WtR0rorRg7g==
X-Received: by 2002:a05:651c:2dd:: with SMTP id f29mr668905ljo.235.1611595428324;
        Mon, 25 Jan 2021 09:23:48 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id d28sm1130581lfn.15.2021.01.25.09.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:23:47 -0800 (PST)
Subject: Re: [PATCH v3] soc/tegra: Add devm_tegra_core_dev_init_opp_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
References: <20210121190117.25235-1-digetx@gmail.com>
 <20210122063537.7yd7ww47gl2rdsdu@vireshk-i7>
 <60cfafdf-4615-5a41-103d-96c35ba1fa8c@gmail.com>
 <20210125030750.735minp7toxortm4@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8433a00a-cacf-9149-f7e0-e61e7ab0a83b@gmail.com>
Date:   Mon, 25 Jan 2021 20:23:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210125030750.735minp7toxortm4@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

25.01.2021 06:07, Viresh Kumar пишет:
> On 22-01-21, 17:41, Dmitry Osipenko wrote:
>> 22.01.2021 09:35, Viresh Kumar пишет:
>>> On 21-01-21, 22:01, Dmitry Osipenko wrote:
>>>> Add common helper which initializes OPP table for Tegra SoC core devices.
>>>>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>>> Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
>>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>>> [tested on some other non-upstreamed-yet T20/30/114 devices as well]
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>> v3: - This patch is factored out from [1] to ease merging of the patches
>>>>       that will use the new helper. The goal is to get this new helper
>>>>       into 5.12, this should remove dependency on this patch for a several
>>>>       patchsets of a different subsystems (DRM, media, memory, etc) that
>>>>       will target 5.13.
>>>>
>>>>       @Thierry/Jon, please review and apply this patch for 5.12!
>>>
>>> This is not how stuff works in kernel Dmitry, every commit in the
>>> kernel tree should build(at least)/boot fine. Your patch can only be
>>> applied once your base tree has all the patches on which your work is
>>> based of, otherwise this will lead to build failure (stuff like git
>>> bisect breaks with that). It would be better if you take this patch in
>>> 5.13, or after 5.12-rc2 once all other stuff lands.
>>>
>>
>> OMG, I completely missed that the devm series from Yangtao Li isn't
>> merged yet.
>>
>> Viresh / Yangtao, will be it be okay if I'll collect all the
>> prerequisite devm patches from Yangtao + add this patch into a single
>> series that could be merged via the OPP tree for 5.12?
>>
>> Of course Thierry or Jon will need to give the ack for the Tegra changes
>> in that case.
> 
> I haven't heard back from Yangtao since his last post, not sure what's going on.
> It is normally better if he keeps posting his series, unless he is busy and will
> not be able to do it.
> 

Indeed, it will be much better if Yangtao could make the update, no
doubt about this.

If devm_tegra_core_dev_init_opp_table() will miss 5.12, then it will
likely put on hold couple Tegra patches for a another 2+ months, which
isn't critical, but it's a bit difficult to accept morally :)

Yangtao, could you please let us know the current status of yours
series? If you don't have spare time right now to finish v2, then I'd
like to pick up couple patches from yours v1 which add the devm_*
helpers that are used by this patch to make a small patchset that could
go into 5.12.
