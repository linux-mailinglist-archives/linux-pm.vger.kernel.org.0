Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F72EB3AC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 20:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbhAETv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 14:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbhAETv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 14:51:58 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BFC061793
        for <linux-pm@vger.kernel.org>; Tue,  5 Jan 2021 11:51:18 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q1so836156ilt.6
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2021 11:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yuUp96Dy9EvE7pFdc2UT55pn6ORXJwMoBW6BB0BgLiY=;
        b=bQP7qIexcx4SZMa8hnp7djt8zuWQK49oCKLFrDYhJE0sDnGAMowJQ9lmYtVomf/p2K
         hU/kE2ebouwRhxiIrgclabCBKCYE/E5D14nO/8AQRbT4y7CYwvSxfvB2VcHpTEen0nnF
         E4A24VFEkT6v1gL7dWvqKLKd1qjJoKAcu+i9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuUp96Dy9EvE7pFdc2UT55pn6ORXJwMoBW6BB0BgLiY=;
        b=X/X5nwb+WXyRyQqhw+v4kpkOodpUaIn7/HKh7e9iaT5t9dWgRMewuJW+jQKudPzYpt
         bqhcFAQ31xFweN6u4Oa9L1aYr+xJUxfQ92antr0h36re9+5kA1jXY9zjketK6TFfz5ra
         J9r7q749SBE/ZanAdA4pLWXASrHcnn7BzXGVYoTyb+tOaoJ/rc/p0EHkH1tr0q3ocTj9
         vvSq40/hkQ3rPwU9tjLjuYIWwBWnS59j2dSl9/A+jI9vgBdZ2/qYwJ97AYQ78IkebO8Q
         fDcWhlYForAhKctJpObxSRiUn1YX+WEZPgeNSIWYVAwj51oQ0YAwbgiQ8nMwvZnIb6eo
         SNLQ==
X-Gm-Message-State: AOAM532j+Ii+M+AzKHgWQ8PjuY20gU9wZElmsqAuyzO1JCEyTPCOHDhx
        7+IFYV6ELP53SeYr885gq6GRyw==
X-Google-Smtp-Source: ABdhPJySg+2QcVGOwLgTLYpZnekmN0LjSaEldgKPqGwUnNANFqbM8WHdNyPi9pXxYXaIGyBPaeVVvQ==
X-Received: by 2002:a92:8495:: with SMTP id y21mr1131074ilk.55.1609876277463;
        Tue, 05 Jan 2021 11:51:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i6sm139679ilm.70.2021.01.05.11.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:51:16 -0800 (PST)
Subject: Re: [PATCH] cpuidle_set accepts alpha numeric values for idle-set
 operation
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210105122452.8687-1-latha@linux.vnet.ibm.com>
 <e2234e38-e18e-e0d3-1a2a-7c8b136d8817@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5bf14c30-0c47-a93c-fd31-8b5d4caf1616@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 12:51:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e2234e38-e18e-e0d3-1a2a-7c8b136d8817@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/5/21 11:03 AM, Shuah Khan wrote:
> On 1/5/21 5:24 AM, Brahadambal Srinivasan wrote:
>> For both the d and e options in cpuidle_set, an atoi() conversion is
>> done without checking if the input argument is all numeric. So, an
>> atoi conversion is done on any character provided as input and the
>> CPU idle_set operation continues with that integer value, which may
>> not be what is intended or entirely correct.
>>
>> A similar check is present for cpufreq-set already.
>>
>> This patch adds a check to see that the idle_set value is all numeric
>> before doing a string-to-int conversion.
>>
>> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
>> ---
>>   tools/power/cpupower/utils/cpuidle-set.c | 39 +++++++++++++++++++++---
>>   1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/cpuidle-set.c 
>> b/tools/power/cpupower/utils/cpuidle-set.c
>> index 46158928f9ad..b3dec48e7141 100644
>> --- a/tools/power/cpupower/utils/cpuidle-set.c
>> +++ b/tools/power/cpupower/utils/cpuidle-set.c
>> @@ -21,6 +21,19 @@ static struct option info_opts[] = {
>>        { },
>>   };
>> +int is_number(char *arg)
>> +{
>> +    size_t len, i = 0;
>> +
>> +    len = strlen(arg);
>> +
>> +    for (i = 0; i < len; i++) {
>> +        if (!isdigit(arg[i]))
>> +            return 0;
>> +    }
>> +
>> +    return 1;
>> +}
> 
> Any reason why you can't use isdigit()? Please see isdigit()
> usages examples in other tools and cpupower itself.
> 

Okay - Let me clarify my question a bit. What I am looking for
is if there is an existing function that can do what you are doing
here. It appears there is one:

Please take a look at the exiting is_number() in
tools/perf/tests/pmu-events.c

It uses strtod() to do what you are doing with strlen() and loop
over it with isdigit().

It is static and you can't use it as is.

Unfortunately you will have to duplicate this routine to keep
cpupower not dependent on tools/lib. Please add it to cpupower
lib instead.

thanks,
-- Shuah
