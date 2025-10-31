Return-Path: <linux-pm+bounces-37188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D56C25427
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A008D1896742
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99834B189;
	Fri, 31 Oct 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3f6WrOs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538832D7D1;
	Fri, 31 Oct 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917216; cv=none; b=e35NsNKL+aLiJ5RPc2fyrilsy1fewowJ4SWFbO7AD9lAxCLSYHYXcnwvHrk9PjXpoeBMBQinsa3MimJ6oEUpA7ZZcu029QWoWeTSYLhpEvORM/zlcBxaqm0LSC0iwhR5GfGdFyTtGstb+u2N96WljNIcaQFCH8gheOaBr1o82vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917216; c=relaxed/simple;
	bh=hkHIbd/2KHBwtbLvW9dmpBJfSBnb3UWSGKN6mKGS77w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORy2MpEIzoyGn0c2HExUKNHm1i14ftwu1amZ4xqpL92lC1Tket9zneyy6n2ao2u03Zv/sHLWQbV1KbMpUWFMOdLGjWc5Ob3nWRwdEj+jBDS2wiVJHMIhoxJy4SoMdBj6pbvxPtOUOR6ByFLB7pTXF6AeSzbbjE+y1ZvwmP5tefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3f6WrOs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917215; x=1793453215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hkHIbd/2KHBwtbLvW9dmpBJfSBnb3UWSGKN6mKGS77w=;
  b=T3f6WrOs/RSKTRmECmhquIinTAHztFAHer5SQcKAKcld16pF81nRHon0
   kTtqq3mg+JTmY1unIn3tS7ALrD5IGXDNt1AHs+sOYnYnLOpfImWrlhfr8
   ti7MZWebesh0YeDVIo3Mn4hCWCYuP3ktuX3mMDc6Y7hGv7NvbL1SDQx24
   43UeTdL8yHn0kMhq/yo0bbE1vfEuUeuSliOqHo4L16toaiXyye+eh1rjQ
   6IYztjKhBOUe9Yq8f7lZDG2H73SXmYmLRuDCCPSyjXtLsAwufYdBj22oL
   FLs4pLtWNFFR9FC4LOTzf+8vGzcevX9anWKkpgDCjmlkSLeNW3KZoxo9F
   Q==;
X-CSE-ConnectionGUID: O6qEG3pdSSqYr9cq1XmoEQ==
X-CSE-MsgGUID: YAL1VxxuRQ+O4tTcEP0wcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81488562"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81488562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:26:54 -0700
X-CSE-ConnectionGUID: YhdcpFCgQv2ggPyZ/MCr5A==
X-CSE-MsgGUID: 5yUGvElYQ3i3h5QeBClyOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="191378438"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:26:51 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEp9T-00000004HHQ-0nVw;
	Fri, 31 Oct 2025 15:26:47 +0200
Date: Fri, 31 Oct 2025 15:26:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031130835.7953-4-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID.
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Notice that the checking order is important as the machine compatible
> are normally defined with the specific one following the generic SoC
> (for example compatible = "qcom,ipq8065", "qcom,ipq8064").

...

> +		if (of_machine_is_compatible("qcom,ipq8062"))
> +			msm_id = QCOM_ID_IPQ8062;
> +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> +			 of_machine_is_compatible("qcom,ipq8069"))
> +			msm_id = QCOM_ID_IPQ8065;
> +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> +			 of_machine_is_compatible("qcom,ipq8066") ||
> +			 of_machine_is_compatible("qcom,ipq8068"))
> +			msm_id = QCOM_ID_IPQ8064;

A nit-pick (in case you need a new version of the series): I would expect
the conditionals be sorted by assigned value.

		if (of_machine_is_compatible("qcom,ipq8062"))
			msm_id = QCOM_ID_IPQ8062;
		else if (of_machine_is_compatible("qcom,ipq8064") ||
			 of_machine_is_compatible("qcom,ipq8066") ||
			 of_machine_is_compatible("qcom,ipq8068"))
			msm_id = QCOM_ID_IPQ8064;
		else if (of_machine_is_compatible("qcom,ipq8065") ||
			 of_machine_is_compatible("qcom,ipq8069"))
			msm_id = QCOM_ID_IPQ8065;

-- 
With Best Regards,
Andy Shevchenko



