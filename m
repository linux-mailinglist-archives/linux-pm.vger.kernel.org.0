Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E232EB246
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbhAESOE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 13:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbhAESOE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 13:14:04 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ACFC061793
        for <linux-pm@vger.kernel.org>; Tue,  5 Jan 2021 10:13:23 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id b24so596180otj.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2021 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GxkJo5g4V4czIVLT4j/kAOkJxRGEcQTcKpmMI8mFQbU=;
        b=S1KTQA0hFGQnlkBt6vPEdxNuehUu3XeZgcYJmw5IVzuvvVi3rZIayqrqbki6LTknon
         y7c6NGcqfYuX6D4zzOzO5fyVgqpiG/JgEZyY2p0p2ZaWzwO3aqVH7EJbn1mlVPQkp3Zq
         Xi5k7qgxSHXAb6K0+Tyb1Vz6tCvCQwW87UCUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GxkJo5g4V4czIVLT4j/kAOkJxRGEcQTcKpmMI8mFQbU=;
        b=OGd8i5rk0PB1E2C6GhSHh8Gqz5fSAQvSVsFaC1z7qLYkCUNDjiuWgQyFG+yQj4pUsx
         jyS7E7VXOizfZ3xNg0UKOJ7hd2kUvq9s/ySTYOZO66uAz1j1cAzyuNflgVfnk+faQznq
         hjaXKOtTZbpgEYz0PawX2zoexh1o/udak4MpM7of46Xo0jaX9pvzgKjK/bTgRKHBOiEe
         pPyM82SsdCDpdqJgOjMHULy/eUkvyIA0iphc1lDbfavJGv0z+zWkDkF1q13VVJ34Kw1U
         VxfvuTv4lGoAaXSyo0e3AaOYjgztrOXVs358XHFgrHSEtAv83M1tOyRRRI5QvAvjBl+2
         skfQ==
X-Gm-Message-State: AOAM531NLrEw+w7SCMtmGp/dVIGPEv+N7F3CDfTbfkRv2ZINvnaQtlVo
        YoNYlD36zYkF8JTqU068eI130w==
X-Google-Smtp-Source: ABdhPJyJOPa2iuR/DDqycjJ6gFVcvIOxDc6bpCNHPBbNd35njGXSiYkI1RHMAJWfHibjadg1BAhngw==
X-Received: by 2002:a05:6830:403a:: with SMTP id i26mr511468ots.111.1609870403194;
        Tue, 05 Jan 2021 10:13:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n16sm20932oop.9.2021.01.05.10.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:13:22 -0800 (PST)
Subject: Re: [PATCH] cpuidle_set accepts alpha numeric values for idle-set
 operation
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210105122452.8687-1-latha@linux.vnet.ibm.com>
 <e2234e38-e18e-e0d3-1a2a-7c8b136d8817@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b6060801-9477-a61b-abb5-b6eecf5940c9@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 11:13:21 -0700
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

Another thing. Please add "cpupower:" to identify what you are
changing clearly.

thanks,
-- Shuah



