Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942DB2FA9DF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 20:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393860AbhARTPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 14:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393835AbhARTPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 14:15:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34AC061574;
        Mon, 18 Jan 2021 11:14:31 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v67so25612361lfa.0;
        Mon, 18 Jan 2021 11:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t2WDGIWPAw5uMllXaciM/LhVaMlZ/X9LzIRIbsz/nXQ=;
        b=kn4nXwPS0PnB+asmQWimKB7MuVM3uxJcFRVZYnKv89CT4EM2eak2wrKI2flJwSFgcc
         akJyLDJpm193okg3CFEKLedJM5LlerrAjT36yjhnnLkQoxXMERpCqY41UW3PpBuqUgTk
         8OOQ5aQ9ehxUQMfkbbmTk13MuKhvTUxLQ2yngxzpspWOb7+6tNAq37nDfOPRwySTXRer
         p9AbCJ/Jn31Z7CsWtpq1GS64447vMCrplbhAc3+UKArucCRKAc0bIXWhjeYzzsbVaddR
         gGK6kgcuqSvt0rM3Ua9F7ZWe+QwaF0hsMh5woGOvRnVNM9Mfq/OjhCt/5wEpuDPLMni7
         e4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t2WDGIWPAw5uMllXaciM/LhVaMlZ/X9LzIRIbsz/nXQ=;
        b=f14wm74brGwPzzKTbzIEU3tsxgQ6tvpj8MMEV8Kjzqu6duWj6pX0O3Zkr3tx92LuQT
         mrYTMxgu7hq5ARqwrrWg1fgA6kXnDjCX25zfuhUhqnFsK3QwNv5SfMJC0k3Sh1CCcrNZ
         S4CXaMQh96tejyyEsQx9bpdxSwqajKnlVLX36eT3boIW+7BN4W4OUMZk4+3KyNdM3UbO
         q9rKmmXmfPjpKE/NYrvuTqP4L47fhep/Ps4TDC9sI0UjGqsi36+DpvJyvOrHRi+ELXVt
         JYGaUwXVzyJ4LBiRwzQfkrLT+4S2ygdJtUWBwEKyLVH/Z7t8Liu+AQ1A9v+Wj91yTwz6
         T7Pw==
X-Gm-Message-State: AOAM533b+z4k3TkPDyt6n74/AvkfVrZXdk0+z/LhlE1K328NoUMOZj5U
        lmuEBTBlXke3Xnr6BODYnWfu+tDLE+w=
X-Google-Smtp-Source: ABdhPJy7R8718qM5BynuwN5lXAtoZUYz8oERmYgMSgqKM16DSQ2HUVjbZKEuAou/dzPkWAKkj3vLQA==
X-Received: by 2002:a19:4148:: with SMTP id o69mr227498lfa.610.1610997270175;
        Mon, 18 Jan 2021 11:14:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id x1sm1767110ljc.20.2021.01.18.11.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:14:29 -0800 (PST)
Subject: Re: [PATCH v3 05/12] opp: Add dev_pm_opp_set_voltage()
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a48dca91-4264-e153-cefa-ccbcca1b1d9d@gmail.com>
Date:   Mon, 18 Jan 2021 22:14:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210118095256.tr2qgnrmokkc6ngf@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 12:52, Viresh Kumar пишет:
> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 99d18befc209..341484d58e6c 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2731,3 +2731,58 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
>> +
>> +/**
>> + * dev_pm_opp_set_voltage() - Change voltage of regulators
>> + * @dev:	device for which we do this operation
>> + * @opp:	opp based on which the voltages are to be configured
>> + *
>> + * Change voltage of the OPP table regulators.
>> + *
>> + * Return: 0 on success or a negative error value.
>> + */
>> +int dev_pm_opp_set_voltage(struct device *dev, struct dev_pm_opp *opp)
> 
> I think we should do better than this, will require some work from
> your part though (or I can do it if you want).
> 
> Basically what you wanted to do here is set the OPP for a device and
> this means do whatever is required for setting the OPP. It is normally
> frequency, which is not your case, but it is other things as well.
> Like setting multiple regulators, bandwidth, required-opps, etc.
> 
> I feel the right way of doing this would be to do this:
> 
> Factor out dev_pm_opp_set_opp() from dev_pm_opp_set_rate() and make
> the later call the former. And then we can just call
> dev_pm_opp_set_opp() from your usecase. This will make sure we have a
> single code path for all the set-opp stuff. What do you think ?
> 

Sounds like it could be a lot of code moving and some extra complexity
will be added to the code. If nobody will ever need the universal
dev_pm_opp_set_opp(), then it could become a wasted effort. I'd choose
the easiest path, i.e. to defer the dev_pm_opp_set_opp() implementation
until somebody will really need it.

But if it looks to you that it won't be a too much effort, then I'll
appreciate if you could type the patch.
