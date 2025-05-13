Return-Path: <linux-pm+bounces-27074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A80AB5426
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CDE1B45793
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49DF28C5A5;
	Tue, 13 May 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rv/ezBbf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F923C504
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137207; cv=none; b=mqXt26nSsy+NjJKCd84YVGCJnTbstYJ+A8J5SMasm03TRUUmMWJx4NGyT76TpNiX7IgauPHKbzaeru9zRajVk5jqAsCD0zxoZxvKnYt8TtC/XvhdP0D24/L31At944JDXwg7HPdTGmTD94ROCdsf3Ya9T/8Mh79CCb/N/GyeKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137207; c=relaxed/simple;
	bh=ymyhCeXbSWn3XGyJdVpxrSZ9u388hotAQ2d6VE4lzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UlQNQvgSfxeKekf1OubfeO66RRCWo9bQ1tG//ZLfr3uAX5oLmXCBNyH0Yku/iiNdbe8YncZHd93Twrcbwk/yNDy5rfbWaIRw6o/L01GOGBqOK/BZYUx/bq6rbh/iQxTngegduLlMMnx+u+tE3dtIquJINfLqTfEQ4fCy6z8bcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rv/ezBbf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747137206; x=1778673206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ymyhCeXbSWn3XGyJdVpxrSZ9u388hotAQ2d6VE4lzOk=;
  b=Rv/ezBbffC7asjyYK3Jt6su6X9IoHwzwuxt9in/iEHdEsQJTQo2nf7Jr
   VYmoHUjRVB3JavWlYZ27qGpEyWEQiB9/JHbhwj92xJP6xW/d9wjh1VC6I
   Q6SB+YSqO2YlO6s5V6LJXzcauiI/8Fn0HPie7au0z46AignHqVMhqHnbF
   o66tMlcH9kWG/u3qLETjbrcymFjnzw7/bjPjdfmc9Ltjck+ANUGedMNUZ
   VH57SWoC0oDDDyuwop7i+V1Kq82W49FjHLLJPvOfHf8Uh+WJL1YjBGYY7
   DbkSneAGRm3A5L0DNEo3cpKRb0Dd+UZ/iVNMIo6ayHA9WNudfiJNc9hpe
   A==;
X-CSE-ConnectionGUID: CZrFjxSETaGE8ssDolctWQ==
X-CSE-MsgGUID: 3ve+qDRXTh+IzDcaEv5miA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49095116"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49095116"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 04:53:23 -0700
X-CSE-ConnectionGUID: QhDnc8Q+TaCarXNyX91zqA==
X-CSE-MsgGUID: aZXh+6nwSka0ypetIm6e2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142805012"
Received: from igk-lkp-server01.igk.intel.com (HELO b9ffd1689040) ([10.211.3.150])
  by orviesa005.jf.intel.com with ESMTP; 13 May 2025 04:53:21 -0700
Received: from kbuild by b9ffd1689040 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEoCE-0000xy-1X;
	Tue, 13 May 2025 11:53:18 +0000
Date: Tue, 13 May 2025 19:52:27 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [chanwoo:devfreq-next 1/1] drivers/devfreq/sun8i-a33-mbus.c:384:50:
 error: too few arguments to function call, expected 2, have 1
Message-ID: <202505131950.YgTPTbPS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-next
head:   bc253b28a365cf6f3dc066f2607d516eb6ef930e
commit: bc253b28a365cf6f3dc066f2607d516eb6ef930e [1/1] PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
config: i386-buildonly-randconfig-2001-20250513 (https://download.01.org/0day-ci/archive/20250513/202505131950.YgTPTbPS-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505131950.YgTPTbPS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505131950.YgTPTbPS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/devfreq/sun8i-a33-mbus.c:384:50: error: too few arguments to function call, expected 2, have 1
     384 |         ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~               ^
   include/linux/clk.h:214:5: note: 'devm_clk_rate_exclusive_get' declared here
     214 | int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk);
         |     ^                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +384 drivers/devfreq/sun8i-a33-mbus.c

   330	
   331	static int sun8i_a33_mbus_probe(struct platform_device *pdev)
   332	{
   333		const struct sun8i_a33_mbus_variant *variant;
   334		struct device *dev = &pdev->dev;
   335		struct sun8i_a33_mbus *priv;
   336		unsigned long base_freq;
   337		unsigned int max_state;
   338		const char *err;
   339		int i, ret;
   340	
   341		variant = device_get_match_data(dev);
   342		if (!variant)
   343			return -EINVAL;
   344	
   345		max_state = variant->max_dram_divider - variant->min_dram_divider + 1;
   346	
   347		priv = devm_kzalloc(dev, struct_size(priv, freq_table, max_state), GFP_KERNEL);
   348		if (!priv)
   349			return -ENOMEM;
   350	
   351		platform_set_drvdata(pdev, priv);
   352	
   353		priv->variant = variant;
   354	
   355		priv->reg_dram = devm_platform_ioremap_resource_byname(pdev, "dram");
   356		if (IS_ERR(priv->reg_dram))
   357			return PTR_ERR(priv->reg_dram);
   358	
   359		priv->reg_mbus = devm_platform_ioremap_resource_byname(pdev, "mbus");
   360		if (IS_ERR(priv->reg_mbus))
   361			return PTR_ERR(priv->reg_mbus);
   362	
   363		priv->clk_bus = devm_clk_get_enabled(dev, "bus");
   364		if (IS_ERR(priv->clk_bus))
   365			return dev_err_probe(dev, PTR_ERR(priv->clk_bus),
   366					     "failed to get bus clock\n");
   367	
   368		priv->clk_dram = devm_clk_get(dev, "dram");
   369		if (IS_ERR(priv->clk_dram))
   370			return dev_err_probe(dev, PTR_ERR(priv->clk_dram),
   371					     "failed to get dram clock\n");
   372	
   373		priv->clk_mbus = devm_clk_get(dev, "mbus");
   374		if (IS_ERR(priv->clk_mbus))
   375			return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
   376					     "failed to get mbus clock\n");
   377	
   378		/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
   379		ret = devm_clk_rate_exclusive_get(dev, priv->clk_dram);
   380		if (ret)
   381			return dev_err_probe(dev, ret, "failed to lock dram clock rate\n");
   382	
   383		/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
 > 384		ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
   385		if (ret)
   386			return dev_err_probe(dev, ret, "failed to lock mbus clock rate\n");
   387	
   388		priv->gov_data.upthreshold	= 10;
   389		priv->gov_data.downdifferential	=  5;
   390	
   391		priv->profile.initial_freq	= clk_get_rate(priv->clk_dram);
   392		priv->profile.polling_ms	= 1000;
   393		priv->profile.target		= sun8i_a33_mbus_set_dram_target;
   394		priv->profile.get_dev_status	= sun8i_a33_mbus_get_dram_status;
   395		priv->profile.freq_table	= priv->freq_table;
   396		priv->profile.max_state		= max_state;
   397	
   398		ret = devm_pm_opp_set_clkname(dev, "dram");
   399		if (ret)
   400			return dev_err_probe(dev, ret, "failed to add OPP table\n");
   401	
   402		base_freq = clk_get_rate(clk_get_parent(priv->clk_dram));
   403		for (i = 0; i < max_state; ++i) {
   404			unsigned int div = variant->max_dram_divider - i;
   405	
   406			priv->freq_table[i] = base_freq / div;
   407	
   408			ret = dev_pm_opp_add(dev, priv->freq_table[i], 0);
   409			if (ret) {
   410				err = "failed to add OPPs\n";
   411				goto err_remove_opps;
   412			}
   413		}
   414	
   415		ret = sun8i_a33_mbus_hw_init(dev, priv, priv->profile.initial_freq);
   416		if (ret) {
   417			err = "failed to init hardware\n";
   418			goto err_remove_opps;
   419		}
   420	
   421		priv->devfreq_dram = devfreq_add_device(dev, &priv->profile,
   422							DEVFREQ_GOV_SIMPLE_ONDEMAND,
   423							&priv->gov_data);
   424		if (IS_ERR(priv->devfreq_dram)) {
   425			ret = PTR_ERR(priv->devfreq_dram);
   426			err = "failed to add devfreq device\n";
   427			goto err_remove_opps;
   428		}
   429	
   430		/*
   431		 * This must be set manually after registering the devfreq device,
   432		 * because there is no way to select a dynamic OPP as the suspend OPP.
   433		 */
   434		priv->devfreq_dram->suspend_freq = priv->freq_table[0];
   435	
   436		return 0;
   437	
   438	err_remove_opps:
   439		dev_pm_opp_remove_all_dynamic(dev);
   440	
   441		return dev_err_probe(dev, ret, err);
   442	}
   443	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

