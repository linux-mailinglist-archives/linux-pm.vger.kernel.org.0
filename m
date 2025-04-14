Return-Path: <linux-pm+bounces-25378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF6A8870B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27DE167E3F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41751274642;
	Mon, 14 Apr 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuQmmMGG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF482741CB;
	Mon, 14 Apr 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644382; cv=none; b=DB2qvZxkUOiVo3tzzTtsZSlNvBy55mzY9mdGJtQ6vqHOumqSbeLjBoq33PO9RxQv76cK0DH0gtUBOlzbq3SYcnFyQjdfJAbPaMWW8hoY8JQugMoH+k/SWqxH4rjtvEfeiJOAdQ3htSAPDB5+DZopUEORc3EPFqiWac8oPeE5XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644382; c=relaxed/simple;
	bh=lOWJwifRCn7NKQa2BRVeLtf2r9i5Lev8/V1R6B783wY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3rnMAWcutIQoIKigqpE9W9RLdZW1P7TaKQHNfSkuoku1XBKyL2GexnHhIJsrKTFWRrbeYh9Lku88N+Ctn9Re+PjuWpxm3en2cN8Hw08Qiy6fWO8ShBoqLaY8NtPPHXzgiEcVL0Cbn3Y6ACLtfMnaaj047snzOoQpnUWzWDkpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuQmmMGG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744644380; x=1776180380;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lOWJwifRCn7NKQa2BRVeLtf2r9i5Lev8/V1R6B783wY=;
  b=VuQmmMGGYcA0AR0Zu1AofrvLygBQbYTfPU14yAlFYnLir5XD2t8CZw9O
   Kr8XCj04pt4qIhUpNckVTMnxLttwSOl16p5hxTtTo/la9aYUQyBy9YFA+
   qzRo0R5l3XAEP+V1TsU3z3E2ySOqRb93BT9KgmAZgR7kUgVZLmz0XCIp+
   f+nlnEJAqEAkabLLbbizX4LHCl9oQZmnSumC/Ltm6F6BaXbrxV2edxunr
   aaR51UFzMTKkETwI2gG33ni3VXCImpfT3qE4yGKEqLC6zwr8GB5Fg1Ddt
   EwxW0KYndwxqHsJ72GZZA8jvfTP+/Id3UDBP/tBq11XOYPhti5oJLyPH7
   Q==;
X-CSE-ConnectionGUID: 0tqnblYxSsqR4AcsHA/FuA==
X-CSE-MsgGUID: snPiZKCzTbKZeQwcA4ixmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45830490"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45830490"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 08:26:19 -0700
X-CSE-ConnectionGUID: h4k/5wCISr2kwajSYhgS5g==
X-CSE-MsgGUID: T+yrJBNiTtKgFaQfG3a8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="160850503"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 08:26:18 -0700
Message-ID: <5dd2e5c6abb39dfafee91247cd8473ec643280ac.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use raw_smp_processor_id() in
 hwp_get_cpu_scaling()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>,
  Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>,  linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Date: Mon, 14 Apr 2025 08:26:18 -0700
In-Reply-To: <12659608.O9o76ZdvQC@rjwysocki.net>
References: <20250412103434.5321-1-xry111@xry111.site>
	 <b7b0b3f98f8fad9cc9559e1c4ce832387c520d7a.camel@linux.intel.com>
	 <12659608.O9o76ZdvQC@rjwysocki.net>
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

On Mon, 2025-04-14 at 17:19 +0200, Rafael J. Wysocki wrote:
> On Sunday, April 13, 2025 4:44:56 PM CEST srinivas pandruvada wrote:
> > On Sat, 2025-04-12 at 18:34 +0800, Xi Ruoyao wrote:
> > > Use raw_smp_processor_id() instead of plain smp_processor_id() in
> > > hwp_get_cpu_scaling(), otherwise we get some errors on a Lenovo
> > > Thinkpad
> > > T14P Gen 2:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 BUG: using smp_processor_id() in preemptible [0000=
0000] code:
> > > swapper/0/1
> > > =C2=A0=C2=A0=C2=A0 caller is hwp_get_cpu_scaling+0x7f/0xc0
> > >=20
> > > Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to
> > > get
> > > cpu-type")
> > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> >=20
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> It's still broken after this patch though because the function should
> use the cpu_data() of the target CPU and not of the CPU running the
> code.

That is correct. The below patch should work.

Thanks,
Srinivas

>=20
> The patch below should fix it.
>=20
> =3D=3D=3D
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] cpufreq: intel_pstate: Fix hwp_get_cpu_scaling()
>=20
> Commit b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> cpu-type") introduced two issues into hwp_get_cpu_scaling().=C2=A0 First,
> it made that function use the CPU type of the CPU running the code
> even though the target CPU is passed as the argument to it and
> second,
> it used smp_processor_id() for that even though hwp_get_cpu_scaling()
> runs in preemptible context.
>=20
> Fix both of these problems by simply passing "cpu" to cpu_data().
>=20
> Fixes: b52aaeeadfac ("cpufreq: intel_pstate: Avoid SMP calls to get
> cpu-type")
> Link:
> https://lore.kernel.org/linux-pm/20250412103434.5321-1-xry111@xry111.site=
/
> Reported-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A0 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2336,7 +2336,7 @@
> =C2=A0static int hwp_get_cpu_scaling(int cpu)
> =C2=A0{
> =C2=A0	if (hybrid_scaling_factor) {
> -		struct cpuinfo_x86 *c =3D
> &cpu_data(smp_processor_id());
> +		struct cpuinfo_x86 *c =3D &cpu_data(cpu);
> =C2=A0		u8 cpu_type =3D c->topo.intel_type;
> =C2=A0
> =C2=A0		/*
>=20
>=20
>=20
>=20


