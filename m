Return-Path: <linux-pm+bounces-18791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A19E8A28
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 05:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE72280C7E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 04:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B36156861;
	Mon,  9 Dec 2024 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVDShtSR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84537156649
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717532; cv=none; b=J0UOIfxNx+AibX+yu7r15yBS5GAuCCb3nt9LRAJDeSusOOPt97Nwrz1rG6ot0bazoVid9o1AoFVtZ3kz+UXKp4sA1ATmeG0T5PVd9mmJQRP5JfRBDXq1SWr5chtwrxvIBdXn7OANDS60CJcS6X+vKIGLSc3NextL5/DqaB2M6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717532; c=relaxed/simple;
	bh=xlAmvJY1EcCAH273GfroIocGNxG++mVZRPCJKDMo4T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fAW75EpGS9Hg0aa8bCdkVLP8r1YawHegmqh7KTDjgHq4Sow4og1iSVralvJ5soMnkPYbUARfVLn7vK4ibjWybKQSg6yHIYO9Sngh7AThVoiDqBfX8Po4+1D8rz8KBm0iB2rtqQq99baI91+TY0yTc91/juqPrD5jf2IduMhIFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVDShtSR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717531; x=1765253531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xlAmvJY1EcCAH273GfroIocGNxG++mVZRPCJKDMo4T0=;
  b=IVDShtSRuIHAmNDPfxxp7fJDUv7IJ2pI5NhZXYFbwtDCmnTvmyivs5xw
   zLIuLukI/xya3Wel6RbcR0RgosF9mK63Kd7pRPG/geIOqwp7LaOrhNsGo
   uu0lvGsk7wuNjoxGHNUV7sLsAly5TI7rU2DnFpogZ4WGA97WMnsvoq6IB
   7tDom1QVqJyRBGIlZc2Z2wG4HeFPcV8RQbVyPHqLkpniMtPpIBzftDvW/
   9lV8u9jfTsYpekVqkOn3vTTahZ+ttNFKymHj0wYJ+8xUt2eBzoqlcCChX
   FXbz8Mv1udxZgvsYBY6zzPr+GjOM2DZopzGpJjEDXhqSc1udVsqg901k/
   A==;
X-CSE-ConnectionGUID: +3xOpr71QFGF3p7nzgELQg==
X-CSE-MsgGUID: CSx2SRVOTBGySJyK6lkQTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33891398"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33891398"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:12:11 -0800
X-CSE-ConnectionGUID: TW3lUvx1Rz+4a/JS+jsx0w==
X-CSE-MsgGUID: BjzqgKb/ROOBP1ZTL9tv4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99004596"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Dec 2024 20:12:08 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV7t-0003oH-2G;
	Mon, 09 Dec 2024 04:12:05 +0000
Date: Mon, 9 Dec 2024 12:11:50 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [chanwoo:devfreq-next 4/4] drivers/devfreq/sun8i-a33-mbus.c:384:50:
 error: too few arguments to function call, expected 2, have 1
Message-ID: <202412071628.eroJDpgX-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241207/202412071628.eroJDpgX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071628.eroJDpgX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071628.eroJDpgX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/devfreq/sun8i-a33-mbus.c:7:
   In file included from include/linux/devfreq.h:13:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/devfreq/sun8i-a33-mbus.c:9:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/devfreq/sun8i-a33-mbus.c:9:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/devfreq/sun8i-a33-mbus.c:9:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/devfreq/sun8i-a33-mbus.c:384:50: error: too few arguments to function call, expected 2, have 1
     384 |         ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~               ^
   include/linux/clk.h:214:5: note: 'devm_clk_rate_exclusive_get' declared here
     214 | int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk);
         |     ^                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 warnings and 1 error generated.


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

