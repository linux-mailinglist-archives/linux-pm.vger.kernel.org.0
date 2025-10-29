Return-Path: <linux-pm+bounces-37050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE27C1BB85
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 838645C6FE2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBFD33A010;
	Wed, 29 Oct 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxUI6nFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81C33F6;
	Wed, 29 Oct 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751976; cv=none; b=e6alufCLuaDRPgEbRijDkx02wSnQ5OZjubLr0YjKbpCqaDhm/MoCWdDJlWIplDCRlqJb30+b2qy3dJNHQChyCz9BBfsiptuTnNBlnJCBuoeQFydJCnaFEfh6NzgXKoMySX97/Mfcf87pNi+PH/QRhr5NZ0s5EEASpIs/P0nUU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751976; c=relaxed/simple;
	bh=TxENEe7NQO6UcmjfLxpYlcw7Ossg4UvvqD86QkB1Oa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gysvmhvfQM59risoTkOsGzDPqI+xYAdulUswzLytpQ9gWGiR7xm3Usf7+98+sV0hKvz3FyVWoEVvLAC9T+p0wkFxnOvV7qNfvhsdb8mPBZQgrwCnGFZ60BSpzAjCVI5h0cglyUuYuRVz9IlPmsFB1bT00r8imx8ldqpnQnEo/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxUI6nFL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761751975; x=1793287975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TxENEe7NQO6UcmjfLxpYlcw7Ossg4UvvqD86QkB1Oa8=;
  b=hxUI6nFLLM45V54F03luFT3PaM3XAtseC9qP+ASgyZru9C0zpzyLmPMC
   BteqGUbH4k0u1kcEJfv2IjyOBd1caBlS9dYzvDwRQIjctMUIJ562Wgc+K
   lZCqDZJGBS/xk2nVV4yslYJCDYQrVGwytYBDXqAAQ4n2cliJLeCCMhFR8
   Eo7btwKMdczevDqMFuyo85TgfMJ9TJXw3I0jhepiGw3iV1WL+clSF4pp9
   Jy3ZpNdwIQrAlL/uTCu60OR0Y9BFIOc3B4UT9W2HgdE+KXtzR/I7Aat81
   12MyBlhD01QU17cnR3ImhNVryl5H0ANvnXOPfQbWRq2s/n90NsD6qITM1
   A==;
X-CSE-ConnectionGUID: 1N/HUreiRSWKxSJEOUcjjQ==
X-CSE-MsgGUID: gxUkZQmeT8u7BbZERVc5/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86505100"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="86505100"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:32:54 -0700
X-CSE-ConnectionGUID: FYKE3uOkTjORrToYrrDzFQ==
X-CSE-MsgGUID: SxPWkYJWQgWPtT/6XByhZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184940801"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.248])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:32:52 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vE8AK-00000003eYl-2uZp;
	Wed, 29 Oct 2025 17:32:48 +0200
Date: Wed, 29 Oct 2025 17:32:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
Message-ID: <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133323.24565-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 02:33:19PM +0100, Christian Marangi wrote:
> Add ERR_PTR_CONST macro to initialize global variables with error

ERR_PTR_CONST()

> pointers. This might be useful for specific case where there is a global
> variables initialized to an error condition and then later set to the
> real handle once probe finish/completes.

Okay, this has two caveats:

1) naming is bad as it suggests something about const qualifier (and not, it's
not about that at all);

2) it doesn't explain what's wrong with ERR_PTR().

...

Note, I'm not objecting an idea as a whole.

-- 
With Best Regards,
Andy Shevchenko



