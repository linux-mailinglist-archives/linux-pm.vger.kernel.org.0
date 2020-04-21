Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EF01B2135
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgDUIPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDUIPh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 04:15:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C753C061A0F
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 01:15:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so2495615wmb.4
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xjSknTeR+7dqcaL1YgejpgJ9/KujY8j8UEnyfLmZD4=;
        b=frOKGgAVIjbSzucTY8HiXqzPrWgYdihoiEtz+cb34v3+J49RpTLLTKTwBeXk+DnyE/
         Ma/xI/Oz4r+iM7CFvAgmw0X7Oa1CoDY3pQPLZWCm04SaG+jx1Cg8F8ipUTjca56HpLcP
         sqW3/+7LhmRxDOqO4/j0dRG2dGQhvnU1BAhRMGEYqTQqX/1dnb99c+ctJj7h0fXVuc6f
         B/5XyRppCG6V9Hs8TWKyfwNOYfNldnC2fjsFvYYbASsK8YajbRqqTQl1VOee2YmGjuVN
         DgzLhyyFVbu5ax5j4VzJ+uGJhqdBCMQbAETtVyt1n1J2iqSZmvbUoeKXPnVVc0XZIRHo
         DqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xjSknTeR+7dqcaL1YgejpgJ9/KujY8j8UEnyfLmZD4=;
        b=bx6t60QlDr43oR4WMkBktftCbV60Tr0YyrvbKpNZYTVBYNxUdbTmiJiPn9bsuwrL53
         cIDXlHYVtXPOFWZfxQ8p1xBOQ4ZIUeCfC91cTQTxjpjEmk9BjwyFrrzy8pl7rmWKhD17
         bUXSFYpRsC1UYXhHlv3r6/f2eix72zTn+X4jtsyElbaKJUv6fbHtTm+6AtkpBBYsPpW4
         uI/3w/cNi62FNVn+/REtXRP2njmHXTH6Wotl/dHfTbs1U9OujnPkZ4OCm3A2fZ7jnZbK
         nLWnH2qcAly4SxU/P7W68avJ/wtEx/5di7eRCXlzxUmEuD3iWH5dR5TU38wJ+H2chBXL
         aL0A==
X-Gm-Message-State: AGi0PubBP75C3smHJxDVZldHURxhcWXhaUflsyngyW3aAEX+y9k+E3aY
        a3CertHzWik/Jms0dtHh14X4NgF0ytk=
X-Google-Smtp-Source: APiQypLAbrQ/7+vnxMSEVWZPMUZwhWOh+FsfXCIwjmuMJt8X2Ze0PcEBnGHrEyqo46iBVLy1lNevDA==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr3484494wmd.19.1587456935761;
        Tue, 21 Apr 2020 01:15:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8985:83c2:22f1:8de3? ([2a01:e34:ed2f:f020:8985:83c2:22f1:8de3])
        by smtp.googlemail.com with ESMTPSA id k14sm2678325wrp.53.2020.04.21.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 01:15:35 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] thermal: cpuidle: Register cpuidle cooling device
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6b58035c-fe48-09ab-f042-729b07bcfec6@linaro.org>
Date:   Tue, 21 Apr 2020 10:15:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414220837.9284-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lorenzo, Sudeep,

other patches of the series are acked / reviewed.

If you are ok with these changes, could you add your acked-by so I can
merge all the series via the thermal tree?

Thanks

  -- Daniel

On 15/04/2020 00:08, Daniel Lezcano wrote:
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional
> 
> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm.c  | 5 +++++
>  drivers/cpuidle/cpuidle-psci.c | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 9e5156d39627..2406ac0ae134 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>  
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
>  	if (ret)
>  		goto out_kfree_drv;
>  
> +	ret = cpuidle_cooling_register(drv);
> +	if (ret)
> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
> +
>  	return 0;
>  
>  out_kfree_drv:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index edd7a54ef0d3..8e805bff646f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>  
>  #include <linux/cpuhotplug.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
>  	if (ret)
>  		goto out_kfree_drv;
>  
> +	ret = cpuidle_cooling_register(drv);
> +	if (ret)
> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
> +
>  	return 0;
>  
>  out_kfree_drv:
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
