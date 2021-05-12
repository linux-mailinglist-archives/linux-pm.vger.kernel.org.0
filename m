Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC037CF7C
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhELRNy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbhELQ0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 12:26:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE45C06138A
        for <linux-pm@vger.kernel.org>; Wed, 12 May 2021 08:54:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m9so24151558wrx.3
        for <linux-pm@vger.kernel.org>; Wed, 12 May 2021 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IwYsrzsC2zQ9ouTjOtGEcNL7bnh+Wh/0iUzgrECoMI=;
        b=ZjgWy3OuctQsWClejuaMFzNAjqjnQ7T27W0tUvKB6N2vWtLhhuGm5BZlDg/mLYdRIq
         5Z5u1BnczdsvMnIg9+/j+HBF7VZ2QIpEcSdArGuR73Xl4OnHoJ2/YQ8aU74IR/qG/w3R
         mr9WfawkFDx97rPEFUjtdLuHQsbMn8ygQP3n13z4tb3r48MOdgu+rx07sEyzkm+quIcY
         pxDCOZ8E0Q+yJlWR3NKTMtTB/qsJz9CktIxGmQggTbH3zmy2NCcc5RfHNWVBjp7wz9yj
         eLtgdtLTl5tRFazjALtNnL8Vew/PczQkDpYQpgb2WMCeYwhA4QnRJCdENul460Fy0rYx
         N+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IwYsrzsC2zQ9ouTjOtGEcNL7bnh+Wh/0iUzgrECoMI=;
        b=Z0Gvz275u2jhgoaNcrV15zYF2MmARF3yn+76Gj69UK7A8xJWHzftOU+Mp1GQ7VmVcP
         l7sMXwX2ox0JgDMFaIYVFjgsSYK8qhiPIs1VcOvIhWBjxGz5/lLnK06jDMJ2pnEyoM+3
         LeVintWVvw8QIWO85m4xm5+rVnCxhjp08N9VRt0nyCz9WApdRddEHQbG3RdLHLCyjxxV
         72fpOYEd7zY6LG1oPHSyTncZeJ6ojbE//Fq1TfHUrOHmj6+9LWdLtCBmYi+p6aB7/pGO
         Lgj+mKAUFCHQcSAZnvNBp+/Ui3t5Yn2m9al1ncY39cPAwTFy+n5W8MOqMPKNcTergxy7
         +oug==
X-Gm-Message-State: AOAM5325W7N2iG8SFF2iFJp0jBd/VtH0xxBbRYs7N1h2aNhqcd48DmeA
        E6Qqf6n8lROp7CsXgEHa5Dm4OEy/99ITLA==
X-Google-Smtp-Source: ABdhPJwco3h+aOprpJ3p26OsY/TOVH7nGTXIggfYMQhbTiwiYgwiI3ncw0pkRqH0iaLrED0HLn4+uA==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr44649858wro.279.1620834849855;
        Wed, 12 May 2021 08:54:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1412:ffb:31a1:6c9d? ([2a01:e34:ed2f:f020:1412:ffb:31a1:6c9d])
        by smtp.googlemail.com with ESMTPSA id n20sm101363wmk.12.2021.05.12.08.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 08:54:09 -0700 (PDT)
Subject: Re: [PATCH] thermal: intel: Initialize RW trip to
 THERMAL_TEMP_INVALID
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20210430122343.1789899-1-srinivas.pandruvada@linux.intel.com>
 <7dc2bb343052c6c8fbb60d38c2ce7dac708f568a.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <62b8cdf7-29b1-d856-2686-34fdab5d485d@linaro.org>
Date:   Wed, 12 May 2021 17:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7dc2bb343052c6c8fbb60d38c2ce7dac708f568a.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2021 17:52, Srinivas Pandruvada wrote:
> On Fri, 2021-04-30 at 05:23 -0700, Srinivas Pandruvada wrote:
>> After commit 81ad4276b505 ("Thermal: Ignore invalid trip points") all
>> user_space governor notifications via RW trip point is broken in
>> intel
>> thermal drivers. This commits marks trip_points with value of 0
>> during
>> call to thermal_zone_device_register() as invalid. RW trip points can
>> be
>> 0 as user space will set the correct trip temperature later.
>>
>> During driver init, x86_package_temp and all int340x drivers sets RW
>> trip
>> temperature as 0. This results in all these trips marked as invalid
>> by
>> the thermal core.
>>
>> To fix this initialize RW trips to THERMAL_TEMP_INVALID instead of 0.
>>
> Any chance that we can take care of this issue during 5.13-rc*?

Yes, I will take care of it


>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Srinivas Pandruvada <
>> srinivas.pandruvada@linux.intel.com>
>> ---
>>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4
>> ++++
>>  drivers/thermal/intel/x86_pkg_temp_thermal.c                 | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> index d1248ba943a4..62c0aa5d0783 100644
>> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
>> @@ -237,6 +237,8 @@ struct int34x_thermal_zone
>> *int340x_thermal_zone_add(struct acpi_device *adev,
>>         if (ACPI_FAILURE(status))
>>                 trip_cnt = 0;
>>         else {
>> +               int i;
>> +
>>                 int34x_thermal_zone->aux_trips =
>>                         kcalloc(trip_cnt,
>>                                 sizeof(*int34x_thermal_zone-
>>> aux_trips),
>> @@ -247,6 +249,8 @@ struct int34x_thermal_zone
>> *int340x_thermal_zone_add(struct acpi_device *adev,
>>                 }
>>                 trip_mask = BIT(trip_cnt) - 1;
>>                 int34x_thermal_zone->aux_trip_nr = trip_cnt;
>> +               for (i = 0; i < trip_cnt; ++i)
>> +                       int34x_thermal_zone->aux_trips[i] =
>> THERMAL_TEMP_INVALID;
>>         }
>>  
>>         trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
>> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c
>> b/drivers/thermal/intel/x86_pkg_temp_thermal.c
>> index 295742e83960..4d8edc61a78b 100644
>> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
>> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
>> @@ -166,7 +166,7 @@ static int sys_get_trip_temp(struct
>> thermal_zone_device *tzd,
>>         if (thres_reg_value)
>>                 *temp = zonedev->tj_max - thres_reg_value * 1000;
>>         else
>> -               *temp = 0;
>> +               *temp = THERMAL_TEMP_INVALID;
>>         pr_debug("sys_get_trip_temp %d\n", *temp);
>>  
>>         return 0;
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
