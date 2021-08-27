Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6422D3F9375
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 06:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhH0EQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 00:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhH0EQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 00:16:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B649C061757;
        Thu, 26 Aug 2021 21:15:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q21so9112824ljj.6;
        Thu, 26 Aug 2021 21:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SyhHgV5tmGCX9EPESfwHvVUgx4qCN8VC/mRNtowNnh0=;
        b=pIrUozoO0pV0T3BaVPB2WheUxq08WOaRZJQ53dtVSvbYm0X9gwbq1E1Z+WKCp/oGOv
         U/AwQNtbGgmPJPjt5EVt5LunpTMAnX8t41nM7Bl8x91YtiuZiPRBglcTDUG6LO+PHr5z
         s61MS5czakRQ3pwVFz8W9r9xHRcgT05YVixj4Z7iHaVWkbBZFM+cdBbfbTu9gJYUnc43
         GcLGxhVu556rPFQ8YwTYgsBlMjGusIrVKVgxSU7USTLFGOeHR0J06BPhE+qnzzM5iAKH
         EVCVJJDxkKjQVyOeXUP2OWTi0be/dxuh3txGmrKtBKFn1vruEKXpwNVviqKfJni2TwuK
         emmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SyhHgV5tmGCX9EPESfwHvVUgx4qCN8VC/mRNtowNnh0=;
        b=V/WlBr3Dh09rFuRx1Yl19q7Bj53DXjqV6fntpqce1x+WittJiPraHmpRrdCBp3tcKm
         tbUnsI602PbaJe5kYQz9XapuIrVb7BrUAH7LO7FTqZrzbF4TeFzlOygzd1JfM95VaLZN
         snmVyY0Q/fSlC4XzaLdlPstQeUeN4UgD0c/R/1rHiflvOp8N+KIwmPExRMYEkMy1WhdC
         sdhPSOf6sh7mBSWNTPwJTHXkfqayRTzgNeoVU/CLNJTwoKl8eFNreldyUFiqUi9zE04+
         njD4GPtdVeZx+M+u7gxPbKqihSFG8UTu7gmmOJ5w95lTgsfpD3tGvyIqTO+DdWHaCVN4
         cHpg==
X-Gm-Message-State: AOAM532BGqwYNXVKt93Y3PM9hheUv707WK17zb3mh16Z1NsMJtKPoHVm
        4F8c+HBb5sSTbgptDHahLwKwDsJnRc4=
X-Google-Smtp-Source: ABdhPJzMmDjs3tgVeVB3w/NSRqThcAnkcJFyzHyj0wG0hDpRHoJzdUGE1zuNyE5jqInZtxz/cISkTw==
X-Received: by 2002:a2e:8185:: with SMTP id e5mr6054691ljg.31.1630037739601;
        Thu, 26 Aug 2021 21:15:39 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id l26sm477488lfh.247.2021.08.26.21.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 21:15:39 -0700 (PDT)
Subject: Re: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state()
 callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-6-digetx@gmail.com>
 <20210827030557.aymjkky7athjxpow@vireshk-i7>
 <9c2287ca-4c51-d782-a0a5-4b1227c2e9db@gmail.com>
 <7aca6da3-89a7-a4a6-c720-8be4a105a696@gmail.com>
 <20210827040239.roal5jpndamzotle@vireshk-i7>
 <4a945d40-b30a-8a30-bdf8-4e17ad26cea7@gmail.com>
 <20210827041303.5rz6xcyc2bo75tbr@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <01117523-5793-e3ff-9d50-24f964e4e745@gmail.com>
Date:   Fri, 27 Aug 2021 07:15:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827041303.5rz6xcyc2bo75tbr@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 07:13, Viresh Kumar пишет:
> On 27-08-21, 07:08, Dmitry Osipenko wrote:
>> 27.08.2021 07:02, Viresh Kumar пишет:
>>> On 27-08-21, 06:47, Dmitry Osipenko wrote:
>>>> Actually, it doesn't work.
>>>>
>>>> The devm_tegra_core_dev_init_opp_table() needs to set clk to support older device-tree and now OPP table already has clk being set.
>>>>
>>>> WARNING: CPU: 2 PID: 92 at drivers/opp/core.c:2146 dev_pm_opp_set_clkname+0x97/0xb8
>>>> Modules linked in:
>>>> CPU: 2 PID: 92 Comm: kworker/u8:1 Tainted: G        W         5.14.0-rc7-next-20210826-00181-g6389463cbb0a #9318
>>>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>>> Workqueue: events_unbound deferred_probe_work_func
>>>> [<c010cc91>] (unwind_backtrace) from [<c0108d35>] (show_stack+0x11/0x14)
>>>> [<c0108d35>] (show_stack) from [<c0a6c1bd>] (dump_stack_lvl+0x2b/0x34)
>>>> [<c0a6c1bd>] (dump_stack_lvl) from [<c011fc47>] (__warn+0xbb/0x100)
>>>> [<c011fc47>] (__warn) from [<c0a696e3>] (warn_slowpath_fmt+0x4b/0x80)
>>>> [<c0a696e3>] (warn_slowpath_fmt) from [<c07407b3>] (dev_pm_opp_set_clkname+0x97/0xb8)
>>>> [<c07407b3>] (dev_pm_opp_set_clkname) from [<c07407e3>] (devm_pm_opp_set_clkname+0xf/0x64)
>>>> [<c07407e3>] (devm_pm_opp_set_clkname) from [<c050735b>] (devm_tegra_core_dev_init_opp_table+0x23/0x144)
>>>
>>> Why are you calling this anymore ?
>>
>> Older device-trees don't have OPPs, meanwhile drivers will use
>> dev_pm_opp_set_rate() and it requires OPP table to be set up using
>> devm_pm_opp_set_clkname().
>>
>> The devm_tegra_core_dev_init_opp_table() is a common helper that sets up
>> OPP table for Tegra drivers and it sets the clk.
> 
> Ahh, I see. that's okay then. Just add a comment over it to specify the same.
> Doing devm_pm_opp_set_clkname(dev, NULL) is special and looks suspicious
> otherwise.

I'll add comment, thanks.
