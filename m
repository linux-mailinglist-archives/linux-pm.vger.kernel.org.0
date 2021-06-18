Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4913AD53F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhFRWfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 18:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhFRWfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 18:35:02 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA4C061760;
        Fri, 18 Jun 2021 15:32:52 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 83FAC3F367;
        Sat, 19 Jun 2021 00:32:50 +0200 (CEST)
Subject: Re: [RESEND PATCH v4 1/3] cpuidle: qcom_spm: Detach state machine
 from main SPM handling
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20210618180907.258149-1-angelogioacchino.delregno@somainline.org>
 <20210618180907.258149-2-angelogioacchino.delregno@somainline.org>
 <YM0SCaAdYMxZQya1@gerhold.net>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <ebeb5f35-b284-222f-86df-9ca6633d73ba@somainline.org>
Date:   Sat, 19 Jun 2021 00:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YM0SCaAdYMxZQya1@gerhold.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 18/06/21 23:37, Stephan Gerhold ha scritto:
> Hi,
> 
> Thanks for the patch!
> 
> On Fri, Jun 18, 2021 at 08:09:05PM +0200, AngeloGioacchino Del Regno wrote:
>> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
>> CPUidle driver") the SPM driver has been converted to a
>> generic CPUidle driver: that was mainly made to simplify the
>> driver and that was a great accomplishment;
>>
> 
> Hmm, you mention my commit but did not Cc me.
> Only saw this patch while randomly looking through linux-arm-msm. :)
> 

Sorry, I've originally sent this series 6 months ago, things may fly
off of my head... :))

>> Though, it was ignored that the SPM driver is not used only
>> on the ARM architecture.
> 
> This sentence is a bit misleading IMO. In mainline the SPM driver is
> *currently* only used for CPUidle, and the old driver was as
> CPUidle-specific as the new one. So saying that I "ignored" something
> here is kind of wrong. :)
> 
> Can you re-phrase this a bit to say that the SPM hardware is also
> used for power-collapse of the CPU caches/AVS/whatever and therefore we
> need to refactor the driver to something more independent?
> 

On SAWv4.1, the SPM is used to regulate AVS limits but *not* power
collapse of the CPU caches "and whatever": platforms with this version
are using different HW to accomplish that.

>> In preparation for the enablement of SPM features on AArch64/ARM64,
>> split the cpuidle-qcom-spm driver in two: the CPUIdle related
>> state machine (currently used only on ARM SoCs) stays there, while
>> the SPM communication handling lands back in soc/qcom/spm.c and
>> also making sure to not discard the simplifications that were
>> introduced in the aforementioned commit.
>>
>> Since now the "two drivers" are split, the SCM dependency in the
>> main SPM handling is gone and for this reason it was also possible
>> to move the SPM initialization early: this will also make sure that
>> whenever the SAW CPUIdle driver is getting initialized, the SPM
>> driver will be ready to do the job.
>>
>> Please note that the anticipation of the SPM initialization was
>> also done to optimize the boot times on platforms that have their
>> CPU/L2 idle states managed by other means (such as PSCI), while
>> needing SAW initialization for other purposes, like AVS control.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> The diff is quite hard to read for me (just the nature of this change,
> not your fault). Just mentioning this in case I miss something obvious.
> 
>> ---
>>   drivers/cpuidle/Kconfig.arm        |   1 +
>>   drivers/cpuidle/cpuidle-qcom-spm.c | 294 ++++++-----------------------
>>   drivers/soc/qcom/Kconfig           |   9 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/spm.c             | 198 +++++++++++++++++++
>>   include/soc/qcom/spm.h             |  45 +++++
>>   6 files changed, 312 insertions(+), 236 deletions(-)
>>   create mode 100644 drivers/soc/qcom/spm.c
>>   create mode 100644 include/soc/qcom/spm.h
>>
>> [...]
>> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
>> index adf91a6e4d7d..3dd7bb10b82d 100644
>> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
>> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
>> [...]
>> -static int spm_dev_probe(struct platform_device *pdev)
>> +static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>>   {
>>   	[...]
>> +	for_each_possible_cpu(cpu) {
>> +		ret = spm_cpuidle_register(cpu);
>> +		if (ret != -ENODEV) {
>> +			dev_err(&pdev->dev,
>> +				"Cannot register for CPU%d: %d\n", cpu, ret);
>> +			break;
> 
> Huh, why does this error for ret = 0? :S
> 
> [    0.736332] qcom-spm-cpuidle qcom-spm-cpuidle: Cannot register for CPU0: 0
> 
> A couple more lines in the UART log, then the device hangs forever.
> For testing I changed this to: if (ret && ret != -ENODEV).
> 

I have no idea what happened here; this was indeed supposed to be what
you just pointed out.

>> [...]
>> @@ -213,132 +80,87 @@ static const struct of_device_id qcom_idle_state_match[] = {
>> -static int spm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
>> +static int spm_cpuidle_register(int cpu)
>>   {
>> +	struct platform_device *pdev = NULL;
>> +	struct spm_driver_data *spm = NULL;
>> +	struct device_node *cpu_node, *saw_node;
>>   	int ret;
>>   
>> -	memcpy(drv, &qcom_spm_idle_driver, sizeof(*drv));
>> -	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> 
> Somehow this line got lost, which means the first cpuidle_driver will
> cover all CPUs and we will always fail to register the cpuidle_driver
> for all other CPUs:
> 
> [    0.736591] failed to register cpuidle driver
> [    0.744186] qcom-spm-cpuidle qcom-spm-cpuidle: Cannot register for CPU1: -16
> [    0.748443] qcom-spm-cpuidle: probe of qcom-spm-cpuidle failed with error -16
> 
> (Then the device hangs forever.)
> 

So you have discovered a bug for which your platform dies when SPM
does not probe, probably due to something else being dependant on this.
In this case, I would encourage you to produce a fix for your platform
to not unexpectedly just hang forever if *some driver* doesn't probe:
that's definitely not right.

> I added
> spm->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
> below
> 
>> +	spm->cpuidle_driver = qcom_spm_idle_driver;
> 
> and this seems to make it boot again at least.
> 

I really think that I've originally messed up the patch originally:
this doesn't seem to be the right version, even though it was marked as
v4. I trusted my folders organization too much. Apologies.

> However, it seems a bit pointless now to have a separate cpuidle_driver
> per CPU, since they are all registered at the same time. With my
> refactoring this was kind of convenient because the SPM platform devices
> could happily probe independently and just register a cpuidle_driver for
> the CPU they belong to.
> 
> With your patch, the cpuidle_drivers are registered at the same time for
> all CPUs, so we might as well use a single cpuidle_driver that covers
> all CPUs (like you already do without setting cpumask).
> 
> Note that if you have a single cpuidle_driver for all CPUs you need to
> refactor spm_enter_idle_state() a bit. The container_of() will no longer
> work to get the CPU-specific SPM. Before my changes there was a
> DEFINE_PER_CPU for this. I guess we need to bring that back.
> 
>>   	[...]
>> +	ret = dt_init_idle_driver(&spm->cpuidle_driver,
>> +				  qcom_idle_state_match, 1);
>> +	if (ret <= 0)
>> +		return ret ? : -ENODEV;
>>   
>> -	return drv;
>> -}
>> +	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
>> +	if (ret)
>> +		return ret;
> 
> And the advantage here is that we should be able to do this with a
> single firmware call (set the warm boot addr for all CPUs at once).
> 


Probably staying with setting the cpumask is a better option; we don't

really know if there's any platform requiring that kind of quirk: at
least downstream, I recall that they made sure to send multiple calls.


>> [...]
>> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
>> new file mode 100644
>> index 000000000000..604eca2c4d4a
>> --- /dev/null
>> +++ b/include/soc/qcom/spm.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2014,2015, Linaro Ltd.
>> + * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
>> + */
>> +
>> +#ifndef __SPM_H__
>> +#define __SPM_H__
>> +
>> +#include <linux/cpuidle.h>
>> +
>> +#define MAX_PMIC_DATA		2
>> +#define MAX_SEQ_DATA		64
>> +
>> +enum pm_sleep_mode {
>> +	PM_SLEEP_MODE_STBY,
>> +	PM_SLEEP_MODE_RET,
>> +	PM_SLEEP_MODE_SPC,
>> +	PM_SLEEP_MODE_PC,
>> +	PM_SLEEP_MODE_NR,
>> +};
>> +
>> +struct spm_reg_data {
>> +	const u16 *reg_offset;
>> +	u32 spm_cfg;
>> +	u32 spm_dly;
>> +	u32 pmic_dly;
>> +	u32 pmic_data[MAX_PMIC_DATA];
>> +	u32 avs_ctl;
>> +	u32 avs_limit;
> 
> Looks like you accidentally included changes from PATCH 2/3
> ("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
> here, reg_offset u8 -> u16 and adding avs_ctl and avs_limit should be in
> a separate patch. It's really hard to see that you added those here
> while moving the code. :/
> 

This change belongs to 2/3.
Will send a v5 with fixes.

> Thanks,
> Stephan
> 

