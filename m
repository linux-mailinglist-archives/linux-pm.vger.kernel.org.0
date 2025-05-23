Return-Path: <linux-pm+bounces-27544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9FAC1AF3
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 06:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B6C1BC36EA
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 04:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8B221F25;
	Fri, 23 May 2025 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="acRWXqCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621492DCBEE;
	Fri, 23 May 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747974358; cv=none; b=Gzdip6E7DrYHZlCPXz55/Aez+zW0PSguFQ5z22zuBMaKoFt9zwsQpd4fqZXe+KOKvqUczr5IWUTizxJgZZnd8TusFJ6etmfBeV7n2CuxbclYMbF4DtBIt6NxX7WApiXK1RY8oeNi8qYOoue/XhOdZMZPh7ED9MhmfwWXsweIq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747974358; c=relaxed/simple;
	bh=BzdyDwDeJv2F5cDzsWzhnvqe+JoeKHLuUefOZkQJHIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iswoc3KfNLWGrNcw/pnP903I+B+eF3CawRmY1U43jRTU9AjmYVjXPi+3k10Ihnft7IbxhySVzqjP2bimit7iV8A6fDjwcJ+78GWmbcDGw1BpEgg+i3EsUDrn6Wjdv78rZX1Qf5EfDh7YHyC2ca3eUTqueVnsUwWjBoaLKOGmboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=acRWXqCT; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747974356; x=1779510356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gar/FB2757pqFBaQ0cGxeTWivVdQr0YcZQ+QVR8jFjk=;
  b=acRWXqCTvNAyyD66Fv1Ln+kGhiWuCNJVBjy7ngGgRvC4BYuMlfWcLnSg
   p10ti+1Jp7NUZlmn2yt1UArcIapTPGtjuBT/8cqnVqhY65U6Gf8EXLezM
   NrZxEPUcm4xUJOCO87jVb4IzH19KQoXSunT5fMeXkL3q7coye9DVNEfEk
   RjkU8rtSWCyPhNW/mVVupYSDQRfSkaMUZxtlYxJyVSb63Y3PCq10OcbJN
   FTTz3p+wVnP/SV0kt63LgtYi4xTQ2agejySOUrmOOr3dGjo7FBzwZm7M9
   GblIsJUq7p1r8q1zM5cchxlDbsAfFO0rmJw0eSnIQpODWyP1ng6lgF2s/
   g==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 13:25:47 +0900
X-IronPort-AV: E=Sophos;i="6.15,307,1739804400"; 
   d="scan'208";a="562996545"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 13:25:48 +0900
Date: Fri, 23 May 2025 13:25:44 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Russell Haley <yumpusamongus@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
Message-ID: <aC_4yLsFVVszI_FA@JPC00244420>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
 <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>

Hi Russell,

On Thu, May 22, 2025 at 06:15:24AM -0500, Russell Haley wrote:
> > The userspace governor requests a frequency between policy->min and
> > policy->max on behalf of user space.  In intel_pstate this translates
> > to setting DESIRED_PERF to the requested value which is also the case
> > for the other governors.
> 
> Huh.  On this Skylake box with kernel 6.14.6, it seems to be setting
> Minimum_Performance, and leaving desired at 0.
> 
> > echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> userspace
> > echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_setspeed
> 1400000
> > sudo x86_energy_perf_policy &| grep REQ
> cpu0: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0

Oh cool, I didn't know about x86_energy_perf_policy.

Consider the following on a Raptor Lake machine:

1. HWP_REQUEST MSR set by intel_pstate in active mode:

	# echo active > intel_pstate/status
	# x86_energy_perf_policy -c 0 2>&1 | grep REQ
	cpu0: HWP_REQ: min 11 max 68 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
	pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
	# echo 2000000 > cpufreq/policy0/scaling_min_freq 
	# echo 3000000 > cpufreq/policy0/scaling_max_freq 
	# x86_energy_perf_policy -c 0 2>&1 | grep REQ
	cpu0: HWP_REQ: min 26 max 39 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
	pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)

	scaling_{min,max}_freq just affect the min and max frequencies
	set in HWP_REQEST. desired_freq is left at 0.

2. HWP_REQUEST MSR set by intel_pstate in passive mode with userspace
governor:

	# echo passive > intel_pstate/status
	# echo userspace > cpufreq/policy0/scaling_governor 
	# cat cpufreq/policy0/scaling_setspeed 
	866151
	# x86_energy_perf_policy -c 0 2>&1 | grep REQ
	cpu0: HWP_REQ: min 11 max 68 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
	pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
	# echo 2000000 > cpufreq/policy0/scaling_setspeed 
	# x86_energy_perf_policy -c 0 2>&1 | grep REQ
	cpu0: HWP_REQ: min 26 max 68 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
	pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)

	scaling_setspeed only changes the min frequency in HWP_REQUEST.
	Meaning, software is explicitly allowing the hardware to choose
	higher frequencies.

3. Same as above, except with strictuserspace governor, which is a
custom kernel module which is exactly the same as the userspace
governor, except it has the CPUFREQ_GOV_STRICT_TARGET flag set:

	# echo strictuserspace > cpufreq/policy0/scaling_governor 
	# x86_energy_perf_policy -c 0 2>&1 | grep REQ
	cpu0: HWP_REQ: min 26 max 26 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
	pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
	# echo 3000000 > cpufreq/policy0/scaling_setspeed 
	# x86_energy_perf_policy -c 0 2>&1 | grep REQ
	cpu0: HWP_REQ: min 39 max 39 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
	pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)

	With the strict flag set, intel_pstate honours this by setting
	the min and max freq same.

desired_perf is always 0 in the above cases. The strict flag check is done in
intel_cpufreq_update_pstate, which sets max_pstate to target_pstate if policy
has strict target, and cpu->max_perf_ratio otherwise.

As Russell and Rafael have noted, CPU frequency is subject to hardware
coordination and optimizations. While I get that, shouldn't software try
its best with whatever interface it has available? If a user sets the
userspace governor, that's because they want to have manual control over
CPU frequency, for whatever reason. The kernel should honor this by
setting the min and max freq in HWP_REQUEST equal. The current behaviour
explicitly lets the hardware choose higher frequencies.

Since Russell pointed out that the "actual freq >= target freq" can be
achieved by leaving intel_pstate active and setting scaling_{min,max}_freq
instead (for some reason this slipped my mind), I now think the strict target
flag should be added to the userspace governor, leaving the documentation as
is. Maybe a warning like "you may want to set this exact frequency, but it's
subject to hardware coordination, so beware" can be added.

Thanks

Regards,
Shashank

