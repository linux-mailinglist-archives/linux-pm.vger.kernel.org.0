Return-Path: <linux-pm+bounces-22797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB284A41E07
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0520B17B512
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5C219308;
	Mon, 24 Feb 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaoXzVOq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F713E40F;
	Mon, 24 Feb 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397276; cv=none; b=ZLKUnk7B3T7fSxl61NrEQPQHQSenuGOCorYAZJApgTpgbM7Zu3yriJ2klp/lPUB5Isrm5Q+O7PkBjIYLe+2zrvpDjvq79LrDOYFcpU2Q5Eu5pA2ZMINQj0jom6Ymy4jqt57yI579c6Y9/tC9CHZexc6LlJ5kLwrfHtmRGACVZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397276; c=relaxed/simple;
	bh=585yBmWTLfUiF2tCoZqBlv/iebLuolZUUVpK5OX179c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhmquu1NhRl6flhEMvi3xFsiwrWD6uwXtGUumi+WnsapSDvA0400N0rcKeGyX3AisaFYtTJN+55pb2ceSRZs0I4VwQAZ7/w64lrli09UmpcuRoG6o46F/LaGCroZyCv00cH0xOM72776112TIQ83UVJrQrrrZaL9A3Bc9tHho/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaoXzVOq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740397274; x=1771933274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=585yBmWTLfUiF2tCoZqBlv/iebLuolZUUVpK5OX179c=;
  b=LaoXzVOqMFT1Sixr226uuiOmFJZ+bPJ2aKNQ6BCzEd30QkbBAqfRNsew
   DWvXELAAvsOc0It8mwOMn/NspnAzsbnCEYLklL7xYsk7fHJgQGKKP/rYR
   KzuQxnm4DbmhyvrxXU/S/ZinnWxSxbuZnfjRmHDv9RgzFL3afsOAfzl9z
   aJ7Q/81DIc9ByAwCJrnz9UjxOmuufRUAivU8pMla4tXwOPnSBCP0L/G7+
   qmqfiPKh2b+CvVtDIVQW820yO2ivgoEnvH3S5xhLeXAIsvFMKRWUL41Pv
   yfsSDUwe5gw+GkkMW1wmPkYNoPDgx5VKYrc9y/qQ/FBYJ21ru7lSoT2S+
   Q==;
X-CSE-ConnectionGUID: Je5eVPCpSQ2I8wmq9nBDgg==
X-CSE-MsgGUID: +b95ah6vRrGx+7e1lww2HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="63616705"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="63616705"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:41:13 -0800
X-CSE-ConnectionGUID: FaoyXpzRS8exTUEKIk9PwQ==
X-CSE-MsgGUID: F4XAk5u0RMiaOhmoMCbv8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116054034"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:41:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmWpe-0000000EgM4-1czv;
	Mon, 24 Feb 2025 13:41:06 +0200
Date: Mon, 24 Feb 2025 13:41:05 +0200
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
Message-ID: <Z7xa0cGZvGxsGCrI@smile.fi.intel.com>
References: <20250221165333.2780888-8-raag.jadav@intel.com>
 <202502220449.DvJuMgsL-lkp@intel.com>
 <Z7xQ2y-7U5-OhzhB@smile.fi.intel.com>
 <Z7xW2AIz6vUo6mu-@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xW2AIz6vUo6mu-@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 01:24:08PM +0200, Raag Jadav wrote:
> On Mon, Feb 24, 2025 at 12:58:35PM +0200, Andy Shevchenko wrote:
> > On Sat, Feb 22, 2025 at 05:41:24AM +0800, kernel test robot wrote:
> > > Hi Raag,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on b16e9f8547a328b19af59afc213ce323124d11e9]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/ASoC-Intel-avs-use-devm_kmemdup_array/20250222-010322
> > > base:   b16e9f8547a328b19af59afc213ce323124d11e9
> > > patch link:    https://lore.kernel.org/r/20250221165333.2780888-8-raag.jadav%40intel.com
> > > patch subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
> > > config: arm-randconfig-004-20250222 (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/config)
> > > compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202502220449.DvJuMgsL-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    drivers/video/fbdev/pxafb.c: In function 'pxafb_probe':
> > > >> drivers/video/fbdev/pxafb.c:2236:13: warning: unused variable 'i' [-Wunused-variable]
> > >     2236 |         int i, irq, ret;
> > >          |             ^
> > 
> > Ragg, please, fix this, and issue a v2 with the link to fixed PR:
> > https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com.
> 
> Sure, but perhaps wait a few days for review comments.

Then perhaps answering to the cover letter that the maintainers who want to
apply should use the updated PR?

-- 
With Best Regards,
Andy Shevchenko



