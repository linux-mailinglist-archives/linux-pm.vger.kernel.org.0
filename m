Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9ED5833FD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiG0UPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiG0UPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 16:15:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363948C9A
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:15:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b9so71649pfp.10
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b5kB7yUGCXKzmggBGC2zxxJNbzrNY7b9ttnX/1cFGfo=;
        b=RXW+NbcZLkB66ZeI6HThp4bUMVJBOgveDhGzLQq6WZKZSh/Q0zSRajBwC6GHJfUG0h
         CRHwAtICxFBjn/oZWuHGhTSq24dypw0RohlcHMgI8L9bzkf8lyXeSN4Hb2GdR0oWe6Lr
         t5MLw0Wa/y1zoQycU5DfRLGqXlsevU3adiNiTQQm0rnnWwOp9Q0NdOmamE1Ayn2Ub66f
         QXoJ7mOukhFvywuYoL5AVUN/17Sgn05IA4A4qyqXkpElflnG+VjZWJQevtnDvo6cnqj1
         kGqgvFv8+1N32A4cWsxgqjuYnNdvpGfoYerQ8DwAyXAizdz8BpxQ8D3lRE0iO6zsDOst
         zHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b5kB7yUGCXKzmggBGC2zxxJNbzrNY7b9ttnX/1cFGfo=;
        b=mkkA4omfX7LfvF98IjERPXWRpxQJGiTsrPDqwb5qJ3iR1IjQATA0LUxhpjMa3dFUos
         U0lmCDao6PMj2KAgGi7JHTmqYDCExAoOBZw4GY7wTBlIfl25nw6hHBaSh386ewJN/TKW
         VWnb8Uwg3aIyzDTkJOLAsaaFlXhEwe3w4ctHiLNV2MPDNaurs3xAB+HTXUUAszlYzFSK
         i4PnnNexOXmAV4DAFDXQo3P3owaymv8qORuOASEnI2O8mrT126GgU6V9CjWZdRk1r3ft
         HSuEVPbJPs38YTdhcKW6NUGvdLOrI4xNV6WpdKikdxAI2IQoahdyVmz2ypIGaSRrhWBI
         Enew==
X-Gm-Message-State: AJIora+exReVO4MorIEOSodnMUIvExVMH5ep+xzqAU9/iS2wT84N9SQE
        O6JBH6hCRTIZwBap0PFjdDgP1A==
X-Google-Smtp-Source: AGRyM1uSj22o00ydyvWNF7OXDaapjxToi5KOe23zJFUzV6jw/KdMO6gtey8hCsnw8caBXuUMDkyJ/w==
X-Received: by 2002:a63:f502:0:b0:415:ee58:b22b with SMTP id w2-20020a63f502000000b00415ee58b22bmr19679901pgh.349.1658952915786;
        Wed, 27 Jul 2022 13:15:15 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0? ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0016c304612a0sm4231860plg.292.2022.07.27.13.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 13:15:15 -0700 (PDT)
Message-ID: <bec61bd7-f547-5254-50a5-6f16c221051e@linaro.org>
Date:   Thu, 28 Jul 2022 01:45:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 7/28/22 1:39 AM, Dmitry Baryshkov wrote:
> To ease debugging of PSCI supported features, add debugfs file called
> 'psci' describing PSCI and SMC CC versions, enabled features and
> options.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/firmware/psci/psci.c | 112 ++++++++++++++++++++++++++++++++++-
>   include/uapi/linux/psci.h    |   9 +++
>   2 files changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index b907768eea01..6595cc964635 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -9,6 +9,7 @@
>   #include <linux/acpi.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/cpuidle.h>
> +#include <linux/debugfs.h>
>   #include <linux/errno.h>
>   #include <linux/linkage.h>
>   #include <linux/of.h>
> @@ -324,12 +325,121 @@ static void psci_sys_poweroff(void)
>   	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
>   }
>   
> -static int __init psci_features(u32 psci_func_id)
> +static int psci_features(u32 psci_func_id)

This change doesn't seem related to the patch $SUBJECT.
Also is it really needed? If yes, probably this should be a separate patch.

Thanks,
Bhupesh

>   {
>   	return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
>   			      psci_func_id, 0, 0);
>   }
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
> +		seq_printf(s, "SMC Calling Convention v1.0 is assumed\n");
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
> +		seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n", cpuid, resident_cpu);
> +	} else if (type == PSCI_0_2_TOS_MP) {
> +		seq_printf(s, "Trusted OS migration not required\n");
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
> +			seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n", psci_fn_ids[i].name, feature);
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
> +	return PTR_ERR_OR_ZERO(debugfs_create_file("psci", S_IRUGO, NULL, NULL,
> +						   &psci_debugfs_ops));
> +}
> +late_initcall(psci_debugfs_init)
> +#endif
> +
>   #ifdef CONFIG_CPU_IDLE
>   static int psci_suspend_finisher(unsigned long state)
>   {
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index 2bf93c0d6354..f6f0bad5858b 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -48,11 +48,20 @@
>   #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU	PSCI_0_2_FN64(7)
>   
>   #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
> +#define PSCI_1_0_FN_CPU_FREEZE			PSCI_0_2_FN(11)
> +#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND		PSCI_0_2_FN(12)
> +#define PSCI_1_0_FN_NODE_HW_STATE		PSCI_0_2_FN(13)
>   #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
>   #define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
> +#define PSCI_1_0_FN_STAT_RESIDENCY		PSCI_0_2_FN(16)
> +#define PSCI_1_0_FN_STAT_COUNT			PSCI_0_2_FN(17)
>   #define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
>   
> +#define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND	PSCI_0_2_FN64(12)
> +#define PSCI_1_0_FN64_NODE_HW_STATE		PSCI_0_2_FN64(13)
>   #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
> +#define PSCI_1_0_FN64_STAT_RESIDENCY		PSCI_0_2_FN64(16)
> +#define PSCI_1_0_FN64_STAT_COUNT		PSCI_0_2_FN64(17)
>   #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
>   
>   /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
