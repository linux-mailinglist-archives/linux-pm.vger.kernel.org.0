Return-Path: <linux-pm+bounces-27017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847FAB2968
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20D13AB3DB
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF871C861F;
	Sun, 11 May 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCa4kuns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC83B19A
	for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746978116; cv=none; b=GScuGzMHxLnly+cjSLJ4KHolpz9cDTy5p3gmAqZgvraUvJ3I9+X1iNgBmWDWdBAJd/O3hEWsgs0YCXk9ZqOnTqXsse+PgO84asG95Q4lyiaSyZCCfnYg5gdpNQVEyOgPx39x+mW9cf3KiEiC+fjM3xnQlowbjajw64yRbVyhjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746978116; c=relaxed/simple;
	bh=eFx9d8RmL6xATtwQP4jVIt6qbk+QHVY0+CZhlPrU/fU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X1KMSU5hlK6xsqEl3LerQCjjuq/C9tfX9QQiJeqPx27qgTB1u3D9fK8PRyhQTsCE4duitG0D3/VAcsQQrSajOgE0hr8k+6TVz6Ja/fnymySG480NnDmNJd5uTTGYqeQ5Ayy8h/5h5zdjVfVtfnw+xbxOeNT233978MT7gsFlgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCa4kuns; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746978114; x=1778514114;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eFx9d8RmL6xATtwQP4jVIt6qbk+QHVY0+CZhlPrU/fU=;
  b=RCa4kunsdDbZ72FZjqZNQqsC/YTgSIRanHsp48CkNHgMuEbxT+ZDEs/v
   sV7k9Yz48jUT/vfo/xYQpX0RQ9eJrhWHPcPn80GhCe6tLjz0o6inqm+sM
   sqS5237ampz955LKVE822YAOaAKG4N87G4njjBDtCrFSA23KvI2eM3k7A
   loVIai1IJeajgPPp73P0pL3Gd4Y9vwfJZmPItDpC4gzYPaT1nV6AzehYQ
   TCPz8c4u7ZI4qtIjl6tU9ck9OIF/QbM6x8tEIFwWTCJEvNHGL9E10dw/X
   qsYeUwxDXrn2B/p7aATzuBtdiuo+mPvio4i4RTb9KJPc3GZGDXRR5uhoI
   w==;
X-CSE-ConnectionGUID: 9sUKvZ2oQ2ekyCn/KuF11A==
X-CSE-MsgGUID: SQ7JtvYzTX2TpRczXjCgMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="47887788"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="47887788"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 08:41:53 -0700
X-CSE-ConnectionGUID: e8X/wZyKRse64BEBwtvfXQ==
X-CSE-MsgGUID: d+uo5qSES1Kfzs7Opgnxcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="160395276"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 May 2025 08:41:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uE8oH-000Dox-2X;
	Sun, 11 May 2025 15:41:49 +0000
Date: Sun, 11 May 2025 23:41:48 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Subject: [chanwoo:devfreq-next 1/1] drivers/devfreq/sun8i-a33-mbus.c:384:47:
 error: passing argument 1 of 'devm_clk_rate_exclusive_get' from incompatible
 pointer type
Message-ID: <202505112315.mvBeoFDc-lkp@intel.com>
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
config: csky-randconfig-002-20250511 (https://download.01.org/0day-ci/archive/20250511/202505112315.mvBeoFDc-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250511/202505112315.mvBeoFDc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505112315.mvBeoFDc-lkp@intel.com/

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

