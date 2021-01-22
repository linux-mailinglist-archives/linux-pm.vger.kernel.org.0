Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3453A3005B8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbhAVOmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbhAVOls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:41:48 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530FC06174A;
        Fri, 22 Jan 2021 06:41:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o17so7845014lfg.4;
        Fri, 22 Jan 2021 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xoSe8r1qjBUVWGzfJU/ltvkY+iSuecaF2y7zZ5LnPZs=;
        b=MUCab2ILvhXHvluaoo8PgOOpIDjLiYd36l+qB5nGQwHmzIcytWIGMwqnN1wd6cYC+n
         gCHdMGlxbamDB9FXEkavaLSct3bNGzImmsGYbRP+vusyLZp3m5FvgoccKQ1s3zbElSPC
         yC921z8EjEQMWo+cpBBTB7Imr/dXYYbECd4bxgE+Vc/GQ4vWA1a0PGaciK2HaKRvCy2h
         Ei2sRxvvizYoWQ2e/Aao1r8Ac5KCZuNewPIkD9H0iJbEYUuxX2V4E6e47+L+c02DeoiO
         4iY62LTGGRtx1lXWJsFDVOErOdIvVDMpplLXLABkPpTvpW5K/e8E9mPxm4gV/PCJ19Xd
         96RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoSe8r1qjBUVWGzfJU/ltvkY+iSuecaF2y7zZ5LnPZs=;
        b=jWfe60+XTMsBBNX2cjNgsiHofB6sxeuOqCh1gwS8mb2K0oKjOMTO2xMjf3j5lv2HoE
         vbFhdx6uN8QWrj8W6qk5N+KlEcblvNfBRo6Vv4S5+1k329mkn1LVIf4MovuCj63wDJoz
         U1ysFOGLwUckY3MWCdJdR3Ryy+TGfnEOQtUsvyGV4eTB6D8ialVkDQ2i/MPwqEkbVXTg
         yR+fVvW0N8mPPAAuK9h5HYsNh0mMOYkcpMx8/zxszeHcO4mjwZgDEn5DC99k/5vJNpuP
         3nBeJ+NvwnVqD4ODkG6MS3CqvGOn7nD+sX32UCrdrTj71l6CtTKsI8gvaIpEOWjOYKgI
         zWYg==
X-Gm-Message-State: AOAM530S2timK4cF5/u2grMtBzetFNZnAo6xGri0o+tikw4j7EhkxQjZ
        Qu1mHAJ5868UK9l12Bnnj6M=
X-Google-Smtp-Source: ABdhPJxef6llQ5TdSL/YmUH2jy98F7g+cgf1+AHpK9A9lncJEg1OMiL1GCihXJJ3QD9zUr7KZD6FQA==
X-Received: by 2002:a19:4104:: with SMTP id o4mr1354010lfa.34.1611326466913;
        Fri, 22 Jan 2021 06:41:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id y23sm908006lfy.158.2021.01.22.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:41:06 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <60cfafdf-4615-5a41-103d-96c35ba1fa8c@gmail.com>
Date:   Fri, 22 Jan 2021 17:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210122063537.7yd7ww47gl2rdsdu@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.01.2021 09:35, Viresh Kumar пишет:
> On 21-01-21, 22:01, Dmitry Osipenko wrote:
>> Add common helper which initializes OPP table for Tegra SoC core devices.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>> Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>> [tested on some other non-upstreamed-yet T20/30/114 devices as well]
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v3: - This patch is factored out from [1] to ease merging of the patches
>>       that will use the new helper. The goal is to get this new helper
>>       into 5.12, this should remove dependency on this patch for a several
>>       patchsets of a different subsystems (DRM, media, memory, etc) that
>>       will target 5.13.
>>
>>       @Thierry/Jon, please review and apply this patch for 5.12!
> 
> This is not how stuff works in kernel Dmitry, every commit in the
> kernel tree should build(at least)/boot fine. Your patch can only be
> applied once your base tree has all the patches on which your work is
> based of, otherwise this will lead to build failure (stuff like git
> bisect breaks with that). It would be better if you take this patch in
> 5.13, or after 5.12-rc2 once all other stuff lands.
> 

OMG, I completely missed that the devm series from Yangtao Li isn't
merged yet.

Viresh / Yangtao, will be it be okay if I'll collect all the
prerequisite devm patches from Yangtao + add this patch into a single
series that could be merged via the OPP tree for 5.12?

Of course Thierry or Jon will need to give the ack for the Tegra changes
in that case.
