Return-Path: <linux-pm+bounces-37187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398AC2540F
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0C2B4EA4DD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CA346790;
	Fri, 31 Oct 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lcoksx+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E700169AD2;
	Fri, 31 Oct 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917003; cv=none; b=JAf/4OAylkkQjunAg7eWnAIK2NdmKIbtnFfHTey1Zk6DwQO5N0DbFmNww2K7QKV9CThP05votdjT8DRU8mN+GhbSOgOHmfiXIy7lQhIXlmNlpt4FoiOKselEIP1fmWBmW4ZwTf0mWTiPJ66Txr8mtpqDOoaTrv3XBGe/aju/yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917003; c=relaxed/simple;
	bh=bkGhgi8iqi2+AfB9qzXTPdblZcv8oMNGHFucB7oeB10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlyxAwwLc2x0mGt3owjE3C8p8ywk9FOcJxLjHq8Xw5ydJYe33C8sTzQAPWLJGmJ1Ea1RHhkVNOyc04HhMuq/9qJ0omw0vnzdTHuDXGYjnJp6PPW7buhP8sZZ4ogTisZhAxChSKciAh+Mvm6gw67ahlPlg+evKTB64Avm9tGmuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lcoksx+C; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917001; x=1793453001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bkGhgi8iqi2+AfB9qzXTPdblZcv8oMNGHFucB7oeB10=;
  b=Lcoksx+CWSmKjv5rCsC6cX8s6qe0IKC5z0sNGv77Wq/iv1n8tYUzaQT9
   yBFuB5m8WZYtPz+64J3ewavllcKLsOctpVp18hTvgRwp1qif7QnRXzbto
   jNcRf9eSNNDBuMvsOXDdNPpfnDQo+80sGgsXe6tm0iBVeED5bl0Ba35xR
   Zd4qh1HRUA4+VQsqB/ahAl40D77xQxhr7w56XHMJHOc2aCwN7TqR9hpi3
   HdEkRgF9VwceOd3eGCBnoUYCM2RMlzM7kcsNR8dCjYwWbYsPE0tXs3TB5
   8OUUkXIGVj2Xj3kcte2YLXgZI79Zl+Yde7tPhQ8c2HnVx70VIOX4oHBdB
   A==;
X-CSE-ConnectionGUID: YOCtM3vQQoyjECfquzrbzA==
X-CSE-MsgGUID: oTdEwzt4TSWp9mPM8yHwmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81488216"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81488216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:23:21 -0700
X-CSE-ConnectionGUID: 5cCMTEaiSwOoLsWBZbZfew==
X-CSE-MsgGUID: RQzTYXkCR2ew3mtRYL+fkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186976021"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:23:18 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEp61-00000004HEu-1zVO;
	Fri, 31 Oct 2025 15:23:13 +0200
Date: Fri, 31 Oct 2025 15:23:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] err.h: add INIT_ERR_PTR macro
Message-ID: <aQS4QOBC_LLSicQQ@smile.fi.intel.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031130835.7953-2-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 02:08:32PM +0100, Christian Marangi wrote:
> Add INIT_ERR_PTR macro to initialize static variables with error

INIT_ERR_PTR()

> pointers. This might be useful for specific case where there is a static
> variable initialized to an error condition and then later set to the
> real handle once probe finish/completes.
> 
> This is to handle compilation problems like:
> 
> error: initializer element is not constant
> 
> where ERR_PTR can't be used.

ERR_PTR()

In case you need a new version, please address the above.
Anyways, LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



