Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C853E9C00
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhHLBkf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 21:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhHLBkd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 21:40:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27B3C0613D5;
        Wed, 11 Aug 2021 18:40:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n7so8019982ljq.0;
        Wed, 11 Aug 2021 18:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0MSveyJjLXImxpdu0C0hUm8m0UQzwOm1b1lGIh3ij04=;
        b=kEvhNsPT1Mh5koxgm7JSi5bsT4K1jkqzm2sz4aUEorl7EezBk0pZo7NLctdYWuQjkT
         FFXpPBc9HPFBov4bB1UIpGTzPtJP+vvfWLcKnugdCXkGvciV2gCfLQkgtjWMoPUX1tqp
         GihIJhyKFrV2C4Yu5zm4PddYljKHLZKEX03IGVpO+IkvCBtqhtlReHb9mhX4SgRV+7MO
         IyoZP68aD6PuncWbBTtRCisnb5AsFjC5F1+1HkCCkDKsJurt7+fmK4aNt4afYkGMej0J
         q6FHiRf+RyJYNtE1VtcouOSTbgJPSkjKAYqP36qUyf+XAbYlcoHwW1NX/VwwWqs0Iy1t
         W/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0MSveyJjLXImxpdu0C0hUm8m0UQzwOm1b1lGIh3ij04=;
        b=YcGeRnqMDQ0s4FT6vANUAz0ChDfJ47iaVybMQXyGluzw3ceSDOCar1eq5q5VL2+MMU
         +c/iuE2xJsM772f6mE741bRkiPrs2b/FPyqznkq8N1yxOgSRadAneRhSEAUs7KlxJfRu
         vLxUAn3lNUxsKCWmbLPaJLCsV6Bjv9UCGuwWAb1Ai1KsFbRou/vWM/PP8STObXEvzyf9
         pQBeEZ9QhEgzYradTbr3CD6RUXnZcuDYUb+vFxKHNIA1gN0yCPUx86B6oiIYsQ2YWJM+
         eL5rL9vH2kSiK52v1gKP8IhumhOjge/s8Ma+0QYp2MqlQwA3UU6EuCpjTynDjLXQFuUH
         pN0A==
X-Gm-Message-State: AOAM532JfQB42oG2oKaMPk4T9I8VMMC0rLufyF8PThSNzLKckd6FexOo
        PfRc4ZsUMaDXSTCunjEKEXflGWuND/g=
X-Google-Smtp-Source: ABdhPJxyf3JPf06cPGGELMY241Zb0GE/+7If22YtmX0pWKEEVkdOW8zH47pzihPAXvxexIiIxh46Qw==
X-Received: by 2002:a05:651c:b28:: with SMTP id b40mr1107549ljr.504.1628732406876;
        Wed, 11 Aug 2021 18:40:06 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id p8sm122711ljn.108.2021.08.11.18.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 18:40:06 -0700 (PDT)
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210701232728.23591-1-digetx@gmail.com>
 <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
 <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
 <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
 <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com>
 <CAPDyKFq+ExjbGrN=yUUXPKfN_fGrwY6EAYn9a6VUFFU_VjhC=g@mail.gmail.com>
 <6741262b-386b-7635-fd42-ebd4f877fddd@gmail.com>
 <CAPDyKFpJhX51rOnvbYTmj9Akd+xX+b7xcSWt87UDrvMEfYOZ7Q@mail.gmail.com>
 <aab38f90-f7b2-900f-897b-470b81d473f2@gmail.com>
 <8e110e08-1268-464c-6edb-0a3f640d43d6@gmail.com>
Message-ID: <e21106ab-95ef-fc97-1744-dc58180e321a@gmail.com>
Date:   Thu, 12 Aug 2021 04:40:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8e110e08-1268-464c-6edb-0a3f640d43d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.08.2021 01:41, Dmitry Osipenko пишет:
>>> I am not saying you should change the clock rate. The current code
>>> path that runs via devm_tegra_core_dev_init_opp_table() just calls
>>> clk_get_rate and then dev_pm_opp_set_rate() with the current rate to
>>> vote for the corresponding OPP level. Right?
>>>
>>> Isn't this exactly what you want? No?
>> I see now what you meant, it's actually a simpler variant and it works
>> too. Thank you for the suggestion, I'll prepare v8.
>>
> My bad, it doesn't work at all. I actually need to use the rpm_pstate or
> something else because performance state is coupled with the enable
> state of the device. If device is never rpm-suspended by consumer
> driver, then the initialized performance state is never dropped. Hence I
> want to initialize the state which is set only when device is resumed.
> 
> I'll need to think more about it.

GENPD core has these false assumptions:

1. It assumes that by default all devices are at zero performance level
at a boot time. This is not true for Tegra because hardware is
pre-initialized independently from GENPD.

2. It assumes that nothing depends on performance level and devices can
operate at any level at any time. Not true for Tegra and other platforms
where performance level is coupled with clocks state of attached
devices. OPP framework glues clock and performance level together for
us, which works good so far.

Hence I either need to patch every driver to use dev_pm_opp_set_rate in
order to sync clk rate with the perf level at device runtime, or I need
to preset the rpm perf level to allow GENPD core to set the level before
device is resumed.
