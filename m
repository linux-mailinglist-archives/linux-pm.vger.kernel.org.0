Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265185A59EE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiH3D2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Aug 2022 23:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiH3D1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 23:27:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45EA7219
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 20:27:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z187so10070189pfb.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 20:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=McuXcOgRlIT69jbtsKdNiVloP2lEB4pZKRYZsVxXQoQ=;
        b=zFr1/S5oRfcKoHS1Lgf6cTntybtW9AIh1OHLiFFkKp4yGZPCv57suQINkIcq4fZCbh
         FwNaDtZ1opvQlapaJxnDAchvx8GCHrlV3zwKzk63kjwxp/0CwRjyIrLUUUD7dsqWbTLP
         x7j6FuLFoEyzTxDi7+mqidf04orpSOc0g5U6e/A5FVeagu16Fy4Ukg5baiTE4KBgMAnc
         zwAWUEn5RvxPN/WDMEX+801UKfP6V53plY58hitr81BWuKr5P7Phs5+vxv4XVUP7LILc
         SWzWWdVoDVHWJy256jgruVDWxP5Ezi+LlRSSjgKDaBaQ59Cvb2GvtBafu5S38pe25cDB
         OkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=McuXcOgRlIT69jbtsKdNiVloP2lEB4pZKRYZsVxXQoQ=;
        b=Ucy3mCNLRbx5OiSLJS9L0+9U8ZDNjDYsa6qu7046MOiUSayZn1R7R06T0Iz+v2BdEs
         Xl18SQjw4stq6Y6u9cmD1Ua+e2FXo1T+PF++0RUTkiVEBVBlQbS9DhCyh/jSe3R1owcm
         qSIz2jMRxj1DvM2cXgpD0SKuhU+Iz3YixXt3YdDwuWRzacrmuqOX6HrUVAV6Ty5DA0U7
         H3uLRq4CrIedPyyd7Yn82AEM/8BD0cU2EX8Y8bSXwuZV5jqdTP2Xb/Q+i2ff7I/2EjEw
         01L/D48n5zSJ1UzhNCOlc7pPa3wZCNCqzrz0tz8k6qJQ8Ha6GYCmpgUwO3arG3iJJG7P
         6Dig==
X-Gm-Message-State: ACgBeo3bnBngsXxMkh1GVQHVQdUV/YuqiDKEofuq+5+ZFh+MyCk6r1+V
        jLV8pX7xMhsH5NW893TYoikQgGIDXBG4Ug==
X-Google-Smtp-Source: AA6agR73e0QiuRwvysMfySjmFUqjEBga3EdkZnzq6VbKU2f++ujIAWqktXqsqavXCzU2qhgTQWDLBQ==
X-Received: by 2002:a63:e07:0:b0:429:8604:d9ad with SMTP id d7-20020a630e07000000b004298604d9admr16142796pgl.586.1661830062332;
        Mon, 29 Aug 2022 20:27:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902ca0100b00174be817124sm3494843pld.221.2022.08.29.20.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 20:27:41 -0700 (PDT)
Date:   Tue, 30 Aug 2022 08:57:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, vincent.guittot@linaro.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.or,
        lenb@kernel.org, robert.moore@intel.com,
        punit.agrawal@bytedance.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-kernel@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Message-ID: <20220830032739.m4jw2tcjrdmxvid7@vireshk-i7>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-2-jeremy.linton@arm.com>
 <59f3ba6f-b657-2da2-cb2a-9736e1488908@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f3ba6f-b657-2da2-cb2a-9736e1488908@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Vincent.

On 24-08-22, 15:41, Lukasz Luba wrote:
> Hi Jeremy,
> 
> +CC Dietmar, Morten and Souvik
> 
> On 8/18/22 22:16, Jeremy Linton wrote:
> > PCC regions utilize a mailbox to set/retrieve register values used by
> > the CPPC code. This is fine as long as the operations are
> > infrequent. With the FIE code enabled though the overhead can range
> > from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> > based machines.
> > 
> > So, before enabling FIE assure none of the registers used by
> > cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
> > enable a module parameter which can also disable it at boot or module
> > reload.
> > 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
> >   drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
> >   include/acpi/cppc_acpi.h       |  5 +++++
> >   3 files changed, 73 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 1e15a9f25ae9..c840bf606b30 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1240,6 +1240,47 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> >   }
> >   EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
> > +/**
> > + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
> > + *
> > + * CPPC has flexibility about how counters describing CPU perf are delivered.
> > + * One of the choices is PCC regions, which can have a high access latency. This
> > + * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
> > + *
> > + * Return: true if any of the counters are in PCC regions, false otherwise
> > + */
> > +bool cppc_perf_ctrs_in_pcc(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_present_cpu(cpu) {
> > +		struct cpc_register_resource *ref_perf_reg;
> > +		struct cpc_desc *cpc_desc;
> > +
> > +		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > +
> > +		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> > +		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> > +		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> > +			return true;
> > +
> > +
> > +		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> > +
> > +		/*
> > +		 * If reference perf register is not supported then we should
> > +		 * use the nominal perf value
> > +		 */
> > +		if (!CPC_SUPPORTED(ref_perf_reg))
> > +			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> > +
> > +		if (CPC_IN_PCC(ref_perf_reg))
> > +			return true;
> > +	}
> 
> Do we have a platform which returns false here?
> 
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> > +
> >   /**
> >    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
> >    * @cpunum: CPU from which to read counters.
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 24eaf0ec344d..32fcb0bf74a4 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] = {
> >   static struct cpufreq_driver cppc_cpufreq_driver;
> > +static enum {
> > +	FIE_UNSET = -1,
> > +	FIE_ENABLED,
> > +	FIE_DISABLED
> > +} fie_disabled = FIE_UNSET;
> > +
> >   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> > +module_param(fie_disabled, int, 0444);
> > +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
> 
> Why we need the modules support?
> I would drop this, since the fie_disabled would be set properly when
> needed. The code would be cleaner (more below).
> 
> >   /* Frequency invariance support */
> >   struct cppc_freq_invariance {
> > @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> >   	struct cppc_freq_invariance *cppc_fi;
> >   	int cpu, ret;
> > -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +	if (fie_disabled)
> >   		return;
> >   	for_each_cpu(cpu, policy->cpus) {
> > @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> >   	struct cppc_freq_invariance *cppc_fi;
> >   	int cpu;
> > -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +	if (fie_disabled)
> >   		return;
> >   	/* policy->cpus will be empty here, use related_cpus instead */
> > @@ -229,7 +237,21 @@ static void __init cppc_freq_invariance_init(void)
> >   	};
> >   	int ret;
> > -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +	switch (fie_disabled) {
> > +	/* honor user request */
> > +	case FIE_DISABLED:
> > +	case FIE_ENABLED:
> 
> This module's over-write doesn't look 'clean'.
> Is it OK to allow a user to go with the poor performing
> system (likely on many platforms)? Or we assume that there are
> platforms which has a bit faster mailboxes and they already
> have the FIE issue impacting task's utilization measurements.
> 
> It looks like we are not sure about the solution. On one hand
> we implement those checks in the cppc_perf_ctrs_in_pcc()
> which could set the flag, but on the other hand we allow user
> to decide. IMO this creates diversity that we are not able to control.
> It creates another tunable knob in the kernel, which then is forgotten
> to check.
> 
> I still haven't seen information that the old FIE was an issue on those
> servers and had impact on task utilization measurements. This should be
> a main requirement for this new feature. This would be after we proved
> that the utilization problem was due to the FIE and not something else (like
> uArch variation or workload variation).
> 
> IMO let's revert the ACPI_CPPC_CPUFREQ_FIE. When we get data that
> FIE is an issue on those servers we can come back to this topic.
> 
> Regards,
> Lukasz

-- 
viresh
