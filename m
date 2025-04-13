Return-Path: <linux-pm+bounces-25331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59395A8723B
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A27A7633
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804C61C84DD;
	Sun, 13 Apr 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTv0EwJL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F91C1F21;
	Sun, 13 Apr 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744555499; cv=none; b=SNvTYb00oa9rdsmD7wQCSpbANM1UXK4RT1EKG1BjDCq8Fxk7/16KdT/ZznG2NOu7gDlhKye1a7BCQ4409oNyqSFMpFeo7za5ah8A279ZcPLXkDj/8DF/AYyZScl6yxHVjgSxHQo6nyZRrZtSWVjG+Gj4froW8+gUMsOQXKqtdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744555499; c=relaxed/simple;
	bh=aJWz1QDvLinhEs6itBhA0RHzGTs8f6L+aT6P1LOOut8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ss4nBWHsWLoqG6J5p4MlyybznwhjuRS4kc8MNKuGOsC+j8yCG73ouUBeWM1nn4/XawF8CsQ9Tm6/PZI/PyNUYsRe/2hK9rYqRol9nDlpsudCKbjVZRV0TunJb6DsY0aT7Rm+4KU+Yj3DFeNV9zXY5O8+KLtbhnwChAkdP48liOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTv0EwJL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744555499; x=1776091499;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aJWz1QDvLinhEs6itBhA0RHzGTs8f6L+aT6P1LOOut8=;
  b=aTv0EwJLcM8oKpfp+hLuLPGsm37EfGJtE1l2wE7COHooMXqNxIZ0v9c2
   w0U6Bo2yaZ22dTxJshOVl3VM6xnSSuM5OiZwuxGe851xGguXsit715Zhk
   4+hbBVdJIdo7xMh0u+ldkBZBqmF8qk5mypmfUpElo4jHU6eWQBOel2ztB
   389zL8G+xrPmhR4EW79fPjNUo1xIRSR/DjLA0jhb0RdSgSQTcwOz/86pA
   umplq6kyMiDbnBftsaEOLAKmD01mMvSmAbTsP5pkdspj3irba2Boa/gog
   iCuFb25h2xVoMdddlHfZvELZs4mCvGV8WyvyOWTSU0r9v0K5IsZH3uQQI
   A==;
X-CSE-ConnectionGUID: 8B1ZHo6xS8mrRdFs41Xp1w==
X-CSE-MsgGUID: Xs4+6GHqT82j9xnA9X6GMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45742740"
X-IronPort-AV: E=Sophos;i="6.15,210,1739865600"; 
   d="scan'208";a="45742740"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 07:44:58 -0700
X-CSE-ConnectionGUID: 6OnYtDAmT/CaghxEm3Zoxg==
X-CSE-MsgGUID: Hwr+u6p/SRGmn21JzaBj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,210,1739865600"; 
   d="scan'208";a="160565674"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.108.247])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 07:44:57 -0700
Message-ID: <b7b0b3f98f8fad9cc9559e1c4ce832387c520d7a.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use raw_smp_processor_id() in
 hwp_get_cpu_scaling()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>,
  Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 13 Apr 2025 07:44:56 -0700
In-Reply-To: <20250412103434.5321-1-xry111@xry111.site>
References: <20250412103434.5321-1-xry111@xry111.site>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-04-12 at 18:34 +0800, Xi Ruoyao wrote:
> Use raw_smp_processor_id() instead of plain smp_processor_id() in
> hwp_get_cpu_scaling(), otherwise we get some errors on a Lenovo
> Thinkpad
> T14P Gen 2:
>=20
> =C2=A0=C2=A0=C2=A0 BUG: using smp_processor_id() in preemptible [00000000=
] code:
> swapper/0/1
> =C2=A0=C2=A0=C2=A0 caller is hwp_get_cpu_scaling+0x7f/0xc0
>=20
> Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> cpu-type")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 4aad79d26c64..bfc20b978240 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2209,7 +2209,7 @@ static int knl_get_turbo_pstate(int cpu)
> =C2=A0static int hwp_get_cpu_scaling(int cpu)
> =C2=A0{
> =C2=A0	if (hybrid_scaling_factor) {
> -		struct cpuinfo_x86 *c =3D
> &cpu_data(smp_processor_id());
> +		struct cpuinfo_x86 *c =3D
> &cpu_data(raw_smp_processor_id());
> =C2=A0		u8 cpu_type =3D c->topo.intel_type;
> =C2=A0
> =C2=A0		/*


