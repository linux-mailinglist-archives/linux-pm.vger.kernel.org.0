Return-Path: <linux-pm+bounces-37048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 235ABC1BC27
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B105C135A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399572D94A5;
	Wed, 29 Oct 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyPmYQXN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D2BEC28;
	Wed, 29 Oct 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751828; cv=none; b=hK/vNQVCfNWD8wlXzkUwxjnWuo1Dx3EjEhbEaPhjHACXXqdwXVeV4Ggs+OnTe52VhwsM/ltWa/jg5kHoU1eGFY3EA7MdmTnMeYXMjTKXc1lOtNJj4G5wWYOTQQhmaI1pvm8x5enbo8yxkl9xOUvjcTslpPkms7zy7K+gqnaGxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751828; c=relaxed/simple;
	bh=QI+3NuHAULegYSg+VL29kjpFXdr9o+ejvnVWqLJLfPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9MsB5tSFJIJZ9AF+oQGQWpPKQyRNrS6n2Lj5EIcIjNti1+IEpVx5senbJDchaRO2rGePiKvmOo1aMS6pgKUH6CdJjSoQh4kzKeWu3+2lKT0yQxbakFcp7QeCzLPNbWjBdcmIZjPda6nyftzHhxTCusnv7u61kCMQ+yGNUOm+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyPmYQXN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761751827; x=1793287827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QI+3NuHAULegYSg+VL29kjpFXdr9o+ejvnVWqLJLfPA=;
  b=AyPmYQXNmRCE/jeEW46V2J1bHy5w878fG3PdTGafbU5e60Tj6kPP4Y7d
   8eaKVhgb9QyB3/1sWEKO1iHyWmd62SsWKtq5MGM+kK9nfa//tDVlpQ66C
   c4gSnzOfa2i0SXLyaCEv5nUEuJ+pEs6vHRx6fQz5UacDOfVDU6wrG3imf
   zewErOVbTgVPRd3l3D/YgjjOXQ0PKWS/ntTYzmvn50MBtF9w4RzgSNJh5
   UpmnLEwXBKMA3h0u8tkgiICKTyHGonkM+Ef4fWq/wYOFwUgTb4NdoiN+L
   hwDke3gj732KR1AXlNRX/8BjYYhIh/ZyPzh3fQkAI0rPXVtCemNvtuU12
   w==;
X-CSE-ConnectionGUID: C7GA/+psTYePIrq5Jt606Q==
X-CSE-MsgGUID: XpjhBACIRGa/o9kfzv7y1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74994808"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74994808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:30:26 -0700
X-CSE-ConnectionGUID: QAp6n/FITk6+MHT+dMkLdA==
X-CSE-MsgGUID: 2K0V7+sYTO664w/WZy1PQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185580899"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.248])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:30:23 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vE87w-00000003eWe-2GpP;
	Wed, 29 Oct 2025 17:30:20 +0200
Date: Wed, 29 Oct 2025 17:30:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <aQIzDItA9vo0b9FB@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133323.24565-3-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 02:33:21PM +0100, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID.
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Notice that the checking order is important as the machine compatible
> are normally defined with the specific one following the generic SoC.
> (for example compatible = "qcom,ipq8065", "qcom,ipq8064")

Misplaced period, should be at the end of closing parenthesis.

...

>  	ret = qcom_smem_get_soc_id(&msm_id);
> -	if (ret)
> -		goto exit;
> +	if (ret) {
> +		if (ret != -ENODEV)
> +			goto exit;

	if (ret == ...) {
		...
	} else if (ret)
		goto exit;

Even patch will look better after that.

> +		/* Fallback to compatible match with no SMEM initialized */
> +		if (of_machine_is_compatible("qcom,ipq8062"))
> +			msm_id = QCOM_ID_IPQ8062;
> +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> +			 of_machine_is_compatible("qcom,ipq8069"))
> +			msm_id = QCOM_ID_IPQ8065;
> +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> +			 of_machine_is_compatible("qcom,ipq8066") ||
> +			 of_machine_is_compatible("qcom,ipq8068"))
> +			msm_id = QCOM_ID_IPQ8064;
> +	}

-- 
With Best Regards,
Andy Shevchenko



