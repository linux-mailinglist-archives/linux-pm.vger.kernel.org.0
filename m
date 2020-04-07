Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5761A15A6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgDGTMF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 15:12:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33595 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGTMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 15:12:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so3303893lfc.0;
        Tue, 07 Apr 2020 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CF9EVkMcPXMLKckuhEi8Rm3sQX799rg96bk7BbCR0Pw=;
        b=AtJC2mfTzvxyg4EVv/8nFSUIkD0xfX8P59C1zdFpCOgqzoywoKw2zMD4zhktYPYzKP
         rgAUBhwYTy5OrRTuShl3I0k6Csj3jS3zDSmqLLxCVWRa4619jWf6d8lxxBWtig+gvHLu
         8cw/rgZKgVLCqEpbMSxf+8LaEXej4zdu3ZLHKGTd1ItZtLqF1OetnaiVS4c37ZV7kPhE
         TXCCxDGJeqCzjrSoI6SSFyvBtYlURGmmE5lUP9skRgoIXMJmijiT7yIKwmDoD/cjeo0X
         kTEhHNohnTnnG3ran3l7Rmt+YZmBQspA6ak6+xyrUjxVMRy3tQqqd6oeyx22IMv9jsNs
         mpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CF9EVkMcPXMLKckuhEi8Rm3sQX799rg96bk7BbCR0Pw=;
        b=nzQpuI8QpNGza9f/h+V6wixFMxbSAEJJccPce1oGj58icX2d2mtGbcs/nHQq67d1Ce
         Rdfb1l6QT/O0SWYR/+hYHDneEPFNf6C+DsUtfZCcjYEOpMnx9a2X/hF//NCGP0q0LpgC
         Cb3GqGwaDAD1aj9CEUTm+QhCa6VGuORMpCmKZyDfs24NdX9pT+no6aA5RXWrvrtGnhbg
         LSs1agFvG3lb2GSd4ODBuMozxPMbe0AJ76bbd38t4IhSK2ufoUQuSeJvZ9wUZpGlUDyx
         Lh6mqD3JUQJc0oQNG+Vw03Z1bq/B8isWmhXzHFkIdD7tcrvz7fdlF0hF8WWjnGuvd7aS
         0onw==
X-Gm-Message-State: AGi0PubtZ1E78whqVb4uEDM+SaMRPyijnINpJUWpqE06/iOYOZfwehU6
        XsC1f5D9K/+EZJHZZMgAVbA=
X-Google-Smtp-Source: APiQypKLhUCx0eZnDHj52JEjnwmcfs/bE/1CLscRFZDkrSrz/iXzWyI75wF3JRRIMi8u5Jgbyvys6g==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr2376490lfm.91.1586286722428;
        Tue, 07 Apr 2020 12:12:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id 203sm12202499ljf.65.2020.04.07.12.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:12:01 -0700 (PDT)
Subject: Re: [TEGRA194_CPUFREQ Patch v2 2/3] cpufreq: Add Tegra194 cpufreq
 driver
To:     sumitg <sumitg@nvidia.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, mperttunen@nvidia.com
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
 <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
 <67f9feb1-ba51-f1ac-b6eb-4587924d0748@gmail.com>
 <538ddcf4-b760-a342-eab6-5a61c9bd860a@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3009a636-0c85-c867-6dcb-2deb1a610a00@gmail.com>
Date:   Tue, 7 Apr 2020 22:12:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <538ddcf4-b760-a342-eab6-5a61c9bd860a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.04.2020 21:55, sumitg пишет:
...
>>> + * Returns freq in KHz on success, 0 if cpu is offline
>>
>> I don't see any checks in the code about whether CPU is offline.
>>
>> Googling for "queue_work_on offline cpu" suggests that this function
>> should hang.
>>
> Tried this and didn't get crash or hang.
> show_cpuinfo_cur_freq() returns "<unknown>" value on reading frequency
> from a cluster having both it's cores offline.
> If only one cpu is offline, then frequency of other online cpu which is
> managing the policy of that cluster is returned.
> Have still added below check as guard in get|set() freq calls.
>     if (!cpu_online(cpu))
>         return -EINVAL;
> Thankyou for the input.

If CPUFreq core takes care of taking into account the offline CPU, then
the check isn't needed. It also wouldn't be enough if there was a
problem here.
