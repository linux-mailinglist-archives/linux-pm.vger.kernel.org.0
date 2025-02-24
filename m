Return-Path: <linux-pm+bounces-22798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D6A41EED
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4014E3AB5AC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8D23371F;
	Mon, 24 Feb 2025 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgOB4+I0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9222192F9;
	Mon, 24 Feb 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399738; cv=none; b=b3Q9ZzNiOst/i/Vpt+eTTmhiLQMnl3n7JBmjsl7w5j6j+/Zd/bL6gJq6KiYYYQv2uudDZfRYQEQQdFCUIXl0Fm78s4fxTK7Fo6dWaefj63Q4uEgVoVuAXaIQfR/Ag1OJ51VAWkzd3XVqgHWLHkQAaz5l/10Tzj+34eOYubGdHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399738; c=relaxed/simple;
	bh=HFUefC/P5P0u1guY5j9N980bP23neVViId3YrVW8xJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMqFLvpPAX6/Sicm1H7MYwhSLelFXlvHPaLo9BExiY3/E4tgOU0opjv2Nnfuk1tPH5zzIssdMLOyzKDZF2uqmgTE43LfO8Wo88B015XWhWTwHjrA0enT85HKUuDGu8AthG3W25fZYqANWGogsC6Wb1P5qE5r1EkTRjIrgREujCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgOB4+I0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740399736; x=1771935736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFUefC/P5P0u1guY5j9N980bP23neVViId3YrVW8xJ4=;
  b=WgOB4+I0DzWSlyqMzsmrTdq8bK6COP2BFnsR30cPKNz6l/3yIB4bCiaK
   tcLmRrZ4xPvlmySdwxyXYaSf1vUJzM4zK8T8Mo0CrPkC+2UFJ8SWSwC9Q
   B65A/sL1hBAwfkzLPJ3ogL886hTKCrfSdSFt2bZCTpq/OPvv2O1VXM4tL
   UpGrAlZf7LLffpT58ZiPA+eOOdQF+ugppVdREpXdZQhlAjo+gN/cB2Sq0
   Zea7KVYs/1+6LmZ549+r/lvD5t1ZELzfpIfhGAtHhexw6EQajYh9+tqHq
   2m15rACDVR7YESYU+kZhZDxG2/Bq6taKJ1+SeVPLE1wvqnDffzBw98LaV
   Q==;
X-CSE-ConnectionGUID: I5OWSUiaQK+WCiEFKwui4A==
X-CSE-MsgGUID: K3dDzPUQRY+gfIxaAP6rTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52552225"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="52552225"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:22:15 -0800
X-CSE-ConnectionGUID: ZrQLmEUcTo+rS7YahFOsHQ==
X-CSE-MsgGUID: a+u+R8KQQWaj7Y8awt/CjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116034465"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:22:10 -0800
Date: Mon, 24 Feb 2025 14:22:07 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, perex@perex.cz, tiwai@suse.com,
	broonie@kernel.org, lgirdwood@gmail.com, deller@gmx.de,
	sre@kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com,
	oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
Message-ID: <Z7xkb9m_Qc54znOH@black.fi.intel.com>
References: <20250221165333.2780888-8-raag.jadav@intel.com>
 <202502220449.DvJuMgsL-lkp@intel.com>
 <Z7xQ2y-7U5-OhzhB@smile.fi.intel.com>
 <Z7xW2AIz6vUo6mu-@black.fi.intel.com>
 <Z7xa0cGZvGxsGCrI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xa0cGZvGxsGCrI@smile.fi.intel.com>

On Mon, Feb 24, 2025 at 01:41:05PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2025 at 01:24:08PM +0200, Raag Jadav wrote:
> > On Mon, Feb 24, 2025 at 12:58:35PM +0200, Andy Shevchenko wrote:
> > > On Sat, Feb 22, 2025 at 05:41:24AM +0800, kernel test robot wrote:
> > > > Hi Raag,
> > > > 
> > > > kernel test robot noticed the following build warnings:
> > > > 
> > > > [auto build test WARNING on b16e9f8547a328b19af59afc213ce323124d11e9]
> > > > 
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/ASoC-Intel-avs-use-devm_kmemdup_array/20250222-010322
> > > > base:   b16e9f8547a328b19af59afc213ce323124d11e9
> > > > patch link:    https://lore.kernel.org/r/20250221165333.2780888-8-raag.jadav%40intel.com
> > > > patch subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
> > > > config: arm-randconfig-004-20250222 (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/config)
> > > > compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202502220449.DvJuMgsL-lkp@intel.com/
> > > > 
> > > > All warnings (new ones prefixed by >>):
> > > > 
> > > >    drivers/video/fbdev/pxafb.c: In function 'pxafb_probe':
> > > > >> drivers/video/fbdev/pxafb.c:2236:13: warning: unused variable 'i' [-Wunused-variable]
> > > >     2236 |         int i, irq, ret;
> > > >          |             ^
> > > 
> > > Ragg, please, fix this, and issue a v2 with the link to fixed PR:
> > > https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com.
> > 
> > Sure, but perhaps wait a few days for review comments.
> 
> Then perhaps answering to the cover letter that the maintainers who want to
> apply should use the updated PR?

Okay, but I'm not sure how this plays out for those who already pulled
the old PR, i.e. Sebastian.

Anything to worry about here?

Raag

