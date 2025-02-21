Return-Path: <linux-pm+bounces-22700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4089A4023A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 22:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7670142773E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3E253F30;
	Fri, 21 Feb 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXLSATl6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB5253F19;
	Fri, 21 Feb 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174123; cv=none; b=lbIjJZavKa008lD8/FN9rtXbhOaEYlTCpkxx6VdcONtHTXW9IJrv9MBaujlYXHAekyLp92Zk0Gy2SNC6+7fcFar0v8in9o1nkiTfIbX7WPisDJVq2EtW6GpddOfhKp9uN70q6X1HWA+yRTavT+wnR/pOOdF2TcT2tDArWcAkSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174123; c=relaxed/simple;
	bh=avCJqIijOjgsHV7YPXX6EtjKmvRXJlgAmaqzcTzfWS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxLFFfO3pRq+ePiq4kbYjOZE/S4CH1U6Q4DwAGUuLfdX7zzCpZI4mzsXdvKMR+Y0vPop/rJUS6qY5bXz4EoFITLC/HELClKg+fy7q5wzSkwnd38sqG5FOWtvNSVBbUglRhQXDCOyG0AsdjDeXQsXy+MHdL17d+kaGn5bw4POLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXLSATl6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740174121; x=1771710121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avCJqIijOjgsHV7YPXX6EtjKmvRXJlgAmaqzcTzfWS8=;
  b=DXLSATl6XZMW4ynTM9E1uP3M13pVD4x4Z6wqHc7+6x2aEbeZu8BVbb6J
   F4/mbfe3RqZ8LKd+Sm4JLOWjGlxnx/FJQNkGrD7e97o/lDKTUu/d5a+E+
   KhZMnfoEySaU79BOayMsagQSJWmrZVQodVGboc2ZFvOGli+zK+MRwLyhH
   OKbyGsdSf3KCeiWlyxV8TVt+RjmBFmVNmOtUYSTmQK+rmwgXYHFyNDtLP
   8XTDvdSDZn/HnDYpfINFq+dB/++Vg4TlorKk8zvgYWTbZlXZxID11vSDl
   8dx9MIjY5eoJyLTI6SggzTXU0SBhYmkLz9vzEgv0DqFfp0LKu0WrbzBr8
   Q==;
X-CSE-ConnectionGUID: shSmEkvIRVS6jxGGZA7I1g==
X-CSE-MsgGUID: 8abZw4POQ6CRlmwALeNRlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="66372183"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="66372183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 13:42:00 -0800
X-CSE-ConnectionGUID: e7lXd041ReaY2tiVJrh6RA==
X-CSE-MsgGUID: v3GSrf7rSZWvNvtZxfuKBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120111398"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2025 13:41:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlamB-00062p-1G;
	Fri, 21 Feb 2025 21:41:51 +0000
Date: Sat, 22 Feb 2025 05:41:24 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, perex@perex.cz, tiwai@suse.com,
	broonie@kernel.org, lgirdwood@gmail.com, deller@gmx.de,
	andriy.shevchenko@linux.intel.com, sre@kernel.org,
	sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
Message-ID: <202502220449.DvJuMgsL-lkp@intel.com>
References: <20250221165333.2780888-8-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221165333.2780888-8-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b16e9f8547a328b19af59afc213ce323124d11e9]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/ASoC-Intel-avs-use-devm_kmemdup_array/20250222-010322
base:   b16e9f8547a328b19af59afc213ce323124d11e9
patch link:    https://lore.kernel.org/r/20250221165333.2780888-8-raag.jadav%40intel.com
patch subject: [PATCH v1 07/13] fbdev: pxafb: use devm_kmemdup_array()
config: arm-randconfig-004-20250222 (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502220449.DvJuMgsL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502220449.DvJuMgsL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/pxafb.c: In function 'pxafb_probe':
>> drivers/video/fbdev/pxafb.c:2236:13: warning: unused variable 'i' [-Wunused-variable]
    2236 |         int i, irq, ret;
         |             ^


vim +/i +2236 drivers/video/fbdev/pxafb.c

420a488278e86a drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2231  
48c68c4f1b5424 drivers/video/pxafb.c       Greg Kroah-Hartman 2012-12-21  2232  static int pxafb_probe(struct platform_device *dev)
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2233  {
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2234  	struct pxafb_info *fbi;
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2235  	struct pxafb_mach_info *inf, *pdata;
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12 @2236  	int i, irq, ret;
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2237  
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2238  	dev_dbg(&dev->dev, "pxafb_probe\n");
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2239  
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2240  	ret = -ENOMEM;
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2241  	pdata = dev_get_platdata(&dev->dev);
ed63c72a467651 drivers/video/fbdev/pxafb.c Raag Jadav         2025-02-21  2242  	if (pdata) {
ed63c72a467651 drivers/video/fbdev/pxafb.c Raag Jadav         2025-02-21  2243  		inf = devm_kmemdup(&dev->dev, pdata, sizeof(*pdata), GFP_KERNEL);
6f6abd360603af drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-19  2244  		if (!inf)
6f6abd360603af drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-19  2245  			goto failed;
420a488278e86a drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2246  
ed63c72a467651 drivers/video/fbdev/pxafb.c Raag Jadav         2025-02-21  2247  		inf->modes = devm_kmemdup_array(&dev->dev, pdata->modes, pdata->num_modes,
ed63c72a467651 drivers/video/fbdev/pxafb.c Raag Jadav         2025-02-21  2248  						sizeof(*pdata->modes), GFP_KERNEL);
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2249  		if (!inf->modes)
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2250  			goto failed;
b23e868d35d572 drivers/video/fbdev/pxafb.c Wang Qing          2022-03-29  2251  	} else {
b23e868d35d572 drivers/video/fbdev/pxafb.c Wang Qing          2022-03-29  2252  		inf = of_pxafb_of_mach_info(&dev->dev);
420a488278e86a drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2253  		if (IS_ERR_OR_NULL(inf))
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2254  			goto failed;
ed63c72a467651 drivers/video/fbdev/pxafb.c Raag Jadav         2025-02-21  2255  	}
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2256  
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2257  	ret = pxafb_parse_options(&dev->dev, g_options, inf);
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2258  	if (ret < 0)
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2259  		goto failed;
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2260  
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2261  	pxafb_check_options(&dev->dev, inf);
4f3e2664622d23 drivers/video/pxafb.c       Eric Miao          2008-08-16  2262  
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2263  	dev_dbg(&dev->dev, "got a %dx%dx%d LCD\n",
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2264  			inf->modes->xres,
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2265  			inf->modes->yres,
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2266  			inf->modes->bpp);
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2267  	if (inf->modes->xres == 0 ||
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2268  	    inf->modes->yres == 0 ||
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2269  	    inf->modes->bpp == 0) {
3ae5eaec1d2d9c drivers/video/pxafb.c       Russell King       2005-11-09  2270  		dev_err(&dev->dev, "Invalid resolution or bit depth\n");
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2271  		ret = -EINVAL;
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2272  		goto failed;
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2273  	}
a5718a14a1d91b drivers/video/pxafb.c       Eric Miao          2008-11-11  2274  
f3621a60b20d67 drivers/video/fbdev/pxafb.c Robert Jarzmik     2015-12-12  2275  	fbi = pxafb_init_fbinfo(&dev->dev, inf);
a2f2058e3d295f drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2276  	if (IS_ERR(fbi)) {
3ae5eaec1d2d9c drivers/video/pxafb.c       Russell King       2005-11-09  2277  		dev_err(&dev->dev, "Failed to initialize framebuffer device\n");
a2f2058e3d295f drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2278  		ret = PTR_ERR(fbi);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2279  		goto failed;
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2280  	}
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2281  
52a7a1cec88acd drivers/video/pxafb.c       Daniel Mack        2009-09-10  2282  	if (cpu_is_pxa3xx() && inf->acceleration_enabled)
52a7a1cec88acd drivers/video/pxafb.c       Daniel Mack        2009-09-10  2283  		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
52a7a1cec88acd drivers/video/pxafb.c       Daniel Mack        2009-09-10  2284  
a5718a14a1d91b drivers/video/pxafb.c       Eric Miao          2008-11-11  2285  	fbi->backlight_power = inf->pxafb_backlight_power;
a5718a14a1d91b drivers/video/pxafb.c       Eric Miao          2008-11-11  2286  	fbi->lcd_power = inf->pxafb_lcd_power;
a5718a14a1d91b drivers/video/pxafb.c       Eric Miao          2008-11-11  2287  
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2288  	fbi->lcd_supply = devm_regulator_get_optional(&dev->dev, "lcd");
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2289  	if (IS_ERR(fbi->lcd_supply)) {
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2290  		if (PTR_ERR(fbi->lcd_supply) == -EPROBE_DEFER)
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2291  			return -EPROBE_DEFER;
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2292  
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2293  		fbi->lcd_supply = NULL;
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2294  	}
31e1391af210fd drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2295  
7610bca71ea85d drivers/video/fbdev/pxafb.c Markus Elfring     2019-09-19  2296  	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2297  	if (IS_ERR(fbi->mmio_base)) {
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2298  		dev_err(&dev->dev, "failed to get I/O memory\n");
f35b1d6c21b414 drivers/video/fbdev/pxafb.c Tiezhu Yang        2020-05-25  2299  		ret = PTR_ERR(fbi->mmio_base);
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2300  		goto failed;
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2301  	}
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2302  
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2303  	fbi->dma_buff_size = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2304  	fbi->dma_buff = dma_alloc_coherent(fbi->dev, fbi->dma_buff_size,
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2305  				&fbi->dma_buff_phys, GFP_KERNEL);
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2306  	if (fbi->dma_buff == NULL) {
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2307  		dev_err(&dev->dev, "failed to allocate memory for DMA\n");
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2308  		ret = -ENOMEM;
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2309  		goto failed;
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2310  	}
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2311  
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2312  	ret = pxafb_init_video_memory(fbi);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2313  	if (ret) {
3ae5eaec1d2d9c drivers/video/pxafb.c       Russell King       2005-11-09  2314  		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2315  		ret = -ENOMEM;
77e196752bdd76 drivers/video/pxafb.c       Eric Miao          2008-12-16  2316  		goto failed_free_dma;
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2317  	}
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2318  
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2319  	irq = platform_get_irq(dev, 0);
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2320  	if (irq < 0) {
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2321  		ret = -ENODEV;
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2322  		goto failed_free_mem;
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2323  	}
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2324  
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2325  	ret = devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fbi);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2326  	if (ret) {
3ae5eaec1d2d9c drivers/video/pxafb.c       Russell King       2005-11-09  2327  		dev_err(&dev->dev, "request_irq failed: %d\n", ret);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2328  		ret = -EBUSY;
ce4fb7b892a6d6 drivers/video/pxafb.c       eric miao          2008-04-30  2329  		goto failed_free_mem;
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2330  	}
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2331  
3c42a449107bf7 drivers/video/pxafb.c       Eric Miao          2008-04-30  2332  	ret = pxafb_smart_init(fbi);
3c42a449107bf7 drivers/video/pxafb.c       Eric Miao          2008-04-30  2333  	if (ret) {
3c42a449107bf7 drivers/video/pxafb.c       Eric Miao          2008-04-30  2334  		dev_err(&dev->dev, "failed to initialize smartpanel\n");
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2335  		goto failed_free_mem;
3c42a449107bf7 drivers/video/pxafb.c       Eric Miao          2008-04-30  2336  	}
07df1c4fea1474 drivers/video/pxafb.c       Eric Miao          2008-12-04  2337  
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2338  	/*
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2339  	 * This makes sure that our colour bitfield
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2340  	 * descriptors are correctly initialised.
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2341  	 */
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2342  	ret = pxafb_check_var(&fbi->fb.var, &fbi->fb);
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2343  	if (ret) {
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2344  		dev_err(&dev->dev, "failed to get suitable mode\n");
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2345  		goto failed_free_mem;
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2346  	}
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2347  
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2348  	ret = pxafb_set_par(&fbi->fb);
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2349  	if (ret) {
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2350  		dev_err(&dev->dev, "Failed to set parameters\n");
c8f96304ec8b49 drivers/video/fbdev/pxafb.c Daniel Mack        2018-07-24  2351  		goto failed_free_mem;
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2352  	}
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2353  
3ae5eaec1d2d9c drivers/video/pxafb.c       Russell King       2005-11-09  2354  	platform_set_drvdata(dev, fbi);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2355  
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2356  	ret = register_framebuffer(&fbi->fb);
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2357  	if (ret < 0) {
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2358  		dev_err(&dev->dev,
b0086efba5ad49 drivers/video/pxafb.c       eric miao          2008-04-30  2359  			"Failed to register framebuffer device: %d\n", ret);
ee98476bbc565f drivers/video/pxafb.c       Jaya Kumar         2008-06-22  2360  		goto failed_free_cmap;
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2361  	}
^1da177e4c3f41 drivers/video/pxafb.c       Linus Torvalds     2005-04-16  2362  
198fc108ee4c2c drivers/video/pxafb.c       Eric Miao          2008-12-23  2363  	pxafb_overlay_init(fbi);
198fc108ee4c2c drivers/video/pxafb.c       Eric Miao          2008-12-23  2364  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

