Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7290439AA9F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCTFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 15:05:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC26C061756;
        Thu,  3 Jun 2021 12:03:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d2so4304015ljj.11;
        Thu, 03 Jun 2021 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CKsULA7rThjPaUHGFT8H1xt4qomXuIlWh+26mqVq67o=;
        b=aya4yneFWMDMGtWFiZacm/sMQaQS4ElC2xTGZQ3N49LFvla8PRz9lrV/j2MfJzFIAK
         gljbcs2qelv8/ksXND77uXLkOsAFdJoTJlKK+4QImPgyb+EX7gfelSQafCIUF4BxsyOU
         RyYAag8SW7Kx6X/6ped2sveIGmwi9YHcO9v60HyWlTTitNbdk1afs9+RRPuXYUnIdKr1
         2ebCIC573NuMB6krZqgQXKLHQrkA1iYfwYOx1UAu99PoQqu2WWCB/TJWFuaURA3nUiCA
         Kyel1WEbQaMeY/z1uAOIxvac38Q12381yHXno4QCplZ3/N+bXeS+zg4+NvswJiL+2TKy
         xstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKsULA7rThjPaUHGFT8H1xt4qomXuIlWh+26mqVq67o=;
        b=nG79rG9T6WU9oLTO06E0O00DBrC3W8vWazu2RTRQLWck2AOtqyzdrQPMlXjx9/ogRm
         XdIwDilBwjWbX3h/3dnc3wpc4c6818YVjf71jGy2Gr2A8AqxAGirTmMVhrYUap5r1aR3
         +dlPvSztAH46KzIdPsaVXjgHDH/z6+Ci6qJ3xA4QznFfLJJnRvNFJ51euOUJXCnC8DWn
         DeRjgFAvUHIvkglnM+pOWZg/sR0WaVHS0qc55G4UxIMjvqxLo7j4EbWpz7Yt7VEXc0fD
         QFZfWbaUNnRN+LrK59FuuF04e6tZKdJ/RTE27tex1qM1evhjLmaeR9NVPM3auTtzByXL
         1Pog==
X-Gm-Message-State: AOAM533XK2bK5+I236x5Vceifh7PI6nKzDN6ggCQaCG6g71IF71Feeqn
        eb327TA7nW7ScQTdFmjStDg58u1xua8=
X-Google-Smtp-Source: ABdhPJzDgjsNGfQa4Aq8TvhzEWXv55Rt2l5v11MPCBxr2Daq0yo1wOfHUon9pH+FgEtIKU0W6I9ToA==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr560499ljo.456.1622746980700;
        Thu, 03 Jun 2021 12:03:00 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id w4sm449277ljo.1.2021.06.03.12.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:03:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a7f55fce-dd4a-22ab-f7e2-4821e765a634@gmail.com>
Date:   Thu, 3 Jun 2021 22:02:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603093438.138705-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.06.2021 12:34, Ulf Hansson пишет:
> A subsystem/driver that need to manage OPPs for its device, should
> typically drop its vote for the OPP when the device becomes runtime
> suspended. In this way, the corresponding aggregation of the performance
> state votes that is managed in genpd for the attached PM domain, may find
> that the aggregated vote can be decreased. Hence, it may allow genpd to set
> the lower performance state for the PM domain, thus avoiding to waste
> energy.
> 
> To accomplish this, typically a subsystem/driver would need to call
> dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> callback, to drop the vote for the OPP. Accordingly, it needs another call
> to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> ->runtime_resume() callback.
> 
> To avoid boilerplate code in subsystems/driver to deal with these things,
> let's instead manage this internally in genpd.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Rebased.
> 	- A few minor cosmetic changes.
> 	- Deal with the error path in genpd_runtime_resume().

I tested this on NVIDIA Tegra by removing the boilerplate code from
drivers' RPM and haven't noticed any problems, the performance state is
dropped/restored as expected. Thank you.
