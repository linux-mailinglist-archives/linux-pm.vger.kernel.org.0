Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98C433A9C8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 04:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCODLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 23:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCODKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 23:10:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA84C06175F
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:10:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v4so4947136wrp.13
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FhTLju1NPn4NPgJImSXtm4ufxNg1Mw9xI4J0y2WfHqU=;
        b=wOPEgb90hjcbYfs5esQzgQezxmckiHpmpzR2NvgQ87G6x2//Z2BhuDeKVoi+5I7pn4
         Em0zqkvvbZOYH5yUAxY/wAF56bVZFJg5oqotd3FaCV1KoWRo6E2YGE+sWjDxGs4mXbqy
         PW5BCBR+x/Gg5YASYPLnEzT0N8ycCCGMMf+byE4nwSjmFat58LfWyACF5GoVbpVGpvbN
         V3BnwQ5ZOiUo7si5ZFI7hAr692tjS+Gr8eXXiINnJ8Tk2igu7wdDj4danMVRP4j868rt
         LV4AefGORLckJbtD0qs63JQmp2Z2Nt6wGCaqct1bmHRswXibwx6N9Uwbx8FPh9w5VLjE
         wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhTLju1NPn4NPgJImSXtm4ufxNg1Mw9xI4J0y2WfHqU=;
        b=tmIgvvaPAOyB+p/gHQ39bsA50ZC2XaBDWP2I43NFYyNLnkZ4jM/7whgDDH2CfjdstC
         5faJ0Z/uxhFy955N3Z1FwQX/YY0v3lbTLrbIpoxyJCEmiBtYH2xTySVNVZOWXnZOD/M3
         8Il7Js30NKVjOVnAkaB8WbH3GW0fylydwjedpjctjv27AsThkBKVO5JI4GuIqqiMr9ga
         QAvf46PGvc3hJdQZMrq+ZNidXiU6gB0qlqu9s2FVz983GdbDzcZSiZHTD8GGDwmRoZTk
         69p8gneRmyiXxacxvZwD3KLdtBXv42ce4Q4B/XLhC82fNk/LK5CmyX5kM8xz2EtuzL6Y
         spOg==
X-Gm-Message-State: AOAM531R9PxkGgJ//vycEx3jSYaHaYTRp249qXR8iZqqL780FwrJRT/9
        gbuFq1LK9DOb/NzgzhEQj6rIIMOAsfh3qg==
X-Google-Smtp-Source: ABdhPJzl3sQkIHfBR/CL0r3eK1hGRqS7qIXaHeZiVL4vcMzPZDnYoP2Jjf8DDh7LiKD0P/Ginv2GIA==
X-Received: by 2002:adf:a418:: with SMTP id d24mr24872497wra.187.1615777838058;
        Sun, 14 Mar 2021 20:10:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:fcf7:1d46:a8c5:fa1b? ([2a01:e34:ed2f:f020:fcf7:1d46:a8c5:fa1b])
        by smtp.googlemail.com with ESMTPSA id c26sm17710075wrb.87.2021.03.14.20.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 20:10:37 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] thermal/drivers/cpuidle_cooling: Use device name
 instead of auto-numbering
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
 <20210312170316.3138-4-daniel.lezcano@linaro.org>
 <20210315030755.kl7gt66f45o254u3@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f18cdcc2-fcd0-3b87-d52d-19083d81d6cc@linaro.org>
Date:   Mon, 15 Mar 2021 04:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210315030755.kl7gt66f45o254u3@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/03/2021 04:07, Viresh Kumar wrote:
> On 12-03-21, 18:03, Daniel Lezcano wrote:
>> Currently the naming of a cooling device is just a cooling technique
>> followed by a number. When there are multiple cooling devices using
>> the same technique, it is impossible to clearly identify the related
>> device as this one is just a number.
>>
>> For instance:
>>
>>  thermal-idle-0
>>  thermal-idle-1
>>  thermal-idle-2
>>  thermal-idle-3
>>  etc ...
>>
>> The 'thermal' prefix is redundant with the subsystem namespace. This
>> patch removes the 'thermal prefix and changes the number by the device
>> name. So the naming above becomes:
>>
>>  idle-cpu0
>>  idle-cpu1
>>  idle-cpu2
>>  idle-cpu3
>>  etc ...
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> I acked for both the patches :(

Right, I'll add you when merging the patches.

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
