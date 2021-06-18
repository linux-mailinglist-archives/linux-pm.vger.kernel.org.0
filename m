Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB39D3AD55B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhFRWrq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 18:47:46 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:32415 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFRWrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 18:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624056332;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=w0tUq6/SM98o5fSQSd5dyTufO/IQnWLXIW0zDGxMihQ=;
    b=rwfAv7X7E05dTKCBHIAst/O1AK8BXYuhBAh+/EvCi+KIs6vfSQ5im5em1Esub//qFH
    JWPpEQTPRrNwX6hLyHmzto+tKGMIrgvxalxY7gkx/Mc+zp9UuxHEBcwl4gVtIydBt5Qw
    Al4vR2yeI8mrPRc7y9mqmcYQfItnkAb8z9JjJmiI3NHiitU3MNfKFyHeqVwTwgyODwpN
    uYiXn1RtgwILKByiuEvdoeqhGstBXS0Gd1tZJOgJY5n0cUgv+TfL9sUkbrH6GhWtc/QQ
    YGO1j6MszwhfsGWaKXc2eJFtREM1gdYTBbIbPgGZ2T3Ob+UGnvdiJdvK9elBPYUtwY+H
    LwiA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f7IcfABg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5IMjV7Gf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 19 Jun 2021 00:45:31 +0200 (CEST)
Date:   Sat, 19 Jun 2021 00:45:25 +0200
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
Message-ID: <YM0iBYCL9FHlsue2@gerhold.net>
References: <20210618180907.258149-1-angelogioacchino.delregno@somainline.org>
 <20210618180907.258149-2-angelogioacchino.delregno@somainline.org>
 <YM0SCaAdYMxZQya1@gerhold.net>
 <ebeb5f35-b284-222f-86df-9ca6633d73ba@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebeb5f35-b284-222f-86df-9ca6633d73ba@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 19, 2021 at 12:32:50AM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/06/21 23:37, Stephan Gerhold ha scritto:
> > > Though, it was ignored that the SPM driver is not used only
> > > on the ARM architecture.
> > 
> > This sentence is a bit misleading IMO. In mainline the SPM driver is
> > *currently* only used for CPUidle, and the old driver was as
> > CPUidle-specific as the new one. So saying that I "ignored" something
> > here is kind of wrong. :)
> > 
> > Can you re-phrase this a bit to say that the SPM hardware is also
> > used for power-collapse of the CPU caches/AVS/whatever and therefore we
> > need to refactor the driver to something more independent?
> > 
> 
> On SAWv4.1, the SPM is used to regulate AVS limits but *not* power
> collapse of the CPU caches "and whatever": platforms with this version
> are using different HW to accomplish that.
> 

OK, thanks for clarifying! My point stands though, I don't think
I "ignored" anything in my refactoring commit. :)

> 
> > > [...]
> > > @@ -213,132 +80,87 @@ static const struct of_device_id qcom_idle_state_match[] = {
> > > -static int spm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
> > > +static int spm_cpuidle_register(int cpu)
> > >   {
> > > +	struct platform_device *pdev = NULL;
> > > +	struct spm_driver_data *spm = NULL;
> > > +	struct device_node *cpu_node, *saw_node;
> > >   	int ret;
> > > -	memcpy(drv, &qcom_spm_idle_driver, sizeof(*drv));
> > > -	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> > 
> > Somehow this line got lost, which means the first cpuidle_driver will
> > cover all CPUs and we will always fail to register the cpuidle_driver
> > for all other CPUs:
> > 
> > [    0.736591] failed to register cpuidle driver
> > [    0.744186] qcom-spm-cpuidle qcom-spm-cpuidle: Cannot register for CPU1: -16
> > [    0.748443] qcom-spm-cpuidle: probe of qcom-spm-cpuidle failed with error -16
> > 
> > (Then the device hangs forever.)
> > 
> 
> So you have discovered a bug for which your platform dies when SPM
> does not probe, probably due to something else being dependant on this.
> In this case, I would encourage you to produce a fix for your platform
> to not unexpectedly just hang forever if *some driver* doesn't probe:
> that's definitely not right.
> 

Fair enough, might investigate this further.

> > I added
> > spm->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
> > below
> > 
> > > +	spm->cpuidle_driver = qcom_spm_idle_driver;
> > 
> > and this seems to make it boot again at least.
> > 
> 
> I really think that I've originally messed up the patch originally:
> this doesn't seem to be the right version, even though it was marked as
> v4. I trusted my folders organization too much. Apologies.
> 

It seems mostly equivalent with the previous v4 and v3, but didn't check
very carefully. No problem though, as long we can get it fixed. :)

> > However, it seems a bit pointless now to have a separate cpuidle_driver
> > per CPU, since they are all registered at the same time. With my
> > refactoring this was kind of convenient because the SPM platform devices
> > could happily probe independently and just register a cpuidle_driver for
> > the CPU they belong to.
> > 
> > With your patch, the cpuidle_drivers are registered at the same time for
> > all CPUs, so we might as well use a single cpuidle_driver that covers
> > all CPUs (like you already do without setting cpumask).
> > 
> > Note that if you have a single cpuidle_driver for all CPUs you need to
> > refactor spm_enter_idle_state() a bit. The container_of() will no longer
> > work to get the CPU-specific SPM. Before my changes there was a
> > DEFINE_PER_CPU for this. I guess we need to bring that back.
> > 
> > >   	[...]
> > > +	ret = dt_init_idle_driver(&spm->cpuidle_driver,
> > > +				  qcom_idle_state_match, 1);
> > > +	if (ret <= 0)
> > > +		return ret ? : -ENODEV;
> > > -	return drv;
> > > -}
> > > +	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
> > > +	if (ret)
> > > +		return ret;
> > 
> > And the advantage here is that we should be able to do this with a
> > single firmware call (set the warm boot addr for all CPUs at once).
> > 
> 
> Probably staying with setting the cpumask is a better option; we don't
> really know if there's any platform requiring that kind of quirk: at
> least downstream, I recall that they made sure to send multiple calls.
> 

I don't think it really makes a difference but fair enough. I still
think it could be worth having a single cpuidle_driver (even if we call
qcom_scm_set_warm_boot_addr() separately for each CPU), but I suppose
this is more material for a potential follow-up patch.

> 
> > > [...]
> > > diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> > > new file mode 100644
> > > index 000000000000..604eca2c4d4a
> > > --- /dev/null
> > > +++ b/include/soc/qcom/spm.h
> > > @@ -0,0 +1,45 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2014,2015, Linaro Ltd.
> > > + * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
> > > + */
> > > +
> > > +#ifndef __SPM_H__
> > > +#define __SPM_H__
> > > +
> > > +#include <linux/cpuidle.h>
> > > +
> > > +#define MAX_PMIC_DATA		2
> > > +#define MAX_SEQ_DATA		64
> > > +
> > > +enum pm_sleep_mode {
> > > +	PM_SLEEP_MODE_STBY,
> > > +	PM_SLEEP_MODE_RET,
> > > +	PM_SLEEP_MODE_SPC,
> > > +	PM_SLEEP_MODE_PC,
> > > +	PM_SLEEP_MODE_NR,
> > > +};
> > > +
> > > +struct spm_reg_data {
> > > +	const u16 *reg_offset;
> > > +	u32 spm_cfg;
> > > +	u32 spm_dly;
> > > +	u32 pmic_dly;
> > > +	u32 pmic_data[MAX_PMIC_DATA];
> > > +	u32 avs_ctl;
> > > +	u32 avs_limit;
> > 
> > Looks like you accidentally included changes from PATCH 2/3
> > ("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
> > here, reg_offset u8 -> u16 and adding avs_ctl and avs_limit should be in
> > a separate patch. It's really hard to see that you added those here
> > while moving the code. :/
> > 
> 
> This change belongs to 2/3.
> Will send a v5 with fixes.
> 

Thanks!
Stephan
