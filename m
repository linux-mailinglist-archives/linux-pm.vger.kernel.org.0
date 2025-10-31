Return-Path: <linux-pm+bounces-37195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E26C2597D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ADD1A6165E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BF34C989;
	Fri, 31 Oct 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvZlJupw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666D34C811;
	Fri, 31 Oct 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921272; cv=none; b=dciDHKUEZ3PUwTej1ZIq0ni9ZTjxPI31Q2bZ9GPNJnif2rnfJrzV3Is+xvYcMaXyAZ3sy0BfSATXD+T4WvHLImCPXbCzrWjc+b44i96n55MhQJJcez8iZgZ+AQ5regRtG6CsD0XT4bV3ZbVLYcV2b2uu1wALjsSxzzrEzxoprB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921272; c=relaxed/simple;
	bh=/g1AxzJQOcya88xAhA0tStQsU9mezZXtDTiynle222Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7QscrN+x9qpRSmiKCtDpIsXPXTdIMAOKyCtbA5+FsvR1oGJc4jyTahUapxsIth7Xm1aPvVvntnBuZcjGaLKFpk5m8RyayO87TecL5osp/FObC806ennasEl+t7Hrm2zs/q9pZPgmJDh+myoUJL0T88+3dBGyWbFdYVPrWKkpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvZlJupw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761921271; x=1793457271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/g1AxzJQOcya88xAhA0tStQsU9mezZXtDTiynle222Y=;
  b=cvZlJupwnd4jtEq6U0PT2GcuxICUJZ0aklBDtrQWyzkWd+EJ7/QCZOSY
   pXi19iz/GDs9bO3dxHJu62JSPh/xOHEiiBU7vxJZonkQKzpvDeTFluPNR
   RUmN+zmlbo/gqDkNo9+jPoS96MOlv5vDCQKhk1gMc0G0PfFtt/DFpXPzY
   g6phIM8UkzoVcxYxkgHesBhpdyqIlx0sAwaF2xVWpwWFKM01O/iyrqkfV
   NMRqa2lslYOFkP8yOhWw55Bp4GsG35AB+BE2lYO54EyyfMOsHgbHPMhSw
   P00Mm5Xje1YH57uzw9P0F3SehtA/hua0VhzI4RGDR8+/heHAMXKSLlipm
   A==;
X-CSE-ConnectionGUID: r40qX6xxQkC+XhtIRK/zwg==
X-CSE-MsgGUID: Qxs2tb4bSEiKZXEcG7Mzzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="51654686"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="51654686"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:34:30 -0700
X-CSE-ConnectionGUID: /EQF3V/oQ/+hpsvXAymnpg==
X-CSE-MsgGUID: DJ4WcSkuTQmrSZQtuuieLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186990352"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:34:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEqCt-00000004IPL-0Zcq;
	Fri, 31 Oct 2025 16:34:23 +0200
Date: Fri, 31 Oct 2025 16:34:22 +0200
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
Message-ID: <aQTI7o1HQYbQ_Pl2@smile.fi.intel.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
 <6904c563.050a0220.a13ee.0212@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6904c563.050a0220.a13ee.0212@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:19:12PM +0100, Christian Marangi wrote:
> On Fri, Oct 31, 2025 at 03:26:46PM +0200, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:

...

> > > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > > +			msm_id = QCOM_ID_IPQ8062;
> > > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > +			 of_machine_is_compatible("qcom,ipq8069"))
> > > +			msm_id = QCOM_ID_IPQ8065;
> > > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > > +			 of_machine_is_compatible("qcom,ipq8068"))
> > > +			msm_id = QCOM_ID_IPQ8064;
> > 
> > A nit-pick (in case you need a new version of the series): I would expect
> > the conditionals be sorted by assigned value.
> > 
> > 		if (of_machine_is_compatible("qcom,ipq8062"))
> > 			msm_id = QCOM_ID_IPQ8062;
> > 		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > 			 of_machine_is_compatible("qcom,ipq8066") ||
> > 			 of_machine_is_compatible("qcom,ipq8068"))
> > 			msm_id = QCOM_ID_IPQ8064;
> > 		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > 			 of_machine_is_compatible("qcom,ipq8069"))
> > 			msm_id = QCOM_ID_IPQ8065;
> >
> 
> Hi as said in the commit, parsing 65/69 before 64 is needed as we might
> have compatible like
> 
> "qcom,ipq8065","qcom,ipq8064" so we might incorrectly parse msm_id
> ipq8064.

Oh, this is unfortunate. Wouldn't it be possible to use some API that returns
an index (or an error if not found) of the compatible? I believe we have a such
for the regular 'compatible' properties.

-- 
With Best Regards,
Andy Shevchenko



