Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6113D211BB7
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 07:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgGBFxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 01:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBFxM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 01:53:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC53FC08C5C1;
        Wed,  1 Jul 2020 22:53:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so15207393lfe.9;
        Wed, 01 Jul 2020 22:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwHCT7cT5X5SdEciMo4uCbOZCo5n65PfdpAKlH+e0hw=;
        b=FaeLrB1PxfX9Rsw/lPFjelWqksRrbsEITJFJeCizLaLwdP9ptRy3tMKhctrK9R6CYb
         A8nh51VNmcK5plrXDtyDG9ONNrRVmwEZg4d5jOjyn1M7Zv4yuzv20vCqUTpCv/UN9reM
         0J/Aazqbh2YVku/j72RTB/OKgDHo7woJWRAIO6VM/4mO7P4+I1UarkTpQJAEdcdm8IMv
         PM2DtVEx29/IgoQkPD/+MH1lNZuzUFdPpgXpks+P8GcvoLFDytKBUI6boI6c9HtXeE9F
         An8Rj/UTes1byT+HZCjUEHlF/XLw+3G/BRf8oiXykibH0xR8E5u9VsawaRpJJYhAdc4Z
         X2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwHCT7cT5X5SdEciMo4uCbOZCo5n65PfdpAKlH+e0hw=;
        b=mDaSqwAt24kCEz1jxF2hpJCHZ+JunXKZbYkrttQvr12AcRcsBOafi9zNd28g2WKLCX
         Z6rIqu8po591s+NG2fpHsCPDDg7DI/UMPaaCvxBSLC5EiJBw7GzXq5CPtxNgxiPsi0LY
         dFyM7nOCLReE84wUeAAsF+DRFV+1nfddML38TsE5LLo2rz/1jT6Pc0O7c4gbvXXuM0Eg
         dU99yMWbMlJJezml0ElUDWPl/tnpUyAqP+6DyzRtV0i9A+V0a2ZqxnqkSI/Yk93+WPAl
         BHSJ6JU816w7s9XtqO5qcOsNXqDc34J6dPUpM7e1QVooCBdk/VRu6ajX8vzz2oRbI8u6
         YMOQ==
X-Gm-Message-State: AOAM532l+ZPBpk59ca0MWe+Xp5antRuR0WzGr0vE0CBphElXCg7GEbYU
        a84Eubl+9e8ZNa0ni8wPxvOBCp0LN6E=
X-Google-Smtp-Source: ABdhPJwavK+SIIiWOV66MVXkfysc7JQV+BS31nbzvmYL6xd58vIGpeeocZo16IZXV41yYLdjSkOmXw==
X-Received: by 2002:a19:691c:: with SMTP id e28mr17498281lfc.131.1593669189870;
        Wed, 01 Jul 2020 22:53:09 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id c27sm2939944lfm.56.2020.07.01.22.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 22:53:09 -0700 (PDT)
Subject: Re: [PATCH v4 12/37] PM / devfreq: tegra20: Use MC timings for
 building OPP table
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <7988b6cf-e60c-7e5c-ffc3-8075c20af3d3@gmail.com>
Message-ID: <388eef55-3452-064b-8560-e9d65b908525@gmail.com>
Date:   Thu, 2 Jul 2020 08:53:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7988b6cf-e60c-7e5c-ffc3-8075c20af3d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2020 08:43, Dmitry Osipenko пишет:
> 02.07.2020 08:30, Chanwoo Choi пишет:
>> On 7/2/20 2:07 PM, Dmitry Osipenko wrote:
>>> 02.07.2020 07:18, Chanwoo Choi пишет:
>>>> Hi Dmitry,
>>>>
>>>> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>>>>> The clk_round_rate() won't be usable for building OPP table once
>>>>> interconnect support will be added to the EMC driver because that CLK API
>>>>> function limits the rounded rate based on the clk rate that is imposed by
>>>>> active clk-users, and thus, the rounding won't work as expected if
>>>>> interconnect will set the minimum EMC clock rate before devfreq driver is
>>>>> loaded. The struct tegra_mc contains memory timings which could be used by
>>>>> the devfreq driver for building up OPP table instead of rounding clock
>>>>> rate, this patch implements this idea.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  drivers/devfreq/tegra20-devfreq.c | 18 +++++++++++-------
>>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>>>>> index 6469dc69c5e0..bf504ca4dea2 100644
>>>>> --- a/drivers/devfreq/tegra20-devfreq.c
>>>>> +++ b/drivers/devfreq/tegra20-devfreq.c
>>>>> @@ -123,8 +123,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>  {
>>>>>  	struct tegra_devfreq *tegra;
>>>>>  	struct tegra_mc *mc;
>>>>> -	unsigned long max_rate;
>>>>> -	unsigned long rate;
>>>>> +	unsigned int i;
>>>>>  	int err;
>>>>>  
>>>>>  	mc = tegra_get_memory_controller();
>>>>> @@ -151,12 +150,17 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	tegra->regs = mc->regs;
>>>>>  
>>>>> -	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>>>> -
>>>>> -	for (rate = 0; rate <= max_rate; rate++) {
>>>>> -		rate = clk_round_rate(tegra->emc_clock, rate);
>>>>> +	if (!mc->num_timings) {
>>>>
>>>> Could you explain what is meaning of 'num_timing?
>>>
>>> The num_timings is the number of memory timings defined in a
>>> device-tree. One timing configuration per memory clock rate.
>>
>> OK. I understand.
>>
>>>
>>>> Also, why add the opp entry in case of mc->num_timings is zero?
>>>
>>> Timings may be not defined in some device-trees at all and in this case
>>> memory always running on a fixed clock rate.
>>
>> You mean that 'timings' information is optional?
> 
> Yes
> 
> Actually, looks like I missed to properly test this case where timings
> are missing in DT and it shouldn't work with the current code. I'll fix
> it in the next version.
> 
>>>
>>> The devfreq driver won't be practically useful if mc->num_timings is
>>> zero since memory frequency can't be changed, but anyways we'd want to
>>> load the devfreq driver in order to prevent confusion about why it's not
>>> loaded.
>>>
>>> For example, you may ask somebody to show contents of
>>> /sys/class/devfreq/tegra20-devfreq/trans_stat and the person says to you
>>> that this file doesn't exist, now you'll have to figure out what
>>> happened to the devfreq driver.
>>
>> I understand why add OPP entry point when timing is not defined on DT.
>> But, actually, I think that you better to change 'timings' info is mandatory
>> instead of optional. Because the devfreq driver is for DVFS
>> and the driver supporting DVFS have to have the frequency information
>> like OPP.

That's what I initially did by bailing out from driver's probe if
timings info is missing, until ran into a situation described above :)

>> Or, 
>> If you want to keep 'timing' is optional on DT,
>> I recommend that you add one timing data to tegra mc driver
>> when DT doesn't include the any timing information
>> I think that is it more clear.
> 
> Okay, I'll move it into the MC driver in the next version.
> 
> Thank you for the review!
> 

