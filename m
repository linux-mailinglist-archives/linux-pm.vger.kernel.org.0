Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2C3E98C9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhHKTbF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKTbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 15:31:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E7C061765;
        Wed, 11 Aug 2021 12:30:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so8247223lfa.0;
        Wed, 11 Aug 2021 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U49hpqpAfikeBr8XRmq6oV/PuhbJY4dwE5RfQitZpNk=;
        b=O2FSCMxlKOo72c2TgWAJmQMpSZz+N5+sngAdPTPSDCHvz+FkXyTuexQbEuLou/O9Yu
         Rj3B/UlLwX8oPC/ol9i+T6ksM6x6HWZzeUYkDojNLtanrEJxEkVxCNIq1awdZiuZl6kK
         Y4j4vvdgIrPWtT8OLNr4zye1YURYPZCba9Ia7sPVVLzSbYm/k/iAc87bJbOlfVtpjxg8
         ZrJsBXu/OROjdwDM4xVkxVpBK4c/N/O9guouC5atWNYtAfe8ivX36owTT6ccoAmthNJx
         eYAhwx5Mcp7ydpe4kss4XhG95ymhbdjdcGaQKWb02ZZSwc6FWZcvoK5rnfDoBsYvoo5l
         RLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U49hpqpAfikeBr8XRmq6oV/PuhbJY4dwE5RfQitZpNk=;
        b=gep/9MVc90TCP+k3x7CRrjQfebuGXOcuTaMsjonui/nrRahVuv0zmC6kUW5TB/BfL0
         uShcjTTgHHk6efiBm8N/plWKyyW4wNWkIc3deMIIDK1urPzbTwNllPPtBVHQeLJES0Fw
         TxSqqUN+fm/jQDC8Bj7c5W+NdbQvJNSBsEh/kMUt4R975lvEX9ihAjWRdekKy/M9nzB6
         lT6+AfQKUmCqgXqxfShVjjHgTvy9yCDw1qfevX9UKpLVAZ9LiaDjcA64f6gJI3hjIPOU
         WCV4VGOkVRYGBpG0YTnaJLW8ljQlU3mMGJKOKthPr3ORGptt9bWFY+wi+Drhtj+k/0If
         03hA==
X-Gm-Message-State: AOAM531QQW10WVVoR14I0QhVWbATsT3OOKodgZFrcd4QBlhRxBht5PrR
        U0+GClWMpQstd+ciub9HcWCxyAiG0D0=
X-Google-Smtp-Source: ABdhPJz3ibBPz43adiGssh13p3+QU/PHQyqcGTQOHXJrK2cymxM0/iBKMOJaE30QbpoJwOG9R6XYQw==
X-Received: by 2002:a05:6512:1584:: with SMTP id bp4mr272315lfb.504.1628710238760;
        Wed, 11 Aug 2021 12:30:38 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id u22sm25022lff.270.2021.08.11.12.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 12:30:38 -0700 (PDT)
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aab38f90-f7b2-900f-897b-470b81d473f2@gmail.com>
Date:   Wed, 11 Aug 2021 22:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpJhX51rOnvbYTmj9Akd+xX+b7xcSWt87UDrvMEfYOZ7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.08.2021 13:51, Ulf Hansson пишет:
...
>> +               if (power_on) {
>> +                       ret = dev_pm_genpd_set_performance_state(dev, default_pstate);
> 
> However, this is more questionable to me.
> 
> First, I don't think we should care about whether this is "power_on"
> or not. At this point, performance states are treated orthogonal to
> idle states in genpd. We may decide to change that in some way, but
> that deserves a different change.

Okay

> Second, I don't think we should call
> dev_pm_genpd_set_performance_state() from here. It's probably better
> handled from the genpd callback itself, if/when needed.
Indeed

> That said, perhaps the new callback should just return a regular error
> code and zero on success, rather than the current performance state.
> See more below.
> 
>> +                       if (ret) {
>> +                               dev_err(dev, "failed to set default performance state %u for PM domain %s: %d\n",
>> +                                       default_pstate, pd->name, ret);
>> +                               goto out;
>> +                       }
>> +               } else {
>> +                       dev_gpd_data(dev)->rpm_pstate = default_pstate;
> 
> No, this isn't the right thing to do.
> 
> It looks like you are trying to use the ->rpm_pstate for
> synchronization with runtime PM for consumer drivers. This is fragile
> as it depends on the runtime PM deployment in the consumer driver. I
> think you should look at ->rpm_pstate as a variable solely for
> managing save/restore of the performance state for the device, during
> runtime suspend/resume in genpd.
> 
> Synchronization of a vote for a performance state for a device, needs
> to be managed by calling dev_pm_genpd_set_performance_state() - or by
> calling an OPP function that calls it, like dev_pm_opp_set_rate(), for
> example.

The !power_on case should be skipped at all because common core code
can't handle it properly, hence rpm_pstate shouldn't be touched. I
realized it only after sending out this email.

...
>>> Rather than doing the OF parsing above to find out the current state
>>> for the device, why can't you just call dev_pm_opp_set_rate() to
>>> initialize a proper vote instead?
>>>
>>
>> For some devices clock rate is either preset by bootloader, or by clk driver, or by assigned-clocks in a device-tree. And then I don't see what's the difference in comparison to initialization for the current rate.
>>
>> For some devices, like memory controller, we can't just change the clock rate because it's a complex procedure and some boards will use fixed rate, but the power vote still must be initialized.
> 
> I am not saying you should change the clock rate. The current code
> path that runs via devm_tegra_core_dev_init_opp_table() just calls
> clk_get_rate and then dev_pm_opp_set_rate() with the current rate to
> vote for the corresponding OPP level. Right?
> 
> Isn't this exactly what you want? No?

I see now what you meant, it's actually a simpler variant and it works
too. Thank you for the suggestion, I'll prepare v8.
