Return-Path: <linux-pm+bounces-417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086617FC681
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5971C20C00
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2744360;
	Tue, 28 Nov 2023 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEu5hjsV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBED1BDD;
	Tue, 28 Nov 2023 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701205128; x=1732741128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=svqXuknUfQN8QRePst9SzpFQ/sUKnYFfi2YT176P/kQ=;
  b=MEu5hjsVWGopMdpcKQoV2AdsPQin1kICqrjYH7oO/25q1woMjJpM9apz
   MXFdTXtbJ9DKeMGjJhGnIRIOZuhA64cwYChfPuPmlh3XA9hjBZnAh14vr
   IUF/5VZWsDEgvNy5hbEXCI76iYHSuQiZe2Rgs83qgcNLVfN27JyJ7CWbv
   ibxW8Gx9COPpExynNLI0F04/DROhZZW/veX7Y4gnEsE0CejTiW4QS6Dfo
   uL/PAxa+uRk5/XAt+uhdsdRxtjdgXVrbYh4HypVPgWgQpy4n05cOjbSPU
   ffcY8w+BI67gWSVh197xNcYSB5dIH8zEynMUUyCIixgQbvDHSWEQpMosj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424174868"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424174868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:58:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797697434"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797697434"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2023 12:58:44 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r85AH-00084C-23;
	Tue, 28 Nov 2023 20:58:41 +0000
Date: Wed, 29 Nov 2023 04:49:05 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
	theo.lebrun@bootlin.com, u-kumar1@ti.com,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Message-ID: <202311290245.aUcGn8BT-lkp@intel.com>
References: <20231128130332.584127-1-thomas.richard@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128130332.584127-1-thomas.richard@bootlin.com>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Richard/thermal-k3_j72xx_bandgap-implement-suspend-resume-support/20231128-211217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231128130332.584127-1-thomas.richard%40bootlin.com
patch subject: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231129/202311290245.aUcGn8BT-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290245.aUcGn8BT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290245.aUcGn8BT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/k3_j72xx_bandgap.c:554:12: warning: 'k3_j72xx_bandgap_resume' defined but not used [-Wunused-function]
     554 | static int k3_j72xx_bandgap_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/k3_j72xx_bandgap.c:547:12: warning: 'k3_j72xx_bandgap_suspend' defined but not used [-Wunused-function]
     547 | static int k3_j72xx_bandgap_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/k3_j72xx_bandgap_resume +554 drivers/thermal/k3_j72xx_bandgap.c

   545	
   546	#ifdef CONFIG_PM
 > 547	static int k3_j72xx_bandgap_suspend(struct device *dev)
   548	{
   549		pm_runtime_put_sync(dev);
   550		pm_runtime_disable(dev);
   551		return 0;
   552	}
   553	
 > 554	static int k3_j72xx_bandgap_resume(struct device *dev)
   555	{
   556		struct k3_j72xx_bandgap *bgp = dev_get_drvdata(dev);
   557		int ret;
   558	
   559		pm_runtime_enable(dev);
   560		ret = pm_runtime_get_sync(dev);
   561		if (ret < 0) {
   562			pm_runtime_put_noidle(dev);
   563			pm_runtime_disable(dev);
   564			return ret;
   565		}
   566	
   567		k3_j72xx_bandgap_init_hw(bgp);
   568	
   569		return 0;
   570	}
   571	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

