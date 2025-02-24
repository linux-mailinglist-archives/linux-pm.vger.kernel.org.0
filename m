Return-Path: <linux-pm+bounces-22795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44EA41D8F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D461798D4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805D2627E8;
	Mon, 24 Feb 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIgyjQrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B735257AC8;
	Mon, 24 Feb 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396258; cv=none; b=ulCrSc8dF7Db4BnlfAp/5lqgAUwH1eSk3ndN6CxPS8CmhWDopTc8XTdBe9SPKagxIsy03E23DkBOuPobg/s2a2WrLzuwmAzGV1armjFH3uLAeWGxARoMuo6CxjronsIDP4L0ML48b1DaSJjRm8necIPQF4b2I+vUASu2CS6j2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396258; c=relaxed/simple;
	bh=JEcP7qUK6u00OAPytLU3TUQotFYzjM6j/mx4+g5gaUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBhr6+nH8Ulkfwc86Y4KrwdxN9tHIPvl3BRdbD1i9U7jbC0pOxIsbc92tmQau6ulkI1XywtB/UjLkZ9+FlbPC8kO3GKc8Cy3WW1hWqUpSoNW5vzUQ+GBCk5T/19BqBkqB1tYhYep+gFE4sP6Mh+A+9QVGh0vgiHOpnC4AZLHWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIgyjQrb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740396256; x=1771932256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JEcP7qUK6u00OAPytLU3TUQotFYzjM6j/mx4+g5gaUo=;
  b=DIgyjQrbkeRqNWPkeg47gnpy2SynWRatdH9otyUEy6iiCErFWbhtLsd3
   BrimtGIKJPA1zYpCC/exr6vX8bW2JL/9IcFsZ3e/c9wQLr6flQk7lHRmk
   4cIUpxQb8ejArKf/XKWp0Bl5FxzMlWRgaAgmum/72Zz+4BrrG7TF1sVnk
   BTMclSyHO4qLPDY8FfpqD2wE+Wpsl5Iuuxa3+oEtegN4cm9FN5U+mp0cE
   DHz55Lz368Mmv0PptD3jKz/K+dNhZssID1SEKU1Y6rIlcd1t0JIL+eykR
   zbtRomloI5oq1/aX264FZHL06VUY//IBmZoLIPvquwSyf2hY2Tv5YV+MS
   w==;
X-CSE-ConnectionGUID: aWTxoC83Qc609azyz6kJ/w==
X-CSE-MsgGUID: zW3fyXE2Sqa4BS8gUdaFjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41284554"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41284554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:24:15 -0800
X-CSE-ConnectionGUID: XyR0He+eS9uuuEihv2486A==
X-CSE-MsgGUID: u4XpFd1CQeOL5c8P45fx7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120159488"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:24:11 -0800
Date: Mon, 24 Feb 2025 13:24:08 +0200
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
Message-ID: <Z7xW2AIz6vUo6mu-@black.fi.intel.com>
References: <20250221165333.2780888-8-raag.jadav@intel.com>
 <202502220449.DvJuMgsL-lkp@intel.com>
 <Z7xQ2y-7U5-OhzhB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xQ2y-7U5-OhzhB@smile.fi.intel.com>

On Mon, Feb 24, 2025 at 12:58:35PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 22, 2025 at 05:41:24AM +0800, kernel test robot wrote:
> > Hi Raag,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on b16e9f8547a328b19af59afc213ce323124d11e9]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/ASoC-Intel-avs-use-devm_kmemdup_array/20250222-010322
> > base:   b16e9f8547a328b19af59afc213ce323124d11e9
> > patch link:    https://lore.kernel.org/r/20250221165333.2780888-8-raag.jadav%40intel.com
> > patch subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
> > config: arm-randconfig-004-20250222 (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202502220449.DvJuMgsL-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/video/fbdev/pxafb.c: In function 'pxafb_probe':
> > >> drivers/video/fbdev/pxafb.c:2236:13: warning: unused variable 'i' [-Wunused-variable]
> >     2236 |         int i, irq, ret;
> >          |             ^
> 
> Ragg, please, fix this, and issue a v2 with the link to fixed PR:
> https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com.

Sure, but perhaps wait a few days for review comments.

Raag

