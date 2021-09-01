Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB693FD325
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhIAFol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhIAFok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 01:44:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4CC061575;
        Tue, 31 Aug 2021 22:43:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t19so2116928lfe.13;
        Tue, 31 Aug 2021 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gim4EuYzMPzECIPE9S4nR1nvyfAMSTvMIW6Rj/ZTiog=;
        b=MghnCIi+9feXf3Ym2IHdbIQNq2BoX/1BOSuksrFLRXVxqO0hbDsdvifp/sDYElI7e4
         krG4jqPIoxG0AmeRGwM/f8Yc1D4f8jsGOZNT5a8d+LHhYsk1A1z17oCFAdflTUKoJ9J+
         7T0Sh28Lke9h6EVoUKk9/+NcgUnQD6vql7nTBxTioNJLwxWatlQ5blocEgHGs3NlLn/1
         KO9ko60jW8N39T32cB/QIEw222exPt0z17ZfNJWR+2TTh60lUbKbJPTy4oYP5Spi/8pL
         TOxOWplaOOiITsMRNiN9xwQy1/aC64GOOuI98/DZ80FcSontBZPa8eBKqW48o7typ8R9
         A40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gim4EuYzMPzECIPE9S4nR1nvyfAMSTvMIW6Rj/ZTiog=;
        b=rOQVDlRVkR6AvwukMy+eG7oWGP00Az8qcOMDKg2HJz6wk7t46byuTq8iVRBacct0jB
         8ApPV4eGsVGdCIBEWvorPpl3r273m3FGmGGkv+4qTNvbRcjmDU1sEF4LHxYMjeeAnIVO
         ozAk9HB2kDGdibDEPfQnxU20EyQDXAXGpYdB84nMfpOZG6RNa1K5skqF0ppKqyeWzUER
         jA5F/zfnHzRqFZW2qgEwaQkzT93sU9QurIRWK5aLCdeq8UbuMIN9J5h9QlVR/KhUvfEM
         rtnmku2cqactkPSsVm9TBHZX19wsE5v+m6FMk0Ag2+0Fq/Sc/YFXdSPPQu/4dio6GjyK
         qPVQ==
X-Gm-Message-State: AOAM532tkieqSc33LGZ3MHW0/QP41HZoAmGOpSyGHGr2vSsmJtp8qLXG
        OiRdKct8C/IhlwAychgCUMRSoO50gKY=
X-Google-Smtp-Source: ABdhPJwwEJqgRkqTYsgfRUc5rrHS4adDnLusibuPc4BX5QwYuMNoyFrDbXSienq/vCNQI50ignlxlA==
X-Received: by 2002:a05:6512:21b1:: with SMTP id c17mr24884557lft.34.1630475022240;
        Tue, 31 Aug 2021 22:43:42 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id z3sm1933374lfh.18.2021.08.31.22.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 22:43:41 -0700 (PDT)
Subject: Re: [PATCH v10 1/8] opp: Add dev_pm_opp_get_current()
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
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-2-digetx@gmail.com>
 <20210901043953.va4v3fwgs6ldtwar@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e9d9f288-fe37-a6f5-2f5f-fba227dba0c7@gmail.com>
Date:   Wed, 1 Sep 2021 08:43:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901043953.va4v3fwgs6ldtwar@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.09.2021 07:39, Viresh Kumar пишет:
> On 31-08-21, 16:54, Dmitry Osipenko wrote:
>> Add dev_pm_opp_get_current() helper that returns OPP corresponding
>> to the current clock rate of a device.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c     | 43 +++++++++++++++++++++++++++++++++++++++---
>>  include/linux/pm_opp.h |  6 ++++++
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 04b4691a8aac..dde8a5cc948c 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -939,7 +939,7 @@ static int _set_required_opps(struct device *dev,
>>  	return ret;
>>  }
>>  
>> -static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>> +static struct dev_pm_opp *_find_current_opp(struct opp_table *opp_table)
>>  {
>>  	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
>>  	unsigned long freq;
>> @@ -949,6 +949,18 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>>  		opp = _find_freq_ceil(opp_table, &freq);
>>  	}
>>  
>> +	return opp;
>> +}
>> +
>> +static void _find_and_set_current_opp(struct opp_table *opp_table)
>> +{
>> +	struct dev_pm_opp *opp;
>> +
>> +	if (opp_table->current_opp)
>> +		return;
> 
> Why move this from caller as well ?

To make code cleaner.

>> +
>> +	opp = _find_current_opp(opp_table);
>> +
>>  	/*
>>  	 * Unable to find the current OPP ? Pick the first from the list since
>>  	 * it is in ascending order, otherwise rest of the code will need to
> 
> If we aren't able to find current OPP based on current freq, then this
> picks the first value from the list. Why shouldn't this be done in
> your case as well ?

You will get OPP which corresponds to the lowest freq, while h/w runs on
unsupported high freq. This may end with a tragedy.

>> @@ -1002,8 +1014,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>>  		return _disable_opp_table(dev, opp_table);
>>  
>>  	/* Find the currently set OPP if we don't know already */
>> -	if (unlikely(!opp_table->current_opp))
>> -		_find_current_opp(dev, opp_table);
>> +	_find_and_set_current_opp(opp_table);
>>  
>>  	old_opp = opp_table->current_opp;
>>  
>> @@ -2931,3 +2942,29 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
>> +
>> +/**
>> + * dev_pm_opp_get_current() - Get current OPP
>> + * @dev:	device for which we do this operation
>> + *
>> + * Get current OPP of a device based on current clock rate or by other means.
>> + *
>> + * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
>> + */
>> +struct dev_pm_opp *dev_pm_opp_get_current(struct device *dev)
>> +{
>> +	struct opp_table *opp_table;
>> +	struct dev_pm_opp *opp;
>> +
>> +	opp_table = _find_opp_table(dev);
>> +	if (IS_ERR(opp_table))
>> +		return ERR_CAST(opp_table);
>> +
>> +	opp = _find_current_opp(opp_table);
> 
> This should not just go find the OPP based on current freq. This first
> needs to check if curret_opp is set or not. If set, then just return
> it, else run the _find_current_opp() function and update the
> current_opp pointer as well.
> 

Alright, I'll change it.
