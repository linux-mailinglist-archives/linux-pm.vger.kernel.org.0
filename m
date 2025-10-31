Return-Path: <linux-pm+bounces-37189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F3C2543C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C52C3B4409
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5334A77F;
	Fri, 31 Oct 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTp1qtKy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CC345CD6;
	Fri, 31 Oct 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917271; cv=none; b=JeB1rEMIRlWOC47nHHVQD7rGn7nATOM25bfzLxf0Lz0UqxQbIH47RDEu5h5QfWIxQLmhCoE0vqjlo80iTkk08BLqrKg0SZkZPUuCzmO7HOM3AWucu/3VYGhd2df/v51KmYHopEGI1/87CFdYLG/XOJ5hRYL5LpfXHgE5/llx/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917271; c=relaxed/simple;
	bh=NEaXmL/KjogWa3Ar76UBtjP3Q9rWcWDv9QQSToHQBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz2VToRaMAyAWnRbuWjoVDstPHEgnWE3M0ek/k5Uy38eHuKXV8t35EkUtiVvhZ1qtloFIL0z5c4YIteMxrTHZcK6F9x8ZVPb5VIyieG/zo6gGfQXmyrgjZ/uRPfN5ags+Pyj2spe5EUzevI3D2RUmBf2a+hdgxh4mIyuBQjA5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTp1qtKy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917270; x=1793453270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEaXmL/KjogWa3Ar76UBtjP3Q9rWcWDv9QQSToHQBFY=;
  b=GTp1qtKyorVCTvkBNVd3FXaN4fStykMOA/3xOoEPH4d3FaimzlrHUsm7
   ZPYAt4Nca7n96XVMo4+5tRKwELfoWWO2sfzv2/piQiwTGHLIUcd3KLg03
   YoFsmP5xI+vdMp6kTXnwdux0wkMRTkITtFCUHEr3rxup5io8J+8szj/cM
   jqCaLZlkJQosmoDzLia/em1DBf3MXDTrUg0dhxdzQTOSGz5snVvyAsQrZ
   cvqdrcDDvKeUHClrlbhWUSId6xQnmSQShwq/lKHXcjAMhTYdocwjR8/iU
   QnPwgAPk/+6Wy+eMDz4iVNn1znJRUqjWlNaSijF8wBpJSEjsgqL0+VZyM
   A==;
X-CSE-ConnectionGUID: M2ijntaDSwm4bRp+hNphbw==
X-CSE-MsgGUID: i3eJZvurQbewxj7m4S7UKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="89541714"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="89541714"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:27:49 -0700
X-CSE-ConnectionGUID: /crBrY90S+C+G/SXMgJaVw==
X-CSE-MsgGUID: M2ffBQeRRb69LG5jAHjCVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190583116"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:27:47 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEpAM-00000004HIg-09eC;
	Fri, 31 Oct 2025 15:27:42 +0200
Date: Fri, 31 Oct 2025 15:27:41 +0200
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
Message-ID: <aQS5Te-nUGLlYNmL@smile.fi.intel.com>
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

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



