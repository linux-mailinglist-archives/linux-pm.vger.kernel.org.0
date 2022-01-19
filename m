Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D96493507
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jan 2022 07:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351801AbiASGfx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jan 2022 01:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351777AbiASGfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jan 2022 01:35:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA88DC061574
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 22:35:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so1740073pjp.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 22:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0PXs+XnAFQgpQ9xLRKE0glSvUjxvj1L/ZIt0SEGUo1c=;
        b=fQqbhjybCwC0L/PgihADaiXSShglwgmOZIzlIM1KL7gK9tFDs5tAowQyn+J5vAihiI
         U4IhMUIkEYEmocU4AMF3O0a/h+styyIG6XBHf7aWYdZgxd1xOyeEHuFTwzEcQuowavDc
         kB5xKzCVZ1M7zqVoDlC/7XnuGrUIPKAT2OH13CAhmDEzYfbTPaaDbQR9d4d5v/N+ji8I
         bMM0x7JZD/XYLJGXr+9tlmMPP68pJhDb5Hl52W/Gk7C1NwoSDCElHYd/MKdcGgOL/n9O
         uZXTceLAgaznKP8h9fxP6sFq5GQQiu8KIg58ar3arvdfXORb3MJpC16wGz2kx0v2IQDs
         PYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0PXs+XnAFQgpQ9xLRKE0glSvUjxvj1L/ZIt0SEGUo1c=;
        b=LPUKy/NhDRHvn2UmSvIgrMpkE8lpdRsYM7ddUSh4y9Ne2XEHPjfnQ8kOvU93nU1CUv
         ximybVnk2AZ00qfBtxHVd3MOuODmFknxbjv+zTX4hHpU59M2TawKxBhzVqdOphaajCMB
         C+OwdDBDRZA5r7WqjR43SDXnziPZtpLRJnVEfJBBdFcEEee8ZB/z97V9cdrEqTweNwWD
         SKRjh2XIkxU/Cdd3VAlfhMTHb7hJHqfaYkvnL1yFu1FTPVNhhl+7Ss+BNhFQ5/hfLkRV
         +tcPDFo4u0IVdHjR2LzrSowLzH8yPwl9BTlkmpX1TitUO7RD4Hhk1UxDVjFJg165niD4
         gC5g==
X-Gm-Message-State: AOAM530r73NdXSOy9wa4tARdAjn8Th+HsKC4I10mMr/ewvlcZFLlwlFU
        z+pvZf708+R9hivWPZtGKjuPDw==
X-Google-Smtp-Source: ABdhPJwbDseRQ/w2ehW0f94PPtEHNvGrQCY5xA9P7mRGxNv2wA+R59MGE3gIl9erF8qcfvWhrTQSpA==
X-Received: by 2002:a17:90b:17c1:: with SMTP id me1mr2560402pjb.135.1642574150392;
        Tue, 18 Jan 2022 22:35:50 -0800 (PST)
Received: from localhost ([223.184.90.234])
        by smtp.gmail.com with ESMTPSA id o186sm18968479pfb.187.2022.01.18.22.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 22:35:49 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:05:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: qcom-hw: Use initialized cpumask for
 thermal pressure update
Message-ID: <20220119063547.hktwzbycf7trqjju@vireshk-i7>
References: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-22, 10:56, Bjorn Andersson wrote:
> In the event that the SoC is under thermal pressure while booting it's
> possible for the dcvs notification to happen inbetween the cpufreq
> framework calling init and it actually updating the policy's
> related_cpus cpumask.
> 
> Prior to the introduction of the thermal pressure update helper an empty
> cpumask would simply result in the thermal pressure of no cpus being
> updated, but the new code will attempt to dereference an invalid per_cpu
> variable.
> 
> Avoid this problem by using the policy's cpus cpumask instead of the
> related_cpus mask, as this is initialized before the interrupt is
> registered.
> 
> Fixes: 0258cb19c77d ("cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 05f3d7876e44..866fba3ac6fc 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -297,7 +297,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>  	throttled_freq = freq_hz / HZ_PER_KHZ;
>  
>  	/* Update thermal pressure (the boost frequencies are accepted) */
> -	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
> +	arch_update_thermal_pressure(policy->cpus, throttled_freq);

policy->cpus keeps on changing with CPU hotplug and this can leave
your platform in an inconsistent state. For example, in case where you
offline a CPU from policy, other CPUs get their thermal pressure
updated, online the CPU back and all CPUs of a policy don't have the
same settings anymore.

There are few things we can do here now:

- Check for empty related_cpus and return early. Since related_cpus is
  updated only once, this shall work just fine and must not be racy.

  While at it, I think we can also do something like this in
  topology_update_thermal_pressure() instead:

  	cpu = cpumask_first(cpus);
        if (unlikely(cpu >= NR_CPUS))
                return;

- And while writing this email, I dropped all other ideas in favor of
  change to topology_update_thermal_pressure() :)

--
viresh
