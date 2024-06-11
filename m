Return-Path: <linux-pm+bounces-8927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972E903738
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A072528C182
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18217625E;
	Tue, 11 Jun 2024 08:54:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56654176252;
	Tue, 11 Jun 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096088; cv=none; b=OmtRku4fhOVVCnitXLRPS7XrF/L+5k5VK2CKbtCFU1xeHvronC05bYtLsxm4IWxDNLeMrQrLJo3/DMOMk7p7v2nEl0cy1bdeVs+CaGleHMfTo6nsXI7/KrRXLfdRIiAepuZ82SvLLhURLQFcDJfiI51rtO7x0tH8J97hY5OE3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096088; c=relaxed/simple;
	bh=o3eB7wJEdm3DUYd/p49zXlEgGiySZyZUDXG+2U4oMv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/+6Yqcmi85oz2N/0yjKHSZCme/xsBZfxm4p0kYeNSQQg3qjxql7BcXupxlv1ZfqFtcOehjMJlH1CO0CVAaU/jyIZulXlu2A76kgMEKz2uehG0Xre5JZmuQfmrU+NeadBhbw0eV4rmKeXfLu4hMpVecI7fkhNlzyXNMCYrRBH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F13BA152B;
	Tue, 11 Jun 2024 01:55:09 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA183F5A1;
	Tue, 11 Jun 2024 01:54:45 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:54:43 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Riwen Lu <luriwen@hotmail.com>, beata.michalska@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, hotran@apm.com,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <ZmgQ06jtJBPh5wat@arm.com>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240606090737.z3qenphikjs5ijj4@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090737.z3qenphikjs5ijj4@vireshk-i7>

Hey,

On Thursday 06 Jun 2024 at 14:37:37 (+0530), Viresh Kumar wrote:
> Ionela, Beata,
> 
> On 30-05-24, 19:08, Riwen Lu wrote:
> > From: Riwen Lu <luriwen@kylinos.cn>
> > 
> > There is a case that desired_perf is exactly the same with the old perf,
> > but the actual current freq is not.
> > 
> > This happened in S3 while the cpufreq governor is set to powersave.
> > During cpufreq resume process, the booting CPU's new_freq obtained via
> > .get() is the highest frequency, while the policy->cur and
> > cpu->perf_ctrls.desired_perf are in the lowest level(powersave
> > governor). Causing the warning: "CPU frequency out of sync:", and set
> > policy->cur to new_freq. Then the governor->limits() calls
> > cppc_cpufreq_set_target() to configures the CPU frequency and returns
> > directly because the desired_perf converted from target_freq is the
> > same with cpu->perf_ctrls.desired_perf and both are the lowest_perf.
> > Since target_freq and policy->cur have been compared in
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	  [note] below

> > __cpufreq_driver_target(), there's no need to compare desired_perf
> > and cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target()
> > to ensure that the CPU frequency is properly configured.
> > 
> > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> > 
> > ---
> > v1 -> v2:
> >  - Update commit message and email.
> > v2 -> v3:
> >  - Update patch subject and commit message.
> >  - Remove the desired_perf compare logic.
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 15f1d41920a3..337cece61ab5 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -295,9 +295,6 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
> >  	int ret = 0;
> >  
> >  	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
> > -	/* Return if it is exactly the same perf */
> > -	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
> > -		return ret;
> >  
> >  	cpu_data->perf_ctrls.desired_perf = desired_perf;
> >  	freqs.old = policy->cur;
> 
> Any objections to this change ?

It's alright with me.

Some "nits":
 - the "desired_perf" local variable could be removed in this case.

 - [note] while this change helps, we'd still need policy->cur to always
   have the latest request value (see details at [1]) for this check to
   be made obsolete by the comparison between target_freq and policy->cur,
   as mentioned in the commit message. But this is/can be a separate
   matter.

   [1] https://lore.kernel.org/lkml/ZmB1qKucR5fXk100@arm.com/

Thanks,
Ionela.

> 
> -- 
> viresh

