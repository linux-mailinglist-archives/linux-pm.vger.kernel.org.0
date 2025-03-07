Return-Path: <linux-pm+bounces-23629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CEFA567EA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558397A4D12
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718982192F2;
	Fri,  7 Mar 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpAtiDVZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC851E1E0E;
	Fri,  7 Mar 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350970; cv=none; b=EOz6ckH2I8Vs8i77sSy0h5F+3tqzEo8Z/3FxLmdp3BcOllY/dmemGmrAfwMOpXAJWvP8b85TBLgSgv/vlNGiEXZncL//xhAQrteMkJP1P2rBjvdFqZiEpACGSdAGM3x/HkqrH8tYCG79RaUWM5SESjxCEyrw6NMTS6iR7IghKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350970; c=relaxed/simple;
	bh=3/TtT1E4mUKW2DF96LvlJsi7p3Ib7T4oRNpt7Y0xJb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlXEWwNjqXZcY8LPercSKY7+iglzRh1g4/Aqbu+Fw+e/zuqTV2V2klngBL6YFyO+rmF0+ja9VhI6rub0FH5Pkk7PNNIcoTtboeV/YsxgndEBiGUQRkhNuXnym2Kemwz+Rm5F82SFxgN3Lv1xWhsq0sHD7KBVwug4SEh95ZqqPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpAtiDVZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741350969; x=1772886969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3/TtT1E4mUKW2DF96LvlJsi7p3Ib7T4oRNpt7Y0xJb0=;
  b=GpAtiDVZvHWSV7UUS+qNg8id1YJNGAd3cpSlnjbwYleKH0YKZwDZqqQs
   yGAKEvRKX2YZx6m9Utu0IZREpRA0Cy7tdZwRWcWR+vx5rirrpRLt/+oVl
   nGucmhxMZGShBdqQFWPZzg78RXffr1lf7rBPKJvdjnaV97Zu1tivJFROp
   tclK1WunFsf8RzaIEx1GQVuJkN9aFPUyOtYfifxbJmP6K69omndypGnu0
   puKyao+xXtLfU7ZitDDeWSokbBpTgPwYV4KEFY7QjSNpxtIqXbNSDU3Gg
   D02jBSNOxujW5Swt7lnGFkei/jUx0lk5sHhB/mGbv8PwJsYpxrEVAnns6
   Q==;
X-CSE-ConnectionGUID: Urs9vzC+SA2d0Z4vGlKZMg==
X-CSE-MsgGUID: jxAn3MZ0Rs6JnHWYYaBpUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64837787"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="64837787"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:36:08 -0800
X-CSE-ConnectionGUID: tBSkKd3eRSiolr5vMlSz5A==
X-CSE-MsgGUID: pOtmXMPnSGGDzqiJ/uyoYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="142542885"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2025 04:36:05 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWvq-0000TX-2O;
	Fri, 07 Mar 2025 12:36:02 +0000
Date: Fri, 7 Mar 2025 20:35:09 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v4 4/7] nvmem: add support for device and sysfs-based
 cell lookups
Message-ID: <202503072059.sFFL62LS-lkp@intel.com>
References: <20250306093900.2199442-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306093900.2199442-5-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on broonie-regulator/for-next rafael-pm/thermal linus/master v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250306-174233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250306093900.2199442-5-o.rempel%40pengutronix.de
patch subject: [PATCH v4 4/7] nvmem: add support for device and sysfs-based cell lookups
config: s390-randconfig-001-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072059.sFFL62LS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503072059.sFFL62LS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072059.sFFL62LS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/ethernet/eth.c:46:
>> include/linux/nvmem-consumer.h:115:20: warning: no previous prototype for 'nvmem_cell_get_by_sysfs_name' [-Wmissing-prototypes]
     115 | struct nvmem_cell *nvmem_cell_get_by_sysfs_name(struct nvmem_device *nvmem,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/nvmem-consumer.h:197:22: warning: no previous prototype for 'nvmem_device_get_by_name' [-Wmissing-prototypes]
     197 | struct nvmem_device *nvmem_device_get_by_name(const char *name)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
--
   s390-linux-ld: net/ethernet/eth.o: in function `nvmem_cell_get_by_sysfs_name':
>> eth.c:(.text+0x16a0): multiple definition of `nvmem_cell_get_by_sysfs_name'; drivers/net/phy/dp83867.o:dp83867.c:(.text+0x18d0): first defined here
   s390-linux-ld: net/ethernet/eth.o: in function `nvmem_device_get_by_name':
>> eth.c:(.text+0x16a8): multiple definition of `nvmem_device_get_by_name'; drivers/net/phy/dp83867.o:dp83867.c:(.text+0x18d8): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

