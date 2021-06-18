Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864023AD475
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhFRVjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 17:39:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:32887 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFRVjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 17:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624052239;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JnaCFQz5St+EGDw1QBMBxwejwzWiHa+sJHFJNjIixV0=;
    b=i1TGzoSA1JeJUOBdMaBwQEmGOMJHqTF5zLiYmd2YZl712HPuJyMs8k1DAMhBUAB0J/
    u8OiXb4jvlrB65OS1/nA/eqUl76bFF1IYpJMsmFpSkgUncgWnglTC3WeRmYVXUW+GI7i
    vYm3JgXTJ0Xg6vVg5DquCQwssDgxL9W1NPUnZxLi7O/l+fZjQHb74mcSyd1SOKACt87B
    I8ZyJUbfDuN4X1CbuRAKGNFO/Krn40Lj0Pd9F8ZsTSQnAlUb6LN54i5N0pZCvkxmRKB7
    MkMJUOcH31ekXPDxWBamXOVaBtx6pYvB86xBUCRgsuzcc4WO7u7jVxdZqH15d7CA6e4i
    lK6g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f7IcfABg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5ILbI78H
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 18 Jun 2021 23:37:18 +0200 (CEST)
Date:   Fri, 18 Jun 2021 23:37:13 +0200
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
Subject: Re: [RESEND PATCH v4 1/3] cpuidle: qcom_spm: Detach state machine
 from main SPM handling
Message-ID: <YM0SCaAdYMxZQya1@gerhold.net>
References: <20210618180907.258149-1-angelogioacchino.delregno@somainline.org>
 <20210618180907.258149-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618180907.258149-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thanks for the patch!

On Fri, Jun 18, 2021 at 08:09:05PM +0200, AngeloGioacchino Del Regno wrote:
> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
> CPUidle driver") the SPM driver has been converted to a
> generic CPUidle driver: that was mainly made to simplify the
> driver and that was a great accomplishment;
>

Hmm, you mention my commit but did not Cc me.
Only saw this patch while randomly looking through linux-arm-msm. :)

> Though, it was ignored that the SPM driver is not used only
> on the ARM architecture.

This sentence is a bit misleading IMO. In mainline the SPM driver is
*currently* only used for CPUidle, and the old driver was as
CPUidle-specific as the new one. So saying that I "ignored" something
here is kind of wrong. :)

Can you re-phrase this a bit to say that the SPM hardware is also
used for power-collapse of the CPU caches/AVS/whatever and therefore we
need to refactor the driver to something more independent?

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

The diff is quite hard to read for me (just the nature of this change,
not your fault). Just mentioning this in case I miss something obvious.

> ---
>  drivers/cpuidle/Kconfig.arm        |   1 +
>  drivers/cpuidle/cpuidle-qcom-spm.c | 294 ++++++-----------------------
>  drivers/soc/qcom/Kconfig           |   9 +
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/spm.c             | 198 +++++++++++++++++++
>  include/soc/qcom/spm.h             |  45 +++++
>  6 files changed, 312 insertions(+), 236 deletions(-)
>  create mode 100644 drivers/soc/qcom/spm.c
>  create mode 100644 include/soc/qcom/spm.h
> 
> [...]
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index adf91a6e4d7d..3dd7bb10b82d 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> [...]
> -static int spm_dev_probe(struct platform_device *pdev)
> +static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>  {
>  	[...]
> +	for_each_possible_cpu(cpu) {
> +		ret = spm_cpuidle_register(cpu);
> +		if (ret != -ENODEV) {
> +			dev_err(&pdev->dev,
> +				"Cannot register for CPU%d: %d\n", cpu, ret);
> +			break;

Huh, why does this error for ret = 0? :S

[    0.736332] qcom-spm-cpuidle qcom-spm-cpuidle: Cannot register for CPU0: 0

A couple more lines in the UART log, then the device hangs forever.
For testing I changed this to: if (ret && ret != -ENODEV).

> [...]
> @@ -213,132 +80,87 @@ static const struct of_device_id qcom_idle_state_match[] = {
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

Somehow this line got lost, which means the first cpuidle_driver will
cover all CPUs and we will always fail to register the cpuidle_driver
for all other CPUs:

[    0.736591] failed to register cpuidle driver
[    0.744186] qcom-spm-cpuidle qcom-spm-cpuidle: Cannot register for CPU1: -16
[    0.748443] qcom-spm-cpuidle: probe of qcom-spm-cpuidle failed with error -16

(Then the device hangs forever.)

I added
spm->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
below

> +	spm->cpuidle_driver = qcom_spm_idle_driver;

and this seems to make it boot again at least.

However, it seems a bit pointless now to have a separate cpuidle_driver
per CPU, since they are all registered at the same time. With my
refactoring this was kind of convenient because the SPM platform devices
could happily probe independently and just register a cpuidle_driver for
the CPU they belong to.

With your patch, the cpuidle_drivers are registered at the same time for
all CPUs, so we might as well use a single cpuidle_driver that covers
all CPUs (like you already do without setting cpumask).

Note that if you have a single cpuidle_driver for all CPUs you need to
refactor spm_enter_idle_state() a bit. The container_of() will no longer
work to get the CPU-specific SPM. Before my changes there was a
DEFINE_PER_CPU for this. I guess we need to bring that back.

>  	[...]
> +	ret = dt_init_idle_driver(&spm->cpuidle_driver,
> +				  qcom_idle_state_match, 1);
> +	if (ret <= 0)
> +		return ret ? : -ENODEV;
>  
> -	return drv;
> -}
> +	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
> +	if (ret)
> +		return ret;

And the advantage here is that we should be able to do this with a
single firmware call (set the warm boot addr for all CPUs at once).

> [...]
> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> new file mode 100644
> index 000000000000..604eca2c4d4a
> --- /dev/null
> +++ b/include/soc/qcom/spm.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014,2015, Linaro Ltd.
> + * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
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
> +	const u16 *reg_offset;
> +	u32 spm_cfg;
> +	u32 spm_dly;
> +	u32 pmic_dly;
> +	u32 pmic_data[MAX_PMIC_DATA];
> +	u32 avs_ctl;
> +	u32 avs_limit;

Looks like you accidentally included changes from PATCH 2/3
("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
here, reg_offset u8 -> u16 and adding avs_ctl and avs_limit should be in
a separate patch. It's really hard to see that you added those here
while moving the code. :/

Thanks,
Stephan
