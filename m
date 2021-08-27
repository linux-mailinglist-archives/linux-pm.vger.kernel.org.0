Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429A83F9368
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 06:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhH0EJK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 00:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhH0EJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 00:09:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479B3C061757;
        Thu, 26 Aug 2021 21:08:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c12so9112210ljr.5;
        Thu, 26 Aug 2021 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V1I4L+WuQcg7nWDY9KXq21TZu2GnKesC/k47Saxr6QE=;
        b=fvxGy3KeiW5F1WxZjJBhdz8dmeqbJ+TxHhoj24arnoPWM1erBG4dUf/34j3vnKxEya
         KbylsG3L/RjG5QPagD5JWYMwIZgORVLRcYFPapM3f95IW3i3kpDuwO9ea9q0sgdTHDWn
         QB0nDotBPb9jehl0SgNToLoTc6H4NWwaTI/IwviUuW1PlfNFQpan7rD+6aZuxKIDRvni
         esAAfvnR8hhFk+sKXr/ZsND2q7V9bMmXCZLjjBS+/vUhbdn6Xh856zqmVR9Ui5XmYWDl
         EBSneHXzzHbCQH+fC2s7uB3KPRbpBLhHJkDGNgQXvJ03UlFASH34RFeoN3Nxuna8rxbt
         BEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V1I4L+WuQcg7nWDY9KXq21TZu2GnKesC/k47Saxr6QE=;
        b=dx9fsxrAzxz9p0aRvnRdX7nH7EufpnPypIacXUNp8DjIOX/8cT/Y3Zj3KGKXv9Pm5b
         55oLiL5c+bBlnCt9HfGyHlBW+B3EhML5LdTKo2DdM8BaoA1FV0+8vN9e8g9Ayvoz8dDz
         x8o5WYCX3mBSh2cnwGsIWcusEP498r7CsSU8o1DXM2+ojEi/b/o48rtg1UNpopxjf0Le
         rkuCalfM9yvtg1/jnE23JSoBMyLzOBwah+Ikp39fypV0pSccw7UG8DAI7J7LNki+R4id
         UvEDA4QJ3tJKrJACtsY/T5pzMoi4fT8hJOWgLHodtoVUH0KeBX5psGdgmypSMzAhuhaR
         TkIg==
X-Gm-Message-State: AOAM531CbE1hW59wcE/YbT5EjUuIts2ydxWmEaN3irzenIRozxvXwX8w
        vF6eSCSaGy1FTv+HbDM5+T7bvu3SoSo=
X-Google-Smtp-Source: ABdhPJwf11QWDRb1QrI5lmIND74fU73c+Xz/hXkvk9+Fcx1Ncsvp8ge/xtvcMB8fGteiXGN9oky+DQ==
X-Received: by 2002:a2e:9802:: with SMTP id a2mr6017695ljj.470.1630037299403;
        Thu, 26 Aug 2021 21:08:19 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id c19sm553142ljn.75.2021.08.26.21.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 21:08:19 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4a945d40-b30a-8a30-bdf8-4e17ad26cea7@gmail.com>
Date:   Fri, 27 Aug 2021 07:08:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827040239.roal5jpndamzotle@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 07:02, Viresh Kumar пишет:
> On 27-08-21, 06:47, Dmitry Osipenko wrote:
>> Actually, it doesn't work.
>>
>> The devm_tegra_core_dev_init_opp_table() needs to set clk to support older device-tree and now OPP table already has clk being set.
>>
>> WARNING: CPU: 2 PID: 92 at drivers/opp/core.c:2146 dev_pm_opp_set_clkname+0x97/0xb8
>> Modules linked in:
>> CPU: 2 PID: 92 Comm: kworker/u8:1 Tainted: G        W         5.14.0-rc7-next-20210826-00181-g6389463cbb0a #9318
>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> Workqueue: events_unbound deferred_probe_work_func
>> [<c010cc91>] (unwind_backtrace) from [<c0108d35>] (show_stack+0x11/0x14)
>> [<c0108d35>] (show_stack) from [<c0a6c1bd>] (dump_stack_lvl+0x2b/0x34)
>> [<c0a6c1bd>] (dump_stack_lvl) from [<c011fc47>] (__warn+0xbb/0x100)
>> [<c011fc47>] (__warn) from [<c0a696e3>] (warn_slowpath_fmt+0x4b/0x80)
>> [<c0a696e3>] (warn_slowpath_fmt) from [<c07407b3>] (dev_pm_opp_set_clkname+0x97/0xb8)
>> [<c07407b3>] (dev_pm_opp_set_clkname) from [<c07407e3>] (devm_pm_opp_set_clkname+0xf/0x64)
>> [<c07407e3>] (devm_pm_opp_set_clkname) from [<c050735b>] (devm_tegra_core_dev_init_opp_table+0x23/0x144)
> 
> Why are you calling this anymore ?

Older device-trees don't have OPPs, meanwhile drivers will use
dev_pm_opp_set_rate() and it requires OPP table to be set up using
devm_pm_opp_set_clkname().

The devm_tegra_core_dev_init_opp_table() is a common helper that sets up
OPP table for Tegra drivers and it sets the clk.
