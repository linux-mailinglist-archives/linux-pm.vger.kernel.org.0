Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0543C211BA4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 07:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGBFnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 01:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGBFne (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 01:43:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435FAC08C5C1;
        Wed,  1 Jul 2020 22:43:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so22975382lji.9;
        Wed, 01 Jul 2020 22:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8q209O2LZaPOsMqrkcwLXZ9FBAITgOWF27/Mx+CT9XE=;
        b=m6mNKjiOin5lgFBuoN5BSEkJnGnaqUFj0LyH9vfXAI5kXFAMaAD6Gk3FH/jPRl178h
         fQQTlpUePeq4EXUm+oADV3rXutKG7wXyJp3IncAg0FLgPdK/lnLbIYinqm7vTd5aTomr
         bRsdSbtBZyNLj8Cmo9hNk0ljmnqAHKyZaHUxC2Krf5RbVQPtqeBl/I1c+fH6u/cU4H0e
         o7KEvY2B/Zd/aMNH0/sxZjXV+Y1pDAzxvquulWy91PqKwp6x8Iv7ZGcv4rrLL+7Ze3nq
         zIAOFLXLO4GSLT/gZxs45TYfQE8HBqC6n+Zd1SBHCeT736pqB73Rpxq0lCY03gtwKQK7
         kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8q209O2LZaPOsMqrkcwLXZ9FBAITgOWF27/Mx+CT9XE=;
        b=bPHXNhJSU7y/SPcPP2TiZmVqkeOg6nufoxFvLdcx9VMZSkn/kg5oydqsqWX+mgj5yR
         YP8Nwy8TMbO1J6zpVGeRA9OfdBgkH/av4pCBP9Kjiht4JFGyl8yU/KvE0NWX4r2G42CV
         b+SmnUKGQYvl4VPCgRGFKA0EUy4SbGsgDVTDQYuCoXi0jnwLyipyP4DuNSFOBe5e0VFU
         LKNpj+wZUBYjPE6pG458rsCjyyHCqN3igY120j+jBGvgDqCsrF2f7rtJt8mqzCwoCqkT
         +SwXsI6/qpo9ogNmEnj2kIJrWzh7wJnFfYPNy64horoSacCu0mVQ8i6lZMggwSU+UUxG
         mSkw==
X-Gm-Message-State: AOAM533KuPA8IbtEkWnvPCc79rUA9mUdNcauxjyStIM4kaiNvHRY52mC
        SKVElh5D4YBamJLqELkAJTe458BhVrQ=
X-Google-Smtp-Source: ABdhPJzNDK/EGBA1dP+Bkg8lYhHrdYDFzeDuloBP68+sx4P4oGWh2smxM3ZdupKE9ncqdIA0J+glXQ==
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr6402902ljj.333.1593668612201;
        Wed, 01 Jul 2020 22:43:32 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id w24sm2937288lfl.17.2020.07.01.22.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 22:43:31 -0700 (PDT)
Subject: Re: [PATCH v4 12/37] PM / devfreq: tegra20: Use MC timings for
 building OPP table
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <CGME20200609131458epcas1p2c774a0302bcef2c02790c2cb8cad57a0@epcas1p2.samsung.com>
 <20200609131404.17523-13-digetx@gmail.com>
 <4ea7fe00-7676-3186-8222-6e0d0eb8ed1f@samsung.com>
 <4b22d3ee-f303-d81d-e261-187d4a46e749@gmail.com>
 <2069fb51-f043-795d-7768-0024fc9a9f4e@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7988b6cf-e60c-7e5c-ffc3-8075c20af3d3@gmail.com>
Date:   Thu, 2 Jul 2020 08:43:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2069fb51-f043-795d-7768-0024fc9a9f4e@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2020 08:30, Chanwoo Choi пишет:
> On 7/2/20 2:07 PM, Dmitry Osipenko wrote:
>> 02.07.2020 07:18, Chanwoo Choi пишет:
>>> Hi Dmitry,
>>>
>>> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>>>> The clk_round_rate() won't be usable for building OPP table once
>>>> interconnect support will be added to the EMC driver because that CLK API
>>>> function limits the rounded rate based on the clk rate that is imposed by
>>>> active clk-users, and thus, the rounding won't work as expected if
>>>> interconnect will set the minimum EMC clock rate before devfreq driver is
>>>> loaded. The struct tegra_mc contains memory timings which could be used by
>>>> the devfreq driver for building up OPP table instead of rounding clock
>>>> rate, this patch implements this idea.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra20-devfreq.c | 18 +++++++++++-------
>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>>>> index 6469dc69c5e0..bf504ca4dea2 100644
>>>> --- a/drivers/devfreq/tegra20-devfreq.c
>>>> +++ b/drivers/devfreq/tegra20-devfreq.c
>>>> @@ -123,8 +123,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct tegra_devfreq *tegra;
>>>>  	struct tegra_mc *mc;
>>>> -	unsigned long max_rate;
>>>> -	unsigned long rate;
>>>> +	unsigned int i;
>>>>  	int err;
>>>>  
>>>>  	mc = tegra_get_memory_controller();
>>>> @@ -151,12 +150,17 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  
>>>>  	tegra->regs = mc->regs;
>>>>  
>>>> -	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>> -
>>>> -	for (rate = 0; rate <= max_rate; rate++) {
>>>> -		rate = clk_round_rate(tegra->emc_clock, rate);
>>>> +	if (!mc->num_timings) {
>>>
>>> Could you explain what is meaning of 'num_timing?
>>
>> The num_timings is the number of memory timings defined in a
>> device-tree. One timing configuration per memory clock rate.
> 
> OK. I understand.
> 
>>
>>> Also, why add the opp entry in case of mc->num_timings is zero?
>>
>> Timings may be not defined in some device-trees at all and in this case
>> memory always running on a fixed clock rate.
> 
> You mean that 'timings' information is optional?

Yes

Actually, looks like I missed to properly test this case where timings
are missing in DT and it shouldn't work with the current code. I'll fix
it in the next version.

>>
>> The devfreq driver won't be practically useful if mc->num_timings is
>> zero since memory frequency can't be changed, but anyways we'd want to
>> load the devfreq driver in order to prevent confusion about why it's not
>> loaded.
>>
>> For example, you may ask somebody to show contents of
>> /sys/class/devfreq/tegra20-devfreq/trans_stat and the person says to you
>> that this file doesn't exist, now you'll have to figure out what
>> happened to the devfreq driver.
> 
> I understand why add OPP entry point when timing is not defined on DT.
> But, actually, I think that you better to change 'timings' info is mandatory
> instead of optional. Because the devfreq driver is for DVFS
> and the driver supporting DVFS have to have the frequency information
> like OPP.
> 
> Or, 
> If you want to keep 'timing' is optional on DT,
> I recommend that you add one timing data to tegra mc driver
> when DT doesn't include the any timing information
> I think that is it more clear.

Okay, I'll move it into the MC driver in the next version.

Thank you for the review!
