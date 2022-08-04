Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEE589DDD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbiHDOtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiHDOtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 10:49:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 969E018C;
        Thu,  4 Aug 2022 07:49:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15AEB11FB;
        Thu,  4 Aug 2022 07:49:48 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5998F3F73B;
        Thu,  4 Aug 2022 07:49:46 -0700 (PDT)
Date:   Thu, 4 Aug 2022 15:49:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] firmware/psci: Add debugfs support to ease debugging
Message-ID: <YuvchxwbbI3H+kxY@FVFF77S0Q05N.cambridge.arm.com>
References: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 04, 2022 at 04:15:07PM +0300, Dmitry Baryshkov wrote:
> To ease debugging of PSCI supported features, add debugfs file called
> 'psci' describing PSCI and SMC CC versions, enabled features and
> options.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes since v1:
> - Extended the table to include MEM_PROTECT functions (noted by Mark
>   Brown)
> - Switched to seq_puts where possible
> - Changed S_IRUGO to 0444
> ---
>  drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/psci.h    |  14 +++++
>  2 files changed, 129 insertions(+), 1 deletion(-)

TBH I am really not keen on exposing this to userspace. AFAICT this is his is
incredibly niche, and is going to be very painful to maintain.

Without a strong rationale, I do not thing we should do this.

Who is going to use this, and when?

I'd be much happier logging stuff as it's probed into dmesg; I'm happy to add
more information there (and/or a command line parameter to be more verbose).

Thanks,
Mark.

> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 1628f1edef4a..42cae0ba10e2 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -9,6 +9,7 @@
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/cpuidle.h>
> +#include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
>  #include <linux/of.h>
> @@ -326,12 +327,125 @@ static void psci_sys_poweroff(void)
>  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
>  }
>  
> -static int __init psci_features(u32 psci_func_id)
> +static int psci_features(u32 psci_func_id)
>  {
>  	return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
>  			      psci_func_id, 0, 0);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define PSCI_ID(ver, _name) \
> +	{ .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
> +#define PSCI_ID_NATIVE(ver, _name) \
> +	{ .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
> +
> +/* A table of all optional functions */
> +static const struct {
> +	u32 fn;
> +	const char *name;
> +} psci_fn_ids[] = {
> +	PSCI_ID_NATIVE(0_2, MIGRATE),
> +	PSCI_ID(0_2, MIGRATE_INFO_TYPE),
> +	PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
> +	PSCI_ID(1_0, CPU_FREEZE),
> +	PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
> +	PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
> +	PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
> +	PSCI_ID(1_0, SET_SUSPEND_MODE),
> +	PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
> +	PSCI_ID_NATIVE(1_0, STAT_COUNT),
> +	PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> +	PSCI_ID(1_1, MEM_PROTECT),
> +	PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> +};
> +
> +static int psci_debugfs_read(struct seq_file *s, void *data)
> +{
> +	int feature, type, i;
> +	u32 ver;
> +
> +	ver = psci_ops.get_version();
> +	seq_printf(s, "PSCIv%d.%d\n",
> +		   PSCI_VERSION_MAJOR(ver),
> +		   PSCI_VERSION_MINOR(ver));
> +
> +	/* PSCI_FEATURES is available only starting from 1.0 */
> +	if (PSCI_VERSION_MAJOR(ver) < 1)
> +		return 0;
> +
> +	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> +	if (feature != PSCI_RET_NOT_SUPPORTED) {
> +		ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> +		seq_printf(s, "SMC Calling Convention v%d.%d\n",
> +			   PSCI_VERSION_MAJOR(ver),
> +			   PSCI_VERSION_MINOR(ver));
> +	} else {
> +		seq_puts(s, "SMC Calling Convention v1.0 is assumed\n");
> +	}
> +
> +	feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
> +	if (feature < 0) {
> +		seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
> +	} else {
> +		seq_printf(s, "OSI is %ssupported\n",
> +			   (feature & BIT(0)) ? "" : "not ");
> +		seq_printf(s, "%s StateID format is used\n",
> +			   (feature & BIT(1)) ? "Extended" : "Original");
> +	}
> +
> +	type = psci_ops.migrate_info_type();
> +	if (type == PSCI_0_2_TOS_UP_MIGRATE ||
> +	    type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
> +		unsigned long cpuid;
> +
> +		seq_printf(s, "Trusted OS %smigrate capable\n",
> +			   type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
> +		cpuid = psci_migrate_info_up_cpu();
> +		seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n",
> +			   cpuid, resident_cpu);
> +	} else if (type == PSCI_0_2_TOS_MP) {
> +		seq_puts(s, "Trusted OS migration not required\n");
> +	} else {
> +		if (type != PSCI_RET_NOT_SUPPORTED)
> +			seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
> +		feature = psci_features(psci_fn_ids[i].fn);
> +		if (feature == PSCI_RET_NOT_SUPPORTED)
> +			continue;
> +		if (feature < 0)
> +			seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n",
> +				   psci_fn_ids[i].name, feature);
> +		else
> +			seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
> +	}
> +
> +	return 0;
> +}
> +
> +static int psci_debugfs_open(struct inode *inode, struct file *f)
> +{
> +	return single_open(f, psci_debugfs_read, NULL);
> +}
> +
> +static const struct file_operations psci_debugfs_ops = {
> +	.owner = THIS_MODULE,
> +	.open = psci_debugfs_open,
> +	.release = single_release,
> +	.read = seq_read,
> +	.llseek = seq_lseek
> +};
> +
> +static int __init psci_debugfs_init(void)
> +{
> +	return PTR_ERR_OR_ZERO(debugfs_create_file("psci", 0444, NULL, NULL,
> +						   &psci_debugfs_ops));
> +}
> +late_initcall(psci_debugfs_init)
> +#endif
> +
>  #ifdef CONFIG_CPU_IDLE
>  static int psci_suspend_finisher(unsigned long state)
>  {
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index 2bf93c0d6354..3511095c2702 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -48,12 +48,26 @@
>  #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU	PSCI_0_2_FN64(7)
>  
>  #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
> +#define PSCI_1_0_FN_CPU_FREEZE			PSCI_0_2_FN(11)
> +#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND		PSCI_0_2_FN(12)
> +#define PSCI_1_0_FN_NODE_HW_STATE		PSCI_0_2_FN(13)
>  #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
>  #define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
> +#define PSCI_1_0_FN_STAT_RESIDENCY		PSCI_0_2_FN(16)
> +#define PSCI_1_0_FN_STAT_COUNT			PSCI_0_2_FN(17)
> +
>  #define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
> +#define PSCI_1_1_FN_MEM_PROTECT			PSCI_0_2_FN(19)
> +#define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN(19)
>  
> +#define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND	PSCI_0_2_FN64(12)
> +#define PSCI_1_0_FN64_NODE_HW_STATE		PSCI_0_2_FN64(13)
>  #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
> +#define PSCI_1_0_FN64_STAT_RESIDENCY		PSCI_0_2_FN64(16)
> +#define PSCI_1_0_FN64_STAT_COUNT		PSCI_0_2_FN64(17)
> +
>  #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
> +#define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE	PSCI_0_2_FN64(19)
>  
>  /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
>  #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
> -- 
> 2.35.1
> 
