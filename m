Return-Path: <linux-pm+bounces-26508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7530BAA6230
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF21BC7B08
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7F225417;
	Thu,  1 May 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laA0+eyi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C47224B0F;
	Thu,  1 May 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119585; cv=none; b=SsAMxnIF93po3ruKl6NGqKP33wRJkC1dx79fMaCccpU1COO53pjeBohuQSbn55VCwodFUQU3KcD6ap6Pka7jAqixtQU7zgWF255ffGA/Wcdok+mjx4sa+Mivu1EvNaxPYqLPZjJaaF74icQHFg6ogN3jm/6QFjMgCLpDVZTZXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119585; c=relaxed/simple;
	bh=RDw5fe1I0wGfFFQ4oBh704MLHi+i2x088h5hMiXy21I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwNXR3jLG3DIE5INexa50gK2ERF5lPOSDPFduy2zaKPdq1oes2t3bYBaZmsl0lRT9PvpOIhUKviEWrto70ozsbHvmMDnBJ7fJLYDSBxdrZJ1KANDMLWAoydWxKTw973PV1o6rMpdQs7Zo5xBE41DUFluw8RioTmbvdk4FISNUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laA0+eyi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746119583; x=1777655583;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RDw5fe1I0wGfFFQ4oBh704MLHi+i2x088h5hMiXy21I=;
  b=laA0+eyiaLCsNvsLXOJq1pBaAx1mwgTTEZ6turBvlf4/TxXa11RpCXHN
   EzRZcEMlJzYVyYBBzuA52ESUzBi3JqsbdMjaPsR1nCPHFHScPPlvUHGnB
   EqjBJZ7pg6IcRGOaKlKKIre5s62DrokKzf+1iwIy3CwIe68FEBMrl40hj
   AG64B+7j5p2S9O7ZMATkgY4v6AefF7WpSqyBouKHBuxjYLmXE9mAM59Mk
   pfK1whkm11Fegc5nDa40PIUerJuJxETEi09UFuRJQcQ4BvtIhxcKF0kuj
   j6xghZPazhfhr89FjHIaNW+eNhuVDy4FXS/pI+wHqkI5bfgrt6zte+cLb
   w==;
X-CSE-ConnectionGUID: lSAFwQ/tR9CLCJ9kM0bOYw==
X-CSE-MsgGUID: ZWapRcxhRuyDB1JOacZfXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="59184158"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="59184158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 10:13:03 -0700
X-CSE-ConnectionGUID: ZuNpnD1hSgKdTNFPaoN6qA==
X-CSE-MsgGUID: 75dm0u2JTGyPt/2rvc/HYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="134961176"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.85])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 10:13:02 -0700
Message-ID: <b1bc2569b0da4c6749e896eee0fdf0af97c18fea.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] cpufreq: intel_pstate: Use CPPC to get scaling
 factors
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Russell Haley <yumpusamongus@gmail.com>, "Rafael J. Wysocki"
	 <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 01 May 2025 10:13:01 -0700
In-Reply-To: <53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com>
References: <1923452.tdWV9SEqCh@rjwysocki.net>
	 <8476313.T7Z3S40VBb@rjwysocki.net>
	 <53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com>
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

Hi Russell,


On Wed, 2025-04-30 at 20:28 -0500, Russell Haley wrote:
>=20
> On 12/5/24 5:39 AM, Rafael J. Wysocki wrote:
>=20
> > +	 * Compute the perf-to-frequency scaling factor for the
> > given CPU if
> > +	 * possible, unless it would be 0.
> > +	 */
> > +	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
> > +	=C2=A0=C2=A0=C2=A0 cppc_perf.nominal_perf && cppc_perf.nominal_freq)
> > +		return div_u64(cppc_perf.nominal_freq *
> > KHZ_PER_MHZ,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_perf.nominal_perf);
>=20
Can you dump the output of

 grep -r . /sys/devices/system/cpu/cpu*/acpi_cppc/

Thanks,
Srinivas

> I think this exposed a firmware bug on ARL. I have a Core Ultra 265K,
> and two of the E-cores report 33 for nominal_perf, while the others
> report 46. They all report 3300 for nominal_freq.
>=20
> The result is that the kernel thinks these two E-cores are capable of
> 6.5 GHz.
>=20
> > grep . /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:5400000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq:5500000
> /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq:5400000
> /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:5400000
> /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq:5400000
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:5400000
> /sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_max_freq:5400000
> /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_max_freq:5500000
> /sys/devices/system/cpu/cpu8/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu9/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu10/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu11/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu12/cpufreq/cpuinfo_max_freq:6500000 # wow
> /sys/devices/system/cpu/cpu13/cpufreq/cpuinfo_max_freq:6500000 #
> amazing
> /sys/devices/system/cpu/cpu14/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu15/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu16/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu17/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu18/cpufreq/cpuinfo_max_freq:4600000
> /sys/devices/system/cpu/cpu19/cpufreq/cpuinfo_max_freq:4600000
>=20
> Hopefully you have the ear of someone on the firmware team so that a
> ticket can be created for this.
>=20
> In Phoronix discussion, users have reported seeing this on both
> ASRock
> and MSI motherboards:
>=20
> https://www.phoronix.com/forums/forum/hardware/processors-memory/1541981-=
intel-core-ultra-9-285k-arrow-lake-performance-on-linux-has-improved-a-lot-=
since-launch?p=3D1543676#post1543676
>=20
> ----------
>=20
> Also, this may be related... I can't set scaling_max_freq to odd
> multiples of 100 MHz, only even. Checking with:
>=20
> =C2=A0=C2=A0=C2=A0 x86_energy_perf_policy &| grep -i req
>=20
> reveals that some values of max are being skipped. Setting manually
> with
>=20
> =C2=A0=C2=A0=C2=A0 x86_energy_perf_policy --cpu 0-7 --hwp-max 76
>=20
> allows the odd multiples to be accessed. Integer division issue
> somewhere?
>=20


