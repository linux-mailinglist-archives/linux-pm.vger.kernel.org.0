Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF86330606E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbhA0QAx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 11:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhA0P71 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 10:59:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95EFC061788;
        Wed, 27 Jan 2021 07:58:34 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i187so3344274lfd.4;
        Wed, 27 Jan 2021 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkl23YYCAN7td3M2Yke0axkC0ziieHeFZsCxQDb5Nko=;
        b=Dn89ET8ROAPBM0aXpz6DrKWB044nV6zsg9xvTxnFSiXhXbThstKRIgu1kzB/eJg6r1
         5DoC9PG8HZGwCW+1CKM3urc7UcQ0UBKiij+DQ7CcabslbIoWdT3dUvcLMASLpZnVtPPw
         qcdZqidFCDYhO1eb3UawlpVC2OAsIIRgDILTAP/oLucPcdjATOSz7lPpUgKsfkbblUjA
         RPeKoM84g8HKD7DIvCn6zbpa1Hr/sXKhn3KMa5otRlY+qBU+O4nz9zIpCHFyRHMhPbix
         O4To35jnsDnJzAhVdjgF120mB29D+jLegTUVsJq2E8WNFvPjZWeZBguCS8a2o4eJ/IjM
         G5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkl23YYCAN7td3M2Yke0axkC0ziieHeFZsCxQDb5Nko=;
        b=SCpkNuhXWrQtsAYNn4Zv3LRQcnylc+jMdOqI/9u2bIGE9kgQjYXgCjyf6Rty8vDLFx
         EaO9oCRjatG2CEqmntFvtmszmZ87j1pkEhRqCaInfvfiW+pSplIvdvf1ZtFqVKVdn0oZ
         mZmhqL3LrjVzj/rZdKG/IaZtZr9XmHvV9fA4y1O5nZM4y8oGXI9g5C+Yc30p8ZkLMftm
         kZrXWG1z5hvgz0n9a75uBh1pcrsTOzA5SYxp6QccXXBUZ86/P+nzUkZeAXffyn6N66wH
         /TqQXZhxpwbBdx6beFwXV8+cQ95UwE6L2LdmIrQOsJaKJvXXrXehdyihgfY+GCFINnmU
         mMgQ==
X-Gm-Message-State: AOAM530Y77hXnSudIJmvOkMq6sWQ6cFn0gJ5n9zEKlL38eS7VEMvIwGT
        jVtT5wftnoX18RL9Ugl25XYmyWYjBUo=
X-Google-Smtp-Source: ABdhPJz6ngq6hOfVFIs8rFg9oOmlF6bbI+gFeQqU00YqMM+2j/aEHNezEvyP8wmU2JpN4awGfS9+vA==
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr5239788lfu.239.1611763113017;
        Wed, 27 Jan 2021 07:58:33 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id q190sm679199ljb.8.2021.01.27.07.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:58:32 -0800 (PST)
Subject: Re: [PATCH V2 11/13] devfreq: tegra30: Migrate to
 dev_pm_opp_set_opp()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
 <20210127100234.vl2wwe7rjrrz4btz@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b5f1065b-14ad-adae-af1c-e9962e6626ad@gmail.com>
Date:   Wed, 27 Jan 2021 18:58:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210127100234.vl2wwe7rjrrz4btz@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.01.2021 13:02, Viresh Kumar пишет:
> On 27-01-21, 14:40, Viresh Kumar wrote:
>> dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
>> be used instead. Migrate to the new API.
>>
>> We don't want the OPP core to manage the clk for this driver, migrate to
>> dev_pm_opp_of_add_table_noclk() to make sure dev_pm_opp_set_opp()
>> doesn't have any side effects.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> Dmitry,
>>
>> This is based over the patches sent here:
>>
>> https://lore.kernel.org/lkml/6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar@linaro.org/
>>
>> This should fix the problem you mentioned earlier. Will push this for
>> linux-next unless you have any issues with it.
>>
>>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 117cad7968ab..31f7dec5990b 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>  		return PTR_ERR(opp);
>>  	}
>>  
>> -	ret = dev_pm_opp_set_bw(dev, opp);
>> +	ret = dev_pm_opp_set_opp(dev, opp);
>>  	dev_pm_opp_put(opp);
>>  
>>  	return ret;
>> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  		return err;
>>  	}
>>  
>> -	err = dev_pm_opp_of_add_table(&pdev->dev);
>> +	err = dev_pm_opp_of_add_table_noclk(&pdev->dev);
> 
> Plus this, somehow was left uncommited in my tree :(
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 31f7dec5990b..ce83f883ca65 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>                 return err;
>         }
>  
> -       err = dev_pm_opp_of_add_table_noclk(&pdev->dev);
> +       err = dev_pm_opp_of_add_table_noclk(&pdev->dev, 0);
>         if (err) {
>                 dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
>                 goto put_hw;
> 

Sadly this doesn't work because we missed that clk is assigned to
opp_table when OPP table is allocated and not when it's added to device.

Hence we're now set back to the dev_pm_opp_clear_clk() variant.

What about to add a new OPP API which will allow OPP users to configure
behaviour that user wants from OPP core in a generic way, something like
this:

struct opp_config {
	bool no_clk;
	...
};

devm_pm_opp_set_config(dev, struct opp_config);
dev_pm_opp_set_config(dev, struct opp_config);
dev_pm_opp_unset_config(dev);

Or maybe even rename it dev_pm_opp_allocate_table(dev, struct
opp_config), which will allow users to directly allocate OPP table
instead of relying on the implicit allocations. Then there won't be a
need for drivers to use a dummy devm_pm_opp_set_clkname(dev, NULL) just
to allocate the table usable for dev_pm_opp_set_rate().
