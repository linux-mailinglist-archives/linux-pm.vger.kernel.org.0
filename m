Return-Path: <linux-pm+bounces-37047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CECCC1BBFA
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F12622408
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689B324B3C;
	Wed, 29 Oct 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3sYZJ4Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089A37A3B9;
	Wed, 29 Oct 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751662; cv=none; b=plODmPWmbAvSuYFzw6obtKNNHld1Gsrdm3Y1aYzc8JmP1Tml1NOv/LfeUnOYtLiAhKLrxU0mqJLprr9zmF15fdCGSLcC0hUxXe/E8Nar79WrTggvEv/LkxD5liUm2RSvgv2a7i4suLqIaItH0sMAWkswwBi2dfrzF8PXrkvKFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751662; c=relaxed/simple;
	bh=+c2yWfsFAtcqK/RTBWhiA0Lm5EnE7WpuD065rADWS20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXhRKlVqk3rexyRW/xJfWcuk3yyxwxR1FNWhNOFj5yv9jdjDIhMpSDC6hh9R2dULTFsjsTcwMrS3eDoyZtt6bVyece9eBdx9zirxSWeXbzKW6Aym6C3715xBX6EdweyO5je/BY85M8hfFZgzRMcxEcXh2WQDtGvFQUSWgNb3Opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3sYZJ4Z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761751660; x=1793287660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+c2yWfsFAtcqK/RTBWhiA0Lm5EnE7WpuD065rADWS20=;
  b=T3sYZJ4ZOfXxq+fhVDgdgIWandmqr3igJ2ZL1NRAJ5e6ZmqidVpC0w54
   V2FNaI8aj9Fp5w/oGfvLwNviI28fsLZu4vNl20jffXwJcIvoBWPf0PlqM
   gKKriFl9FSFQLdIRITF8TYIN5jfcNmR1pwPcHZVCXd2T3b4t0KKF6W0d7
   ei1gp+rqU70PZzgFiGhNbB5AmMMPudatckK8wK64lra5t9HuJ3w1LvAzW
   BBKI6MwvJnPOHospnHYDIhYW/Nfp4KeY5RTa4FY2Fub6iaXsvl3iepUe3
   lQeTetiK9KYNkqGQbc2TblIxshpF0jy4v1T3Sq8Bu5HRj2+BhOjPDe4zK
   A==;
X-CSE-ConnectionGUID: uXQzv2MhSxy67/Gi9OLYew==
X-CSE-MsgGUID: 2HT2pk+hQM6W2Pv5OP2KrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="66492835"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="66492835"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:27:38 -0700
X-CSE-ConnectionGUID: Uk4wX8dcSUydHcVqgfa9Jg==
X-CSE-MsgGUID: rP7bmV0lQYu+vJXVD2B/1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="216353841"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.248])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:27:37 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vE85F-00000003eUN-2QGi;
	Wed, 29 Oct 2025 17:27:33 +0200
Date: Wed, 29 Oct 2025 17:27:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: smem: better track SMEM uninitialized
 state
Message-ID: <aQIyZfQ-Tvxmh6vL@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133323.24565-2-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 02:33:20PM +0100, Christian Marangi wrote:
> There is currently a problem where, in the specific case of SMEM not
> initialized by SBL, any SMEM API wrongly returns PROBE_DEFER
> communicating wrong info to any user of this API.
> 
> A better way to handle this would be to track the SMEM state and return
> a different kind of error than PROBE_DEFER.
> 
> Rework the __smem handle to always init it to the error pointer
> -EPROBE_DEFER following what is already done by the SMEM API.
> If we detect that the SBL didn't initialized SMEM, set the __smem handle
> to the error pointer -ENODEV.
> Also rework the SMEM API to handle the __smem handle to be an error
> pointer and return it appropriately.

...

>  	if (le32_to_cpu(header->initialized) != 1 ||
>  	    le32_to_cpu(header->reserved)) {
>  		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
> +		__smem = ERR_PTR(-ENODEV);
>  		return -EINVAL;
>  	}

I find this a bit confusing. Why the error code returned to the upper layer is
different to the stored one?

...

Also, the series of patches should include the cover letter to explain not only
series background but additionally
- how it should be applied
- if it has dependencies
- etc

-- 
With Best Regards,
Andy Shevchenko



