Return-Path: <linux-pm+bounces-39864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A8CD9615
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63FD7300905C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8432C331;
	Tue, 23 Dec 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCOptn23"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8E328B79
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494679; cv=none; b=ncQtONgTAbs1YMms0QOXUHFlijmdccdQooS5UgLqtj6n5RxKv6MLom6/bFhlK4DZmCTxiCtD8yT6nAliD9GrvpgOeYfZdDRjPFJpjlkiDYPFP0vH6ldjSmq5aGKaD+ivi8+W+eouCVGsjyOXqANlzKvRS1MAaT9VvLO2xJT9o8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494679; c=relaxed/simple;
	bh=u9qpA+aPZVcwGHmGRxvEnqx5ap58NA4sS79B5Z84UgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAjBbTzR8iRiMdhe09yusJdCXPfO6R1c6UzGw9ynyFVzuUmD+NJuObCcJepSSADAFCWzdb+P/rqikLBBRtzdqrLH66nvI+AmbIfFeKvqqYZibP8dXCsyVFmsLLp9M0jDn4pXQwUoxF7aTiRcUSkQhb80NR0WEwpW/TUq17pHxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCOptn23; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766494678; x=1798030678;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=u9qpA+aPZVcwGHmGRxvEnqx5ap58NA4sS79B5Z84UgU=;
  b=HCOptn23yUE4yRxVqvs0yRg7hRjig0B71Mx/EGsbSUTJT4Il7v0rYEBQ
   F5gaIITflG1TJ/6cHsmMYcQ0YCeFqYIt/743FEzrQmm6c1MtetQg+6BEu
   EYVcF5a+aorNKpv9dnf9dJ2m93M5SSJDMKHP3Rupbq5Xdj2jDfmepAoZe
   5DpGzxUT+UVTdKE4/jtYIfTtV70hqxMbDOJyLS4P19vyrlQjl8O46Mk+O
   HL7cFua3JFDeZp/sRT4lzlhuuc62643Kof5oOSZbrhJmyXefPp1DR3DBr
   6rMbvv8TgQXSGUsRE5KtuVeOkdq5DrlqSQP4tMwOC/sONmkvIyhDpE0Y1
   Q==;
X-CSE-ConnectionGUID: 8FGl3UZGTq2IvG4ek/pgWg==
X-CSE-MsgGUID: 4w8IYu+YQAmyzT8yNpU9JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68325790"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68325790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 04:57:57 -0800
X-CSE-ConnectionGUID: vlSOfEu5SP6w7K6xnZqY+Q==
X-CSE-MsgGUID: xQcP33FOSLarT02Hk9ogcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="203911783"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.160]) ([10.124.220.160])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 04:57:56 -0800
Message-ID: <cd806f6a752d8138b51cb4aa1943176ac511d210.camel@linux.intel.com>
Subject: Re: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix
 slider_balance param get returning wrong value
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, "rafael@kernel.org"	
 <rafael@kernel.org>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>,  "Zhang, Rui" <rui.zhang@intel.com>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Tue, 23 Dec 2025 04:57:55 -0800
In-Reply-To: <LV3PR11MB876863C45EF9B76B52E16369F5B5A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251215063347.3521513-1-kaushlendra.kumar@intel.com>
	 <LV3PR11MB876863C45EF9B76B52E16369F5B5A@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 07:44 +0000, Kumar, Kaushlendra wrote:
> Adding Cc: srinivas.pandruvada@linux.intel.com
>=20
> No code changes.

> Original patch:
> https://lore.kernel.org/all/20251215063347.3521513-1-kaushlendra.kumar@in=
tel.com/
>=20
> -----Original Message-----
> From: Kumar, Kaushlendra <kaushlendra.kumar@intel.com>=20
> Sent: Monday, December 15, 2025 12:04 PM
> To: rafael@kernel.org; daniel.lezcano@linaro.org; Zhang, Rui
> <rui.zhang@intel.com>; lukasz.luba@arm.com
> Cc: linux-pm@vger.kernel.org; Kumar, Kaushlendra
> <kaushlendra.kumar@intel.com>
> Subject: [PATCH] thermal: int340x: Fix slider_balance param get
> returning wrong value
>=20
> The slider_def_balance_get() function returns the array value
> slider_values[SOC_POWER_SLIDER_BALANCE] instead of the actual module
> parameter slider_balanced_param. This means reading the
> slider_balance sysfs attribute always shows the default value
> (0x03) rather than the user-configured value set via module parameter
> or sysfs write.
>=20
> Return slider_balanced_param to correctly reflect the current module
> parameter value.


That is the intentional. This shows what is the current value used for
balance slider.

Setting module parameter is not enough. It needs to be applied by
changing/updating profile, otherwise there is no way to know what value
is getting used now.

Once you touched profile you will see the value you set.


Thanks,
Srinivas



>=20
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> =C2=A0.../intel/int340x_thermal/processor_thermal_soc_slider.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.
> c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.
> c
> index 49ff3bae7271..96307dcb4812 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.
> c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider
> +++ .c
> @@ -80,7 +80,7 @@ static int slider_def_balance_set(const char *arg,
> const struct kernel_param *kp=C2=A0 static int slider_def_balance_get(cha=
r
> *buf, const struct kernel_param *kp)=C2=A0 {
> =C2=A0	guard(mutex)(&slider_param_lock);
> -	return sysfs_emit(buf, "%02x\n",
> slider_values[SOC_POWER_SLIDER_BALANCE]);
> +	return sysfs_emit(buf, "%02x\n", slider_balanced_param);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct kernel_param_ops slider_def_balance_ops =3D {
> --
> 2.34.1

