Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848FD330CE4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHMAj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 07:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCHMA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 07:00:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D53C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 04:00:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d15so11164701wrv.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 04:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UScq4Ry4BV1D3nVvylBLbHnwm8LDSH9/8urnS48OvlE=;
        b=oI5QNIlnIG33NqNlfQkK297Hfx5vX+/l84Rk7wJFB7UKvcQpF50Vnt3lwymKoFkJFq
         grR1s1Im48ws0tnbCKJuH1Ky5HKftCNhpncBnFtLvs796N5fxbmD9hk8wfhbzrL74FL4
         8o0FRJTSZpwXA4kybaeej54XVvBFqUOv6ZXpLJd4IjfhE9/ICMUKGLWlXihtdOpT+oML
         jBVnz0zL5fb7pbqgllEyp/fjB3QqXhdeRwfMUg3EMqbkznPrg34sNBnjVhqMow4B8HPE
         tkfIaMuQtrxvFVS1HV4qNsYeV0/ybzlx9s1Y14KRuLP4azf1H4/xhg0VIY4wwvcqz+3a
         /64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UScq4Ry4BV1D3nVvylBLbHnwm8LDSH9/8urnS48OvlE=;
        b=qDeY470AeoJy7NYK7aWyfygGnesAWyBnGUOeO36ccCPaohssWdQX/4HNFb7fusuOBe
         CR//B6pxCB0+ct2fHIZrznj5v9ej2W/8BfBhAcnigOgeQoDg7Ywt+OoWziM4cFJ+/oC2
         pVrOdiUt6f7bXbHlMFUKB82tz0mSB89p2rNWX1gmhknzbqLTbspXDhDAStfPErAWIh7J
         LNtyRomt20zeAjVOGSRC1TvwEjwB0ZXjccqHIujMXnZ7bMwhf6uoHTmprSFbixo4zw7C
         aOhORpOSqIwvDoLL0s7XrUzI2b9vcskdcwGN0y2tW5yQSVunVufPMb5dX0QTvbvpxY12
         dgqA==
X-Gm-Message-State: AOAM530mXnB15A/cDJ8wn+OuLL4NWZEv9UyS8B1mKN6QhSisjRKnQNwy
        yKSHoqbvrBMWsabvp8oYSu3KUw==
X-Google-Smtp-Source: ABdhPJxBWzV9hIdD/ppivptyrR1Q/BbH6VDl/2J8QOWvz7pwtbP9BUzgcUex4ERGvaxlxqzx0o7WTA==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr22674462wrm.37.1615204822703;
        Mon, 08 Mar 2021 04:00:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:60f3:8fc:7d4b:c2d9? ([2a01:e34:ed2f:f020:60f3:8fc:7d4b:c2d9])
        by smtp.googlemail.com with ESMTPSA id p18sm21700615wro.18.2021.03.08.04.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:22 -0800 (PST)
Subject: Re: [PATCH v5 1/4] PM / devfreq: Register devfreq as a cooling device
 on demand
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     cwchoi00@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
 <c6d6781a-759c-0361-aaaa-28a625e4809b@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bd6c8e7f-e626-b6f4-65b9-f7ea96098677@linaro.org>
Date:   Mon, 8 Mar 2021 13:00:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c6d6781a-759c-0361-aaaa-28a625e4809b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2021 10:53, Lukasz Luba wrote:
> Hi Daniel,
> 
> In general the approach is good. If there is a special GPU driver, which
> would like to provide 'struct devfreq_cooling_power *' it would leave
> 'is_cooling_device=false' and register manually:
> devfreq_cooling_em_register(df, dfc_power);
> 
> Please find only a few minor comments below.
> 
> 
> On 3/8/21 9:16 AM, Daniel Lezcano wrote:
>> Currently the default behavior is to manually having the devfreq
>> backend to register themselves as a devfreq cooling device.
>>
>> Instead of adding the code in the drivers for the thermal cooling
>> device registering, let's provide a flag in the devfreq's profile to
>> tell the common devfreq code to register the newly created devfreq as
>> a cooling device.
>>
>> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +    struct thermal_cooling_device *cdev;
> 
> The linux/thermal.h for 'cdev' would be needed in this header.

May be just a forward declaration ?

struct thermal_cooling_device;

>> +
>>       struct notifier_block nb_min;
>>       struct notifier_block nb_max;
>>   };
>>
> 
> With this small changes:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Regards,
> Lukasz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
