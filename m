Return-Path: <linux-pm+bounces-18713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCFA9E7835
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C35B1886381
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DFD1D63E3;
	Fri,  6 Dec 2024 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHJfgmqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C61D63C0
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510294; cv=none; b=RzHc3V3oXqceZSnsDAWcobMBpZ7+RE+6cWsEkByi85ijR1htO0yonSG5XG6+OOJTCLaTUa47XGaFXndxDpBA6cyVDRZXgx4/29ykc+kQSAkL+tne6/j2q/ySWt884ev4uBXSgyivyqfGXvw9071keQYf8YaF+O/n02nt0735VIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510294; c=relaxed/simple;
	bh=WwUY9x2el1F2/anpPRl1wf8DjVDt734lmdw3+xDh0aU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ugidJr+k7khRxr92RJ0rCZz8eoA6Y0wSFbDLpg19SZC/0qtWViW8jziisIYgm9SidIkCgdGCkQMYi7sG0goMJhYEvtc8mzYYMXBDJnq1u5qmaa4ajzH9xGwnG4TbeeMkEmu5qfR8n55+WZmEQptBzYOchPkiAWcF5Xs0siKi9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHJfgmqy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733510291; x=1765046291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WwUY9x2el1F2/anpPRl1wf8DjVDt734lmdw3+xDh0aU=;
  b=iHJfgmqyv735odOiqEMj0ct7JohMowTMe7qsral68jEzAo+wjNoV6TZx
   LfDdnzS4AD+wTNVprXjxG7kYXlw9P0cu10+MG0jqnYULmt/50tSNW6GvO
   FrKH7te/D5zyaL7JhAvyNi8MXPohTPQnti4oL2BvPJ7rVu361Ra5OQCrp
   kGeP4m99jkKBJzB6tCzXh09I/UhaSkl7c/PhYHElCGMbH+vLo3BSNppYg
   QonR8dxjdTSkz6n8CqRBDq4L9REAiYpkDq8AKXRQuHFirYHT7xLR2qS7v
   l2DjvhEFB/8hDo7z8DPLw4UkHZ5cYuT8pjITOnuU7WP3PybpYGHjXH4bZ
   Q==;
X-CSE-ConnectionGUID: VyTst/JRTvehSUxMcssPQA==
X-CSE-MsgGUID: 1eMlSq65RF6Wk2g6hGKOEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33606753"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33606753"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 10:38:10 -0800
X-CSE-ConnectionGUID: pnKZNOHOS5mCD9HkXMHCMA==
X-CSE-MsgGUID: hoG4gD5TQcWYfgfcDQdKEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99521916"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Dec 2024 10:38:08 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJdDJ-0002AW-2Y;
	Fri, 06 Dec 2024 18:38:05 +0000
Date: Sat, 7 Dec 2024 02:37:41 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?unknown-8bit?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Subject: [chanwoo:devfreq-next 4/4] drivers/devfreq/sun8i-a33-mbus.c:384:47:
 error: passing argument 1 of 'devm_clk_rate_exclusive_get' from incompatible
 pointer type
Message-ID: <202412070231.MzXdNrLv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-next
head:   27d1a5d95c5202f927f1155ad8f919778cd9f155
commit: 27d1a5d95c5202f927f1155ad8f919778cd9f155 [4/4] PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
config: arm64-randconfig-002-20241206 (https://download.01.org/0day-ci/archive/20241207/202412070231.MzXdNrLv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070231.MzXdNrLv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070231.MzXdNrLv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/devfreq/sun8i-a33-mbus.c: In function 'sun8i_a33_mbus_probe':
>> drivers/devfreq/sun8i-a33-mbus.c:384:47: error: passing argument 1 of 'devm_clk_rate_exclusive_get' from incompatible pointer type [-Wincompatible-pointer-types]
     384 |         ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
         |                                           ~~~~^~~~~~~~~~
         |                                               |
         |                                               struct clk *
   In file included from drivers/devfreq/sun8i-a33-mbus.c:6:
   include/linux/clk.h:214:48: note: expected 'struct device *' but argument is of type 'struct clk *'
     214 | int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk);
         |                                 ~~~~~~~~~~~~~~~^~~
>> drivers/devfreq/sun8i-a33-mbus.c:384:15: error: too few arguments to function 'devm_clk_rate_exclusive_get'
     384 |         ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/clk.h:214:5: note: declared here
     214 | int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/devm_clk_rate_exclusive_get +384 drivers/devfreq/sun8i-a33-mbus.c

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

