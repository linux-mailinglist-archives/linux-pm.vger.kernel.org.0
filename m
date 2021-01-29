Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD9308D62
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhA2T1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 14:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhA2T1B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 14:27:01 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA5C061756;
        Fri, 29 Jan 2021 11:26:20 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r14so11799114ljc.2;
        Fri, 29 Jan 2021 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1edXkuxL4Xu0RLSWp37gfcR1JPTBiU4IIXR+AyA7W1s=;
        b=dInJpVjd8dcAnPMt22uLSkDsLH6gOmOp3CwgjIPLdw2cDbQ70Sw4ppR5/RpVoiN1X4
         1r5y1uaN4BcJXrsefXILbRKuMn5UazroHhuzJqu0cefw1TXyZmapdSbCFJCoqQzwaWdo
         LV1bTg/kE2XP0H6kdV7q3X+FRWMsFrwY3LQOYuEvHg0QM2C5o6MYhZwc0ImSeOKygQ1k
         MzlnPmpAif1jZuaveGg3ATSuaXJjiQXDmisSpSd3joPTXGNq7JbBOic0aoqHg1KcWzWc
         vLjz6fdvXZoqbP6WjQmHHbwDIH6oH+K/Q1xSs9NQlVZsfqTjZhaIq8K+8FaJKUAsA3ed
         fIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1edXkuxL4Xu0RLSWp37gfcR1JPTBiU4IIXR+AyA7W1s=;
        b=HljyR6mJ+WT+5tJRAP/EmoyaDIFar4ZTLV4GeZQPdRD3BYh6EPCif9Mbwh/6TdP6M5
         N6C2pOQ6nyUoc94UROSCfzW9mBvEhmsRCBYrZPpf8XF25RGYsGNTpJuaCoHosy5PoS2t
         OLg1IltC3ipEjYdrxWSO5FsAMKdEgNf2948FPNQp/nLYLy+hrOpbf1hn638M12X19+Ye
         rhEM8RvFmr0R3bj3QtzZjjWhXpxMOE+BK+/Cy4pf9QMhKb6ck3pUC+F4h/YalMbP7gM0
         5CnX75S+YSaTNF+2hfwMamgLB89cgxwAH1zXPlXRvo1FjP5U0+viq3QsBBf4CPdiyi7M
         5vRw==
X-Gm-Message-State: AOAM533G6Al3Uyi2go6K0mtiwtnZ3AewwNCnR5ltcXK4ifXfmG7QGaAi
        2PxFxJLWofk07bWUmKI6Htms52i7F9E=
X-Google-Smtp-Source: ABdhPJxhoI4bcqqBU+WRLE6IYYpcGpEc+afEQZ/FO21FG5H8cvNWwO7TyrRxTFE+N1JO6hVeaf1vLA==
X-Received: by 2002:a2e:3317:: with SMTP id d23mr3319330ljc.199.1611948378953;
        Fri, 29 Jan 2021 11:26:18 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id b26sm1458799lff.162.2021.01.29.11.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 11:26:18 -0800 (PST)
Subject: Re: [PATCH] opp: Don't ignore clk_get() errors other than -ENODEV
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <28d24b4c5b9ceabbd32b7b312dee050992610be9.1611917396.git.viresh.kumar@linaro.org>
 <49983ca1-feb3-48f5-bdf5-b2f39c963a74@gmail.com>
 <20210129174608.owianuy6yj5m6fgl@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a7585f81-ed88-06d7-c1c5-4b3052fc0aaa@gmail.com>
Date:   Fri, 29 Jan 2021 22:26:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210129174608.owianuy6yj5m6fgl@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

29.01.2021 20:46, Viresh Kumar пишет:
> On 29-01-21, 18:23, Dmitry Osipenko wrote:
>> 29.01.2021 13:51, Viresh Kumar пишет:
>>> Not all devices that need to use OPP core need to have clocks, a missing
>>> clock is fine in which case -ENODEV shall be returned by clk_get().
>>>
>>> Anything else is an error and must be handled properly.
>>>
>>> Reported-by: Dmitry Osipenko <digetx@gmail.com>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>> Stephen, is the understanding correct that -ENODEV is the only error
>>> returned for missing clocks ?
>>>
>>> Dmitry: I hope this is on the lines of what you were looking for ?
>>
>> Viresh, thank you! This is not what I was looking for because clk core
>> doesn't return -ENODEV for a missing clock, but -ENOENT. The ENODEV
>> certainly should break drivers.
> 
> My bad.
>  
>> I was looking for this:
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 0305861fee1b..3dd9cdbc0e75 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1264,7 +1264,7 @@ static struct opp_table
>> *_update_opp_table_clk(struct device *dev,
>>  	if (IS_ERR(opp_table->clk)) {
>>  		int ret = PTR_ERR(opp_table->clk);
>>
>> -		if (ret == -EPROBE_DEFER) {
>> +		if (ret != -ENOENT) {
>>  			dev_pm_opp_put_opp_table(opp_table);
>>  			return ERR_PTR(ret);
>>  		}
> 
> You should be looking for this instead, isn't it ?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 049d45e70807..4bfcbe5b57af 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1268,7 +1268,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>         if (!ret)
>                 return opp_table;
>  
> -       if (ret == -ENODEV) {
> +       if (ret == -ENOENT) {
>                 dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
>                 return opp_table;
>         }
> 
> 

This will work too.

Then also could be better to replace the "if (ret != -EPROBE_DEFER)"
with dev_err_probe(..).
