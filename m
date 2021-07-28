Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9953D863E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhG1DuX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DuX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 23:50:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A3C061757
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 20:50:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so2256441pji.5
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FrYnTL9TwFuN1vt+KIlBzufA7x0qW3I2Fexno73Yt48=;
        b=fhEo/9S/wQeVXZquGw+9zVLckVKnGYZh+T7rRsd6PhQg2LBRt1Ck8ZEKUrlUMzv3/1
         8Y3sRPsi453vXiocWpkYZZhaVctDrrbvrS89J1RW26204oVmMFiY4+TVYFvwCYtvdmT9
         s47YInBTw8O6N4tSznKwUSLhqr0B4PFo5WG93Vy3cCOOQf8exiEYzbcOd+hbIpqrvymB
         b2WwbnhHXsuXOzZ5tQN8Tav9SDbybB70/3dguZkRkjFS/pcQ8hYfIdhR6v0/6odAsvgy
         ZRKpNihXQAkh48QiYZjgUb1qtgh+7kzqWjmdcK6kBlFdyt9SMiJXPY9CdehNii/rjfh/
         TfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FrYnTL9TwFuN1vt+KIlBzufA7x0qW3I2Fexno73Yt48=;
        b=QN2WbycruaYstYN4VBWMpd1kWJsSnCLXvCRvUtq10+3ukn3Zq+09FfY3mjs0XlZnal
         mFmpzgz5u6RErMqDLR7OB65eYY+UTq2Hiy+Wh+GYYRyz1HrmTuSvvZRU+WTNJctlXSlT
         dDcJnkPiszogWYknmMqzdfUwc5BD9wx6ESzF7tA0TOdpTYaYzcscPwHerz0Eo4WkMxPf
         8hkgZCLmXXpsrc3pDIa8+aIe/3RNcITOC7xbSE5RzB6LlPLvP0WArO7d2eGHjP1NkpLs
         IKoo1zGEHtU/eFQIDsaePrrtc0NuTPMmhPlTcPp75x2ZptqfRNLFK5/3v2k69Kw/9+sr
         wv5A==
X-Gm-Message-State: AOAM5320zTnWiQOCejNkEtYCymn2C5svxddDCAfGLTGwFgBP5PGAf2dK
        WAV7H7nz0KIcfWgqUJwvI2CS1ELQlFIhKA==
X-Google-Smtp-Source: ABdhPJx3iBpMT4fccV4pPERpT+6fYf5Q+S9trToOykb5i3f99E2pjH1+nxZ2W3L0Iyez+YUFa8FApQ==
X-Received: by 2002:a63:6d84:: with SMTP id i126mr10689629pgc.97.1627444222026;
        Tue, 27 Jul 2021 20:50:22 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id f4sm5784513pgs.3.2021.07.27.20.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 20:50:16 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:20:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [Patch v4 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210728035014.25mgvrpnraxfslq7@vireshk-i7>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
 <20210727152512.1098329-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727152512.1098329-4-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-07-21, 11:25, Thara Gopinath wrote:
> +static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> +{

> +	/* In the unlikely case cpufreq is de-registered do not enable polling or h/w interrupt */
> +
> +	spin_lock(&data->throttle_lock);
> +	if (data->cancel_throttle) {
> +		spin_unlock(&data->throttle_lock);
> +		return;
> +	}
> +	spin_unlock(&data->throttle_lock);
> +
> +	/*
> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
> +	 * polling and switch back to interrupt mechanism
> +	 */
> +
> +	if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
> +		/* Clear the existing interrupts and enable it back */
> +		enable_irq(data->throttle_irq);
> +	else
> +		mod_delayed_work(system_highpri_wq, &data->throttle_work,
> +				 msecs_to_jiffies(10));
> +}

> +static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> +{
> +	if (data->throttle_irq <= 0)
> +		return;
> +
> +	spin_lock(&data->throttle_lock);
> +	data->cancel_throttle = true;
> +	spin_unlock(&data->throttle_lock);
> +	cancel_delayed_work_sync(&data->throttle_work);
> +	free_irq(data->throttle_irq, data);
> +}

Lets see if we can still make it break :)

CPU0                                            CPU1

qcom_lmh_dcvs_notify()                          qcom_cpufreq_hw_lmh_exit()

spin_unlock()
                                                spin_lock(),
                                                cancel_throttle = true
                                                spin_unlock()

                                                cancel_delayed_work_sync()
mod_delayed_work()
                                                free_irq()
                                                kfree(data)
qcom_lmh_dcvs_poll()
Uses data.


Sorry, locking is fun :)

-- 
viresh
