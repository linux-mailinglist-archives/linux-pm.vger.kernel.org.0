Return-Path: <linux-pm+bounces-22793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E827A41BCF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 11:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF717073A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC4257AFC;
	Mon, 24 Feb 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dh5xXM6n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C5257AEA;
	Mon, 24 Feb 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394726; cv=none; b=BFSzKSlefWBI2Nw4hHWVm7wfIJEi5rwizWNpd+j3AMfoyKGcfQcouOWk8TNJ36u5d8RKvofM2+HQy5sfh0Qeqd8mkk1kWyxhHbmacf9GMXyt+MwHS8cCR/ERL1bimlOk1MdYaCKjAnfVRixhhxuIgbtDIKJceTTmQOVb6OgbOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394726; c=relaxed/simple;
	bh=Gd0nmKi+y7imohMgl2KoUoI5yg1NN3mViH62L60pt44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGM4ZVKn7vLjPJcyDkRZ+uDrLgs882rHcAgh6zQHQ2NaRbnSS4OhvsL0AFr72J8mgUy0L4qninA3FCRu5BL8yzrwMDjMyQ4eylfE+tITN2hInhpnnF7n+vkBtZKdHI9lAqW+sP4TUW6h049Odfg+kYlGkO39Tm0BlIlji0fIdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dh5xXM6n; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740394726; x=1771930726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gd0nmKi+y7imohMgl2KoUoI5yg1NN3mViH62L60pt44=;
  b=dh5xXM6nT8qfUAcVhq+sXroqyLs4Uh+4YNGMuILvQtqzgtmtId9jaHOk
   U+xcTKYlkw0wKSSGfE8yaD6RTf1WhOcmRagaYGzB70iYicOUhZXlhD8kZ
   GO9cMXuFSG0IiKVijeTceQ9E/HPQ6EXMkbRfGEvSTVLEdNBZfwax5Th3C
   rbzc2JOrxDT13m706VOunieALojpY/S5PK0rW27XBdtNmwx39LgqkY7ZX
   21fmbGRzrWcclnnXFp39UWBhiRlnVDHDJKyvac7Ikq/jtmtdRoHsD18uC
   Fa2OHgrPLxfkcE6xnhevszMh7S+JUd474VOtvmoNZ1nu1yjELoOp0ISol
   A==;
X-CSE-ConnectionGUID: ypU1WSYVR/+QOJb8bQpuuw==
X-CSE-MsgGUID: oFgfev9sSJWieOz8jBTJlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44920721"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44920721"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:58:45 -0800
X-CSE-ConnectionGUID: JliRsdN2RBCJOvuRyeIrFQ==
X-CSE-MsgGUID: qp5avr51TuSIlXj+pLby/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116932538"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:58:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmWAW-0000000EfnM-0PEP;
	Mon, 24 Feb 2025 12:58:36 +0200
Date: Mon, 24 Feb 2025 12:58:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, perex@perex.cz, tiwai@suse.com,
	broonie@kernel.org, lgirdwood@gmail.com, deller@gmx.de,
	sre@kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com,
	oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
Message-ID: <Z7xQ2y-7U5-OhzhB@smile.fi.intel.com>
References: <20250221165333.2780888-8-raag.jadav@intel.com>
 <202502220449.DvJuMgsL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502220449.DvJuMgsL-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 22, 2025 at 05:41:24AM +0800, kernel test robot wrote:
> Hi Raag,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on b16e9f8547a328b19af59afc213ce323124d11e9]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/ASoC-Intel-avs-use-devm_kmemdup_array/20250222-010322
> base:   b16e9f8547a328b19af59afc213ce323124d11e9
> patch link:    https://lore.kernel.org/r/20250221165333.2780888-8-raag.jadav%40intel.com
> patch subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
> config: arm-randconfig-004-20250222 (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502220449.DvJuMgsL-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/video/fbdev/pxafb.c: In function 'pxafb_probe':
> >> drivers/video/fbdev/pxafb.c:2236:13: warning: unused variable 'i' [-Wunused-variable]
>     2236 |         int i, irq, ret;
>          |             ^

Ragg, please, fix this, and issue a v2 with the link to fixed PR:
https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com.

-- 
With Best Regards,
Andy Shevchenko



