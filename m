Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5884F39AAAC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCTKd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFCTKc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 15:10:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69949C06174A;
        Thu,  3 Jun 2021 12:08:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c11so8481338ljd.6;
        Thu, 03 Jun 2021 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tSg8tzkQArywSk43mbgKRBHIz2Yfe5Of+oE/8zi9t+M=;
        b=JG/HwBkaJ55V8FyaTfwresS1WJPGo918x+rSkU/RebcMnjdEsBfpTwRL4BM9L07kV+
         tjfFI0DnEFbVaAgk2uBRZUk9fVWCJrjU6wc2faqB83+GS+5jL62wjZwyOiI8u8DDMVRJ
         N+O4tuUwbg1NPBAqYAUl+Pfl9XKckm/N8ZKfHwQYFb3XGGKSnrVfdz3lRisd4Q2tGDIQ
         lLoob6FG5LWx7ALMFe6D5KjPlVg6P4G/bTrGhYrB7Mxtar1tsorADQTnl3PK/CgJpeNf
         fQZUFJXt+ZeEiMDPRKAkpWz+AfM3pLGoS+3l7DdSnCDpGKRtgfng/qvo70QLaNqgDEAb
         0GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSg8tzkQArywSk43mbgKRBHIz2Yfe5Of+oE/8zi9t+M=;
        b=HxJBNaFcNRaYbiaY6joelkTTgC/B61ynPYx13iQWLONj5k7pg+cuFF2vXIo1Mwazat
         qi9nKT1CydTS2BnWFXWeufu947+akGFZuEkupivvFDZnvJntpk4ex/wSTjGTw27S9SxO
         cbMv6Ngo6CyAwEMsUJewpPI4vqhjq4Kj/nOAzlRgERURDjgHlWdfs+gd4B7DqKhv7yYh
         H93u5II0h5d7fWgxzWcDm/UYnvbqeMwIv4nj6ekfArIcA7ZP61Qc1kJUAVV91JD6p2Px
         Oi9w/4WZjw1+iKR7m6G3MJZPBxEaycbRhNSqZ7QhcG9djz83Y1UXELwx4i2PGgFrFFXK
         c+5w==
X-Gm-Message-State: AOAM532LBiQI7hZsCHlAlt5jwI3hbHpD6zXwMnOZMPO0kZv/Ztl5jscY
        zStHiyGwIP7s/KZErEuqSNCnSSe8M74=
X-Google-Smtp-Source: ABdhPJw3EI+7WIk7yuTpQPpGCBcBGAHcCTKZfUumUYF3Byn1/NF3wKOLTi0a7tcmGemaz7fF42KTRg==
X-Received: by 2002:a2e:bf14:: with SMTP id c20mr602441ljr.57.1622747324663;
        Thu, 03 Jun 2021 12:08:44 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id o19sm396996lfd.22.2021.06.03.12.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:08:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org>
 <a7f55fce-dd4a-22ab-f7e2-4821e765a634@gmail.com>
Message-ID: <1f71868c-7274-b4f8-e66d-dfb47cf44731@gmail.com>
Date:   Thu, 3 Jun 2021 22:08:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a7f55fce-dd4a-22ab-f7e2-4821e765a634@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.06.2021 22:02, Dmitry Osipenko пишет:
> 03.06.2021 12:34, Ulf Hansson пишет:
>> A subsystem/driver that need to manage OPPs for its device, should
>> typically drop its vote for the OPP when the device becomes runtime
>> suspended. In this way, the corresponding aggregation of the performance
>> state votes that is managed in genpd for the attached PM domain, may find
>> that the aggregated vote can be decreased. Hence, it may allow genpd to set
>> the lower performance state for the PM domain, thus avoiding to waste
>> energy.
>>
>> To accomplish this, typically a subsystem/driver would need to call
>> dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
>> callback, to drop the vote for the OPP. Accordingly, it needs another call
>> to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
>> ->runtime_resume() callback.
>>
>> To avoid boilerplate code in subsystems/driver to deal with these things,
>> let's instead manage this internally in genpd.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Changes in v2:
>> 	- Rebased.
>> 	- A few minor cosmetic changes.
>> 	- Deal with the error path in genpd_runtime_resume().
> 
> I tested this on NVIDIA Tegra by removing the boilerplate code from
> drivers' RPM and haven't noticed any problems, the performance state is
> dropped/restored as expected. Thank you.
> 

Tested-by: Dmitry Osipenko <digetx@gmail.com>
