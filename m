Return-Path: <linux-pm+bounces-31678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9068B16EE0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99163A9E5D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA229CB5F;
	Thu, 31 Jul 2025 09:43:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82CD28A718;
	Thu, 31 Jul 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954985; cv=none; b=noUfzWB1a30rzPhnQb6I4gWcxL3/rtoLh5OkyyGbbeFRx9qUdbCFpDUo8a5GwmQYlEJ6lm8OjQoaI0kIN/uT9TcooXrsG+dmpW0eLE2OpPCCy/gEnO1WwKGc8ok4xWyMi0gOkM52iHCYzwk0eqWNN4/f+VgsHA0S32oKdVZcoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954985; c=relaxed/simple;
	bh=QJkSrAUetbvWvmT8qBYv6oDH48hw7mqICMLX+im+dFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNN8taDdFYRkkg4zfRQutAurHFZ2lXW1vyqgNwmdgYFu+8KNXEOJx+r+bKBPfGX11p0N1upxRu40k505jaIUDw+lYLX2ivPLRWq1o7/3dSrkNJFSq47Z5Pilt7eWGVfu4WzhcLRnX+Jj7wp+ZAwipZR5d6vVio+NX+InNmFFflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03EE1D13;
	Thu, 31 Jul 2025 02:42:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0BC3F66E;
	Thu, 31 Jul 2025 02:42:58 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:42:37 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, lihuisong@huawei.com,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
Message-ID: <aIs6d4ebRKkbz0az@arm.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com>
 <aIsnA4miO8fCJTgs@arm.com>
 <d9aefa22-9566-9db0-a95f-ab50465977f8@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9aefa22-9566-9db0-a95f-ab50465977f8@hisilicon.com>

On Thu, Jul 31, 2025 at 04:52:05PM +0800, Jie Zhan wrote:
> 
> 
> On 31/07/2025 16:19, Beata Michalska wrote:
> > Hi Bowen, Jie
> > On Wed, Jul 30, 2025 at 11:23:12AM +0800, Bowen Yu wrote:
> >> From: Jie Zhan <zhanjie9@hisilicon.com>
> >>
> >> Perf counters could be 0 if the cpu is in a low-power idle state. Just try
> >> it again next time and update the frequency scale when the cpu is active
> >> and perf counters successfully return.
> >>
> >> Also, remove the FIE source on an actual failure.
> >>
> >> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> >> ---
> >>  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> >> index 904006027df2..e95844d3d366 100644
> >> --- a/drivers/cpufreq/cppc_cpufreq.c
> >> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >> @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
> >>  	struct cppc_cpudata *cpu_data;
> >>  	unsigned long local_freq_scale;
> >>  	u64 perf;
> >> +	int ret;
> >>  
> >>  	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> >>  	cpu_data = cppc_fi->cpu_data;
> >>  
> >> -	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> >> +	ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
> >> +	/*
> >> +	 * Perf counters could be 0 if the cpu is in a low-power idle state.
> >> +	 * Just try it again next time.
> >> +	 */
> >> +	if (ret == -EFAULT)
> >> +		return;
> > Which counters are we actually talking about here ?
> 
> Delivered performance counter and reference performance counter.
> They are actually AMU CPU_CYCLES and CNT_CYCLES event counters.
That does track then.
> 
> >> +
> >> +	if (ret) {
> >>  		pr_warn("%s: failed to read perf counters\n", __func__);
> >> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC,
> >> +						 cpu_data->shared_cpu_map);
> >>  		return;
> >>  	}
> > And the real error here would be ... ?
> > That makes me wonder why this has been registered as the source of the freq
> > scale in the first place if we are to hit some serious issue. Would you be able
> > to give an example of any?
> If it gets here, that would be -ENODEV or -EIO from cppc_get_perf_ctrs(),
> which could possibly come from data corruption (no CPC descriptor) or a PCC
> failure.
> 
> I can't easily fake an error here, but the above -EFAULT path could
> happen when it luckily passes the FIE init.
> 
The change seems reasonable. Though I am wondering if some other errors might be
rather transient as well ? Like -EIO ?
Note, I'm not an expert here.

---
BR
Beata
> Jie
> > 
> > ---
> > BR
> > Beata
> >>  
> >> -- 
> >> 2.33.0
> >>
> >>
> > 

