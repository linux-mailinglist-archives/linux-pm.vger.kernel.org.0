Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029EA65E6E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGKRZb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 13:25:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34197 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRZa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 13:25:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so4621864lfq.1;
        Thu, 11 Jul 2019 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2YMfHUBjXHpo+j06pyniNllvZMRnbJcOo4hnaLC71sE=;
        b=ApmKnjpVGrYMZYw9nmXLaN19GMQAPjPv7W7548PsMxVOiIztXhPoNpajU9makN5x2H
         OU0g1aGH+1kMbq6R3KOSnFMvkR8XhQ2jFY2cP+EMCN/4OFxDNNoOwETRn6/Xy+NtZtX4
         YKd4yvHwa1C/idpQfxRbeKHt3PemDXwQi4pah8oRvYDoaKqVfPRMzg0UDVwEfg5k4mUN
         mDTv06DQjk2qoQ+t7NqHgN5e1oupNpskmuphiTmuBMeSlkwl8o6yFHkJAk5PuqFp0gHM
         aTgj3TNmg6D7mj6G4ID7Ezg4KvEfhTp/OlYXv/nFMYo3JEp4+AtKyQmtxC3zmv1PZApN
         IqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2YMfHUBjXHpo+j06pyniNllvZMRnbJcOo4hnaLC71sE=;
        b=luE1FzP7fw951kVwYtvGw391QaIPfWDy6yMp5SznCzF8GaGtUDHD5M+BH0Uhbi9WAI
         IZzo8KYEX/0lJKUOKnJrKsI8HC4LAI99wqCSorLGNn6kv1xsU2z0exhQndJ8gr6eMPCs
         DDmd/mLT3z6I1I0CxArymII0UblBRnOoYg2spXFni8QbQC6aZu+Ah/w6GwZ+SRSVf/NK
         A7cfS6AgT+KNlb3/GadnhseUiQZmPC8S2gZoSQjl58LRjHLy5QASMvJ/ANCCUJw9k/Z2
         DIFf+3oZR58oFCMDmnIEiqV+UfDHeAlOIvbYYjSet6Exbkujf/Wu5PmDfCkUY0G/fnz9
         l0iQ==
X-Gm-Message-State: APjAAAUBI6g4wTozkiQscO5gs9rqK41juFEEnxWH1MG/+xWPdxkS3jfS
        b9WQYCD0V5ng9+qJw+kFgLLBBPmo
X-Google-Smtp-Source: APXvYqzfDDUhalkCcqE0q9tb+NTPSe5zxtMtKXFg82as9QK71ou16O9M+55H/j8aZ6Ikhc++VBbZ9A==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr2490854lfm.120.1562865927145;
        Thu, 11 Jul 2019 10:25:27 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id b1sm1084553ljj.26.2019.07.11.10.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:25:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] ARM: tegra: Expose functions required for cpuidle
 driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190711031312.10038-1-digetx@gmail.com>
 <20190711031312.10038-3-digetx@gmail.com>
 <bc6e96be-91ee-5d94-cbc2-46d2e2f25bce@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <514c1cd6-2180-b55f-dacc-f0e08d9a366f@gmail.com>
Date:   Thu, 11 Jul 2019 20:25:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bc6e96be-91ee-5d94-cbc2-46d2e2f25bce@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.07.2019 15:42, Jon Hunter пишет:
> 
> On 11/07/2019 04:13, Dmitry Osipenko wrote:
>> The upcoming unified CPUIDLE driver will be added to the drivers/cpuidle/
>> directory and it will require all these Tegra PM-core functions.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/Makefile  |  2 +-
>>  arch/arm/mach-tegra/platsmp.c |  2 --
>>  arch/arm/mach-tegra/pm.c      | 16 +++++++---------
>>  arch/arm/mach-tegra/pm.h      |  3 ---
>>  arch/arm/mach-tegra/sleep.h   |  1 -
>>  include/linux/clk/tegra.h     | 13 +++++++++++++
>>  include/soc/tegra/pm.h        | 28 ++++++++++++++++++++++++++++
>>  7 files changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
>> index 5d93a0b36866..27bd5d9865e3 100644
>> --- a/arch/arm/mach-tegra/Makefile
>> +++ b/arch/arm/mach-tegra/Makefile
>> @@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
>>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
>>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
>>  obj-$(CONFIG_SMP)			+= platsmp.o
>> -obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
>> +obj-y					+= hotplug.o
>>  
>>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
>>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
>> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
>> index e6911a14c096..c8a63719a143 100644
>> --- a/arch/arm/mach-tegra/platsmp.c
>> +++ b/arch/arm/mach-tegra/platsmp.c
>> @@ -183,8 +183,6 @@ const struct smp_operations tegra_smp_ops __initconst = {
>>  	.smp_prepare_cpus	= tegra_smp_prepare_cpus,
>>  	.smp_secondary_init	= tegra_secondary_init,
>>  	.smp_boot_secondary	= tegra_boot_secondary,
>> -#ifdef CONFIG_HOTPLUG_CPU
>>  	.cpu_kill		= tegra_cpu_kill,
>>  	.cpu_die		= tegra_cpu_die,
>> -#endif
>>  };
>> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
>> index 6aaacb5757e1..f9c9bce9e15d 100644
>> --- a/arch/arm/mach-tegra/pm.c
>> +++ b/arch/arm/mach-tegra/pm.c
>> @@ -123,11 +123,9 @@ void tegra_clear_cpu_in_lp2(void)
>>  	spin_unlock(&tegra_lp2_lock);
>>  }
>>  
>> -bool tegra_set_cpu_in_lp2(void)
>> +void tegra_set_cpu_in_lp2(void)
>>  {
>>  	int phy_cpu_id = cpu_logical_map(smp_processor_id());
>> -	bool last_cpu = false;
>> -	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
>>  	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
>>  
>>  	spin_lock(&tegra_lp2_lock);
>> @@ -135,11 +133,7 @@ bool tegra_set_cpu_in_lp2(void)
>>  	BUG_ON((*cpu_in_lp2 & BIT(phy_cpu_id)));
>>  	*cpu_in_lp2 |= BIT(phy_cpu_id);
>>  
>> -	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
>> -		last_cpu = true;
>> -
>>  	spin_unlock(&tegra_lp2_lock);
>> -	return last_cpu;
>>  }
> 
> I think that the commit message should describe what is going on here or
> this should be a separate change.

Indeed, it could be not very obvious what's going on here without a
thorough review. I'll factor out all these minor changes into separate
commits.

In particular there is no need to know whether CPU is the "last_cpu" for
the new driver because CPU0 is always the "last" since it awaits for the
secondaries in the coupled state.

>>  static int tegra_sleep_cpu(unsigned long v2p)
>> @@ -195,14 +189,16 @@ static void tegra_pm_set(enum tegra_suspend_mode mode)
>>  	tegra_pmc_enter_suspend_mode(mode);
>>  }
>>  
>> -void tegra_idle_lp2_last(void)
>> +int tegra_idle_lp2_last(void)
>>  {
>> +	int err;
>> +
>>  	tegra_pm_set(TEGRA_SUSPEND_LP2);
>>  
>>  	cpu_cluster_pm_enter();
>>  	suspend_cpu_complex();
>>  
>> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>> +	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>>  
>>  	/*
>>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
>> @@ -214,6 +210,8 @@ void tegra_idle_lp2_last(void)
>>  
>>  	restore_cpu_complex();
>>  	cpu_cluster_pm_exit();
>> +
>> +	return err;
>>  }
>>  
>>  enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
>> diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
>> index 1e51a9b636eb..81525f5f4a44 100644
>> --- a/arch/arm/mach-tegra/pm.h
>> +++ b/arch/arm/mach-tegra/pm.h
>> @@ -23,9 +23,6 @@ void tegra20_sleep_core_init(void);
>>  void tegra30_lp1_iram_hook(void);
>>  void tegra30_sleep_core_init(void);
>>  
>> -void tegra_clear_cpu_in_lp2(void);
>> -bool tegra_set_cpu_in_lp2(void);
>> -void tegra_idle_lp2_last(void);
>>  extern void (*tegra_tear_down_cpu)(void);
>>  
>>  #ifdef CONFIG_PM_SLEEP
>> diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
>> index d219872b7546..0d9956e9a8ea 100644
>> --- a/arch/arm/mach-tegra/sleep.h
>> +++ b/arch/arm/mach-tegra/sleep.h
>> @@ -124,7 +124,6 @@ void tegra30_hotplug_shutdown(void);
>>  #endif
>>  
>>  void tegra20_tear_down_cpu(void);
>> -int tegra30_sleep_cpu_secondary_finish(unsigned long);
>>  void tegra30_tear_down_cpu(void);
>>  
>>  #endif
>> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
>> index b8aef62cc3f5..cf0f2cb5e109 100644
>> --- a/include/linux/clk/tegra.h
>> +++ b/include/linux/clk/tegra.h
>> @@ -108,6 +108,19 @@ static inline void tegra_cpu_clock_resume(void)
>>  
>>  	tegra_cpu_car_ops->resume();
>>  }
>> +#else
>> +static inline bool tegra_cpu_rail_off_ready(void)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline void tegra_cpu_clock_suspend(void)
>> +{
>> +}
>> +
>> +static inline void tegra_cpu_clock_resume(void)
>> +{
>> +}
>>  #endif
>>  
>>  extern void tegra210_xusb_pll_hw_control_enable(void);
>> diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
>> index 951fcd738d55..fa18c2df5028 100644
>> --- a/include/soc/tegra/pm.h
>> +++ b/include/soc/tegra/pm.h
>> @@ -20,6 +20,12 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
>>  
>>  /* low-level resume entry point */
>>  void tegra_resume(void);
>> +
>> +int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
>> +void tegra_clear_cpu_in_lp2(void);
>> +void tegra_set_cpu_in_lp2(void);
>> +int tegra_idle_lp2_last(void);
>> +void tegra_cpu_die(unsigned int cpu);
>>  #else
>>  static inline enum tegra_suspend_mode
>>  tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
>> @@ -30,6 +36,28 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
>>  static inline void tegra_resume(void)
>>  {
>>  }
>> +
>> +static inline int tegra30_sleep_cpu_secondary_finish(unsigned long arg)
>> +{
>> +	return -1;
>> +}
> 
> -ENOTSUPP?

Good point, thanks!
