Return-Path: <linux-pm+bounces-22293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81609A396CE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB65188D6D5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68F230270;
	Tue, 18 Feb 2025 09:18:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD922FF55;
	Tue, 18 Feb 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870305; cv=none; b=dxut68Kv88Z/Eon1OAYWEdBHrwXFR9k2KCEVWFg0/3ftrfgluIkj5p/zBPrpeAis+lqQQipDpBmOvrIAXvIdiRe/VvJyneYZq+MLHAHDHM1zCl416GfXMTJeqjUQPt+bsVkay6zhbhl91fB6R9yExU6MA48QKgJGiy+OQSl3rbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870305; c=relaxed/simple;
	bh=vfuQjd/8LgaGZuh/Qvb8dlDpyh9HdnmRmMB5nk3IgHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrKkviiJmhZXMKJ46i2dXozrLr3pmGLCy5J7m31eWHcMQg7j8c2wJAFwm0CZfg1V67gIhwmptm6AyAB53CGk0j0wJvG8s8lgTYIbnhzpdpu3NGLw2//506A7IbPixw54dUZhoLNaqtj+GekYrjYy2lLXhx4uoK57cF4xBayHzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC84C4CEE4;
	Tue, 18 Feb 2025 09:18:20 +0000 (UTC)
Date: Tue, 18 Feb 2025 09:18:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com, zhanjie9@hisilicon.com,
	ptsm@linux.microsoft.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 0/4] Add support for AArch64 AMUv1-based average freq
Message-ID: <Z7RQWgLksl4bBksr@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <173982791748.4020779.2848639862581042284.b4-ty@arm.com>
 <Z7PNlFv2995pDARQ@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7PNlFv2995pDARQ@arm.com>

On Tue, Feb 18, 2025 at 01:00:20AM +0100, Beata Michalska wrote:
> On Mon, Feb 17, 2025 at 09:32:06PM +0000, Catalin Marinas wrote:
> > On Fri, 31 Jan 2025 16:24:35 +0000, Beata Michalska wrote:
> > > This series adds support for obtaining an average CPU frequency based on
> > > a hardware provided feedback. The average frequency is being exposed via
> > > dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
> > > The architecture specific bits are being provided for AArch64, caching on
> > > existing implementation for FIE and AMUv1 support: the frequency scale
> > > factor, updated on each sched tick, serving as a base for retrieving
> > > the frequency for a given CPU, representing an average frequency
> > > reported between the ticks.
> > > 
> > > [...]
> >
> Thank you for that.
> 
> There is still a (not so) small issue with patch
> [3/4] arm64: Provide an AMU-based version of arch_freq_get_on_cpu.
> It did not come up while testing, sadly.
> No idea how I could have missed that, nor why I made the mistake
> in the first place.
> 
> The fix is pretty straightforward:
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 6f0cab8e746b..4bac26d8e29c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -268,7 +268,7 @@ int arch_freq_get_on_cpu(int cpu)
>  
>                         do {
>                                 ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
> -                                                           start_cpu, false);
> +                                                           start_cpu, true);
> 
> Please let me know if you want me to send new version with the fix applied.

Usually we apply another patch on top with a Fixes tag or just fold it
in if no-one relies on this branch being stable. I'll do the latter, no
need to resend.

Thanks.

-- 
Catalin

