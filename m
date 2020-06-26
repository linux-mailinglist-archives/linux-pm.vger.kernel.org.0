Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7120AE83
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFZItL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFZItL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 04:49:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28900C08C5C1;
        Fri, 26 Jun 2020 01:49:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d14000d60c73cccfe0752.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1400:d60:c73c:ccfe:752])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 702AB1EC02CF;
        Fri, 26 Jun 2020 10:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593161349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DWPH5Ela8MSgGqxoD71LBJ9URCffpI84WcbeA/yuPDc=;
        b=WJpS6K3jEL/ALZaEr52cr1zLITyiBBoxlqIRnlvxtNkqu/qJbCZlH5FZhWa62wOC2QDyKE
        XcOb8SD9oZPeF+t4+zkCW3H96nuB3hcdhvPnMQ3QZ4eEQCFV02gI0th5qQ61Vl2h0q059c
        GOOIqDgOHJ73CxP14/iQ01s5MJywKhw=
Date:   Fri, 26 Jun 2020 10:49:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [UPDATE][PATCH v3 1/2] cpufreq: intel_pstate: Allow
 enable/disable energy efficiency
Message-ID: <20200626084903.GA27151@zn.tnic>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 03:49:31PM -0700, Srinivas Pandruvada wrote:
> By default intel_pstate driver disables energy efficiency by setting
> MSR_IA32_POWER_CTL bit 19 for Kaby Lake desktop CPU model in HWP mode.
> This CPU model is also shared by Coffee Lake desktop CPUs. This allows
> these systems to reach maximum possible frequency. But this adds power
> penalty, which some customers don't want. They want some way to enable/
> disable dynamically.
> 
> So, add an additional attribute "energy_efficiency_enable" under
> /sys/devices/system/cpu/intel_pstate/ for these CPU models. This allows
> to read and write bit 19 ("Disable Energy Efficiency Optimization") in
> the MSR IA32_POWER_CTL.

Yes, this is how functionality behind MSRs should be made available to
userspace - not poking at naked MSRs. Good.

> This attribute is present in both HWP and non-HWP mode as this has an
> effect in both modes. Refer to Intel Software Developer's manual for
> details. The scope of this bit is package wide. Also these systems
> support only one package. So read/write MSR on the current CPU is
> enough.
> 
> Suggested-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v3 update
> Moved the MSR bit definition to msr-index.h from intel_pstate.c as Doug
> wanted. Offline checking with Borislav, for MSR defintion it is
> fine to move to  msr-index.h even for single user of the definition. But
> here the MSR definition is already in msr-index.h, but adding the MSR bit
> definition also.

Yes.

Btw, no need for the "offline checking" - you can do this on the mailing
list just fine.

>  Documentation/admin-guide/pm/intel_pstate.rst |  9 ++++
>  arch/x86/include/asm/msr-index.h              |  1 +
>  drivers/cpufreq/intel_pstate.c                | 47 ++++++++++++++++++-
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
> index 39d80bc29ccd..1ca2684a94d7 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -431,6 +431,15 @@ argument is passed to the kernel in the command line.
>  	supported in the current configuration, writes to this attribute will
>  	fail with an appropriate error.
>  
> +``energy_efficiency_enable``
> +	This attribute is only present on platforms, which has CPUs matching

						which have

> +	Kaby Lake or Coffee Lake desktop CPU model. By default
> +	"energy_efficiency" is disabled on these CPU models in HWP mode by this
> +	driver. Enabling energy efficiency may limit maximum operating
> +	frequency in both HWP and non HWP mode. In non HWP mode, this attribute
> +	has an effect in turbo range only. But in HWP mode, this attribute also
> +	has an effect in non turbo range.

Those last two sentences could be simplified - read strange.

> +
>  Interpretation of Policy Attributes
>  -----------------------------------
>  
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e8370e64a155..fec86ad14f8d 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -254,6 +254,7 @@
>  #define MSR_PEBS_FRONTEND		0x000003f7
>  
>  #define MSR_IA32_POWER_CTL		0x000001fc
> +#define MSR_IA32_POWER_CTL_BIT_EE	19

Sort that MSR in - I know, the rest is not sorted either but we can
start somewhere. So pls put it...

#define MSR_LBR_SELECT                  0x000001c8
#define MSR_LBR_TOS                     0x000001c9

<--- here.

#define MSR_LBR_NHM_FROM                0x00000680
#define MSR_LBR_NHM_TO                  0x000006c0


>  #define MSR_IA32_MC0_CTL		0x00000400
>  #define MSR_IA32_MC0_STATUS		0x00000401
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8e23a698ce04..daa1d9c12098 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1218,6 +1218,42 @@ static ssize_t store_hwp_dynamic_boost(struct kobject *a,
>  	return count;
>  }
>  
> +static ssize_t show_energy_efficiency_enable(struct kobject *kobj,
> +					     struct kobj_attribute *attr,
> +					     char *buf)
> +{
> +	u64 power_ctl;
> +	int enable;
> +
> +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> +	enable = (power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE)) >> MSR_IA32_POWER_CTL_BIT_EE;

So you can simplify to:

	enable = !!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE));

methinks.

> +	return sprintf(buf, "%d\n", !enable);

If this bit is called

	"Disable Energy Efficiency Optimization"

why do you call your function and sysfs file "enable"? This is making it
more confusing.

Why don't you call it simply: "energy_efficiency" and have it intuitive:

1 - enabled
0 - disabled

?

> +static ssize_t store_energy_efficiency_enable(struct kobject *a,
> +					      struct kobj_attribute *b,
> +					      const char *buf, size_t count)
> +{
> +	u64 power_ctl;
> +	u32 input;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &input);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&intel_pstate_driver_lock);
> +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> +	if (input)

This is too lax - it will be enabled for any !0 value. Please accept
only 0 and 1.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
