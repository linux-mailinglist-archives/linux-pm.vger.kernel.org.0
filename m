Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD947E627
	for <lists+linux-pm@lfdr.de>; Thu, 23 Dec 2021 17:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhLWQIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Dec 2021 11:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLWQIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Dec 2021 11:08:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6AFC061401
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 08:08:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so12507301wrb.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oJXYVflRE3V64ZwTkze2Be2oIi2LQyb10c2T5nTmSn4=;
        b=HKl8naAkHKH3A0izGYbkezfjVnJRGOl/6P3kKwDT32f2LotS4FLbcQynVMNuv2CvmX
         HhT5cKiR7hh0ifERsc+ZOS2bbvJgxFDnZRLQKpArUeKe2YSlWEJGt3OfAhJ7mplmPE5t
         tQoSvov3TUig68rS6q9U76EWgK5seb3mJgTzuLu79FjsxF4VCmmvQcXQ25kbp6AVOJxy
         QZYdGfXKFAwJ7/7DqgyG3vV+Zz058/LSvgcKRZb1O95xzYcQ29aDrmtl+HP2/s2KQORb
         4lQHX1Go5+wZ9HEpTRqty/sC4LOYKBgaexG9Du2SQeGzV5NJVENa9J7XFHxmQoti/lab
         ybug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJXYVflRE3V64ZwTkze2Be2oIi2LQyb10c2T5nTmSn4=;
        b=IRqtbCiS6qcdSsJqXjGxT3R/HSxjZYuLzRmQpaDlHTdnrpeNkHRxS3wx0/LhfE5Waq
         PLYBgzFIA807Mn5yXNHEbLK4F4zR8RjCJlgP1Wf4d4zrLk8cMlgDqM3rSoYU+rKfU6zX
         oXTbfWni3wHPRotSaEudvL4c73fiFSwiZMWAAu+thXeGaAoW9HDxXq3Avy+b+/L9A/uL
         Z6Z5bVUBuMXtJmPw3NFKcdjv1Q4qsdc6hhp2T7S4l482qsjHhcj5eVNe44Y8MCNthP4a
         CXd8HKKeml9mXMNms8Moxm0UL7Is57Y4pU0GYRRPA6cTTOEiNEDdj4/RQQxsKtUxXW85
         JNXA==
X-Gm-Message-State: AOAM532iOyKzEbnfvYw+GbypYY3H0xvBUF6dsd0l+9RjKzD13i/yoVM4
        SwfO4K1R/WT2e4S9j4gQTCMQ4g==
X-Google-Smtp-Source: ABdhPJza6AAwk7pJ9pEL9RVmQUeHc0F5cBOz2j+9khEhOuKlGzMFiW+G5NG1ix3Od4uDJxxT5k3bfw==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr2071735wrt.596.1640275724296;
        Thu, 23 Dec 2021 08:08:44 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id i8sm5302981wmq.4.2021.12.23.08.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 08:08:43 -0800 (PST)
Subject: Re: [PATCH v3 3/4] firmware: qcom: scm: Drop cpumask parameter from
 set_boot_addr()
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>
References: <20211201130505.257379-1-stephan@gerhold.net>
 <20211201130505.257379-4-stephan@gerhold.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4da4b3ec-68a8-5a74-d38d-b483c97caa95@linaro.org>
Date:   Thu, 23 Dec 2021 17:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201130505.257379-4-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/12/2021 14:05, Stephan Gerhold wrote:
> qcom_scm_set_cold/warm_boot_addr() currently take a cpumask parameter,
> but it's not very useful because at the end we always set the same entry
> address for all CPUs. This also allows speeding up probe of
> cpuidle-qcom-spm a bit because only one SCM call needs to be made to
> the TrustZone firmware, instead of one per CPU.
> 
> The main reason for this change is that it allows implementing the
> "multi-cluster" variant of the set_boot_addr() call more easily
> without having to rely on functions that break in certain build
> configurations or that are not exported to modules.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm/mach-qcom/platsmp.c       |  3 +--
>  drivers/cpuidle/cpuidle-qcom-spm.c |  8 ++++----
>  drivers/firmware/qcom_scm.c        | 19 ++++++++-----------
>  include/linux/qcom_scm.h           |  4 ++--
>  4 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
> index 58a4228455ce..65a0d5ce2bb3 100644
> --- a/arch/arm/mach-qcom/platsmp.c
> +++ b/arch/arm/mach-qcom/platsmp.c
> @@ -357,8 +357,7 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	int cpu;
>  
> -	if (qcom_scm_set_cold_boot_addr(secondary_startup_arm,
> -					cpu_present_mask)) {
> +	if (qcom_scm_set_cold_boot_addr(secondary_startup_arm)) {
>  		for_each_present_cpu(cpu) {
>  			if (cpu == smp_processor_id())
>  				continue;
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index 5f27dcc6c110..beedf22cbe78 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -122,10 +122,6 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
>  	if (ret <= 0)
>  		return ret ? : -ENODEV;
>  
> -	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
> -	if (ret)
> -		return ret;
> -
>  	return cpuidle_register(&data->cpuidle_driver, NULL);
>  }
>  
> @@ -136,6 +132,10 @@ static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>  	if (!qcom_scm_is_available())
>  		return -EPROBE_DEFER;
>  
> +	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "set warm boot addr failed");
> +
>  	for_each_possible_cpu(cpu) {
>  		ret = spm_cpuidle_register(&pdev->dev, cpu);
>  		if (ret && ret != -ENODEV) {
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index e0fca80bf6fc..e89be2f0cdec 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -246,8 +246,7 @@ static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
>  	return ret ? false : !!res.result[0];
>  }
>  
> -static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
> -				  const u8 *cpu_bits)
> +static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
>  {
>  	int cpu;
>  	unsigned int flags = 0;
> @@ -258,7 +257,7 @@ static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	for_each_cpu(cpu, cpus) {
> +	for_each_present_cpu(cpu) {
>  		if (cpu >= QCOM_SCM_BOOT_MAX_CPUS)
>  			return -EINVAL;
>  		flags |= cpu_bits[cpu];
> @@ -271,27 +270,25 @@ static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus,
>  }
>  
>  /**
> - * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
> + * qcom_scm_set_warm_boot_addr() - Set the warm boot address for all cpus
>   * @entry: Entry point function for the cpus
> - * @cpus: The cpumask of cpus that will use the entry point
>   *
>   * Set the Linux entry point for the SCM to transfer control to when coming
>   * out of a power down. CPU power down may be executed on cpuidle or hotplug.
>   */
> -int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
> +int qcom_scm_set_warm_boot_addr(void *entry)
>  {
> -	return qcom_scm_set_boot_addr(entry, cpus, qcom_scm_cpu_warm_bits);
> +	return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_warm_bits);
>  }
>  EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
>  
>  /**
> - * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
> + * qcom_scm_set_cold_boot_addr() - Set the cold boot address for all cpus
>   * @entry: Entry point function for the cpus
> - * @cpus: The cpumask of cpus that will use the entry point
>   */
> -int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
> +int qcom_scm_set_cold_boot_addr(void *entry)
>  {
> -	return qcom_scm_set_boot_addr(entry, cpus, qcom_scm_cpu_cold_bits);
> +	return qcom_scm_set_boot_addr(entry, qcom_scm_cpu_cold_bits);
>  }
>  EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
>  
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 81cad9e1e412..048d09e1965b 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -63,8 +63,8 @@ enum qcom_scm_ice_cipher {
>  
>  extern bool qcom_scm_is_available(void);
>  
> -extern int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
> -extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
> +extern int qcom_scm_set_cold_boot_addr(void *entry);
> +extern int qcom_scm_set_warm_boot_addr(void *entry);
>  extern void qcom_scm_cpu_power_down(u32 flags);
>  extern int qcom_scm_set_remote_state(u32 state, u32 id);
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
