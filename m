Return-Path: <linux-pm+bounces-27677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F06BAC4A14
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 10:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2496318914B3
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661F22578C;
	Tue, 27 May 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="stlnoo5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EA24A05D;
	Tue, 27 May 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334122; cv=none; b=n8DuOtYecT7i5JDpUQKH/Icl/kdgzSJ3KKM4c3M2TJNjrfaNlwrvZ/XttpiwAYDrLlkTGC6iRpKC79iG2R7nmL9XKh5WiGTKJ69sPXS/Fek1rlMDg/SiqlHmJHisPIsLW8VkgQf0qO6tHGL//MDp9lqey9eKrc+vyfgE3j0DFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334122; c=relaxed/simple;
	bh=bP3dyqOcdjmeMKsrJgqUZ/tHl2pKyc9vebW0MO1p2XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnglORna58TQlJA8zozGCx9FC18b8u82P/emt2EBjX/U/em1gCiYYLmZI9J4LPRdPVcGakOfc+a49YZrzxJ8A5qew3v55LAUyNbURQQTdUIm+WFz2IJZKI2+OBvk9e0jpFDA6nf54hyNQCv/kpsktQS4PhS06uPawRbNR7hRJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=stlnoo5u; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748334120; x=1779870120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9M+aGmHypwA8Qm6h86CMR5EaNs6NIldl3+8PV51EqcA=;
  b=stlnoo5uuK0XzPZUwyTV450Kw73uW69bqDF9IuiQmPxYdeSC2tETbmP6
   tpH7M1ODe2/wiBRfemWWeJ/LEGpbcD5V4xeGWM2JP08fnNWTl8bAFQzG5
   VXQmcDNpL2gdMm5DLfpUr/uol/pYZ52BF/1+cxaBStlofM7Jh8YMl63nj
   M1pcv6+ZCcJoM3cEvWvFSbyKvz+k03G63eYxzE2HjclPD+q7vdxY7QdU4
   8y9TsI7G2UKWLutQ7Q3w2euJN3c/G8pDN2lGO7vS1U3iS4GPDiNdpM6aA
   9yBJ6H36rfBYjdmjGr3tQPud+BEBbJGbfUodmbx42FAZ60Z33cwxLZMwz
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 17:21:53 +0900
X-IronPort-AV: E=Sophos;i="6.15,317,1739804400"; 
   d="scan'208";a="534528132"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 17:21:52 +0900
Date: Tue, 27 May 2025 17:21:48 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell Haley <yumpusamongus@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
Message-ID: <aDV2HPfybqnbzJ9N@JPC00244420>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
 <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>
 <aC_4yLsFVVszI_FA@JPC00244420>
 <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com>

Hi Rafael,

On Fri, May 23, 2025 at 09:06:04PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 23, 2025 at 6:25 AM Shashank Balaji
> <shashank.mahadasyam@sony.com> wrote:
> > ...
> > Consider the following on a Raptor Lake machine:
> > ...
> >
> > 3. Same as above, except with strictuserspace governor, which is a
> > custom kernel module which is exactly the same as the userspace
> > governor, except it has the CPUFREQ_GOV_STRICT_TARGET flag set:
> >
> >         # echo strictuserspace > cpufreq/policy0/scaling_governor
> >         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
> >         cpu0: HWP_REQ: min 26 max 26 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
> >         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
> >         # echo 3000000 > cpufreq/policy0/scaling_setspeed
> >         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
> >         cpu0: HWP_REQ: min 39 max 39 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
> >         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*10^0us)
> >
> >         With the strict flag set, intel_pstate honours this by setting
> >         the min and max freq same.
> >
> > desired_perf is always 0 in the above cases. The strict flag check is done in
> > intel_cpufreq_update_pstate, which sets max_pstate to target_pstate if policy
> > has strict target, and cpu->max_perf_ratio otherwise.
> >
> > As Russell and Rafael have noted, CPU frequency is subject to hardware
> > coordination and optimizations. While I get that, shouldn't software try
> > its best with whatever interface it has available? If a user sets the
> > userspace governor, that's because they want to have manual control over
> > CPU frequency, for whatever reason. The kernel should honor this by
> > setting the min and max freq in HWP_REQUEST equal. The current behaviour
> > explicitly lets the hardware choose higher frequencies.
> 
> Well, the userspace governor ends up calling the same function,
> intel_cpufreq_target(), as other cpufreq governors except for
> schedutil.  This function needs to work for all of them and for some
> of them setting HWP_MIN_PERF to the same value as HWP_MAX_PERF would
> be too strict.  HWP_DESIRED_PERF can be set to the same value as
> HWP_MIN_PERF, though (please see the attached patch).
> 
> > Since Russell pointed out that the "actual freq >= target freq" can be
> > achieved by leaving intel_pstate active and setting scaling_{min,max}_freq
> > instead (for some reason this slipped my mind), I now think the strict target
> > flag should be added to the userspace governor, leaving the documentation as
> > is. Maybe a warning like "you may want to set this exact frequency, but it's
> > subject to hardware coordination, so beware" can be added.
> 
> If you expect the userspace governor to set the frequency exactly
> (module HW coordination), that's the only way to make it do so without
> potentially affecting the other governors.

I don't mean to say that intel_cpufreq_target() should be modified. I'm
suggesting that the CPUFREQ_GOV_STRICT_TARGET flag be added to the
userspace governor. That'll ensure that HWP_MIN_PERF and
HWP_MAX_PERF are set to the target frequency. intel_cpufreq_target()
already correctly deals with the strict target flag. To test this, I
registered a custom governor, same as the userspace governor, except
with the strict target flag set. Please see case 3 above.

If this flag is added to the userspace governor, then whatever the
documentation says right now will actually be true. No need to modify
the documentation then.

Regards,
Shashank

