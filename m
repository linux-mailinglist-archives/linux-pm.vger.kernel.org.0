Return-Path: <linux-pm+bounces-22285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992AA38FD2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D203ADAF9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12DD175BF;
	Tue, 18 Feb 2025 00:00:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194F110F4;
	Tue, 18 Feb 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836839; cv=none; b=emdeOsbMHZ/A/mLVdF8dRiT/PDrRUlroarrcfX2g4XSAfdsRafImzkK383z0ZT7Gln9enDVJdWPscg9v1mNHR94QyqHmfTApY/o5sZEFasS6QOQDeXWgWEg5Psoe41ZO36t0uicPdHUO3SQhZmPkPADZ/BvZv+Ycbs94sEtsg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836839; c=relaxed/simple;
	bh=LhYlUt1QrmW2pOKW32VLRb2bw6qEuWNVn1QUgKRosZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQBd1wVfYS8HbRllhSCsmMmR3vrZVh2c+b2XAQeWEwMEdkpGDzd68CGF1O9+WGV7AqCn+2bbYZq07PgcQOoUgR2koGrlrzcruQwkBRHSnIRyULzQt6T0aH5LLrcDc7PK0kQPj5AxMnq+7OefS/ctlkvjpymHV8GBzzzYKKHcOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ACD41692;
	Mon, 17 Feb 2025 16:00:55 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C34F3F59E;
	Mon, 17 Feb 2025 16:00:30 -0800 (PST)
Date: Tue, 18 Feb 2025 01:00:20 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <Z7PNlFv2995pDARQ@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <173982791748.4020779.2848639862581042284.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173982791748.4020779.2848639862581042284.b4-ty@arm.com>

On Mon, Feb 17, 2025 at 09:32:06PM +0000, Catalin Marinas wrote:
> On Fri, 31 Jan 2025 16:24:35 +0000, Beata Michalska wrote:
> > This series adds support for obtaining an average CPU frequency based on
> > a hardware provided feedback. The average frequency is being exposed via
> > dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
> > The architecture specific bits are being provided for AArch64, caching on
> > existing implementation for FIE and AMUv1 support: the frequency scale
> > factor, updated on each sched tick, serving as a base for retrieving
> > the frequency for a given CPU, representing an average frequency
> > reported between the ticks.
> > 
> > [...]
>
Thank you for that.

There is still a (not so) small issue with patch
[3/4] arm64: Provide an AMU-based version of arch_freq_get_on_cpu.
It did not come up while testing, sadly.
No idea how I could have missed that, nor why I made the mistake
in the first place.

The fix is pretty straightforward:

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 6f0cab8e746b..4bac26d8e29c 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -268,7 +268,7 @@ int arch_freq_get_on_cpu(int cpu)
 
                        do {
                                ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
-                                                           start_cpu, false);
+                                                           start_cpu, true);

Please let me know if you want me to send new version with the fix applied.

Apologies for the inconvenience.

---
BR
Beata

> Applied to arm64 (for-next/amuv1-avg-freq), thanks!
> 
> [1/4] cpufreq: Allow arch_freq_get_on_cpu to return an error
>       https://git.kernel.org/arm64/c/38e480d4fcac
> [2/4] cpufreq: Introduce an optional cpuinfo_avg_freq sysfs entry
>       https://git.kernel.org/arm64/c/fbb4a4759b54
> [3/4] arm64: Provide an AMU-based version of arch_freq_get_on_cpu
>       https://git.kernel.org/arm64/c/dd871ac1237f
> [4/4] arm64: Update AMU-based freq scale factor on entering idle
>       https://git.kernel.org/arm64/c/96b335620c59
> 
> -- 
> Catalin
> 

