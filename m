Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F241B1B3BC6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDVJxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVJxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 05:53:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCFC03C1A8
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 02:53:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so720349plp.9
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UYGd9RU1hbiT0zKddan3FAbjV6ezaTpORJVOJeBD6Lk=;
        b=fV/Q1PugmJTKycJfD3U8pMLKvp/iDgQJwFYD9U8zNHXv77AWV7B8dS07jX7noDRsBO
         mD9L0yF9v4c/uxGmAs5pLVfKzSoMNo3pL8djx27SHGIeZlwiVtMgLy8+HGkOtXLOlkQ0
         fUugR5nwddIkjlm2Jb8q4ng+bDbashromf/U5aCmEGmAXqiTaszaL9v+scW6uJ2E3sQj
         lDqqHzAsq7Rj6uFitGTNhiRLyHV0vVUZFxuy4U7/6miISGrhW8scoCET6ROeNdP+nX60
         LgUvaknSH2O9hZhYTgAz69tp3Er/EgywSD4wvri00GwtbOE9pPrzoaPAi1abfbMQu+nx
         75+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UYGd9RU1hbiT0zKddan3FAbjV6ezaTpORJVOJeBD6Lk=;
        b=J2Vqpy3npMOQYyNB6gepTJQO3Qoxljbq74QZbjK/MLmx+vzKzbm4L1dIxLBzzacOh0
         Y1xGFVBE2vv2scSKh1SEf9i3SWFuWm++2nHBsV9j0vlWDCsCgbm9P6rRt9pZVm59lWmY
         sKPBKzzf8zzjxU9vZdDm3J6+rnUPIm9pdSZFf85NFRSQJvYLpDBSVC56/puCemLz3cUf
         zaSJdf6H4A6Qn5P4LEdABpx6iqvocUymDJAXaCWv0isnyDiU3uT/d4wOEQCJbPVj8JFv
         RxoEekw9iSt69I+BhGMeF2r5TIkFeJ2RqbNvCY1TC3SZlVLeGWSm32tyCzG8kJB14kHa
         9feg==
X-Gm-Message-State: AGi0PubL+lQc8VspQOMlI+qflUipAgqwO3GPeEt9nKAsanW0ZuHPzyFu
        r7Gk/g3n8pW5I1J90iYokJqr33qHZVb+su4eLEE=
X-Google-Smtp-Source: APiQypK/SaT3+4ABP+5QWI96OF8WjEM+OSuC/YjoLwVxBkuIu1uZvA2kLAEu4BHxCwl5uQxX3S3bAsJ2gIvfj68ILqg=
X-Received: by 2002:a17:90a:fc89:: with SMTP id ci9mr10868051pjb.140.1587549203213;
 Wed, 22 Apr 2020 02:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2129:0:0:0:0 with HTTP; Wed, 22 Apr 2020 02:53:22
 -0700 (PDT)
In-Reply-To: <20200422080439.kkpl7xmaawkxu5re@vireshk-i7>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com> <20200422080439.kkpl7xmaawkxu5re@vireshk-i7>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Wed, 22 Apr 2020 17:53:22 +0800
Message-ID: <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

viresh

Thank you very much for your advice.

In here, only check whether the frequency point given by cpu_cooling
module is the minimum frequency point.

On 22/04/2020, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20-04-20, 14:48, gao.yunxiao6@gmail.com wrote:
>>  static DEFINE_IDA(cpufreq_ida);
>> @@ -313,12 +315,24 @@ static int cpufreq_power2state(struct
>> thermal_cooling_device *cdev,
>>  	u32 last_load, normalised_power;
>>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>>  	struct cpufreq_policy *policy = cpufreq_cdev->policy;
>> +	struct cpufreq_cooling_plat_ops *plat_ops = cpufreq_cdev->plat_ops;
>>
>>  	last_load = cpufreq_cdev->last_load ?: 1;
>>  	normalised_power = (power * 100) / last_load;
>>  	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
>>
>>  	*state = get_level(cpufreq_cdev, target_freq);
>> +	if (*state == cpufreq_cdev->max_level &&
>> +			plat_ops && plat_ops->cpufreq_plat_min_freq_limit) {
>> +		plat_ops->cpufreq_plat_min_freq_limit(policy, &target_freq);
>> +		*state = get_level(cpufreq_cdev, target_freq);
>> +	}
>> +
>> +	if (plat_ops && plat_ops->cpufreq_plat_cpu_ctrl)
>> +		plat_ops->cpufreq_plat_cpu_ctrl(policy,
>> +				last_load, normalised_power,
>> +				cpu_freq_to_power(cpufreq_cdev, target_freq));
>> +
>>  	trace_thermal_power_cpu_limit(policy->related_cpus, target_freq,
>> *state,
>>  				      power);
>>  	return 0;
>> @@ -684,3 +698,41 @@ void cpufreq_cooling_unregister(struct
>> thermal_cooling_device *cdev)
>>  	kfree(cpufreq_cdev);
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
>
> Instead of adding such callbacks to constraint the min freq of CPUs,
> you can directly use frequency constraints used by QoS framework to
> put such limit directly on cpufreq. Look at freq_qos_add_request().
>
> --
> viresh
>
