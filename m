Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B073C1F99
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGIGtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhGIGtd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 02:49:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720BC0613DD
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 23:46:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id u14so8973600pga.11
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xaT7y+PG7DwjxYqSoSUwIQdL1dKO1pep2OkWSy56kbM=;
        b=d5blS0UKDt1DBFfpUH8YUVsFUu3RxbvZlJYKp6BG++edlFbJ4tAl+QNPo4S8A/a+pV
         ouFm4c9mTUFYOt6koEkc648nuL8RKfwUUv2hvolAnfM7rnACSEeebCiYWW44XhW3AiTK
         o/BzoHT3HmebkOY9tmTaGCclZIgTjf7UsUWMhhhWRpmQgZ2PY+IA/VywWkqiBU4QH4SO
         HDN17LUfO7CM8K4SOnRk4s7lKl3r/2j7DhNhzj9/Jmv1NfW4J7BLZb0OD/UPwGkK+NhS
         tNpvX7YcI5LiKdjDVKVN490+uV/E148TR3rQwE6HYxJsK9Jxe6Gmos6rNW6hjUO8ljPv
         vyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaT7y+PG7DwjxYqSoSUwIQdL1dKO1pep2OkWSy56kbM=;
        b=IcQTNvDeJVAz9ulYdQw+kQ56+vfU3AI49R3DCpin7BL86c5MEMeW5V2jL+iHkKNC3d
         oONiETvZvUWgobSnpVTXOfjosyOvmAicvzKhVn3a7Wpt3RAjKIWXYTSEx8vgAChLs2yE
         t98K6aL+9bSRVmTBBMNi+caIzawBilwcKvTqERSnbO/lJzvVYSfusttO0WDciR8ya11k
         O1URTPZ1LlkNbdCAl0/z4DVnMkGyHmS+c93NMwDuKN4yvRpG5MTblAxIikLGP6pX3Iay
         rWP1aOcyGVAtYugxlMB+BaTc3WWGvAvlqheNMkicwOgcp7yxeegEkbgo465juGC3WdeL
         s6RQ==
X-Gm-Message-State: AOAM531luQziy83/L9c2D+bnO8rgRrRi2xGmosdPr7u3OQTlLMV6KY1V
        O/2ozHFW9MEyzZbrQGty6DNKSw==
X-Google-Smtp-Source: ABdhPJyVTVZo24ToIx/xl45xZBXM5V3PkgfTRfpGnXJqHEyvGXd7a+kvj0PE+uAEH9XoX97HcocWOQ==
X-Received: by 2002:a65:550a:: with SMTP id f10mr11024883pgr.155.1625813209004;
        Thu, 08 Jul 2021 23:46:49 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id x13sm4283500pjh.30.2021.07.08.23.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 23:46:48 -0700 (PDT)
Date:   Fri, 9 Jul 2021 12:16:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210709064646.7vjgiba2o7beudly@vireshk-i7>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-4-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-21, 08:06, Thara Gopinath wrote:
>  static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> @@ -370,6 +480,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>  	}
>  
> +	ret = qcom_cpufreq_hw_lmh_init(policy, index);

You missed unregistering EM here (which is also missing from exit,
which you need to fix first in a separate patch).

> +	if (ret)
> +		goto error;
> +
>  	return 0;
>  error:
>  	kfree(data);
> @@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> +	if (data->lmh_dcvs_irq > 0) {
> +		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);

Why using devm variants here and while requesting the irq ? 

> +		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
> +	}

Please move this to qcom_cpufreq_hw_lmh_exit() or something.

Now with sequence of disabling interrupt, etc, I see a potential
problem.

CPU0                                    CPU1

qcom_cpufreq_hw_cpu_exit()
-> devm_free_irq();
                                        qcom_lmh_dcvs_poll()
                                        -> qcom_lmh_dcvs_notify()
                                          -> enable_irq()

-> cancel_delayed_work_sync();


What will happen if enable_irq() gets called after freeing the irq ?
Not sure, but it looks like you will hit this then from manage.c:

WARN(!desc->irq_data.chip, KERN_ERR "enable_irq before
                                     setup/request_irq: irq %u\n", irq))

?

You got a chicken n egg problem :)

-- 
viresh
