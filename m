Return-Path: <linux-pm+bounces-28282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F1AD1677
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 03:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A92188B962
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960153597A;
	Mon,  9 Jun 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIouYRFu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7F2A1B2;
	Mon,  9 Jun 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749431446; cv=none; b=Vksi6DG4pCUwiHnaNOpi1r6EA1A39Jh1ZF1yXV0yg+jR/3qvcaQwIP/5Pjc/Y+hX1xLbqjiaDJCM9chdggkA6YInj3Gf+j3kZXcMJQ3zm2UqdpqDHHd1oedoDUVkiD2FQg/gn9rUnQ2LPlyAj/JPO8Esddti41NuCjqTokKWPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749431446; c=relaxed/simple;
	bh=b8WnIvi9vrfQq6nv39QWS2mPMXoCtjY1tGcYgArvAlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4c84NZPD++MfSOms7tL19y6mx/b026SYGdGo3wI4ra+tE0E/m0+p38Nr9StWy1ZXnEwgz0ppA2aLIj9AP0t1OosnLmfMdyEivd50AX4krQGlR5KIiYV0hGe1alzPkUQfnh8ZZBTzwnN9iPjHQjyX31uQY3pJhdeHeURahDHzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIouYRFu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749431444; x=1780967444;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=b8WnIvi9vrfQq6nv39QWS2mPMXoCtjY1tGcYgArvAlA=;
  b=PIouYRFu7M8n783Ppdabdt8O/MdGkj7fYSPS3NXZzsdmlRgy5ioboAIJ
   sjnAFNqtKorv/PwTy0EaZWOdhKD+qjU1/TQ+NCE9w4v7eVHHk4tfg2BnT
   dWrVf2qRwywlVzlL4NKpwJhG+W98atApdnzRuFAyEok/COlFUwHKDu2q8
   GmtaaYMF/80TqxsfH7QDZqYw0fSM/H3RffXxym7XAMMaet6u4UKDM/Vph
   DtjVYeRJdP1PGytmn980q8Kd6mKu9jN33HQDadxeFk2TLEaBhFd2XqDZo
   DHbe+HUyL3amtgKR+rpqISIcx0Dyr2uPbIiwiMhILz+5YGx18Flm9ZPJn
   g==;
X-CSE-ConnectionGUID: RbqRQIA8RC+u0lpILG+G4A==
X-CSE-MsgGUID: GUXSE5nRT8Cqx3jFu99btQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51647366"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="51647366"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 18:10:43 -0700
X-CSE-ConnectionGUID: LDOyYcNbSCOIFePU25uNfg==
X-CSE-MsgGUID: lgy/T7RRRuyt1MRDplK7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="146290802"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.223.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 18:10:43 -0700
Message-ID: <77216773e80b1d60f41e48a0f2071066d1e0d393.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add DMI quirk for Dell Inspiron
 systems
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Joe Walter <joe.walter@codesensesolutions.com>, rafael@kernel.org
Cc: viresh.kumar@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 08 Jun 2025 18:10:42 -0700
In-Reply-To: <20250606231530.3032-1-joe.walter@codesensesolutions.com>
References: <20250606231530.3032-1-joe.walter@codesensesolutions.com>
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
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-06 at 16:15 -0700, Joe Walter wrote:
> Some Dell Inspiron systems experience frequency scaling issues with
> intel_pstate driver where the CPU gets locked at 900MHz after load.
>=20
> Add DMI quirk table to detect affected Dell Inspiron models and
> prevent
> intel_pstate from loading, allowing acpi-cpufreq to handle frequency
> scaling instead.

This is the first time in 10+ years a quirk using DMI..

>=20
> Affected models:
> - Dell Inspiron 15 7000 Gaming
> - Dell Inspiron 7567
> - Dell Inspiron 7559

I think these all are using KabyLake CPU models around 2017.

Do you have turbostat logs to see why it is dropping to 900 MHz? If not
please attach. Most of such drops usually triggered by power/thermal
limits. We have to check the power limit settings.



Try with a different EPP settings instead of default by using
/sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference


Also try:
echo passive > /sys/devices/system/cpu/intel_pstate/status

Thanks,
Srinivas

>=20
> Tested-by: Joe Walter <joe.walter@codesensesolutions.com>
> Signed-off-by: Joe Walter <joe.walter@codesensesolutions.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 65 ++++++++++++++++++++++---------=
-
> --
> =C2=A01 file changed, 42 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 1b1f62ccec92..3aeb04755afa 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -28,7 +28,6 @@
> =C2=A0#include <linux/pm_qos.h>
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <trace/events/power.h>
> -#include <linux/dmi.h>
> =C2=A0#include <linux/units.h>
> =C2=A0
> =C2=A0#include <asm/cpu.h>
> @@ -48,6 +47,7 @@
> =C2=A0#ifdef CONFIG_ACPI
> =C2=A0#include <acpi/processor.h>
> =C2=A0#include <acpi/cppc_acpi.h>
> +#include <linux/dmi.h>
> =C2=A0#endif
> =C2=A0
> =C2=A0#define FRAC_BITS 8
> @@ -299,25 +299,6 @@ struct pstate_funcs {
> =C2=A0
> =C2=A0static struct pstate_funcs pstate_funcs __read_mostly;
> =C2=A0
> -/* DMI quirk table for systems that should prefer acpi-cpufreq over
> intel_pstate */
> -static int intel_pstate_prefer_acpi_cpufreq(const struct
> dmi_system_id *id)
> -{
> -	pr_info("Preferring acpi-cpufreq for %s due to performance
> issues with intel_pstate\n",
> -		id->ident);
> -	return 1;
> -}
> -
> -static const struct dmi_system_id intel_pstate_acpi_cpufreq_prefer[]
> =3D {
> -	{
> -		.callback =3D intel_pstate_prefer_acpi_cpufreq,
> -		.ident =3D "Dell Inspiron 15 7000 Gaming",
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 15
> 7000 Gaming"),
> -		},
> -	},
> -	{ }
> -};
> =C2=A0static bool hwp_active __ro_after_init;
> =C2=A0static int hwp_mode_bdw __ro_after_init;
> =C2=A0static bool per_cpu_limits __ro_after_init;
> @@ -2799,6 +2780,41 @@ static const struct x86_cpu_id
> intel_pstate_cpu_ids[] =3D {
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> =C2=A0
> +/* DMI quirk table for systems that should prefer acpi-cpufreq over
> intel_pstate */
> +static int intel_pstate_prefer_acpi_cpufreq(const struct
> dmi_system_id *id)
> +{
> +	pr_info("Detected %s, preferring acpi-cpufreq\n", id-
> >ident);
> +	return 0;
> +}
> +
> +static const struct dmi_system_id intel_pstate_acpi_cpufreq_prefer[]
> =3D {
> +	{
> +		.ident =3D "Dell Inspiron 15 7000 Gaming",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 15
> 7000 Gaming"),
> +		},
> +		.callback =3D intel_pstate_prefer_acpi_cpufreq,
> +	},
> +	{
> +		.ident =3D "Dell Inspiron 7567",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron
> 7567"),
> +		},
> +		.callback =3D intel_pstate_prefer_acpi_cpufreq,
> +	},
> +	{
> +		.ident =3D "Dell Inspiron 7559",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron
> 7559"),
> +		},
> +		.callback =3D intel_pstate_prefer_acpi_cpufreq,
> +	},
> +	{}
> +};
> +
> =C2=A0#ifdef CONFIG_ACPI
> =C2=A0static const struct x86_cpu_id intel_pstate_cpu_oob_ids[]
> __initconst =3D {
> =C2=A0	X86_MATCH(INTEL_BROADWELL_D,		core_funcs),
> @@ -3825,6 +3841,12 @@ static int __init intel_pstate_init(void)
> =C2=A0	const struct x86_cpu_id *id;
> =C2=A0	int rc;
> =C2=A0
> +
> +	/* Early DMI check - prevent intel_pstate on problematic
> systems */
> +	if (dmi_check_system(intel_pstate_acpi_cpufreq_prefer)) {
> +		pr_info("intel_pstate: system prefers acpi-cpufreq,
> not loading\n");
> +		return -ENODEV;
> +	}
> =C2=A0	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
> =C2=A0		return -ENODEV;
> =C2=A0
> @@ -3887,9 +3909,6 @@ static int __init intel_pstate_init(void)
> =C2=A0		pr_info("Invalid MSRs\n");
> =C2=A0		return -ENODEV;
> =C2=A0	}
> -/* Check for systems that should prefer acpi-cpufreq */
> -	if (!default_driver &&
> dmi_check_system(intel_pstate_acpi_cpufreq_prefer))
> -		default_driver =3D &intel_cpufreq;
> =C2=A0	/* Without HWP start in the passive mode. */
> =C2=A0	if (!default_driver)
> =C2=A0		default_driver =3D &intel_cpufreq;

