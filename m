Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1871BAA68
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 18:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgD0QuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgD0QuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 12:50:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375EC03C1A7
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 09:50:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so21415183wrx.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ifZHzQrYJTJ2psIoVYONoJxVcPBrBwiLq0Ka5H1X7f0=;
        b=YN4xMzacilYGgkI5xIJKKjKcvwZcZ4qjnwboi7t+4heCeg+DVoCri3aTgOQ43+2b/U
         ur3Wx9/P9iXCTeuhRKTWS9KtRKW7D4EGSQ1W6lDnSmD3l0qsduegt1i2nxkp/i7sIvSY
         40XOB+SMgz68l1/ArBdGciU3CqBzBQR7h2zzVy6FvC8lqekaAiyRsAw56dIw+I4FErQ4
         azNHB4ooJm10iR0K4KIDxECVWcNQfJk1j0FaB9+bxGqUgxFV+H5J+klrzmWcM6+4poJV
         1RqelOBabzBzN0wbIZzc+jQcxhamURzPkZjnvLWAby0K3AwbgDzpUeJXgcLJw4EKrHSR
         6A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifZHzQrYJTJ2psIoVYONoJxVcPBrBwiLq0Ka5H1X7f0=;
        b=H3C1JWtPpEqY3fPtO9M9PG1KX+QRIktl8M2MkVCNA9zBS8v4ihXbWKgajl2fgvBMIW
         7+xbPFym25tHLpDyiMoScEFykFMU4L5qJTwazYyNC33K7cPcjTU/L+h5+kvXhVUAT1K2
         Jz2qq5thUkCGZCvCjaIdIyfJUD2SXeFfUABjODiJ29GurqFEY1ozwM6OH02Nu+18PIVQ
         oCvIP4HgWfnkmSjfK44O9iKDlGpCqv3LGe8MvJKWEHS9Rj5CyENM/t4MdP4eCD+ec7G1
         pEtPGNNxs8u808Y5znEO3Ty010eUua3DklEBDF5dWki6Yb/AyMqDPRggBbOwDu+7tJp+
         4d9A==
X-Gm-Message-State: AGi0PuaDmMpPJKibzY8EAbQch7bhyGjigz5HBJyVdNXv/YNs2wnDe/OT
        DDiBEpM8T4IZVIOGeIGl68lHKw==
X-Google-Smtp-Source: APiQypLnpGbWiFbiATkGLzM1ksCRfp33HEV/xjz0k0UXMZ8dYv4G0WKZWQ6pcTQZyBZPekAo8fPm6Q==
X-Received: by 2002:adf:f24c:: with SMTP id b12mr28353216wrp.359.1588006211473;
        Mon, 27 Apr 2020 09:50:11 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id f23sm16030600wml.4.2020.04.27.09.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 09:50:10 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] thermal: cpuidle: Register cpuidle cooling device
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
 <20200414220837.9284-4-daniel.lezcano@linaro.org>
 <6b58035c-fe48-09ab-f042-729b07bcfec6@linaro.org>
Message-ID: <34667fb4-664c-c80b-6bba-fe2ae981dcc1@linaro.org>
Date:   Mon, 27 Apr 2020 18:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6b58035c-fe48-09ab-f042-729b07bcfec6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi guys,

any chance you ack this patch ?


On 21/04/2020 10:15, Daniel Lezcano wrote:
> 
> Hi Lorenzo, Sudeep,
> 
> other patches of the series are acked / reviewed.
> 
> If you are ok with these changes, could you add your acked-by so I can
> merge all the series via the thermal tree?
> 
> Thanks
> 
>   -- Daniel
> 
> On 15/04/2020 00:08, Daniel Lezcano wrote:
>> The cpuidle driver can be used as a cooling device by injecting idle
>> cycles. The DT binding for the idle state added an optional
>>
>> When the property is set, register the cpuidle driver with the idle
>> state node pointer as a cooling device. The thermal framework will do
>> the association automatically with the thermal zone via the
>> cooling-device defined in the device tree cooling-maps section.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle-arm.c  | 5 +++++
>>  drivers/cpuidle/cpuidle-psci.c | 5 +++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 9e5156d39627..2406ac0ae134 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -8,6 +8,7 @@
>>  
>>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>>  
>> +#include <linux/cpu_cooling.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu_pm.h>
>> @@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
>>  	if (ret)
>>  		goto out_kfree_drv;
>>  
>> +	ret = cpuidle_cooling_register(drv);
>> +	if (ret)
>> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
>> +
>>  	return 0;
>>  
>>  out_kfree_drv:
>> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
>> index edd7a54ef0d3..8e805bff646f 100644
>> --- a/drivers/cpuidle/cpuidle-psci.c
>> +++ b/drivers/cpuidle/cpuidle-psci.c
>> @@ -9,6 +9,7 @@
>>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>>  
>>  #include <linux/cpuhotplug.h>
>> +#include <linux/cpu_cooling.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu_pm.h>
>> @@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
>>  	if (ret)
>>  		goto out_kfree_drv;
>>  
>> +	ret = cpuidle_cooling_register(drv);
>> +	if (ret)
>> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
>> +
>>  	return 0;
>>  
>>  out_kfree_drv:
>>
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
