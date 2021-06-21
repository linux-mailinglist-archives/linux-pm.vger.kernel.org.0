Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E072A3AE86C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFUL4a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 07:56:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:36365 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUL4a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 07:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624276450;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=pM4LwnfWQzSSJj3q4Rt4Fk5pxwNpci9A+bVwbPIo+EQ=;
    b=b3hqBoacHfQgaKxXtjZwOa0qQVlaGiUWBTWt7pMeu5yeKDUneOV0ZZYamH5C0STY4k
    O4nglwffFe4LwIgbVbkj2s0m8HORMtPPuNE06eqM2/K8RK+O5yFFE7eqdfa871/2uKKq
    TIvDZGB8IwdzPikFVVI1o3lAWgdLczLKO8wO61f6prs7Wt4PzkR/O+eL6nvF84Kw6aU6
    oW0hpf6I3AEY7r/J4dmfBmcluh1S8fnSsBK1W40sx1LlL4/phk/2+cYTV6PhQtMk/xP3
    LZF99RFyRFqV9TD4aeMFMcj1OX7d2Fw3D+CEcaasYr5A9UpVVAyBs2fjqaJciD9zBxQy
    9QLg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j5IczAb4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5LBs9HtM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Jun 2021 13:54:09 +0200 (CEST)
Date:   Mon, 21 Jun 2021 13:54:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 1/3] cpuidle: qcom_spm: Detach state machine from main
 SPM handling
Message-ID: <YNB92Dkx5MNg64m+@gerhold.net>
References: <20210618225620.623359-1-angelogioacchino.delregno@somainline.org>
 <20210618225620.623359-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618225620.623359-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 19, 2021 at 12:56:18AM +0200, AngeloGioacchino Del Regno wrote:
> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
> CPUidle driver") the SPM driver has been converted to a
> generic CPUidle driver: that was mainly made to simplify the
> driver and that was a great accomplishment;
> Though, it was ignored that the SPM driver is not used only
> on the ARM architecture.
> 

Can you please reword this sentence like I suggested in v4? The way you
write it at the moment it sounds like this fixes a regression, but
actually it extends the driver to cover more use cases.

> In preparation for the enablement of SPM features on AArch64/ARM64,
> split the cpuidle-qcom-spm driver in two: the CPUIdle related
> state machine (currently used only on ARM SoCs) stays there, while
> the SPM communication handling lands back in soc/qcom/spm.c and
> also making sure to not discard the simplifications that were
> introduced in the aforementioned commit.
> 
> Since now the "two drivers" are split, the SCM dependency in the
> main SPM handling is gone and for this reason it was also possible
> to move the SPM initialization early: this will also make sure that
> whenever the SAW CPUIdle driver is getting initialized, the SPM
> driver will be ready to do the job.
> 
> Please note that the anticipation of the SPM initialization was
> also done to optimize the boot times on platforms that have their
> CPU/L2 idle states managed by other means (such as PSCI), while
> needing SAW initialization for other purposes, like AVS control.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/cpuidle/Kconfig.arm        |   1 +
>  drivers/cpuidle/cpuidle-qcom-spm.c | 295 ++++++-----------------------
>  drivers/soc/qcom/Kconfig           |   9 +
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/spm.c             | 198 +++++++++++++++++++
>  include/soc/qcom/spm.h             |  43 +++++
>  6 files changed, 311 insertions(+), 236 deletions(-)
>  create mode 100644 drivers/soc/qcom/spm.c
>  create mode 100644 include/soc/qcom/spm.h
> 
> [...]
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> [...]
> @@ -213,132 +80,88 @@ static const struct of_device_id qcom_idle_state_match[] = {
>  	{ },
>  };
>  
> -static int spm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
> +static int spm_cpuidle_register(int cpu)
>  {
> +	struct platform_device *pdev = NULL;
> +	struct spm_driver_data *spm = NULL;
> +	struct device_node *cpu_node, *saw_node;
>  	int ret;
>  
> -	memcpy(drv, &qcom_spm_idle_driver, sizeof(*drv));
> -	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> +	cpu_node = of_cpu_device_node_get(cpu);
> +	if (!cpu_node)
> +		return -ENODEV;
>  
> -	/* Parse idle states from device tree */
> -	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 1);
> -	if (ret <= 0)
> -		return ret ? : -ENODEV;
> +	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> +	if (!saw_node)
> +		return -ENODEV;
>  
> -	/* We have atleast one power down mode */
> -	return qcom_scm_set_warm_boot_addr(cpu_resume_arm, drv->cpumask);
> -}
> +	pdev = of_find_device_by_node(saw_node);
> +	of_node_put(saw_node);
> +	of_node_put(cpu_node);
> +	if (!pdev)
> +		return -ENODEV;
>  
> -static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
> -		int *spm_cpu)
> -{
> -	struct spm_driver_data *drv = NULL;
> -	struct device_node *cpu_node, *saw_node;
> -	int cpu;
> -	bool found = 0;
> +	spm = dev_get_drvdata(&pdev->dev);
> +	if (!spm)
> +		return -EINVAL;
>  
> -	for_each_possible_cpu(cpu) {
> -		cpu_node = of_cpu_device_node_get(cpu);
> -		if (!cpu_node)
> -			continue;
> -		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> -		found = (saw_node == pdev->dev.of_node);
> -		of_node_put(saw_node);
> -		of_node_put(cpu_node);
> -		if (found)
> -			break;
> -	}
> +	spm->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
> +	spm->cpuidle_driver = qcom_spm_idle_driver;

This should be in opposite order.

It's still freezing with this patch version. I used the chance to
investigate why it freezes, and it's actually not some bug of my
platform like you mentioned:

> So you have discovered a bug for which your platform dies when SPM
> does not probe, probably due to something else being dependant on this.
> In this case, I would encourage you to produce a fix for your platform
> to not unexpectedly just hang forever if *some driver* doesn't probe:
> that's definitely not right.

There is a simple reason why this happens: If "cpumask" is not set,
the cpuidle_driver applies to *all* CPUs. This means that as soon as
CPU1/2/3 go into standalone power collapse the SPM for CPU0 (rather than
the one for CPU1/2/3!) is re-configured. Eventually CPU0 will execute WFI
(without saving the CPU state) and ends up in power collapse (CPU state
destroyed) rather than standby (CPU state preserved).

> [...]
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> [...]
> +static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {

This should be still u8 in this patch.

drivers/soc/qcom/spm.c:47:16: error: initialization of 'const u8 *' {aka 'const unsigned char *'} from incompatible pointer type 'const u16 *' {aka 'const short unsigned int *'} [-Werror=incompatible-pointer-types]
   47 |  .reg_offset = spm_reg_offset_v2_1,
      |                ^~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/spm.c:47:16: note: (near initialization for 'spm_reg_8974_8084_cpu.reg_offset')

> [...]
> +static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {

drivers/soc/qcom/spm.c:68:16: error: initialization of 'const u8 *' {aka 'const unsigned char *'} from incompatible pointer type 'const u16 *' {aka 'const short unsigned int *'} [-Werror=incompatible-pointer-types]
   68 |  .reg_offset = spm_reg_offset_v1_1,
      |                ^~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/spm.c:68:16: note: (near initialization for 'spm_reg_8064_cpu.reg_offset')

> [...]
> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> new file mode 100644
> index 000000000000..719c604a8402
> --- /dev/null
> +++ b/include/soc/qcom/spm.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014,2015, Linaro Ltd.
> + * Copyright (C) 2021, AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> + */
> +
> +#ifndef __SPM_H__
> +#define __SPM_H__
> +
> +#include <linux/cpuidle.h>
> +
> +#define MAX_PMIC_DATA		2
> +#define MAX_SEQ_DATA		64
> +
> +enum pm_sleep_mode {
> +	PM_SLEEP_MODE_STBY,
> +	PM_SLEEP_MODE_RET,
> +	PM_SLEEP_MODE_SPC,
> +	PM_SLEEP_MODE_PC,
> +	PM_SLEEP_MODE_NR,
> +};
> +
> +struct spm_reg_data {
> +	const u8 *reg_offset;
> +	u32 spm_cfg;
> +	u32 spm_dly;
> +	u32 pmic_dly;
> +	u32 pmic_data[MAX_PMIC_DATA];
> +	u8 seq[MAX_SEQ_DATA];
> +	u8 start_index[PM_SLEEP_MODE_NR];
> +};
> +
> +struct spm_driver_data {
> +	struct cpuidle_driver cpuidle_driver;

Given that the SPM hardware seems to have several different uses,
not just CPUidle, wouldn't it be better to allocate the memory for the
cpuidle_driver from cpuidle-qcom-spm.c? Just devm_kzalloc() something
like:

struct spm_cpuidle_driver {
	struct cpuidle_driver cpuidle_driver;
	struct spm_driver_data *spm;
};

in cpuidle-qcom-spm.c.

And then there wouldn't be a need to have the implementation details of
the SPM driver in the spm.h header, all that cpuidle-qcom-spm needs is

struct spm_driver_data;

enum pm_sleep_mode {
	PM_SLEEP_MODE_STBY,
	PM_SLEEP_MODE_RET,
	PM_SLEEP_MODE_SPC,
	PM_SLEEP_MODE_PC,
	PM_SLEEP_MODE_NR,
};

void spm_set_low_power_mode(struct spm_driver_data *drv,
			    enum pm_sleep_mode mode);

Everything else can remain private to the spm.c driver,
like it was before.

Thanks,
Stephan
