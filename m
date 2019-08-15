Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800588E57A
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfHOHUW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 03:20:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55320 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfHOHUV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 03:20:21 -0400
Received: from zn.tnic (p200300EC2F0B5200DD69E9E370CF27BC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:dd69:e9e3:70cf:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3000C1EC097D;
        Thu, 15 Aug 2019 09:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565853620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nZMt0Zf/5Aq52Zw3ujiS8LgLLo1RrWDRLuyw34+Xjrs=;
        b=lRTJmRYRCniO6eVKaSiGpNLTrh+eAGy1UR3yWSLgvdVVSbW39NOa3gwh2oHvAoeGVE7BGc
        joCCAjn4MUuY55qWxJn5Him+WNrmhftHXb7250MuBe3DjJ3xY/+7ZzGlydptocjgI0F1xF
        qkYhUMHwK9mMWCJ37UL0MeENiu2DaKc=
Date:   Thu, 15 Aug 2019 09:21:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Message-ID: <20190815071940.GB15313@zn.tnic>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 14, 2019 at 09:17:41PM +0000, Lendacky, Thomas wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> There have been reports of RDRAND issues after resuming from suspend on
> some AMD family 15h and family 16h systems. This issue stems from BIOS
> not performing the proper steps during resume to ensure RDRAND continues
> to function properly.

If this happens only during suspend/resume, this probably should
be done only on configurations which have CONFIG_SUSPEND and/or
CONFIG_HIBERNATION enabled. I'm assuming BIOS does init it properly
at least during boot - I mean, they should've passed some sort of a
certification.

OTOH, if the breakage happens on resume, they clearly didn't test the
BIOS suspend/resume. I mean, I'm not at all surprised - it is f*cking
BIOS. News at 11.

> RDRAND support is indicated by CPUID Fn00000001_ECX[30]. This bit can be
> reset by clearing MSR C001_1004[62]. Any software that checks for RDRAND
> support using CPUID, including the kernel,  will believe that RDRAND is
> not supported.
> 
> Update the CPU initialization to clear the RDRAND CPUID bit for any family
> 15h and 16h processor that supports RDRAND. If it is known that the family
> 15h or family 16h system does not have an RDRAND resume issue or that the
> system will not be placed in suspend, the "rdrand_force" kernel parameter
> can be used to stop the clearing of the RDRAND CPUID bit.
> 
> Additionally, update the suspend and resume path to save and restore the
> MSR C001_1004 value to ensure that the RDRAND CPUID setting remains in
> place after resuming from suspend.
> 
> Note, that clearing the RDRAND CPUID bit does not prevent a processor
> that normally supports the RDRAND instruction from executing the RDRAND
> instruction. So any code that determined the support based on family and
> model won't #UD.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++
>  arch/x86/include/asm/msr-index.h              |  1 +
>  arch/x86/kernel/cpu/amd.c                     | 42 ++++++++++
>  arch/x86/power/cpu.c                          | 83 ++++++++++++++++---
>  4 files changed, 121 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 47d981a86e2f..f47eb33958c1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4090,6 +4090,14 @@
>  			Run specified binary instead of /init from the ramdisk,
>  			used for early userspace startup. See initrd.
>  
> +	rdrand_force	[X86]
> +			On certain AMD processors, the advertisement of the
> +			RDRAND instruction has been disabled by the kernel
> +			because of buggy BIOS support, specifically around the
> +			suspend/resume path. This option allows for overriding
> +			that decision if it is known that the BIOS support for
> +			RDRAND is not buggy on the system.
> +
>  	rdt=		[HW,X86,RDT]
>  			Turn on/off individual RDT features. List is:
>  			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 6b4fc2788078..29ae2b66b9e9 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -381,6 +381,7 @@
>  #define MSR_AMD64_PATCH_LEVEL		0x0000008b
>  #define MSR_AMD64_TSC_RATIO		0xc0000104
>  #define MSR_AMD64_NB_CFG		0xc001001f
> +#define MSR_AMD64_CPUID_FN_00000001	0xc0011004

I know the PPR has all the 0s but let's write it

MSR_AMD64_CPUID_FN_1

so that it is readable in the kernel.

>  #define MSR_AMD64_PATCH_LOADER		0xc0010020
>  #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
>  #define MSR_AMD64_OSVW_STATUS		0xc0010141
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 3afe07d602dd..86ff1464302b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -804,6 +804,40 @@ static void init_amd_ln(struct cpuinfo_x86 *c)
>  	msr_set_bit(MSR_AMD64_DE_CFG, 31);
>  }
>  
> +static bool rdrand_force;
> +
> +static int __init rdrand_force_cmdline(char *str)
> +{
> +	rdrand_force = true;
> +
> +	return 0;
> +}
> +early_param("rdrand_force", rdrand_force_cmdline);

Let's make this a more generic param:

	rdrand=force[, ...]

in case we wanna add some more opts here later.

> +
> +static void init_hide_rdrand(struct cpuinfo_x86 *c)

clear_rdrand_cpuid_bit()

is what this function does.

> +{
> +	/*
> +	 * The nordrand option can clear X86_FEATURE_RDRAND, so check for
> +	 * RDRAND support using the CPUID function directly.
> +	 */
> +	if (!(cpuid_ecx(1) & BIT(30)) || rdrand_force)
> +		return;
> +
> +	msr_clear_bit(MSR_AMD64_CPUID_FN_00000001, 62);
> +	clear_cpu_cap(c, X86_FEATURE_RDRAND);
> +	pr_info_once("hiding RDRAND via CPUID\n");

No need for that I guess - that's visible in /proc/cpuinfo.

> +}
> +
> +static void init_amd_jg(struct cpuinfo_x86 *c)
> +{
> +	/*
> +	 * Some BIOS implementations do not restore proper RDRAND support
> +	 * across suspend and resume. Check on whether to hide the RDRAND
> +	 * instruction support via CPUID.
> +	 */
> +	init_hide_rdrand(c);
> +}
> +
>  static void init_amd_bd(struct cpuinfo_x86 *c)
>  {
>  	u64 value;
> @@ -818,6 +852,13 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
>  			wrmsrl_safe(MSR_F15H_IC_CFG, value);
>  		}
>  	}
> +
> +	/*
> +	 * Some BIOS implementations do not restore proper RDRAND support
> +	 * across suspend and resume. Check on whether to hide the RDRAND
> +	 * instruction support via CPUID.
> +	 */
> +	init_hide_rdrand(c);
>  }
>  
>  static void init_amd_zn(struct cpuinfo_x86 *c)
> @@ -860,6 +901,7 @@ static void init_amd(struct cpuinfo_x86 *c)
>  	case 0x10: init_amd_gh(c); break;
>  	case 0x12: init_amd_ln(c); break;
>  	case 0x15: init_amd_bd(c); break;
> +	case 0x16: init_amd_jg(c); break;
>  	case 0x17: init_amd_zn(c); break;
>  	}
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 1c58d8982728..146c4fd90c3d 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -12,6 +12,7 @@
>  #include <linux/smp.h>
>  #include <linux/perf_event.h>
>  #include <linux/tboot.h>
> +#include <linux/dmi.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/proto.h>
> @@ -23,7 +24,7 @@
>  #include <asm/debugreg.h>
>  #include <asm/cpu.h>
>  #include <asm/mmu_context.h>
> -#include <linux/dmi.h>
> +#include <asm/cpu_device_id.h>
>  
>  #ifdef CONFIG_X86_32
>  __visible unsigned long saved_context_ebx;
> @@ -393,15 +394,14 @@ static int __init bsp_pm_check_init(void)
>  
>  core_initcall(bsp_pm_check_init);
>  
> -static int msr_init_context(const u32 *msr_id, const int total_num)
> +static int msr_build_context(const u32 *msr_id, const int num)
>  {
> -	int i = 0;
> +	struct saved_msrs *saved_msrs = &saved_context.saved_msrs;
>  	struct saved_msr *msr_array;
> +	int total_num;
> +	int i, j;
>  
> -	if (saved_context.saved_msrs.array || saved_context.saved_msrs.num > 0) {
> -		pr_err("x86/pm: MSR quirk already applied, please check your DMI match table.\n");
> -		return -EINVAL;
> -	}
> +	total_num = saved_msrs->num + num;
>  
>  	msr_array = kmalloc_array(total_num, sizeof(struct saved_msr), GFP_KERNEL);
>  	if (!msr_array) {
> @@ -409,19 +409,27 @@ static int msr_init_context(const u32 *msr_id, const int total_num)
>  		return -ENOMEM;
>  	}
>  
> -	for (i = 0; i < total_num; i++) {
> -		msr_array[i].info.msr_no	= msr_id[i];
> +	if (saved_msrs->array) {
> +		/* Copy previous MSR save requests */
> +		memcpy(msr_array, saved_msrs->array,
> +		       sizeof(struct saved_msr) * saved_msrs->num);

Why do you need to copy those? Why can't you use the infrastructure like
msr_initialize_bdw() does?

> +		kfree(saved_msrs->array);
> +	}
> +
> +	for (i = saved_msrs->num, j = 0; i < total_num; i++, j++) {
> +		msr_array[i].info.msr_no	= msr_id[j];
>  		msr_array[i].valid		= false;
>  		msr_array[i].info.reg.q		= 0;
>  	}
> -	saved_context.saved_msrs.num	= total_num;
> -	saved_context.saved_msrs.array	= msr_array;
> +	saved_msrs->num   = total_num;
> +	saved_msrs->array = msr_array;
>  
>  	return 0;
>  }
>  
>  /*
> - * The following section is a quirk framework for problematic BIOSen:
> + * The following sections are a quirk framework for problematic BIOSen:
>   * Sometimes MSRs are modified by the BIOSen after suspended to
>   * RAM, this might cause unexpected behavior after wakeup.
>   * Thus we save/restore these specified MSRs across suspend/resume
> @@ -436,7 +444,7 @@ static int msr_initialize_bdw(const struct dmi_system_id *d)
>  	u32 bdw_msr_id[] = { MSR_IA32_THERM_CONTROL };
>  
>  	pr_info("x86/pm: %s detected, MSR saving is needed during suspending.\n", d->ident);
> -	return msr_init_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
> +	return msr_build_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
>  }
>  
>  static const struct dmi_system_id msr_save_dmi_table[] = {
> @@ -451,9 +459,58 @@ static const struct dmi_system_id msr_save_dmi_table[] = {
>  	{}
>  };
>  
> +static int msr_save_cpuid_features(const struct x86_cpu_id *c)
> +{
> +	u32 cpuid_msr_id[] = {
> +		MSR_AMD64_CPUID_FN_00000001,
> +	};
> +
> +	pr_info("x86/pm: family %#hx cpu detected, MSR saving is needed during suspending.\n",
> +		c->family);
> +
> +	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
> +}
> +
> +static const struct x86_cpu_id msr_save_cpu_table[] = {
> +	{
> +		.vendor = X86_VENDOR_AMD,
> +		.family = 0x15,
> +		.model = X86_MODEL_ANY,
> +		.feature = X86_FEATURE_ANY,
> +		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
> +	},
> +	{
> +		.vendor = X86_VENDOR_AMD,
> +		.family = 0x16,
> +		.model = X86_MODEL_ANY,
> +		.feature = X86_FEATURE_ANY,
> +		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
> +	},
> +	{}

I think you can make that table a single entry by setting

	.vendor  = X86_VENDOR_AMD,
	...
	.feature = X86_FEATURE_RDRAND,

and then checking family in msr_save_cpuid_features().

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
