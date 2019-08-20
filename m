Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0B96D32
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHTXT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 19:19:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40878 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfHTXT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 19:19:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so330826lff.7;
        Tue, 20 Aug 2019 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YcmcRq3HCfNtNX+YWz14n9pREBcIsfhG8VklV7l3VAQ=;
        b=NbbaON+VCaOIulax5eo/+tBHL6ayAZySIJXO2yiCMDuVVbGk0SLAxbRI7azUNjJZFv
         4UUBQc0CgzzOR9UHjmfJf2KcJ43RGPdB4N5QizOAuTMveSrQWS+cTN8J5RMLQC/ZXYOa
         6z3iUgAsqia3wbB/FON7HUKC6RQVpUCKsGQqjamevgg6deIHiOYTc0HB4/4G2gD1ga9F
         dmSaV8RQy5pOm1Jt5aet7qEk2Uar4pasT2th9TfEFf1h9p5tTHlE2uN9RpeWOP2echmO
         VCKDVmpu7vUv/6lAVeiw4cy2z6VMm6P0RP05kL7wcrDzGE6KxMMjanJwAW/jsT871Q1K
         1yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YcmcRq3HCfNtNX+YWz14n9pREBcIsfhG8VklV7l3VAQ=;
        b=TSDRChLEA2tOafWXBYWkJ2zRGdLA3LRu0UM8aq/2v0lrRYpo73sbO6E7w8WJS6gs+6
         ich1ZUAoStfMuYxCBuJl9qA/e+/nW0h6GiuZSaJ1p51UbzdNLQL5tsst8gLovp+SZMuH
         8Wo+s8tw2uJjxa0+OCZxZQPO35eR15i9Bmm+E+Sg1HqMMq2TvCqSd1fX8r9ZYz/C2/x3
         HGCiAfrqac0U6RDBxjP7tlBiW8OBJXHEvbJExZC0EbNMJMUUusA2pWQs3cdEeoruklAI
         tje9kpOOz1dhN8r+oaXCqjMiwkCbg6aNxkXR/pzB7MMYaHo3QmZ4dO2ciIeXMZt3CTMS
         280w==
X-Gm-Message-State: APjAAAU7VfDukmuWvoRUySKxmT0xD9JeDfF6YvxiW+CRlLghgTigmgK+
        JM8OMyIF03jXJEB0pYg9OzLbMY/g
X-Google-Smtp-Source: APXvYqx1h1/+ICLIaia5cQl3tZFaRSfO3ar0/YeiF0WytQ5pL953MFEf755IttmEVOhx/4PRZ900pA==
X-Received: by 2002:a19:8c56:: with SMTP id i22mr16806746lfj.105.1566343195280;
        Tue, 20 Aug 2019 16:19:55 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id k4sm1970475ljb.20.2019.08.20.16.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 16:19:53 -0700 (PDT)
Subject: Re: [PATCH v6 08/19] PM / devfreq: tegra30: Ensure that target freq
 won't overflow
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811212315.12689-1-digetx@gmail.com>
 <CGME20190811212546epcas1p22be9fefe18908cdd17a518950d296983@epcas1p2.samsung.com>
 <20190811212315.12689-9-digetx@gmail.com>
 <c85dbd27-7536-9c51-19a2-fe1c2c6342b9@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4398556-12e0-9ba8-b59b-19a38764312f@gmail.com>
Date:   Wed, 21 Aug 2019 02:19:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c85dbd27-7536-9c51-19a2-fe1c2c6342b9@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Chanwoo,

20.08.2019 3:23, Chanwoo Choi пишет:
> On 19. 8. 12. 오전 6:23, Dmitry Osipenko wrote:
>> We already had few integer overflow bugs, let's limit the freq for
>> consistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 70dce58212a4..ca499368ee81 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -430,7 +430,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>>  	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
>>  	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
>>  
>> -	return target_freq;
>> +	return min(target_freq, tegra->max_freq);
> 
> Once again, did you meet this case sometimes?

This case happens at least whenever CPU's freq accounting returns
KHZ_MAX, please see actmon_emc_ratios[] and actmon_cpu_to_emc_rate().

> Usually, we can prevent the overflow of target_freq
> when calculating the target frequency or this style.
> 
> I think that if the overflow of target frequency happen frequently,
> it might have the problem of calculation way. 

It is possible to get sampled avg_count from hardware that results in
target_freq > max_freq because translating number of memory events to
memory frequency has some calculation error, although it is negligible.

In fact, it shouldn't matter that the returned target_freq > max_freq
with the current driver's code structure and in the commit's message I
wrote that this change is done for consistency. Hence it should be okay
to drop this patch as well.
