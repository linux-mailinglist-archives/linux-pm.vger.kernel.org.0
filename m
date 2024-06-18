Return-Path: <linux-pm+bounces-9425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423CD90C95E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE08A1F2284C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824215FA6A;
	Tue, 18 Jun 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9YeCMUs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554B15FA65;
	Tue, 18 Jun 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706314; cv=none; b=RC8HfxmD6/0ax1tif6JhDwMBW0g5BUycyoFuNgW/9QaQ13OKb1hFtiXBYpjSlC1vYYZoF5US5aYY1zXW09JMNwBVatu+K00iMpjdgZ19BZMcZc6bvDX1vVCyEmjOPoSVSOd30eT1wF1eMYA1I4sVWZ+JuA4KHOzoJk9Sm/Hfsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706314; c=relaxed/simple;
	bh=2ehapgBU81X3oy08t/DrCvRpXo7vy6FO7su109skvUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGN+VuKVAETE/xyYLZMdJt3fQcPG0Bfm78PByQGOCFbpKGsqvsth/W67hIdfidgNkuFHxXVB4dvE3Cd95PR79KMfIAQZ2/0YPE+cI9LLxZ5BlT64mstgBc58uu8GM3W/jukkfFqN0tIv4fhz7UKqTBCnb5LaQ2qpMt4D/c4MOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9YeCMUs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718706314; x=1750242314;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2ehapgBU81X3oy08t/DrCvRpXo7vy6FO7su109skvUo=;
  b=U9YeCMUsT037jF+qTb3mqsuT2NmHd5TGojcw8IhRv0ZmYHa5PHc7XwoG
   t4t6jOFoeoeNq3PIWKV6tLJeXc9xHlRi/HPvtp6epDz7pvVKeEP2sVeNJ
   iMBuRWwZtwgCltWMzOQL5o2cG7PbKKkSfXnmvhLBJbRiuUVZeMbFhu4yE
   motwtd/dqgyaOLFi4dnnoaKRmzbRecaUrxNWSE+H4yoqqRAdygRF6Yl8g
   3IWqlGU+Urg8Suc0cuc3bhufG1UsPR5S91ir6Qfnj4DNWHF2p2xCOD8gT
   YKwZbQq8+SdIslLBucNXUBbzv8NFPmj1UiU4+UCliyY0svr25XJnT2pDH
   g==;
X-CSE-ConnectionGUID: /vGcGX3oRhK/kgCQkSu3kg==
X-CSE-MsgGUID: vllrdASbTCG+qjpyaok1zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="33108928"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33108928"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:25:13 -0700
X-CSE-ConnectionGUID: f9YfFLNzRMGV61HPjWbg3Q==
X-CSE-MsgGUID: HNbHw4RETGqg6MLlgwgP4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41600527"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:25:12 -0700
Message-ID: <087eb35754ddd8dde74c55ac7783fe42f48b7f82.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add HWP highest perf change
 feature flag
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Date: Tue, 18 Jun 2024 03:25:11 -0700
In-Reply-To: <20240618090739.GAZnFOW6FRwcE5EkQI@fat_crate.local>
References: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
	 <20240618035122.438822-2-srinivas.pandruvada@linux.intel.com>
	 <20240618090739.GAZnFOW6FRwcE5EkQI@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 11:07 +0200, Borislav Petkov wrote:
> On Mon, Jun 17, 2024 at 08:51:20PM -0700, Srinivas Pandruvada wrote:
> > When CPUID[6].EAX[15] is set to 1, this CPU supports notification
> > for
> > HWP (Hardware P-states) highest performance change.
> >=20
> > Add a feature flag to check if the CPU supports HWP highest
> > performance
> > change.
> >=20
> >=20

[...]

> > +#define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP
> > Highest perf change */
>=20
> Doesn't belong in /proc/cpuinfo:
>=20
> #define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* "" HWP
> Highest perf change */
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^^

Thanks for pointing this out. Will update in v2.

-Srinivas

>=20
>=20


