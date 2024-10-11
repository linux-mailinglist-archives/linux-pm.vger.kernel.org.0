Return-Path: <linux-pm+bounces-15521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B366999A0B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2901F2258B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FA1E884B;
	Fri, 11 Oct 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5XAA3DO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E41E6339;
	Fri, 11 Oct 2024 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612575; cv=none; b=HJTLIwKzaDo+FwnBlEO+3zKVesWT9SyWEUP544PCL1FhNtLsIUYy5UXUN+AXPJx1VmmH8UEbw4yMT2mQoAMaAFb8kg/z6NKKjBvnhWYxPHlrAnrPZ81AU8EoZWXl6Q4NB3cDXSOCdGDsx0BB4w9evyT7uiWldeD6Xs4yjEhU4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612575; c=relaxed/simple;
	bh=vGCu2uocTXN3mqgSyJmw9NgvVofahnz1UUGqX3sAE2M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mANMPqY9Bw3eMCKrvUxy36pjM31EJ9Gw32bVFeYKTKf6+8t7+edGev3CZsFdNshVCgDCCnhV+VMAKTR1852t0tiAEP3oo0dl6rDtWYXSTABMxnugGyr+otTwqKAJiVSyw3E+PaUScQBy1PIKqOLjM8pOwnQbpcVrcFhMB0QaqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5XAA3DO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728612573; x=1760148573;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=vGCu2uocTXN3mqgSyJmw9NgvVofahnz1UUGqX3sAE2M=;
  b=Y5XAA3DOYUu4fX7uI3vs0A4iiPkPQDpdm82G/C4cdeGiRduzvSot78pY
   4I3xe6hl2qwSzqwJUIWA28iyv+1a5iGkjFZOyNrjOl6JTwJ6ajP5PCI9x
   cDXEoisXEXUisupfuVEGorL2cNsoOincQTQyKPVg2MHhmFd6B5hn7AFz9
   OIQjkL+fahnrBapXihtBI2LZpHmSBGMuZ2tGXG1pJh2H6zgs4B/jpX7Cf
   OKoFQOWf/cAGZSCPyZwmtbN2ZsTsCx+KNSzPx+5iotwVLJOYQgD302/ci
   dhaPwCR+K+Gv4aD+r0PTfQFk8cOTTnhQ1c98eVNNOz5aUa5nBRQE1fLP+
   A==;
X-CSE-ConnectionGUID: gYDNkR4AQfK+42IAui1Ndg==
X-CSE-MsgGUID: dlmjaRWFQDWHZ2SEEqLEKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38582773"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="38582773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:09:31 -0700
X-CSE-ConnectionGUID: 9KxnB/Z6SIGpJxprhlZ6iw==
X-CSE-MsgGUID: FiBpLiJSRNumKooa99ITRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="100106630"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.111.112])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:09:12 -0700
Message-ID: <c4513e7857b15ec9146a7b75d00e99987787ced4.camel@linux.intel.com>
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion
 during suspend
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, rjw@rjwysocki.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Thu, 10 Oct 2024 19:09:10 -0700
In-Reply-To: <20241011003640.1613812-2-david.e.box@linux.intel.com>
References: <20241011003640.1613812-1-david.e.box@linux.intel.com>
	 <20241011003640.1613812-2-david.e.box@linux.intel.com>
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

On Thu, 2024-10-10 at 17:36 -0700, David E. Box wrote:
> On some platforms, aggressive C1 auto-demotion may lead to failure to
> enter
> the deepest C-state during suspend-to-idle, causing high power
> consumption.
> To prevent this, disable C1 auto-demotion during suspend and re-
> enable on
> resume.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>=20
> V2 - Remove #define DEBUG
> =C2=A0=C2=A0 - Move refactor of cnl_resume() to separate patch
> =C2=A0=C2=A0 - Use smp_call_function() to disable and restore C1_AUTO_DEM=
OTE
> =C2=A0=C2=A0 - Add comment that the MSR is per core, not per package.
> =C2=A0=C2=A0 - Add comment that the online cpu mask remains unchanged dur=
ing
> =C2=A0=C2=A0=C2=A0=C2=A0 suspend due to frozen userspace.
>=20
> =C2=A0drivers/platform/x86/intel/pmc/cnp.c | 53
> ++++++++++++++++++++++++++++
> =C2=A01 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> b/drivers/platform/x86/intel/pmc/cnp.c
> index 513c02670c5a..f12d4f0f9e93 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -8,6 +8,8 @@
> =C2=A0 *
> =C2=A0 */
> =C2=A0
> +#include <linux/smp.h>
> +#include <linux/suspend.h>
> =C2=A0#include "core.h"
> =C2=A0
> =C2=A0/* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -206,8 +208,52 @@ const struct pmc_reg_map cnp_reg_map =3D {
> =C2=A0	.etr3_offset =3D ETR3_OFFSET,
> =C2=A0};
> =C2=A0
> +
> +/*
> + * Disable C1 auto-demotion
> + *
> + * Aggressive C1 auto-demotion may lead to failure to enter the
> deepest C-state
> + * during suspend-to-idle, causing high power consumption. To
> prevent this, we
> + * disable C1 auto-demotion during suspend and re-enable on resume.
> + *
> + * Note that, although MSR_PKG_CST_CONFIG_CONTROL has 'package' in
> its name, it
> + * is actually a per-core MSR on client platforms, affecting only a
> single CPU.
> + * Therefore, it must be configured on all online CPUs. The online
> cpu mask is
> + * unchanged during the phase of suspend/resume as user space is
> frozen.
> + */
> +
> +static DEFINE_PER_CPU(u64, pkg_cst_config);
> +
> +static void disable_c1_auto_demote(void *unused)
> +{
> +	int cpunum =3D smp_processor_id();
> +	u64 val;
> +
> +	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +	per_cpu(pkg_cst_config, cpunum) =3D val;
> +	val &=3D ~NHM_C1_AUTO_DEMOTE;
> +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> +	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
Do you want to leave pr_debug?

> +}
> +
> +static void restore_c1_auto_demote(void *unused)
> +{
> +	int cpunum =3D smp_processor_id();
> +
> +	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> +		 per_cpu(pkg_cst_config, cpunum));
> +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config,
> cpunum));
> +}
> +
> =C2=A0void cnl_suspend(struct pmc_dev *pmcdev)
> =C2=A0{
> +	if (!pm_suspend_via_firmware()) {
> +		preempt_disable();
Why do you need this?


Thanks,
Srinivas

> +		disable_c1_auto_demote(NULL);
> +		smp_call_function(disable_c1_auto_demote, NULL, 0);
> +		preempt_enable();
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * Due to a hardware limitation, the GBE LTR blocks PC10
> =C2=A0	 * when a cable is attached. To unblock PC10 during suspend,
> @@ -218,6 +264,13 @@ void cnl_suspend(struct pmc_dev *pmcdev)
> =C2=A0
> =C2=A0int cnl_resume(struct pmc_dev *pmcdev)
> =C2=A0{
> +	if (!pm_suspend_via_firmware()) {
> +		preempt_disable();
> +		restore_c1_auto_demote(NULL);
> +		smp_call_function(restore_c1_auto_demote, NULL, 0);
> +		preempt_enable();
> +	}
> +
> =C2=A0	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> =C2=A0
> =C2=A0	return pmc_core_resume_common(pmcdev);


