Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818DD99907
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbfHVQVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 12:21:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388493AbfHVQVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 12:21:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so4295038pfi.3;
        Thu, 22 Aug 2019 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DBiIv1slgEWM7FLtAeh/d3IsGMg9yWNmK8JLYGsDvFg=;
        b=ngnYa/FQ8LXoP5OT7ZfnZBHsP82P/NVYrhY9scSlr2MCZCBRLgkF/WqE6BlW+pRgD/
         Diib35Qy0GPXAQAbSJKXB/3NeSTYrfnpyzniCWA0Gno9q/R8tE+KPph3VvpsguZTGmsc
         27N+EuvwSy7S6gEc9Dkkd7Iube8Nn+H5YOr+G32wxcUvmv9coK1n7qEDCjDwxOIXjeeC
         9qXTN8POrDavb+BdcJi4Uie5jAUesRF9CTsnNKq1dvA4mX5njNE6YcpL9nOzRk8ofG8u
         qyaUf9GPTPgc2N2IgYuRHgpUqjLS3x2HcKsSgpaD48xGw53BKgt17CFQ2KmTZ9FjW26J
         aUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DBiIv1slgEWM7FLtAeh/d3IsGMg9yWNmK8JLYGsDvFg=;
        b=gBcHnJfQJwKSSAe3t1I1lzcXFfDG0oA5HrRKwJP9OcLcUAKfaxub/RibkHvEq8Apbs
         qHjaMGxkYZDfrkLE9puMeV2/iXa3OHkzsU+EGBBcZ2/Wj2ktsBwXa+hAQxwumuH8EnsA
         6U1wS3VzHC5xs9L2vOPf8cZX+1jHNF5VHMkjZx/nDo0vi6P1ohZLa7NEKoM8NCBxPe1W
         qTCSWvZZ9Byef+x9vv0/BmOtUokM6yxHlQx08wYx8qI68KoFUOeZWPWCxUONLfFDhco0
         dfwwQcIVxsiIO/0IYOOvrEml48Cb1CED3N4W6lt26yGkidyNHSKIcsB5FCpV0YtQgjDW
         bDrw==
X-Gm-Message-State: APjAAAV8ts/QVEdlEhh5zF09M48INK4HPtxTGYrRfj9cR7J62w20LAbV
        i6yx70zGrPk5AQXz9Pr7ojYIHqI6
X-Google-Smtp-Source: APXvYqyTKuZd2OSp0oHmseEQCNHnZmuMqwOPi86rttDYjQIGY4R2HDoxaDtwQIaAIocQRTRgBhxpyg==
X-Received: by 2002:a62:ce0e:: with SMTP id y14mr2767477pfg.73.1566490883470;
        Thu, 22 Aug 2019 09:21:23 -0700 (PDT)
Received: from [10.67.49.31] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q4sm34958307pff.183.2019.08.22.09.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:21:22 -0700 (PDT)
Subject: Re: [PATCH] cpufreq: Print driver name if cpufreq_suspend() fails
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
References: <20190821231632.29133-1-f.fainelli@gmail.com>
 <20190822024221.wt7mx2zrm3fetnjp@vireshk-i7>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <b534e21b-af00-bbec-2a53-0c3bda8c8ce9@gmail.com>
Date:   Thu, 22 Aug 2019 09:21:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822024221.wt7mx2zrm3fetnjp@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/21/19 7:42 PM, Viresh Kumar wrote:
> On 21-08-19, 16:16, Florian Fainelli wrote:
>> Instead of printing the policy, which is incidentally a kernel pointer,
>> so with limited interest, print the cpufreq driver name that failed to
>> be suspend, which is more useful for debugging.
>>
>> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
> 
> I will drop this tag as this isn't a bug really.

Indeed, that was a bit too trigger happy on my side. Thanks!

> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index c28ebf2810f1..330d789f81fc 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1807,8 +1807,8 @@ void cpufreq_suspend(void)
>>  		}
>>  
>>  		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
>> -			pr_err("%s: Failed to suspend driver: %p\n", __func__,
>> -				policy);
>> +			pr_err("%s: Failed to suspend driver: %s\n", __func__,
>> +				cpufreq_driver->name);
>>  	}
>>  
>>  suspend:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


-- 
Florian
