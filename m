Return-Path: <linux-pm+bounces-19580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D99F941D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 15:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC570162FB1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC998210189;
	Fri, 20 Dec 2024 14:19:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C668CA4E;
	Fri, 20 Dec 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704380; cv=none; b=HGsoti9qyLHb0tD/iV3li3TaSHbIVxfGRJ0DDhOi69LqhNH22T7M22uIiHkSZ8bPFlPH6CkJXiPLvV95xIEVmZQrBly+InXsOOHrqMWjcQe5Uo0Pw0EV1OYEwsEGZLhO2foWdF5gmicVPe75KnSxAVJ5nU6NGnfMVbLSe0OMtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704380; c=relaxed/simple;
	bh=ASLUFO5R2CgGQPwQ8a6jkmVEdXgBx+P8ojf6e49k7bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtpXpuSpl/gpxOqpkpAe3HK+lOdI20OGuj/7hrsxkU0732dwab9GPkzrtrvs7CHhgpfOZDkUOihVEyZ5pMoNYb0pQPYSjEDqBk4fie39GMaAfpduyYW0pZAioWpsXxWjpp8jnaNsV3I3WBlr6MCBkG1VewNkffyog3inx+rxb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033D51480;
	Fri, 20 Dec 2024 06:20:06 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FB343F720;
	Fri, 20 Dec 2024 06:19:36 -0800 (PST)
Date: Fri, 20 Dec 2024 14:19:34 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <Z2V89nHKetwwRGS0@bogus>
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206211145.2823-2-ansuelsmth@gmail.com>

On Fri, Dec 06, 2024 at 10:11:25PM +0100, Christian Marangi wrote:
> Add simple CPU Freq driver for Airoha EN7581 SoC that control CPU
> frequency scaling with SMC APIs and register a generic "cpufreq-dt"
> device.
> 
> CPUFreq driver registers a get-only clock to get the current global CPU
> frequency from SMC and a Power Domain to configure the performance state
> for each OPP to apply the requested frequency from cpufreq-dt. This is
> needed as SMC use index instead of raw frequency.
> 
> All CPU share the same frequency and can't be controlled independently.
> Current shared CPU frequency is returned by the related SMC command.
> 
> Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
> driver is needed with OPP v2 nodes declared in DTS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

[...]

> diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
> new file mode 100644
> index 000000000000..29738f61f401
> --- /dev/null
> +++ b/drivers/cpufreq/airoha-cpufreq.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/cpufreq.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "cpufreq-dt.h"
> +

[...]


> +
> +static unsigned long airoha_cpufreq_clk_get(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	const struct arm_smccc_1_2_regs args = {
> +		.a0 = AIROHA_SIP_AVS_HANDLE,
> +		.a1 = AIROHA_AVS_OP_GET_FREQ,
> +	};
> +	struct arm_smccc_1_2_regs res;
> +
> +	arm_smccc_1_2_smc(&args, &res);

See below comment. Same applies here.

> +
> +	/* SMCCC returns freq in MHz */
> +	return res.a0 * 1000 * 1000;
> +}
> +
> +/* Airoha CPU clk SMCC is always enabled */
> +static int airoha_cpufreq_clk_is_enabled(struct clk_hw *hw)
> +{
> +	return true;
> +}
> +
> +static const struct clk_ops airoha_cpufreq_clk_ops = {
> +	.recalc_rate = airoha_cpufreq_clk_get,
> +	.is_enabled = airoha_cpufreq_clk_is_enabled,
> +	.round_rate = airoha_cpufreq_clk_round,
> +};
> +
> +static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
> +
> +/* NOP function to disable OPP from setting clock */
> +static int airoha_cpufreq_config_clks_nop(struct device *dev,
> +					  struct opp_table *opp_table,
> +					  struct dev_pm_opp *opp,
> +					  void *data, bool scaling_down)
> +{
> +	return 0;
> +}
> +
> +static const char * const airoha_cpufreq_pd_names[] = { "perf" };
> +
> +static int airoha_cpufreq_set_performance_state(struct generic_pm_domain *domain,
> +						unsigned int state)
> +{
> +	const struct arm_smccc_1_2_regs args = {
> +		.a0 = AIROHA_SIP_AVS_HANDLE,
> +		.a1 = AIROHA_AVS_OP_FREQ_DYN_ADJ,
> +		.a3 = state,
> +	};
> +	struct arm_smccc_1_2_regs res;
> +
> +	arm_smccc_1_2_smc(&args, &res);
> +

I assume the compatible suggests SMCCCv1.2+ is implemented, but it is good
to check  arm_smccc_get_version() and add build config dependency on
HAVE_ARM_SMCCC_DISCOVERY. Also use the SMCCC conduit and don't assume SMC.

-- 
Regards,
Sudeep

