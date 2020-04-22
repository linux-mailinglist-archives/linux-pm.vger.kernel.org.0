Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970A21B3990
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgDVIEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVIEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 04:04:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6167C03C1A6
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 01:04:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j7so684651pgj.13
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9Wyc8DE2t5zNihLzIqsm/QJdBYD4ViUpAEf/RJMSS0=;
        b=ZJmC054xY/YkEw9AT6rHo0MbqeAXUOtedtbE1wmNEmlDrRtyVTQeGv6+33Yrd4/gH3
         N77rzfAoD2kUO3blfkymFKwzH3R2Q19GwdrI8Xf1WWdKIzQySsHR+AqXwXcVrVK9ayui
         aVs24kVmK9WLg4zUq+xUnrY0dZfQt+cGJT24FBUHBOJDu7ZnSFl+YdmgxjmaNVYp5BI8
         NYDIweJCrnfsKFZDK+j79FA4B6qKxXrW8nvqOBtR8a9gXG3O2GT0981LhkV/yiQmc8qh
         cPRbgBmFszJBQEHT9xZ6/inT2aXqYzAITDvILF2uk8wswic8fpK8aQvN6QrVR6RVEV2+
         uODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9Wyc8DE2t5zNihLzIqsm/QJdBYD4ViUpAEf/RJMSS0=;
        b=NBySS1oVYDgJ3uQDQAEtsCmcR8PAUF/YYz7LAtsYjdQUif2ZzeWuRy0visik6M/GuZ
         UV8Q09tDiNGRUdts+7zU9fkRyRgJahZf4XLkzxhEgBT2zOetcRT6wUxCVe6DLbfD4nOP
         YJc/0fjgkZfRnG/Px6gUsRSInkYImASyoD+gjynPbQI3KYL/q5MkgyqJEJIzdyf0gZz+
         PRW2YpjNG5Zhp0Qro+NkgY7mubryxV9hZEGAqhXNU17u7NH6AfF8ARhZPkDsa4zEqfHO
         RAPyTeJOjzvc4QQO3XMk6zaaZSwZiiwkooCE8jXyYMWnQrD2ahZFxYwMGLCc6e2Enssa
         xPbw==
X-Gm-Message-State: AGi0PuaQBugxp2yk6u8nCEy1205zAi1Z5act/dvxzbQW+ByBwyTquPQO
        hDOcZZ5s/Aaf/fnd/zRaLII8bw==
X-Google-Smtp-Source: APiQypLRE6b1a6nqIpVpx1XcMWcop2Vn7+nEY6FQm3p9ZeC8kZ/T/qv9ncm1ppLC1ATqVVIl+DL14g==
X-Received: by 2002:a63:b952:: with SMTP id v18mr25261985pgo.179.1587542682157;
        Wed, 22 Apr 2020 01:04:42 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id y184sm4716596pfg.127.2020.04.22.01.04.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 01:04:41 -0700 (PDT)
Date:   Wed, 22 Apr 2020 13:34:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     gao.yunxiao6@gmail.com
Cc:     daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
Message-ID: <20200422080439.kkpl7xmaawkxu5re@vireshk-i7>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-04-20, 14:48, gao.yunxiao6@gmail.com wrote:
>  static DEFINE_IDA(cpufreq_ida);
> @@ -313,12 +315,24 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>  	u32 last_load, normalised_power;
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>  	struct cpufreq_policy *policy = cpufreq_cdev->policy;
> +	struct cpufreq_cooling_plat_ops *plat_ops = cpufreq_cdev->plat_ops;
>  
>  	last_load = cpufreq_cdev->last_load ?: 1;
>  	normalised_power = (power * 100) / last_load;
>  	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
>  
>  	*state = get_level(cpufreq_cdev, target_freq);
> +	if (*state == cpufreq_cdev->max_level &&
> +			plat_ops && plat_ops->cpufreq_plat_min_freq_limit) {
> +		plat_ops->cpufreq_plat_min_freq_limit(policy, &target_freq);
> +		*state = get_level(cpufreq_cdev, target_freq);
> +	}
> +
> +	if (plat_ops && plat_ops->cpufreq_plat_cpu_ctrl)
> +		plat_ops->cpufreq_plat_cpu_ctrl(policy,
> +				last_load, normalised_power,
> +				cpu_freq_to_power(cpufreq_cdev, target_freq));
> +
>  	trace_thermal_power_cpu_limit(policy->related_cpus, target_freq, *state,
>  				      power);
>  	return 0;
> @@ -684,3 +698,41 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);

Instead of adding such callbacks to constraint the min freq of CPUs,
you can directly use frequency constraints used by QoS framework to
put such limit directly on cpufreq. Look at freq_qos_add_request().

-- 
viresh
