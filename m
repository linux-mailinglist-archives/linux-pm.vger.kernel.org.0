Return-Path: <linux-pm+bounces-17194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E399C1917
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410FAB2389F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C01E0E1A;
	Fri,  8 Nov 2024 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix2xGn8l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3111E0B76;
	Fri,  8 Nov 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058034; cv=none; b=PY+pXRveS6z2dKIPlu/WsH8o9d8TbGl9ahAc38y9ItzL0QYgvhsBZZ81SiC3WH3aEPGRSG18PEFUQiRGh5cM8UZjfFfeN8vxtq+FGIGrzVAQgaEVIJQHkeLp8nG5SVjeCr71gL9LYMTyUuxcHb8+vQVQ6J1fu/ZGPnHG8eLcQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058034; c=relaxed/simple;
	bh=D7B5XodQaqJKTjXD1DW9DcR4uCUzxko5GPGAqZoHL5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWih44cFddXXXv5vObbwFvuXFLMWgqPRWEoj082vWwJ4FKNDGm6yr+mo7CizYxU8w+X8WLVHn8Jm6wI8RCpLs7fzl6GcQ2eLqcILIr9i0qKVwS1D4OkR5R1GxEGkoXwO02QRSRsPYqbwVIey/iB/Mg+F1IsN3Km+xh2ipNl1o+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ix2xGn8l; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731058033; x=1762594033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D7B5XodQaqJKTjXD1DW9DcR4uCUzxko5GPGAqZoHL5U=;
  b=ix2xGn8l7QPrHnnKEfJ62+Q9EfNp/XalClhSUGu6iyb52TjeiOLg67It
   UcBGjBVN65o51zgcNMYCyt8RWtp72nRYuoFDtItoWEXk7Rtflj3vahOkz
   qwNBGLuhBWNGcup2o2VxdLOMmn41NT2Z+tNKN5QEJZDz0gL6lxlu4sNu7
   bKwym+ZUpqhCH+XIo72xKbaRjeS8Ck99EEAWhPOJJqFdVt0BehO/mbxRP
   9YLKpFGl8z6sJadTTNQ9/HMYjGw7Jx7ixTNpDZy2C3yFHWwpt5Qc1KwuF
   gBcHwo/Hh/4WZDIrqZOJXFAbxFjJHaIHULY1Akd6AnRUEGXL+qWhAEaHK
   g==;
X-CSE-ConnectionGUID: Abr5/WI2RzSMt3oV9BGUww==
X-CSE-MsgGUID: iYxDZSj0R4iRzDoX0UvW/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42319100"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="42319100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:27:12 -0800
X-CSE-ConnectionGUID: cShRvmNnRke9JDdYG7Y44A==
X-CSE-MsgGUID: 5AsLQBeoSOulrEbSe10sww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="84998014"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:27:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t9LGm-0000000CYPT-12GD;
	Fri, 08 Nov 2024 11:27:08 +0200
Date: Fri, 8 Nov 2024 11:27:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] cpufreq: loongson3: Check for error code from
 devm_mutex_init() call
Message-ID: <Zy3Za5JvLjk-OYjp@smile.fi.intel.com>
References: <20241031134719.2508841-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031134719.2508841-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 31, 2024 at 03:46:34PM +0200, Andy Shevchenko wrote:
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something. Add the missed
> check.

Any comments? Can this be applied now for fixes, please?

-- 
With Best Regards,
Andy Shevchenko



