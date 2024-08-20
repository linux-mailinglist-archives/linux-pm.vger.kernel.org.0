Return-Path: <linux-pm+bounces-12502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB0957ACE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 03:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CE9284C00
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EAC134D1;
	Tue, 20 Aug 2024 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3+aYTou"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FB1C6A1
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116394; cv=none; b=N/945GWILTpsN6ieRfWm/6JS5y2JrBQmv7zUHFVFyy9H5d1rMjWHQ4Whfkeqs5zckbsjlaJpcOUhYDaO+qhQ2BCrvWwVEMkJrsvjLyscYvFKHj0kGoZk04QnFLjn0pdTY84nN7r0cvKHEHU48CM95YU2W9AsZxi2XOJv8Al0BRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116394; c=relaxed/simple;
	bh=CMpDjLI7/Cy8hgOixYvnKLnwW1x2ElCY4I6FZSCKG7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKuR+alRmI/ee0IdLK6M2lm0Dyw9PosYLBOnA/7rICJKTGQt7uxcZ0P4bEEYgnIrgJQFMOtiIDeKBtHPi2ZrHtT56+XcLJaltiNs24V7jxoHYMnOteoRAFtOCpyR0g2vFGZwZx4ksSqBqd9ooyOoKyqpR/kuyejcWAPRVA1LEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3+aYTou; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724116392; x=1755652392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMpDjLI7/Cy8hgOixYvnKLnwW1x2ElCY4I6FZSCKG7I=;
  b=d3+aYTouMhfAzXxuqA+SpmdxgqMukh/j9/OfuYhSJ2JWIlW7xkFA5q4f
   uaWx+LnJ9j3BDGSBKXNuam6tB7oxg42lM+oCfdq/N80LnSqIxXNhKJAFP
   sb7pn3HHdmhgqY6B4duKZUraPlJNp7KQvxm3PrPKcddoZmB8fcpB/W5zi
   Wbz4nz+xci/CloB9thWn9BFJyp/Bpv6IpDOuvYuesKgzHR4MjLjpWq1yB
   zaRMrjONkrKEJWLgt/wiTy73rl5eVxaXOsCWJCIViLxtZicnx1KwxeIpi
   4qOVwAHuEwDXTXbwYiDeR0pXnVzML6q9ucBiJBQI+3tMYq5tNRQtPZQbD
   g==;
X-CSE-ConnectionGUID: tTzu/9v0TEKnYFvgCZs3wQ==
X-CSE-MsgGUID: C26mctwVSFKhUdypeY1zkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39898043"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="39898043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:13:12 -0700
X-CSE-ConnectionGUID: rqS1tkNKRRyM9FD/KiQBoQ==
X-CSE-MsgGUID: yHevFzlkTmyR4uee2Fg7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60874508"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Aug 2024 18:13:10 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgDQp-0009aa-1x;
	Tue, 20 Aug 2024 01:13:07 +0000
Date: Tue, 20 Aug 2024 09:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
	linux-pm@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] thermal: qoriq: Remove __maybe_unused notations
Message-ID: <202408200829.1ywCKDAw-lkp@intel.com>
References: <20240819142700.1206586-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819142700.1206586-1-festevam@gmail.com>

Hi Fabio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.11-rc4 next-20240819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-Estevam/thermal-imx-Remove-__maybe_unused-notations/20240819-222757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20240819142700.1206586-1-festevam%40gmail.com
patch subject: [PATCH 1/2] thermal: qoriq: Remove __maybe_unused notations
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240820/202408200829.1ywCKDAw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408200829.1ywCKDAw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200829.1ywCKDAw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qoriq_thermal.c:364:12: warning: 'qoriq_tmu_resume' defined but not used [-Wunused-function]
     364 | static int qoriq_tmu_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~
>> drivers/thermal/qoriq_thermal.c:350:12: warning: 'qoriq_tmu_suspend' defined but not used [-Wunused-function]
     350 | static int qoriq_tmu_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~


vim +/qoriq_tmu_resume +364 drivers/thermal/qoriq_thermal.c

   349	
 > 350	static int qoriq_tmu_suspend(struct device *dev)
   351	{
   352		struct qoriq_tmu_data *data = dev_get_drvdata(dev);
   353		int ret;
   354	
   355		ret = regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, 0);
   356		if (ret)
   357			return ret;
   358	
   359		clk_disable_unprepare(data->clk);
   360	
   361		return 0;
   362	}
   363	
 > 364	static int qoriq_tmu_resume(struct device *dev)
   365	{
   366		int ret;
   367		struct qoriq_tmu_data *data = dev_get_drvdata(dev);
   368	
   369		ret = clk_prepare_enable(data->clk);
   370		if (ret)
   371			return ret;
   372	
   373		/* Enable monitoring */
   374		return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
   375	}
   376	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

