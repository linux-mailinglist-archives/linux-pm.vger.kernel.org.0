Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240693D9842
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 00:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhG1WTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhG1WTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 18:19:10 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B9C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 15:19:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 129so3881720qkg.4
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Srjf0aL7kHAVVp8xOjNVibfUf0NYqsilKH/clpF6XdM=;
        b=UsieRyKWGPZS8uLn0zEzD+tYsGMx8iEd2JshbEJ87il9BCsUc5DGd5DDnzaJaJviAF
         hG6b6fha0xukyKUjebYyRg0RrxT9FsdMzUMZ9jSObEtjydk98dW1tmfkegE6nX7XN4ry
         Tyv+nRIS+dO8htCj8kgMgdYm0tPiOxAUYo3Dmb9mK7Zp+roGAoZ6rT5MxxklKcrMcoqG
         E1KUkTurjqjl1U8Yi31iYwNM31HsnJ9UU/Zi/l9TBxNsp6w+GoyhGcXa0qk5uC/hKALu
         MY8jcdHO5aIbEAiWNOGVUxUE973rDiVItbVoT64OVo2sgpl9ErORVX5OYIlRVahnA7qQ
         TPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Srjf0aL7kHAVVp8xOjNVibfUf0NYqsilKH/clpF6XdM=;
        b=DM8mM3bHp99akyOEM2n9icmQn41WVHhgE0pTsbPosOrIboubSBsdvSuH6ObejDWcN6
         CdmAoP51XKJQ0S69rOWr6YSy5WHTd+b179cixBC5fA5Oew7Zwk3hpD/ys1+wSYLm/P9K
         zvlLiUTEAmTN6dm3PS2a3ITlcReYYCYU18N0aKfogEirApDOW0qm1v6B9Hnlva741ato
         uNyzpxj/EaaZJ7UL5ymFDGx95DGg91AaCc1xWVukm4G3638agk9CfyuTNBlO+Cx542vL
         bsLRD5kw3dssogQDPsI+0AHilQse5rEboixID+kGYQr7D7WUD4Jk3GG3bBH80Ae7Tclv
         DpvQ==
X-Gm-Message-State: AOAM5326kZt2AAo4YV58LwzVJmsvDz4VWwC1Etw3TlYtX60IHUDx3MPd
        G/GQiP92uMa2KIR8/3D2EKbF4w==
X-Google-Smtp-Source: ABdhPJygj1RUvPO57MdF67FNVU9lphmm1Rf9eF4v8v5eAw1/v+05x5ILFVQykGw6CtLEzds/4nan8w==
X-Received: by 2002:a37:a004:: with SMTP id j4mr1950099qke.499.1627510746886;
        Wed, 28 Jul 2021 15:19:06 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id n188sm745065qke.54.2021.07.28.15.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 15:19:06 -0700 (PDT)
Subject: Re: [Patch v4 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
 <20210727152512.1098329-4-thara.gopinath@linaro.org>
 <20210728035014.25mgvrpnraxfslq7@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <9a257605-d282-cd06-cc44-5ad5a5f8484d@linaro.org>
Date:   Wed, 28 Jul 2021 18:19:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728035014.25mgvrpnraxfslq7@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/27/21 11:50 PM, Viresh Kumar wrote:
> On 27-07-21, 11:25, Thara Gopinath wrote:
>> +static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>> +{
> 
>> +	/* In the unlikely case cpufreq is de-registered do not enable polling or h/w interrupt */
>> +
>> +	spin_lock(&data->throttle_lock);
>> +	if (data->cancel_throttle) {
>> +		spin_unlock(&data->throttle_lock);
>> +		return;
>> +	}
>> +	spin_unlock(&data->throttle_lock);
>> +
>> +	/*
>> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
>> +	 * polling and switch back to interrupt mechanism
>> +	 */
>> +
>> +	if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
>> +		/* Clear the existing interrupts and enable it back */
>> +		enable_irq(data->throttle_irq);
>> +	else
>> +		mod_delayed_work(system_highpri_wq, &data->throttle_work,
>> +				 msecs_to_jiffies(10));
>> +}
> 
>> +static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
>> +{
>> +	if (data->throttle_irq <= 0)
>> +		return;
>> +
>> +	spin_lock(&data->throttle_lock);
>> +	data->cancel_throttle = true;
>> +	spin_unlock(&data->throttle_lock);
>> +	cancel_delayed_work_sync(&data->throttle_work);
>> +	free_irq(data->throttle_irq, data);
>> +}
> 
> Lets see if we can still make it break :)
> 
> CPU0                                            CPU1
> 
> qcom_lmh_dcvs_notify()                          qcom_cpufreq_hw_lmh_exit()
> 
> spin_unlock()
>                                                  spin_lock(),
>                                                  cancel_throttle = true
>                                                  spin_unlock()
> 
>                                                  cancel_delayed_work_sync()
> mod_delayed_work()
>                                                  free_irq()
>                                                  kfree(data)
> qcom_lmh_dcvs_poll()
> Uses data.
> 
> 
> Sorry, locking is fun :)

Ha! I was too lazy to write this down! So how about I make this a mutex 
and put mod_delayed_work() inside the lock. So it will be something like 
below

qcom_lmh_dcvs_notify()			qcom_cpufreq_hw_lmh_exit()

mutex_lock()				mutex_lock()
   if (data->cancel_throttle) {		cancel_throttle = true
	mutex_unlock()			mutex_unlock()
	return				cancel_delayed_work_sync()
   }					free_irq()
   enable_irq() / mod_delayed_work()
mutex_unlock()

I will let you break it!

> 

-- 
Warm Regards
Thara (She/Her/Hers)
