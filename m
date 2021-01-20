Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6547D2FDD08
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 00:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbhATWay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 17:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbhATV5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:57:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7BC061575;
        Wed, 20 Jan 2021 13:57:08 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id j3so199524ljb.9;
        Wed, 20 Jan 2021 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ceHRCJDK3HYsIEFwVaZdcOC3/1LUUaiOgnlHMxXcJKg=;
        b=W4ZRzJICVHiuDztf0opX/vCbrya/2gxGbYiulmDAeN26an7pfDLwC4uXVeSsZjs2qP
         cAIeGhUo4T20zGUkQwArJb/rD7L2agpHRuA4x84VPsCwWZP/JW9zAMLfMwjVXhVJRMx0
         n8IKlOMybH2T1r8fxngsjrDBnq7dID9jfN/zRu0TjA9rPmO9p9HuQl53eeYWaPitLDsJ
         ZqIELerQYMLrCrtSmIBa3YXesH/Rr3lL8eBp/foZBi5/yw6hJ+wUqi3Gz+orqqqa0D2t
         bLUD7GdJGCCXvkEsXyNOuOI/9/ldHYAJfNE0L8LglMfczwKtfYEOgWJ+dhHt4kH2bmXw
         reNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceHRCJDK3HYsIEFwVaZdcOC3/1LUUaiOgnlHMxXcJKg=;
        b=icVs2wgz1sxsRk2joxvFo7LHGeexY8B19C9qMxgbyqO695UMSC7TYUCZR0dEl4a35X
         zbtyaJd3pOm8EM26Mhduuh93XH9qNEvnxGHb2Twp/qbr0MLnDLHYqryPI11yIPr7KGRn
         K7sn/UUe0j/P8u/Oezggbxg7O7ViW9G83elxl4rO8MKXYEQveNwNggJ69OJ8klUrUWoI
         lnq4Bm2oW2tOrZhxHZepn6LihmK8KbEsLVYU5moTVOSKElzExDQw4mAktaNaMqciAS83
         jnlWYM76M2W63QoSuhUFi5n+xImdDDZoNsB5LW2ICuxVFMm1WZREsT/lzauJTq/ZzA9q
         tqEQ==
X-Gm-Message-State: AOAM533ki+jmJIx1nMeTQHqyIFWGeVggn8wCD8SUsQygW6grhvPZQX6Z
        E7COPg1a5mdRgOVWEmCq2GrUg2psf8I=
X-Google-Smtp-Source: ABdhPJwycW2kFZEra1VeimUqPfqf9oMM2IltvnYEEPSGXuxF3K4moS4SD52zegkvlFyE/vW2eYuhlA==
X-Received: by 2002:a2e:2f17:: with SMTP id v23mr5515563ljv.222.1611179826782;
        Wed, 20 Jan 2021 13:57:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id f3sm349528ljp.114.2021.01.20.13.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:57:05 -0800 (PST)
Subject: Re: [PATCH v3 05/12] opp: Add dev_pm_opp_set_voltage()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-6-digetx@gmail.com>
 <20210118095256.tr2qgnrmokkc6ngf@vireshk-i7>
 <a48dca91-4264-e153-cefa-ccbcca1b1d9d@gmail.com>
Message-ID: <16c7e096-5efd-2d0c-a2ac-c11133c29c30@gmail.com>
Date:   Thu, 21 Jan 2021 00:57:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a48dca91-4264-e153-cefa-ccbcca1b1d9d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 22:14, Dmitry Osipenko пишет:
> 18.01.2021 12:52, Viresh Kumar пишет:
>> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>> index 99d18befc209..341484d58e6c 100644
>>> --- a/drivers/opp/core.c
>>> +++ b/drivers/opp/core.c
>>> @@ -2731,3 +2731,58 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
>>> +
>>> +/**
>>> + * dev_pm_opp_set_voltage() - Change voltage of regulators
>>> + * @dev:	device for which we do this operation
>>> + * @opp:	opp based on which the voltages are to be configured
>>> + *
>>> + * Change voltage of the OPP table regulators.
>>> + *
>>> + * Return: 0 on success or a negative error value.
>>> + */
>>> +int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)
>>
>> I think we should do better than this, will require some work from
>> your part though (or I can do it if you want).
>>
>> Basically what you wanted to do here is set the OPP for a device and
>> this means do whatever is required for setting the OPP. It is normally
>> frequency, which is not your case, but it is other things as well.
>> Like setting multiple regulators, bandwidth, required-opps, etc.
>>
>> I feel the right way of doing this would be to do this:
>>
>> Factor out dev_pm_opp_set_opp() from dev_pm_opp_set_rate() and make
>> the later call the former. And then we can just call
>> dev_pm_opp_set_opp() from your usecase. This will make sure we have a
>> single code path for all the set-opp stuff. What do you think ?
>>
> 
> Sounds like it could be a lot of code moving and some extra complexity
> will be added to the code. If nobody will ever need the universal
> dev_pm_opp_set_opp(), then it could become a wasted effort. I'd choose
> the easiest path, i.e. to defer the dev_pm_opp_set_opp() implementation
> until somebody will really need it.
> 
> But if it looks to you that it won't be a too much effort, then I'll
> appreciate if you could type the patch.
> 

Let's start with dev_pm_opp_set_voltage() for now. It shouldn't be a
problem at all to upgrade it to dev_pm_opp_set_opp() later on.

I'll make a v4 with the dev_pm_opp_set_voltage(), please let me know if
you have objections or more suggestions!
