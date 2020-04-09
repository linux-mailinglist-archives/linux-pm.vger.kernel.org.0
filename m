Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF31A34F1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDINe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 09:34:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36043 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDINe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 09:34:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so11990507wrm.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=chpsDGiY1sSNHuqPkjypc6UTwDn6Q9mqnrS5M2aYh2Q=;
        b=ghwalEhesCbx87Do7kRkD540vzH4QKmdORyO+Wrj8eCcMy92prHK7V7re9Y95NA984
         ITCvnUdcWcBr433ia/G6LBdeXWtwcyUo2Q20zYvMgTZr5IXotGokUjO7SjQbPDLvVWMH
         ZllmyZNT02tqhQTurMI2xLAeXxUaVQ9JE3ugGpebMrBTTC/YlVK9a5gthn/YzHp5mF2B
         SEEl/DoPN7F50nde1FX0nSFz9uxSotnPuBmLT0P47vII10uy9LkhNWNfDDLXO69LD+5O
         MFbsWQkK0sDH+cLYddObg33G+aJ5cRo8Z4X294TUyYYEgZELaH/pQqsj6UOYNM9Lny5d
         38tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=chpsDGiY1sSNHuqPkjypc6UTwDn6Q9mqnrS5M2aYh2Q=;
        b=ptSk1XTec/joXRdmIItQULw9dvngEmztJMqd8gNJqmiUT/gYuwOfJ/2Q8nH99sJvHT
         msMkzSVmOSZCxSh0cNJeseEyXvN6afE9bfyD/uGfOa6+kPoFEuanok2ITNThFQnNJli2
         32/s2DTdxLlH6HFK0EBiGavZ3KMXSIByRG6n6kN8XmIrG5w8zh4ntbOUjhMP4+lP3CTO
         DkqS4YeMvTsgOLFYPTleFgfrZ8qVYs3VDEatK0I2g3rDUxcX074XNx5Pc/7QW/nRbrWs
         gyT71sSZDuqDPvnoAMyC7kNExHavs7aGiPUyDB0rPxGomanlR4WrNQALtWFbLVLbl8h/
         ozqA==
X-Gm-Message-State: AGi0PuZ2TbYPrTNj8WpcwI12JJw9BVrVQyKhQh0t93XTZtKDhWxWE5oT
        jM8bvF10jzjhzCtuMO2umyUoiw==
X-Google-Smtp-Source: APiQypL/HsIMKYObLB4nMF7UdatcsLrjPSirt2tuQAGb6pAlv0/VbPlBUrEn3LFttdcxepNzYQLmkQ==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr14738449wrk.135.1586439298133;
        Thu, 09 Apr 2020 06:34:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda? ([2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda])
        by smtp.googlemail.com with ESMTPSA id r14sm3904543wmg.0.2020.04.09.06.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 06:34:57 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
References: <20200408041917.2329-1-rui.zhang@intel.com>
 <20200408041917.2329-5-rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
Date:   Thu, 9 Apr 2020 15:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408041917.2329-5-rui.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rui,


On 08/04/2020 06:19, Zhang Rui wrote:
> ACPI processor cooling device supports 1 cooling state before cpufreq
> driver probed, and 4 cooling states after cpufreq driver probed.

What is this one state ?

> Thus update the statistics table when the cpufeq driver is
> probed/unprobed.

To be honest, the series seems to skirt a problem in the acpi processor.

If there is a new policy, then there is a new cooling device. Why not
unregister the old one and register the new one ?


> This fixes an OOB issue when updating the statistics of the processor
> cooling device.
> 
> Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/processor_thermal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index 41feb88ee92d..179d1b50ee2b 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -142,6 +142,7 @@ void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>  		if (ret < 0)
>  			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
>  			       cpu, ret);
> +		thermal_cdev_stats_update_max(pr->cdev);
>  	}
>  }
>  
> @@ -154,6 +155,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  		if (pr)
>  			freq_qos_remove_request(&pr->thermal_req);
> +		thermal_cdev_stats_update_max(pr->cdev);
>  	}
>  }
>  #else				/* ! CONFIG_CPU_FREQ */
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
