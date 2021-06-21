Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD53AED2D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 18:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUQOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 12:14:24 -0400
Received: from m-r1.th.seeweb.it ([5.144.164.170]:58645 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUQOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 12:14:23 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 110E81F4AF;
        Mon, 21 Jun 2021 18:12:07 +0200 (CEST)
Subject: Re: [PATCH v5 1/3] cpuidle: qcom_spm: Detach state machine from main
 SPM handling
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20210618225620.623359-1-angelogioacchino.delregno@somainline.org>
 <20210618225620.623359-2-angelogioacchino.delregno@somainline.org>
 <YNB92Dkx5MNg64m+@gerhold.net>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <08c80c7d-638f-23e9-e580-bced3648a635@somainline.org>
Date:   Mon, 21 Jun 2021 18:12:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNB92Dkx5MNg64m+@gerhold.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 21/06/21 13:54, Stephan Gerhold ha scritto:
> On Sat, Jun 19, 2021 at 12:56:18AM +0200, AngeloGioacchino Del Regno wrote:
>> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
>> CPUidle driver") the SPM driver has been converted to a
>> generic CPUidle driver: that was mainly made to simplify the
>> driver and that was a great accomplishment;
>> Though, it was ignored that the SPM driver is not used only
>> on the ARM architecture.
>>
> 
> Can you please reword this sentence like I suggested in v4? The way you
> write it at the moment it sounds like this fixes a regression, but
> actually it extends the driver to cover more use cases.
> 

I don't see any regression implied: I'm explaining the reason of this
change just one line after that and .. besides that, I haven't put any
"Fixes:" tag to this commit.
When you fix regressions, bad behavior, or anything else relative to a
patch, you add that tag to say that you're fixing something.

Moreover, I can't see anything wrong in the description for this change,
nor anything to clarify about it and that as long as you read it in full

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
>> ---
>>   drivers/cpuidle/Kconfig.arm        |   1 +
>>   drivers/cpuidle/cpuidle-qcom-spm.c | 295 ++++++-----------------------
>>   drivers/soc/qcom/Kconfig           |   9 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/spm.c             | 198 +++++++++++++++++++
>>   include/soc/qcom/spm.h             |  43 +++++
>>   6 files changed, 311 insertions(+), 236 deletions(-)
>>   create mode 100644 drivers/soc/qcom/spm.c
>>   create mode 100644 include/soc/qcom/spm.h
>>
>> [...]
>> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
>> [...]
>> @@ -213,132 +80,88 @@ static const struct of_device_id qcom_idle_state_match[] = {
>>   	{ },
>>   };
>>   
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
>> +	cpu_node = of_cpu_device_node_get(cpu);
>> +	if (!cpu_node)
>> +		return -ENODEV;
>>   
>> -	/* Parse idle states from device tree */
>> -	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 1);
>> -	if (ret <= 0)
>> -		return ret ? : -ENODEV;
>> +	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
>> +	if (!saw_node)
>> +		return -ENODEV;
>>   
>> -	/* We have atleast one power down mode */
>> -	return qcom_scm_set_warm_boot_addr(cpu_resume_arm, drv->cpumask);
>> -}
>> +	pdev = of_find_device_by_node(saw_node);
>> +	of_node_put(saw_node);
>> +	of_node_put(cpu_node);
>> +	if (!pdev)
>> +		return -ENODEV;
>>   
>> -static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
>> -		int *spm_cpu)
>> -{
>> -	struct spm_driver_data *drv = NULL;
>> -	struct device_node *cpu_node, *saw_node;
>> -	int cpu;
>> -	bool found = 0;
>> +	spm = dev_get_drvdata(&pdev->dev);
>> +	if (!spm)
>> +		return -EINVAL;
>>   
>> -	for_each_possible_cpu(cpu) {
>> -		cpu_node = of_cpu_device_node_get(cpu);
>> -		if (!cpu_node)
>> -			continue;
>> -		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
>> -		found = (saw_node == pdev->dev.of_node);
>> -		of_node_put(saw_node);
>> -		of_node_put(cpu_node);
>> -		if (found)
>> -			break;
>> -	}
>> +	spm->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
>> +	spm->cpuidle_driver = qcom_spm_idle_driver;
> 
> This should be in opposite order.
> 

That was a bad overlook, sorry.

> It's still freezing with this patch version. I used the chance to
> investigate why it freezes, and it's actually not some bug of my
> platform like you mentioned:
> 
>> So you have discovered a bug for which your platform dies when SPM
>> does not probe, probably due to something else being dependant on this.
>> In this case, I would encourage you to produce a fix for your platform
>> to not unexpectedly just hang forever if *some driver* doesn't probe:
>> that's definitely not right.
> 
> There is a simple reason why this happens: If "cpumask" is not set,
> the cpuidle_driver applies to *all* CPUs. This means that as soon as
> CPU1/2/3 go into standalone power collapse the SPM for CPU0 (rather than
> the one for CPU1/2/3!) is re-configured. Eventually CPU0 will execute WFI
> (without saving the CPU state) and ends up in power collapse (CPU state
> destroyed) rather than standby (CPU state preserved).
> 

That's a big relief!

>> [...]
>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>> [...]
>> +static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
> 
> This should be still u8 in this patch.
> 

Ack.

> drivers/soc/qcom/spm.c:47:16: error: initialization of 'const u8 *' {aka 'const unsigned char *'} from incompatible pointer type 'const u16 *' {aka 'const short unsigned int *'} [-Werror=incompatible-pointer-types]
>     47 |  .reg_offset = spm_reg_offset_v2_1,
>        |                ^~~~~~~~~~~~~~~~~~~
> drivers/soc/qcom/spm.c:47:16: note: (near initialization for 'spm_reg_8974_8084_cpu.reg_offset')
> 
>> [...]
>> +static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
> 
> drivers/soc/qcom/spm.c:68:16: error: initialization of 'const u8 *' {aka 'const unsigned char *'} from incompatible pointer type 'const u16 *' {aka 'const short unsigned int *'} [-Werror=incompatible-pointer-types]
>     68 |  .reg_offset = spm_reg_offset_v1_1,
>        |                ^~~~~~~~~~~~~~~~~~~
> drivers/soc/qcom/spm.c:68:16: note: (near initialization for 'spm_reg_8064_cpu.reg_offset')
> 
>> [...]
>> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
>> new file mode 100644
>> index 000000000000..719c604a8402
>> --- /dev/null
>> +++ b/include/soc/qcom/spm.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2014,2015, Linaro Ltd.
>> + * Copyright (C) 2021, AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
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
>> +	const u8 *reg_offset;
>> +	u32 spm_cfg;
>> +	u32 spm_dly;
>> +	u32 pmic_dly;
>> +	u32 pmic_data[MAX_PMIC_DATA];
>> +	u8 seq[MAX_SEQ_DATA];
>> +	u8 start_index[PM_SLEEP_MODE_NR];
>> +};
>> +
>> +struct spm_driver_data {
>> +	struct cpuidle_driver cpuidle_driver;
> 
> Given that the SPM hardware seems to have several different uses,
> not just CPUidle, wouldn't it be better to allocate the memory for the
> cpuidle_driver from cpuidle-qcom-spm.c? Just devm_kzalloc() something
> like:
> 
> struct spm_cpuidle_driver {
> 	struct cpuidle_driver cpuidle_driver;
> 	struct spm_driver_data *spm;
> };
> 
> in cpuidle-qcom-spm.c.
> 
> And then there wouldn't be a need to have the implementation details of
> the SPM driver in the spm.h header, all that cpuidle-qcom-spm needs is
> 
> struct spm_driver_data;
> 
> enum pm_sleep_mode {
> 	PM_SLEEP_MODE_STBY,
> 	PM_SLEEP_MODE_RET,
> 	PM_SLEEP_MODE_SPC,
> 	PM_SLEEP_MODE_PC,
> 	PM_SLEEP_MODE_NR,
> };
> 
> void spm_set_low_power_mode(struct spm_driver_data *drv,
> 			    enum pm_sleep_mode mode);
> 
> Everything else can remain private to the spm.c driver,
> like it was before.
> 

I don't completely dislike the approach but I honestly think that this
would put some cognitive strain: having a header included in two files
using "things" defined in there gives people an easy path to follow
when looking at one of the two files.

Regarding the addition of that one more structure... I am seriously
undecided on the matter: wasting this kind of amount of memory on a
ARM64 platform (usually having more than 1GB RAM) is completely
unnoticeable but, on the other hand, it's still a waste of memory,
even if it's minimal that much.

I will think about it.

> Thanks,
> Stephan
> 

