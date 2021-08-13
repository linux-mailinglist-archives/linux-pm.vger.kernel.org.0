Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED683EBB61
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhHMRXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhHMRXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 13:23:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5159C0617AD;
        Fri, 13 Aug 2021 10:23:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w20so21100915lfu.7;
        Fri, 13 Aug 2021 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nFvCEWS9nc+hUhvIRKx+G3HCmb1nXE/AJUmaTFf3Dcg=;
        b=YW1JN91Pevet9azoWif0Gpl2VtOEPxPycNOH0Qxlh41N8z1XPR+V8LlvRRte0VPi+A
         0+6G6m0rtoam7BucMzUqv9KiJZMV27WNo9/kLtu0kA+hobLqHvVrkLCfDp9uRZIChxhc
         YTWAR7mMm8fRe6OrjR21hbYmCGW70/8LqeuDXspALeyTXUOy5Cm9he7z8h8ULMmfZO34
         ZncmZmrCHcSGQumVxFMOphGryFdv/2geTkRkybbAEeZv14YmTY+Z9PNpWC1d/SI7Bys2
         hQKOsMHMINIJ1733zWIT+iv8mLNqhbFgJyKIr3aa00ndWaF1Gns6T3EcybmxkdvUI0fS
         aGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nFvCEWS9nc+hUhvIRKx+G3HCmb1nXE/AJUmaTFf3Dcg=;
        b=Opyi5y3bGzh6FFeXk5hjMLJ7ssCk/bKqDKGPqB2AoA1+XarYbtkmjsJH4ciJbJHUtp
         9/7Ezez3AIMamkWuZ4jopriMN/xqQdb1gPgOy5OWNxyncOOcrkzqUdXWyPQDMS5baBsU
         r4RblZEkGdEEDFCqKXxNv7TJRw4UsEi7GhFZn/ICn/HRyoJOhO4HifPDKmfc/HuMhdEV
         BXBn+27OwaKNl68rwgaM+KoeOU9t3U7jPXmTy7YE+LJYth7AfemsAbCdVUYFJOSzp168
         wNgdweNXsmgc9G7oSc3jg4QQiQP3gUL4EDm1M+2uuiaE45nZATHdTZhjyzgIazE+r9XU
         Q8MQ==
X-Gm-Message-State: AOAM5324rXjvv1wN64ogEehNcijRv61poflTTwy5yN4x7qVqor/O7/96
        G0WgXtOrWRsw/VTsTWUeNJx4Ph63ocA=
X-Google-Smtp-Source: ABdhPJynG/s6bbc+iY4ooNJe/vbQgG0uEfff6Lw+m9PwK67RGj67T1hryd+gMINJdRqYZbhDvhJjpg==
X-Received: by 2002:a05:6512:3f8e:: with SMTP id x14mr2311274lfa.389.1628875391957;
        Fri, 13 Aug 2021 10:23:11 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id br39sm204982lfb.104.2021.08.13.10.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 10:23:11 -0700 (PDT)
Subject: Re: [PATCH v1] opp: Release current OPP properly
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210812101353.14318-1-digetx@gmail.com>
 <20210813041224.dqz3kbynr5ffjclj@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <940eb122-651b-1dbf-9a11-5d59bb45008f@gmail.com>
Date:   Fri, 13 Aug 2021 20:23:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210813041224.dqz3kbynr5ffjclj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.08.2021 07:12, Viresh Kumar пишет:
> On 12-08-21, 13:13, Dmitry Osipenko wrote:
>> The current_opp is released only when whole OPP table is released,
>> otherwise it's only marked as removed by dev_pm_opp_remove_table().
>> Functions like dev_pm_opp_put_clkname() and dev_pm_opp_put_supported_hw()
>> are checking whether OPP table is empty and it's not if current_opp is
>> set since it holds the refcount of OPP, this produces a noisy warning
>> from these functions about busy OPP table. Release current_opp when
>> OPP table is removed to fix it.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index b335c077f215..73da968b5c86 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1378,9 +1378,6 @@ static void _opp_table_kref_release(struct kref *kref)
>>  	list_del(&opp_table->node);
>>  	mutex_unlock(&opp_table_lock);
>>  
>> -	if (opp_table->current_opp)
>> -		dev_pm_opp_put(opp_table->current_opp);
>> -
>>  	_of_clear_opp_table(opp_table);
>>  
>>  	/* Release clk */
>> @@ -2901,6 +2898,12 @@ void dev_pm_opp_remove_table(struct device *dev)
>>  	if (_opp_remove_all_static(opp_table))
>>  		dev_pm_opp_put_opp_table(opp_table);
>>  
>> +	/* Drop reference taken by _find_current_opp() */
>> +	if (opp_table->current_opp) {
>> +		dev_pm_opp_put(opp_table->current_opp);
>> +		opp_table->current_opp = NULL;
>> +	}
>> +
> 
> It is better to drop the reference when the OPP table is really
> getting removed.
> 
> I think the WARN_ON() in the put_* functions can be dropped. It is
> important to check this when the stuff is getting set, like in
> dev_pm_opp_set_supported_hw(), but removal is just fine.
> 

Alright, I'll make another patch then.
