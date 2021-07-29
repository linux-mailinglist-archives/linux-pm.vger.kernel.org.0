Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1593D9D85
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 08:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhG2GRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 02:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhG2GRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 02:17:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DDC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 23:17:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k1so5694445plt.12
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Na0oMqbeSSwR2uZk9VSSlYB8c9rLTTyh7/SgfQdnKJQ=;
        b=EWCHDf+R+bffFsYfepKPFX8HRT2BUsfyeOX/npypd0dYNYRHM8CtfedSTIdGaT/KHc
         EMVRuqiqvrDLk748kZ1qJdb9+t1gMIOYnqlarDZHzvEz6VSmT7VQFXoxXcZZFjmt8vOt
         zer9ql5xxlrKGM+r5H55qCH7VsuYta+KF5WqAyl31PFHFzPBKM66LDBkXkgl/tkLcPnl
         i2jcu6mtqjHY02xEbnRztcj9L2vo4gvmIBp3QII212YJrumoJu8Dq28zJyeRroyQ8AMi
         BOWbd9wr0WgpadRwVR2OKAqRYLCeJpsfJIOWG0k49oS1ZtkougRAgPcGN1t9+C2O2npb
         c2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Na0oMqbeSSwR2uZk9VSSlYB8c9rLTTyh7/SgfQdnKJQ=;
        b=C11Q5oycnpDDUKvU96X0BTOKmM4RZYFPq13MnYyUsypn5W3QkezPlGniTn1RFWxlvl
         fiDQmI+pOAA837yDcl4MVY8DBBBBZt6BR47PNm8/iwpPG/rNquKK3ZK81IxVPJzEcum9
         MzOHT9lm35lgqLi/wfScuw23vhPVuc91eusTTXlE3EvdHhl5UnmPfE1LRpc96/UudzjA
         bIctVEOc88UsHZfT82w7tswwK4pCNZIpSY0BXjLYuilj+3caK2wl75KgSCxi6Ke83ya5
         enn4SyS9WDXZv3NnQicIzdKOPj8fhmAA5hfOYaAZ3SLnzlau6agwp/P9nlUlx9/cNptA
         s9uQ==
X-Gm-Message-State: AOAM530S446dEfZjCwGyVLfZbW+Z9TD26N9CcHMZzzZZ5l2l58Cvzlnw
        ZnqaO0uq1v4NC4sV7K6hPB0jGQ==
X-Google-Smtp-Source: ABdhPJxhx8hhazm+8eAUS1yOwSVtPtHtAWPcgAv+iDPm82IezE+pVLL+bV10jbyoN4P9o9w1PReZaA==
X-Received: by 2002:a17:90b:2112:: with SMTP id kz18mr13388679pjb.137.1627539437273;
        Wed, 28 Jul 2021 23:17:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id k25sm2003510pfa.213.2021.07.28.23.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 23:17:15 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:47:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [Patch v4 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210729061713.kzhka7nymo53zw2o@vireshk-i7>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
 <20210727152512.1098329-4-thara.gopinath@linaro.org>
 <20210728035014.25mgvrpnraxfslq7@vireshk-i7>
 <9a257605-d282-cd06-cc44-5ad5a5f8484d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a257605-d282-cd06-cc44-5ad5a5f8484d@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-07-21, 18:19, Thara Gopinath wrote:
> Ha! I was too lazy to write this down! So how about I make this a mutex and

mutex may not work as you come here from irq.

> put mod_delayed_work() inside the lock. So it will be something like below
> 
> qcom_lmh_dcvs_notify()			qcom_cpufreq_hw_lmh_exit()
> 
> mutex_lock()				mutex_lock()
>   if (data->cancel_throttle) {		cancel_throttle = true
> 	mutex_unlock()			mutex_unlock()
> 	return				cancel_delayed_work_sync()
>   }					free_irq()
>   enable_irq() / mod_delayed_work()
> mutex_unlock()
> 
> I will let you break it!

I can't any further :)

Consider merging below to this patch, it fixes sever other minor
issues I see in the code.

-- 
viresh

-------------------------8<-------------------------

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 3cc27d9e2ed1..4261299fa9e5 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -38,13 +38,17 @@ struct qcom_cpufreq_soc_data {
 struct qcom_cpufreq_data {
        void __iomem *base;
        struct resource *res;
-       struct delayed_work throttle_work;
        const struct qcom_cpufreq_soc_data *soc_data;
-       struct cpufreq_policy *policy;
-       /* Lock to synchronize between de-init sequence and re-starting LMh polling/interrupts */
+
+       /*
+        * Lock to synchronize between de-init sequence and re-starting LMh
+        * polling/interrupts.
+        */
        spinlock_t throttle_lock;
        int throttle_irq;
        bool cancel_throttle;
+       struct delayed_work throttle_work;
+       struct cpufreq_policy *policy;
 };

 static unsigned long cpu_hw_rate, xo_rate;
@@ -271,10 +275,11 @@ static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)

 static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 {
+       unsigned long max_capacity, capacity, freq_hz, throttled_freq;
        struct cpufreq_policy *policy = data->policy;
+       int cpu = cpumask_first(policy->cpus);
+       struct device *dev = get_cpu_device(cpu);
        struct dev_pm_opp *opp;
-       struct device *dev;
-       unsigned long max_capacity, capacity, freq_hz, throttled_freq;
        unsigned int freq;

        /*
@@ -284,7 +289,6 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
        freq = qcom_lmh_get_throttle_freq(data);
        freq_hz = freq * HZ_PER_KHZ;

-       dev = get_cpu_device(cpumask_first(policy->cpus));
        opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
        if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
                opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
@@ -293,34 +297,37 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)

        /* Update thermal pressure */

-       max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
+       max_capacity = arch_scale_cpu_capacity(cpu);
        capacity = mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq);
+
        /* Don't pass boost capacity to scheduler */
        if (capacity > max_capacity)
                capacity = max_capacity;

        arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);

-       /* In the unlikely case cpufreq is de-registered do not enable polling or h/w interrupt */
-
+       /*
+        * In the unlikely case, where the policy is going away, do not enable
+        * polling or h/w interrupt.
+        */
        spin_lock(&data->throttle_lock);
-       if (data->cancel_throttle) {
-               spin_unlock(&data->throttle_lock);
-               return;
-       }
-       spin_unlock(&data->throttle_lock);
+
+       if (data->cancel_throttle)
+               goto out;

        /*
-        * If h/w throttled frequency is higher than what cpufreq has requested for, stop
-        * polling and switch back to interrupt mechanism
+        * If h/w throttled frequency is higher than what cpufreq has requested
+        * for, then stop polling and switch back to interrupt mechanism.
         */

-       if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
-               /* Clear the existing interrupts and enable it back */
+       if (throttled_freq >= qcom_cpufreq_hw_get(cpu)) {
                enable_irq(data->throttle_irq);
-       else
+       } else {
                mod_delayed_work(system_highpri_wq, &data->throttle_work,
                                 msecs_to_jiffies(10));
+       }
+out:
+       spin_unlock(&data->throttle_lock);
 }

 static void qcom_lmh_dcvs_poll(struct work_struct *work)
@@ -328,7 +335,6 @@ static void qcom_lmh_dcvs_poll(struct work_struct *work)
        struct qcom_cpufreq_data *data;

        data = container_of(work, struct qcom_cpufreq_data, throttle_work.work);
-
        qcom_lmh_dcvs_notify(data);
 }

@@ -407,6 +413,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
        spin_lock(&data->throttle_lock);
        data->cancel_throttle = true;
        spin_unlock(&data->throttle_lock);
+
        cancel_delayed_work_sync(&data->throttle_work);
        free_irq(data->throttle_irq, data);
 }

