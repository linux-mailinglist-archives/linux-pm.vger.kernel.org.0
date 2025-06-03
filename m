Return-Path: <linux-pm+bounces-28024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F1ACC818
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC433A2AE8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47F235071;
	Tue,  3 Jun 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4t4mUV4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC822FF22;
	Tue,  3 Jun 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958075; cv=none; b=gVvwhNOtflFbBmswkzetoUjt24ZTiE3JIIMtkJtW4TY3oHC3nfJ1tz10CHRkLoUsRwu5HSt7FXecQflqz+zchKbuWJ6tKRlXDAM6yECMKJFv4EHFIJa4BcbORFlfwB4227XNUxJfEZkdL7ccb4LJp+R/x7yzmMW6gDHBl0TBqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958075; c=relaxed/simple;
	bh=Ld/DmiOsr/GIjO8Gve7Gwa5r9+0LnmJEzLNU8zeFIpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwwFrJbRu+zvCyS0e+DOGZlAh5X9IIw+eJfUBfK69XmTenu4TGmFwdC43siCacI1qsQJWBlmCv624r1AlJr4sk677qJ2rdHdZTxhlsNA/uHtwNXSeQkm9P7e9+qn0rn/OYPR3gycyYLEzelfftB/0e3OEP5shFGxOnlNTUEusvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4t4mUV4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748958074; x=1780494074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ld/DmiOsr/GIjO8Gve7Gwa5r9+0LnmJEzLNU8zeFIpw=;
  b=n4t4mUV4Egsa9n0z+ZRTTESCOnMD9YG83JaD6l/DRQ5V5amUaa7NEALD
   6kxOEnLPxHlg4bwhny/x8N2/eOMoEX5EDeG8gW7QPbuaJKWiZYZuotzhD
   B+gRrJyodcqCaDda21soXegjpF9Jgz2ud+GNRdr9ww91AXcpcRMcp66jn
   ihqJ3N3zoDFcVmof0Q1faNadE0mx83/e79hvlLKfPARaHRExuxSuUClV3
   PyaUISbhePp1RRDB5/+H2gnZyRWxeVF/uvJXgaoFV/9WNU4lJhdoB6rEi
   th9W5vz9KkbUBa5DunFMr/A+j9k1zZxIkzki4jo3DVovcprhHlomLGVmI
   A==;
X-CSE-ConnectionGUID: jX+4bTatRoOH68ovH/7cKA==
X-CSE-MsgGUID: RH2MfgJcRBqDKPEv309iMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50693253"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50693253"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 06:41:13 -0700
X-CSE-ConnectionGUID: Ksv9muBGQaGp28i285/M4Q==
X-CSE-MsgGUID: Xh9d85mtRBWw5r1/a3RPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145823921"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jun 2025 06:41:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMRt4-0002Sv-1r;
	Tue, 03 Jun 2025 13:41:06 +0000
Date: Tue, 3 Jun 2025 21:40:11 +0800
From: kernel test robot <lkp@intel.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, nfraprado@collabora.com
Cc: oe-kbuild-all@lists.linux.dev, angelogioacchino.delregno@collabora.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Irving lin <irving-ch.lin@mediatek.corp-partner.google.com>
Subject: Re: [1/5] clk: mt8189: Porting driver for clk
Message-ID: <202506032107.zewlKCY5-lkp@intel.com>
References: <20250602083624.1849719-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602083624.1849719-1-irving-ch.lin@mediatek.com>

Hi irving.ch.lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.15 next-20250530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/irving-ch-lin/clk-mt8189-Porting-driver-for-clk/20250603-105623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250602083624.1849719-1-irving-ch.lin%40mediatek.com
patch subject: [1/5] clk: mt8189: Porting driver for clk
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250603/202506032107.zewlKCY5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250603/202506032107.zewlKCY5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506032107.zewlKCY5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/mediatek/clk-bringup.c: In function '__bring_up_enable':
   drivers/clk/mediatek/clk-bringup.c:18:50: error: invalid use of undefined type 'struct platform_device'
      18 |         clk_con = of_count_phandle_with_args(pdev->dev.of_node, "clocks",
         |                                                  ^~
   drivers/clk/mediatek/clk-bringup.c:22:38: error: invalid use of undefined type 'struct platform_device'
      22 |                 clk = of_clk_get(pdev->dev.of_node, i);
         |                                      ^~
   drivers/clk/mediatek/clk-bringup.c: In function 'clk_post_ao_probe':
   drivers/clk/mediatek/clk-bringup.c:48:40: error: invalid use of undefined type 'struct platform_device'
      48 |         struct device_node *node = pdev->dev.of_node;
         |                                        ^~
   drivers/clk/mediatek/clk-bringup.c: In function 'bring_up_probe':
   drivers/clk/mediatek/clk-bringup.c:78:51: error: invalid use of undefined type 'struct platform_device'
      78 |         clk_probe = of_device_get_match_data(&pdev->dev);
         |                                                   ^~
   drivers/clk/mediatek/clk-bringup.c:84:17: error: implicit declaration of function 'dev_err' [-Werror=implicit-function-declaration]
      84 |                 dev_err(&pdev->dev,
         |                 ^~~~~~~
   drivers/clk/mediatek/clk-bringup.c:84:30: error: invalid use of undefined type 'struct platform_device'
      84 |                 dev_err(&pdev->dev,
         |                              ^~
   drivers/clk/mediatek/clk-bringup.c:86:29: error: invalid use of undefined type 'struct platform_device'
      86 |                         pdev->name, r);
         |                             ^~
   drivers/clk/mediatek/clk-bringup.c: At top level:
   drivers/clk/mediatek/clk-bringup.c:96:15: error: variable 'bring_up' has initializer but incomplete type
      96 | static struct platform_driver bring_up = {
         |               ^~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-bringup.c:97:10: error: 'struct platform_driver' has no member named 'probe'
      97 |         .probe          = bring_up_probe,
         |          ^~~~~
   drivers/clk/mediatek/clk-bringup.c:97:27: warning: excess elements in struct initializer
      97 |         .probe          = bring_up_probe,
         |                           ^~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-bringup.c:97:27: note: (near initialization for 'bring_up')
   drivers/clk/mediatek/clk-bringup.c:98:10: error: 'struct platform_driver' has no member named 'remove'
      98 |         .remove         = bring_up_remove,
         |          ^~~~~~
   drivers/clk/mediatek/clk-bringup.c:98:27: warning: excess elements in struct initializer
      98 |         .remove         = bring_up_remove,
         |                           ^~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-bringup.c:98:27: note: (near initialization for 'bring_up')
   drivers/clk/mediatek/clk-bringup.c:99:10: error: 'struct platform_driver' has no member named 'driver'
      99 |         .driver         = {
         |          ^~~~~~
   drivers/clk/mediatek/clk-bringup.c:99:27: error: extra brace group at end of initializer
      99 |         .driver         = {
         |                           ^
   drivers/clk/mediatek/clk-bringup.c:99:27: note: (near initialization for 'bring_up')
   drivers/clk/mediatek/clk-bringup.c:99:27: warning: excess elements in struct initializer
   drivers/clk/mediatek/clk-bringup.c:99:27: note: (near initialization for 'bring_up')
   drivers/clk/mediatek/clk-bringup.c:106:1: warning: data definition has no type or storage class
     106 | module_platform_driver(bring_up);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-bringup.c:106:1: error: type defaults to 'int' in declaration of 'module_platform_driver' [-Werror=implicit-int]
>> drivers/clk/mediatek/clk-bringup.c:106:1: warning: parameter names (without types) in function declaration
   drivers/clk/mediatek/clk-bringup.c:96:31: error: storage size of 'bring_up' isn't known
      96 | static struct platform_driver bring_up = {
         |                               ^~~~~~~~
   drivers/clk/mediatek/clk-bringup.c:96:31: warning: 'bring_up' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +106 drivers/clk/mediatek/clk-bringup.c

   105	
 > 106	module_platform_driver(bring_up);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

