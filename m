Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6494E2FA941
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407795AbhARStk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 13:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407791AbhARStZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 13:49:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93983C061573;
        Mon, 18 Jan 2021 10:48:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o19so25518589lfo.1;
        Mon, 18 Jan 2021 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fxMA13avbLKRVNuLOjk7rttK6AhcMCADubVPJWhkVMc=;
        b=NU6eEJPevw5HPjNo6Xtu6KxAdjB73bNvuWYXa6QbL7vci0lTcpvMZ9tsd0PYzXt9OU
         JQu8x+I+8Fmr+XuDMyt407jnaqDhwF6N0QphhxwRuSg1j6ze+Y1E/9UjCNCBk7GtAc/d
         YcBGYPPJviT83DzmtGH1VPFQUVtmCtndVMDi6QtzL/VVQRtTi41taoSgip1K1HwfG2q+
         HMi5E8uG0PUGs20sQ8Q2TRiPYQbxf8/yn+e0R6YBP2eBd9e77EkFMvHBWvKz4dHfQ+GY
         J1IuDAWoUiYR1Lz/VNlGkM7wPp88caBXrf5GEWrh6/G3Rge+dsdqazTNPVAY04PHMppS
         l3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxMA13avbLKRVNuLOjk7rttK6AhcMCADubVPJWhkVMc=;
        b=tCbHqotvUFHISUo6L5jadKYWe18CFwU3OXD08eR1VWC98Ll6b72Uf7bdXK/d4O4XzO
         SonnzQaOtgu702a67ZzEGXOh5RYhhYiBB1Tn13WV9nveqc0hEMXuFeGrwobkMo1/6Fy4
         xF3/WcvNSe2aCgyG2QewW9aDk0I31AENbn2hn7NbmbMEd/RVPI66Y9pQrwxsr8m2Q4rj
         4eOHSFn0KTuGMjmGbTte6S/PgEDv2SntM9kJ5gAHFNMvHyZCLcCCO9Pa7BBQm9LFZB82
         s6VgvYlRWQj7/hkiXIltVc0wkkoKK2rO2dSORHPOzsKoodiRoYninXgIlgCPGd9Z9Zwm
         5mZg==
X-Gm-Message-State: AOAM5305feXRQdhbwecZ2pHAVS5EjV6mL9qVEsrS9dvK158qFduoFl3y
        GYqpdEpdAIc7X5jBww+SoHQEK1QvJP0=
X-Google-Smtp-Source: ABdhPJzAMYRyR3MYxq+vBNNn5NqDhFjn4tImMiGrXpkA0xSDwCW4upNQtCvBFxo4RdTHGile9/DGng==
X-Received: by 2002:a19:5e5b:: with SMTP id z27mr201701lfi.143.1610995722954;
        Mon, 18 Jan 2021 10:48:42 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id s2sm1703802ljj.100.2021.01.18.10.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:48:42 -0800 (PST)
Subject: Re: [PATCH v3 10/12] opp: Support set_opp() customization without
 requiring to use regulators
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
 <20210118005524.27787-11-digetx@gmail.com>
 <20210118114451.5mpuvgnhhajx4b3y@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
Date:   Mon, 18 Jan 2021 21:48:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210118114451.5mpuvgnhhajx4b3y@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 14:44, Viresh Kumar пишет:
> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index eefd0b15890c..c98fd2add563 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -13,6 +13,7 @@
>>  
>>  #include <linux/energy_model.h>
>>  #include <linux/err.h>
>> +#include <linux/kref.h>
>>  #include <linux/notifier.h>
>>  
>>  struct clk;
>> @@ -74,6 +75,7 @@ struct dev_pm_opp_info {
>>   * @regulator_count: Number of regulators
>>   * @clk:	Pointer to clk
>>   * @dev:	Pointer to the struct device
>> + * @kref:	Reference counter
>>   *
>>   * This structure contains all information required for setting an OPP.
>>   */
>> @@ -85,6 +87,7 @@ struct dev_pm_set_opp_data {
>>  	unsigned int regulator_count;
>>  	struct clk *clk;
>>  	struct device *dev;
>> +	struct kref kref;
>>  };
> 
> Instead of kref thing, allocate the memory for supplies from
> dev_pm_opp_set_regulators() and store it in new entries in opp-table
> and for rest of the data from dev_pm_opp_register_set_opp_helper(), to
> which you can copy supplies pointers then.
> 

Could you please show a code sample?
