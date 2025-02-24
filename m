Return-Path: <linux-pm+bounces-22799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C0A41F2B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513EF3A7E6A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E57221F23;
	Mon, 24 Feb 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGfXPRpo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242C219313;
	Mon, 24 Feb 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400125; cv=none; b=RgnC3hAQ1nI2QgF4ZtRixyvNC2gBs0NQc7YANX9exNlsscDTNaCBWgvRlQ/Z+gHNgN80+GZ9rvOr8jMZAmLvpOSgUrAm/XzTmMWXIEVTE54NNSBNJNynMzeT/ovXPYz+Bl/bBmBKLsfML0MnpFW/F2EqQ8m5YvtKTNVNXQNB+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400125; c=relaxed/simple;
	bh=HY86v1D01B8de8bRnCwQfhrLaS7Uve8orhJi2zLc/AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HooZWejAdcqPSKjuOOuC3L/uYjb4EhgRdtvwvEcOhwT3yfVtWCZ2lBpeFnhtc1QK7jJuqa+tgWgySZTXrNwyLqIdk/QMZrWsj1odfHc+IO1Pd1lxK0QouOdqGXxAKg2vMAKeyXLosxS8ysq3nlrIq//8FE/uXsGstZa5Sxzf55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGfXPRpo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740400124; x=1771936124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HY86v1D01B8de8bRnCwQfhrLaS7Uve8orhJi2zLc/AQ=;
  b=oGfXPRpoazB8Nz67eKcV+7uYQok9c9CXZp+D7vLhxuepnCgePkPabIUK
   w9hDhHHZ0YA9dNLxueXxUoGd4iRFwmL5oAb/8S54kWhF7ozwPKO1fBsGG
   6vvMzP8UTVjdyPL/+eVBzSC6rnIGV+A9oRf8Tru1dLIgrtPRLPL/0zfdn
   5jblIw67GGj6e+mFBVMOSgBP+RGMCf8ydUm1BXLx6e+uBS1My8qLhY66s
   ScASDymsf8Tvk2aIpFuRJ0LAgMiWihe2Wk/Hx7nD4TpJdsfhcxg0qvukR
   tERcSe+bZoasfYsywGAGN1G7UxHU3LSMUN8e8ZT3TYIXrvEOn6y2bu2yo
   Q==;
X-CSE-ConnectionGUID: yCTWskYVRdS2N99KEKK4QQ==
X-CSE-MsgGUID: SXdJp0OjTwOUZiEW/45Xtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52143200"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="52143200"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:28:43 -0800
X-CSE-ConnectionGUID: 5iuv9pjeSqGU3LIzJDbdHQ==
X-CSE-MsgGUID: oR1SJYDNStqf2Ekl4VOMnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116532987"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:28:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmXZb-0000000Eh02-268V;
	Mon, 24 Feb 2025 14:28:35 +0200
Date: Mon, 24 Feb 2025 14:28:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: kernel test robot <lkp@intel.com>, perex@perex.cz, tiwai@suse.com,
	broonie@kernel.org, lgirdwood@gmail.com, deller@gmx.de,
	sre@kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com,
	oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
Message-ID: <Z7xl80RPM6YQgOTj@smile.fi.intel.com>
References: <20250221165333.2780888-8-raag.jadav@intel.com>
 <202502220449.DvJuMgsL-lkp@intel.com>
 <Z7xQ2y-7U5-OhzhB@smile.fi.intel.com>
 <Z7xW2AIz6vUo6mu-@black.fi.intel.com>
 <Z7xa0cGZvGxsGCrI@smile.fi.intel.com>
 <Z7xkb9m_Qc54znOH@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xkb9m_Qc54znOH@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 02:22:07PM +0200, Raag Jadav wrote:
> On Mon, Feb 24, 2025 at 01:41:05PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 24, 2025 at 01:24:08PM +0200, Raag Jadav wrote:
> > > On Mon, Feb 24, 2025 at 12:58:35PM +0200, Andy Shevchenko wrote:
> > > > On Sat, Feb 22, 2025 at 05:41:24AM +0800, kernel test robot wrote:
> > > > > Hi Raag,
> > > > > 
> > > > > kernel test robot noticed the following build warnings:
> > > > > 
> > > > > [auto build test WARNING on b16e9f8547a328b19af59afc213ce323124d11e9]
> > > > > 
> > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/ASoC-Intel-avs-use-devm_kmemdup_array/20250222-010322
> > > > > base:   b16e9f8547a328b19af59afc213ce323124d11e9
> > > > > patch link:    https://lore.kernel.org/r/20250221165333.2780888-8-raag.jadav%40intel.com
> > > > > patch subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
> > > > > config: arm-randconfig-004-20250222 (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/config)
> > > > > compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
> > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/reproduce)
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202502220449.DvJuMgsL-lkp@intel.com/
> > > > > 
> > > > > All warnings (new ones prefixed by >>):
> > > > > 
> > > > >    drivers/video/fbdev/pxafb.c: In function 'pxafb_probe':
> > > > > >> drivers/video/fbdev/pxafb.c:2236:13: warning: unused variable 'i' [-Wunused-variable]
> > > > >     2236 |         int i, irq, ret;
> > > > >          |             ^
> > > > 
> > > > Ragg, please, fix this, and issue a v2 with the link to fixed PR:
> > > > https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com.
> > > 
> > > Sure, but perhaps wait a few days for review comments.
> > 
> > Then perhaps answering to the cover letter that the maintainers who want to
> > apply should use the updated PR?
> 
> Okay, but I'm not sure how this plays out for those who already pulled
> the old PR, i.e. Sebastian.
> 
> Anything to worry about here?

I already informed him and Stephen about a new PR I just sent a few hours ago.

-- 
With Best Regards,
Andy Shevchenko



