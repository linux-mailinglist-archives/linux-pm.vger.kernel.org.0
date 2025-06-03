Return-Path: <linux-pm+bounces-28063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C7ACCF97
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 00:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA74175AE0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151A24A069;
	Tue,  3 Jun 2025 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbjoMTCa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642671A2643;
	Tue,  3 Jun 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988594; cv=none; b=JfewvPsaryOKLsh1yeCE823eDRPp8ZQyoGcv1WnphCMKFOVRuvGPqVX8B6kwwHxQXU+Q/cN6kEVCN7iWYXNDRMxLSkiulsPHbYQaocgTc+/FLLRlWLsZG6io70d4RB1TgsmgCWH+Whfu/Y2pYj+QdKEhoaho9xxlCnlo6iYYB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988594; c=relaxed/simple;
	bh=S0c47ppm0drVdO4jAjCQHwJvNJsQNG50GQKepxniEQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G35FNx9zxqJFy5dhTEp28TiVshoii2niktBURioeAtYuAetKYQbXwsgJ3mtHj4Ex7BH6FmDIk5LwdCmOR4u82DtDzdyuzZrdfiLLyOkaJjUWg8e2P6P0LB0Dgtf9H4TRe7Exc9lw3kFdGWauRAf2oSqhLHqxefH9pDvVeBMU5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbjoMTCa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748988592; x=1780524592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0c47ppm0drVdO4jAjCQHwJvNJsQNG50GQKepxniEQo=;
  b=RbjoMTCaMe0G4Qv+1L+j3wNSJQf3/AYqTjhhHAu/p2Vw6JfLXfbFWbTM
   bLMyb8ojt0Jg89GqzjqOs6p2oyETqkO0rLND4/kcODf6UGVO1KW7Ez7qi
   LUPWtld5QGaiEJNTL/Ku6PXKQ41bMfcH1G5YPTafhKbcDjTVFJ8eYP+8J
   svk0e3sdvINgw6Up9139KVo7OCmgv58Smky42EtXBfttD5Q8Zdhb99oT/
   SFofL53OkPR+JSWCJTsRP2fAzma5Qs/bG1soGkh9D4tFdf26v/9Wqokdv
   nbZr9lG2q0g9OZ4uqacBGNG7iKVDKF3YibfTb4dS3Yi8JYRW4uzH5Gz46
   A==;
X-CSE-ConnectionGUID: XRQRz9eHRGyI3cGZhMzn7A==
X-CSE-MsgGUID: lrhBVdFwSiqgh/FnDCM9lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54840718"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="54840718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:09:51 -0700
X-CSE-ConnectionGUID: uXDwbOKqSaqNgJYSUub+BQ==
X-CSE-MsgGUID: pmasmQ4sQfmqqaQU15SoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="168152739"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 15:09:46 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMZpH-0002kP-3D;
	Tue, 03 Jun 2025 22:09:43 +0000
Date: Wed, 4 Jun 2025 06:08:53 +0800
From: kernel test robot <lkp@intel.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, nfraprado@collabora.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	angelogioacchino.delregno@collabora.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Irving lin <irving-ch.lin@mediatek.corp-partner.google.com>
Subject: Re: [1/5] clk: mt8189: Porting driver for clk
Message-ID: <202506040506.Hrl72R0Q-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.15 next-20250530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/irving-ch-lin/clk-mt8189-Porting-driver-for-clk/20250603-105623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250602083624.1849719-1-irving-ch.lin%40mediatek.com
patch subject: [1/5] clk: mt8189: Porting driver for clk
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250604/202506040506.Hrl72R0Q-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250604/202506040506.Hrl72R0Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506040506.Hrl72R0Q-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt8189.c:22:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      22 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-bringup.c:18:43: error: incomplete definition of type 'struct platform_device'
      18 |         clk_con = of_count_phandle_with_args(pdev->dev.of_node, "clocks",
         |                                              ~~~~^
   include/linux/of_platform.h:14:8: note: forward declaration of 'struct platform_device'
      14 | struct platform_device;
         |        ^
   drivers/clk/mediatek/clk-bringup.c:22:24: error: incomplete definition of type 'struct platform_device'
      22 |                 clk = of_clk_get(pdev->dev.of_node, i);
         |                                  ~~~~^
   include/linux/of_platform.h:14:8: note: forward declaration of 'struct platform_device'
      14 | struct platform_device;
         |        ^
   drivers/clk/mediatek/clk-bringup.c:48:33: error: incomplete definition of type 'struct platform_device'
      48 |         struct device_node *node = pdev->dev.of_node;
         |                                    ~~~~^
   include/linux/of_platform.h:14:8: note: forward declaration of 'struct platform_device'
      14 | struct platform_device;
         |        ^
   drivers/clk/mediatek/clk-bringup.c:78:44: error: incomplete definition of type 'struct platform_device'
      78 |         clk_probe = of_device_get_match_data(&pdev->dev);
         |                                               ~~~~^
   include/linux/of_platform.h:14:8: note: forward declaration of 'struct platform_device'
      14 | struct platform_device;
         |        ^
>> drivers/clk/mediatek/clk-bringup.c:84:3: error: call to undeclared function 'dev_err'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      84 |                 dev_err(&pdev->dev,
         |                 ^
   drivers/clk/mediatek/clk-bringup.c:84:16: error: incomplete definition of type 'struct platform_device'
      84 |                 dev_err(&pdev->dev,
         |                          ~~~~^
   include/linux/of_platform.h:14:8: note: forward declaration of 'struct platform_device'
      14 | struct platform_device;
         |        ^
   drivers/clk/mediatek/clk-bringup.c:86:8: error: incomplete definition of type 'struct platform_device'
      86 |                         pdev->name, r);
         |                         ~~~~^
   include/linux/of_platform.h:14:8: note: forward declaration of 'struct platform_device'
      14 | struct platform_device;
         |        ^
>> drivers/clk/mediatek/clk-bringup.c:96:31: error: variable has incomplete type 'struct platform_driver'
      96 | static struct platform_driver bring_up = {
         |                               ^
   drivers/clk/mediatek/clk-bringup.c:96:15: note: forward declaration of 'struct platform_driver'
      96 | static struct platform_driver bring_up = {
         |               ^
>> drivers/clk/mediatek/clk-bringup.c:106:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     106 | module_platform_driver(bring_up);
         | ^
         | int
>> drivers/clk/mediatek/clk-bringup.c:106:24: error: a parameter list without types is only allowed in a function definition
     106 | module_platform_driver(bring_up);
         |                        ^
   10 errors generated.
--
>> drivers/clk/mediatek/clk-mt8189-adsp.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-cam.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-mmsys.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-img.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-iic.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-bus.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-mdpsys.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-mfg.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt8189-scp.c:15:10: fatal error: 'dt-bindings/clock/mt8189-clk.h' file not found
      15 | #include <dt-bindings/clock/mt8189-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
..


vim +22 drivers/clk/mediatek/clk-mt8189.c

    21	
  > 22	#include <dt-bindings/clock/mt8189-clk.h>
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

