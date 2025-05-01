Return-Path: <linux-pm+bounces-26526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A480CAA6749
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 01:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003B84A1232
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D3257443;
	Thu,  1 May 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4YaK30v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378E202C5D;
	Thu,  1 May 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141150; cv=none; b=lhtuUiF/Vh3MfK6oyCqdfARf+lowsvcUR7nzATkXI17eQ95DL+Kyv0nJB4JIHsty2/EeWB/GJmbrFe7+trnsEcR8O9AhONAHpqpu0lFOqDn4J6k0Ou5oCwf4A08/qAixo3cQjTGJpymx/pplc/43MgkKu3nhW31KS6JgqN3V7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141150; c=relaxed/simple;
	bh=GPNb+1QVQD2lKbdBC337Ayi8643e3qblvHpAPhLgXOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqgNZrUpzWYEDCkjPz3oiKpRfwTtkim/xlRq1o8CaXSmIN/mKt4iw4RsVb1DwDzbmOJHbowymGSjeZetGkBYGqCV48ZOtLC27LEuomLyhqtFhtDbEyuYhsJpkK97LNZfLOukBOaRZTQJ9/iG5wdwZWatuFMTTr2Tx1AtMQ2ez6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4YaK30v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746141148; x=1777677148;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GPNb+1QVQD2lKbdBC337Ayi8643e3qblvHpAPhLgXOo=;
  b=l4YaK30v3djAKSN6l+kZun2sw7m0N7Lefp/U9J9RaVUbjmQi0Rquuqzu
   Nyv2hYci19U3w9qguZooDUbe+Vz9secFYZ/N5jyFhcT6J/LUSAqjIlvyo
   kCLPcFKmwGuYwXFj9aiur7DbP4Oh9MkNH6os8Vr3jQFniMEhiEK3Pq8HO
   wlvnvSd1w8+MaBtRdZ9ArUGC9wgo7qBhUChAZGTvThbTPJRf1UHeVBRhy
   jD8v3ORv39ix1bvXBZtjhCj+SjcRZCXE5gxi42ZZhb3h6Cu6dZIajxSkJ
   RG+ObdpEDioN2N9KI8IsbVGTMHezSSnR8z2K3CALW0V9jaNUVjQPIToMN
   g==;
X-CSE-ConnectionGUID: VcOSmXKbSCWF/N5yiT/rjQ==
X-CSE-MsgGUID: qhkoBYsKQ4aCR4XK2v0eYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47078783"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="47078783"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 16:12:27 -0700
X-CSE-ConnectionGUID: ZUhPpBwERHe6lq8cKt/Mgg==
X-CSE-MsgGUID: FkagkSCvQQOJ5TasFDUFVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="134451497"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.85])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 16:12:27 -0700
Message-ID: <9a06fec4970bfbd294ad80dceaa7ec12f0869587.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] cpufreq: intel_pstate: Use CPPC to get scaling
 factors
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Russell Haley <yumpusamongus@gmail.com>, "Rafael J. Wysocki"
	 <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 01 May 2025 16:12:26 -0700
In-Reply-To: <ac0e5571-15b2-4b7a-adc9-84bbca96cbf3@gmail.com>
References: <1923452.tdWV9SEqCh@rjwysocki.net>
	 <8476313.T7Z3S40VBb@rjwysocki.net>
	 <53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com>
	 <b1bc2569b0da4c6749e896eee0fdf0af97c18fea.camel@linux.intel.com>
	 <ac0e5571-15b2-4b7a-adc9-84bbca96cbf3@gmail.com>
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

On Thu, 2025-05-01 at 16:33 -0500, Russell Haley wrote:
>=20
> On 5/1/25 12:13 PM, srinivas pandruvada wrote:
> > Hi Russell,
> >=20
> >=20
> > On Wed, 2025-04-30 at 20:28 -0500, Russell Haley wrote:
> > >=20
> > > On 12/5/24 5:39 AM, Rafael J. Wysocki wrote:
> > >=20
> > > > +	 * Compute the perf-to-frequency scaling factor for
> > > > the
> > > > given CPU if
> > > > +	 * possible, unless it would be 0.
> > > > +	 */
> > > > +	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
> > > > +	=C2=A0=C2=A0=C2=A0 cppc_perf.nominal_perf && cppc_perf.nominal_fr=
eq)
> > > > +		return div_u64(cppc_perf.nominal_freq *
> > > > KHZ_PER_MHZ,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_perf.nominal_perf);
> > >=20
> > Can you dump the output of
> >=20
> > =C2=A0grep -r . /sys/devices/system/cpu/cpu*/acpi_cppc/
> >=20

For Intel=C2=AE Core=E2=84=A2 Ultra 7 Processor 265K as per spec:

Based on this CPU 0-7 are performance-cores. So there max frequency is
correct.
That can be 5.5 GHz or 5.4 GHz.

CPU 8-19 are Efficient cores
There max can be 4.6 GHz, except CPU 12, 13. 4.6 GHz also match the
spec.
The max perf raw value is 65. That is also correct.
The nominal freq of all is 3300 MHz, that is also correct for all.
Except for CPU 12 and 13 the nominal perf is 46.

I expect that nominal perf value of 12, 13 should be same as other
efficient cores. But here it is not same.

Let me check if I can find some contact of Asrock to see why is this
case.

Thanks,
Srinivas


> > Thanks,
> > Srinivas
>=20

> Running microcode 0x117, CSME firmware 19.0.5.1948, shipped in BIOS
> 3.04
> on an ASRock Z890 Pro-A Wifi motherboard:
>=20
> > /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:1273162075
> > 77 del:142876300546
> > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:87
> > /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:3080604891
> > 0 del:37298826546
> > /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:88
> > /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:3010485691
> > 2 del:37149315858
> > /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:87
> > /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:2886479247
> > 6 del:36395338959
> > /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:87
> > /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:2959129937
> > 4 del:35708084379
> > /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:87
> > /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:2734735138
> > 2 del:35000915045
> > /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:87
> > /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:2811773788
> > 2 del:34854014824
> > /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:87
> > /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:2958635916
> > 6 del:36871078184
> > /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:88
> > /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:2880811533
> > 6 del:32798153181
> > /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:2880844652
> > 4 del:32557156736
> > /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:184467440737
> > 09551615
> > /sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:284668584
> > 72 del:32126528930
> > /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:301586672
> > 40 del:34095663687
> > /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:290567520
> > 36 del:33047611525
> > /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:33
> > /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:39
> > /sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:288689997
> > 96 del:32974873909
> > /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:33
> > /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:39
> > /sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:327543421
> > 92 del:33580705618
> > /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:307564110
> > 36 del:33232643243
> > /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:294303303
> > 84 del:32848376143
> > /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:299978140
> > 80 del:33374419073
> > /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:283124003
> > 76 del:32285787922
> > /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073
> > 709551615
> > /sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:283166047
> > 32 del:32229146887
> > /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:21
> > /sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:65
> > /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:3300
> > /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:47
> > /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:46
> > /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:54
> > /sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073
> > 709551615
>=20
> Thanks,
>=20
> Russell
>=20
>=20


