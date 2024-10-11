Return-Path: <linux-pm+bounces-15545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C499A902
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 18:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2E71C21819
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03A19D080;
	Fri, 11 Oct 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/+2WHEP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D4199932;
	Fri, 11 Oct 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664615; cv=none; b=kjhUTWQkNnj65IAs4VwvLoGsymhHIRMzPqFHhqvloC28KROP3nAZbY17ayHcNRQ1VJQVvgMVsICrWaAId70kSf4amp3fbcDSXVv7qlOpjJ//B37UCXWhxwkAWHnY83TaAKwBx5A/S++8m8Cq5HFCUbLa9iKXNphKa+nrhtl2Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664615; c=relaxed/simple;
	bh=0DOctPhcXkXwaU6mc08w+rbLhDERb4wCWL/N4+tis1E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uda8mfLnU6GHx8Uw8bX0gA5Xvyqy9o/dUMY66/lZEanNxE5vSVstTWSj7NjdPBP1dMgYtp0VaSafwMqfTMB0AMDParmEvef1XCIuRlEQuEi1vdiNoI3QZP5YE9OYQmRW0qacpdMjG0rjcgu9eFcfbw/V8kRHNT0AkGiWVI0+NmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/+2WHEP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728664614; x=1760200614;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=0DOctPhcXkXwaU6mc08w+rbLhDERb4wCWL/N4+tis1E=;
  b=C/+2WHEPX7qXTQJwtRG4oCLsz2lhdj7jsiZ5XxSGy4znEkGvaSQ+q9x7
   Urlwbv0fg8refzpGmPn/hlp42tPRSfBkbS9ivbEs/0wi0Gdm5+qVxEnou
   2o5nX97C/+FvrVOLr7CiM965ZQd9LwDGwf+nKd59ttSsHcoF9br8mXjFD
   eOONePExtSq5jICI7/JuUIwGdvOS92ytRlHO9v7Pj9BTYUj6U5+r4v8Qd
   q9xjQWPR4aa4YYC10I34bT0yBGuryzFD1q1IkIQRmsKaJHCIv8I0ki4Si
   XqF+IjlrPr5DMa2kdrHaIHBYh5pHIctFTpLdLH9BFT23H4tclbBiG7Q9W
   w==;
X-CSE-ConnectionGUID: teAb+/UpSXWr261THYdhwg==
X-CSE-MsgGUID: 0G6d1uVXQumHVnbau1fqEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28232824"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28232824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 09:36:53 -0700
X-CSE-ConnectionGUID: lCFmQ9YCTWi1Aa1mt9+pKA==
X-CSE-MsgGUID: cMQuFs0YQHCNTzvTehFA8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81738379"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.111.157])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 09:36:52 -0700
Message-ID: <462d0bd9eb9c461e01ef27a8da9cd02f92ce8f9f.camel@linux.intel.com>
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion
 during suspend
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: david.e.box@linux.intel.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, rjw@rjwysocki.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Fri, 11 Oct 2024 09:36:52 -0700
In-Reply-To: <c9410dd42e01c1ba26fbb43f97a8777f1c95b9af.camel@linux.intel.com>
References: <20241011003640.1613812-1-david.e.box@linux.intel.com>
	 <20241011003640.1613812-2-david.e.box@linux.intel.com>
	 <c4513e7857b15ec9146a7b75d00e99987787ced4.camel@linux.intel.com>
	 <c9410dd42e01c1ba26fbb43f97a8777f1c95b9af.camel@linux.intel.com>
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
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 20:50 -0700, David E. Box wrote:
> On Thu, 2024-10-10 at 19:09 -0700, srinivas pandruvada wrote:
> > On Thu, 2024-10-10 at 17:36 -0700, David E. Box wrote:
> > > On some platforms, aggressive C1 auto-demotion may lead to
> > > failure to
> > > enter
> > > the deepest C-state during suspend-to-idle, causing high power
> > > consumption.
> > > To prevent this, disable C1 auto-demotion during suspend and re-
> > > enable on
> > > resume.
> > >=20
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >=20
> > > V2 - Remove #define DEBUG
> > > =C2=A0=C2=A0 - Move refactor of cnl_resume() to separate patch
> > > =C2=A0=C2=A0 - Use smp_call_function() to disable and restore
> > > C1_AUTO_DEMOTE
> > > =C2=A0=C2=A0 - Add comment that the MSR is per core, not per package.
> > > =C2=A0=C2=A0 - Add comment that the online cpu mask remains unchanged
> > > during
> > > =C2=A0=C2=A0=C2=A0=C2=A0 suspend due to frozen userspace.
> > >=20
> > > =C2=A0drivers/platform/x86/intel/pmc/cnp.c | 53
> > > ++++++++++++++++++++++++++++
> > > =C2=A01 file changed, 53 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> > > b/drivers/platform/x86/intel/pmc/cnp.c
> > > index 513c02670c5a..f12d4f0f9e93 100644
> > > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > > @@ -8,6 +8,8 @@
> > > =C2=A0 *
> > > =C2=A0 */
> > > =C2=A0
> > > +#include <linux/smp.h>
> > > +#include <linux/suspend.h>
> > > =C2=A0#include "core.h"
> > > =C2=A0
> > > =C2=A0/* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap *=
/
> > > @@ -206,8 +208,52 @@ const struct pmc_reg_map cnp_reg_map =3D {
> > > =C2=A0	.etr3_offset =3D ETR3_OFFSET,
> > > =C2=A0};
> > > =C2=A0
> > > +
> > > +/*
> > > + * Disable C1 auto-demotion
> > > + *
> > > + * Aggressive C1 auto-demotion may lead to failure to enter the
> > > deepest C-state
> > > + * during suspend-to-idle, causing high power consumption. To
> > > prevent this, we
> > > + * disable C1 auto-demotion during suspend and re-enable on
> > > resume.
> > > + *
> > > + * Note that, although MSR_PKG_CST_CONFIG_CONTROL has 'package'
> > > in
> > > its name, it
> > > + * is actually a per-core MSR on client platforms, affecting
> > > only a
> > > single CPU.
> > > + * Therefore, it must be configured on all online CPUs. The
> > > online
> > > cpu mask is
> > > + * unchanged during the phase of suspend/resume as user space is
> > > frozen.
> > > + */
> > > +
> > > +static DEFINE_PER_CPU(u64, pkg_cst_config);
> > > +
> > > +static void disable_c1_auto_demote(void *unused)
> > > +{
> > > +	int cpunum =3D smp_processor_id();
> > > +	u64 val;
> > > +
> > > +	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> > > +	per_cpu(pkg_cst_config, cpunum) =3D val;
> > > +	val &=3D ~NHM_C1_AUTO_DEMOTE;
> > > +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> > > +	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> > > val);
> > Do you want to leave pr_debug?
>=20
> Thought it could be useful but it can be removed.
>=20
> >=20
> > > +}
> > > +
> > > +static void restore_c1_auto_demote(void *unused)
> > > +{
> > > +	int cpunum =3D smp_processor_id();
> > > +
> > > +	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> > > +		 per_cpu(pkg_cst_config, cpunum));
> > > +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL,
> > > per_cpu(pkg_cst_config,
> > > cpunum));
> > > +}
> > > +
> > > =C2=A0void cnl_suspend(struct pmc_dev *pmcdev)
> > > =C2=A0{
> > > +	if (!pm_suspend_via_firmware()) {
> > > +		preempt_disable();
> > Why do you need this?
>=20
> To ensure that the cpu doesn't change between the next two calls.

Correct. You need for smp_processor_id()

Generally for this avoiding issue with smp_processor_id(), you can use
get_cpu(), which gives current cpu as return value and also disable
preemption.

Something like this

                this_cpu =3D get_cpu();
                disable_c1_auto_demote(&this_cpu);
smp_call_function_many(cpu_online_mask, disable_c1_auto_demote, NULL,
0);
                put_cpu();


But fine, this makes your code more complex as you have to pass now a
param and use for local_cpu and use smp_procesor_id() for remote call
via smp_call..


Thanks,
Srinivas

>=20
> David
>=20
> >=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > > +		disable_c1_auto_demote(NULL);
> > > +		smp_call_function(disable_c1_auto_demote, NULL,
> > > 0);
> > > +		preempt_enable();
> > > +	}
> > > +
> > > =C2=A0	/*
> > > =C2=A0	 * Due to a hardware limitation, the GBE LTR blocks PC10
> > > =C2=A0	 * when a cable is attached. To unblock PC10 during
> > > suspend,
> > > @@ -218,6 +264,13 @@ void cnl_suspend(struct pmc_dev *pmcdev)
> > > =C2=A0
> > > =C2=A0int cnl_resume(struct pmc_dev *pmcdev)
> > > =C2=A0{
> > > +	if (!pm_suspend_via_firmware()) {
> > > +		preempt_disable();
> > > +		restore_c1_auto_demote(NULL);
> > > +		smp_call_function(restore_c1_auto_demote, NULL,
> > > 0);
> > > +		preempt_enable();
> > > +	}
> > > +
> > > =C2=A0	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > > =C2=A0
> > > =C2=A0	return pmc_core_resume_common(pmcdev);
> >=20
>=20
>=20


