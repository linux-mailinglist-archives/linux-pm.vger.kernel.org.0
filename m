Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5231840D138
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 03:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhIPBcL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 21:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhIPBcK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 21:32:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D895AC061574;
        Wed, 15 Sep 2021 18:30:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so11898011lfg.6;
        Wed, 15 Sep 2021 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3dQovcTDsXIknYQ67gp4mApPNz8gnn6QM6bd7xL1nSw=;
        b=l0nL6hbsJlapzVa4LsVmafBQB1srF+De1IAWnVZB7u62E5wc2sf50U8u4oKd38IJZj
         YZh9jez/pBUZfSPN6oLobkdbvC6Fb6d1gAvJFrKn+eE9vwfbUAdmiXvLJNiDSDacQ8pk
         xtAIHUyGAk5sAY/sDE+52TrFHRl8zoFrlsgMFMxNMBfLggqBo7+NIFYCsvQXfHk3RGF9
         dlH2ZBhXO3kveqSYWIPDB0g6tj8uvybOgX1417FIG2VdQ1nnZSkVCkiDWxDXecbIlKmj
         STjFi9rLkQaOmYzmPm6YGoQQmZ6/9gT33XxUgYlCu0SD5BewADrlT+ePW21Iqx3/H1XJ
         MRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3dQovcTDsXIknYQ67gp4mApPNz8gnn6QM6bd7xL1nSw=;
        b=onH6cIADBiz5opB4LgaRpg7RuN3s1WEhe2Zf6jWD1NXJQhNJZx2IXlCws/jYTnDtJu
         eRr1XrQ9a7QAb8f+D/353j0ziHkZ7zyH98UWyoWQXCi01D/9CH5+W2KwONYt19N5jttv
         vq3MmfYdqeL6PkSlQQAcpN/IGQdvM6fbsex/RUgfWDq+GY9aW4zvS+uUQ8CKgORm5Pnn
         aH0cIN5RfFBTdjCqkg/ukIDgwG4VzryIwIUlR9iMHcqrG5BDFTj67Re/VqiaoOvcKx9B
         ibJeAywk1carGYSe3goEzM3kZ7soevMgGOwNhYlgqaSTnfZks19XTzUBUuZJe6TYxWJk
         J4Bg==
X-Gm-Message-State: AOAM530r+URpVt9lX82R4nB0qlUWM3C6WCL3S9eC130xi3H6QxgNK+Cr
        6gIntxEu8apGtKEhj8uzbJg=
X-Google-Smtp-Source: ABdhPJzzO+kwRFYOzZlfIQHlpsPaIOdLy8yGQYk0n8682UNkhtVZRRrbex3e203kjCZ7IJU9N3Ph/w==
X-Received: by 2002:a05:6512:c15:: with SMTP id z21mr2120194lfu.193.1631755849311;
        Wed, 15 Sep 2021 18:30:49 -0700 (PDT)
Received: from [192.168.2.145] (94-29-62-67.dynamic.spd-mgts.ru. [94.29.62.67])
        by smtp.googlemail.com with ESMTPSA id s4sm172807ljp.115.2021.09.15.18.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 18:30:48 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] PM / devfreq: Add devm_devfreq_add_governor()
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-3-digetx@gmail.com>
 <504a75a9-3f39-3aed-2df5-4ca1e7f99afc@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2c1b29b3-25fb-0f84-ee04-5d9012a81f3f@gmail.com>
Date:   Thu, 16 Sep 2021 04:30:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <504a75a9-3f39-3aed-2df5-4ca1e7f99afc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.09.2021 21:23, Chanwoo Choi пишет:
> On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
>> Add resource-managed variant of devfreq_add_governor().
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/devfreq/devfreq.c  | 26 ++++++++++++++++++++++++++
>>   drivers/devfreq/governor.h |  3 +++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 85faa7a5c7d1..d3af000ec290 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1301,6 +1301,32 @@ int devfreq_add_governor(struct
>> devfreq_governor *governor)
>>   }
>>   EXPORT_SYMBOL(devfreq_add_governor);
>>   +static void devm_devfreq_remove_governor(void *governor)
>> +{
>> +    devfreq_remove_governor(governor);
> 
> Because devfreq_remove_governor has the return value,
> you need to check the return value and then print error at least.
> 
>     WARN_ON(devfreq_remove_governor(governor));

...
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index 2d69a0ce6291..0d70a9ad951e 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -94,4 +94,7 @@ static inline int devfreq_update_stats(struct
>> devfreq *df)
>>         return df->profile->get_dev_status(df->dev.parent,
>> &df->last_status);
>>   }
>> +
>> +int devm_devfreq_add_governor(struct device *dev,
>> +                  struct devfreq_governor *governor);
> 
> Better to add under devfreq_remove_governor definition in order to
> gather the similar functions.

I'll change it in v2, thanks.
