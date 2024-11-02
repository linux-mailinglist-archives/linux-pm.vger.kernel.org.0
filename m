Return-Path: <linux-pm+bounces-16902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B259BA245
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 20:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEE21C21B90
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BF1AB6F7;
	Sat,  2 Nov 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nr/ZSEYn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96A14F12F;
	Sat,  2 Nov 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577358; cv=none; b=e8bAm1irQxI1KkO1GhtMt/yUUnDxj+tBUFXYWPbK8sNHjYSTldXFGoh/iPazCFdzNrHhveAJ5+rWqxC6Z3qbomvkG1SfMfFmKKj+FW96764EK90hpvetihfSXy2IN/oo0ex3RLxP3ttI1mAFMR01blRBs2oNCJSbj0A5vgxqguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577358; c=relaxed/simple;
	bh=g36kdeuRYZI5ierO4LxZY9yHnOtnQ6TIOAVdj/Y/oLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2ef/9slWq0PgKVusvXoeUI3N8+F/pKN4k4f05ZSzT7Lb2FB7MqlIVvdN+nUsxYfRMFsYHI+PqKJwrzWE5bOJjaMQWn2E2t3yNtNzbKv/lLkVkWj/mCUbc5NIwOhPca4lCY5viCq2VKex0KPPv+tsYogvClMdHXNlBJ+/CbtLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nr/ZSEYn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730577356; x=1762113356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g36kdeuRYZI5ierO4LxZY9yHnOtnQ6TIOAVdj/Y/oLs=;
  b=Nr/ZSEYndI9ktyN1PT5mfkJms1IS9ucFLqn6VmfA0Ws8hKElHHIz6flE
   kALKrXdiGTsfw/XnMAwrwGrrDLBAS10F/fl8vL8U6FwU3tym+HsQkaC4d
   IxWpX371vI0akWF7Kt5L/6K5a/MdKjywNLKMbEi3EQnX51pVfGcodIXsX
   aD8O767BJ4j/HzoDjQVy6q0CSATh2k4kzGQ9xULpqOTnzgHlFhk1SAHlZ
   XuYtW+Vd21Z1+ZSQgO9oUL/FFcsw1wCVo3mZjGXTcMTkIXK9swktK1OQt
   8p7ZLWPH0qDJQZXTdlLvF/4fHGf30LoJHH+93UVYVt9ikAbOmkMw2Rebt
   w==;
X-CSE-ConnectionGUID: QEBY7QQjS9G2IXq2gq4B/A==
X-CSE-MsgGUID: 6e78hUw2TceHejVqmtGryw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30270382"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30270382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 12:55:55 -0700
X-CSE-ConnectionGUID: DEM1bP8vQuCq66BSj637Tw==
X-CSE-MsgGUID: 8fsNL1ZsSEG7Z1R9sShxcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88024912"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Nov 2024 12:55:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7KDt-000jI9-0Z;
	Sat, 02 Nov 2024 19:55:49 +0000
Date: Sun, 3 Nov 2024 03:55:24 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v8 3/7] mfd: Add new driver for MAX77705 PMIC
Message-ID: <202411030141.DTmej8oX-lkp@intel.com>
References: <20241031-starqltechn_integration_upstream-v8-3-2fa666c2330e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-starqltechn_integration_upstream-v8-3-2fa666c2330e@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 86e3904dcdc7e70e3257fc1de294a1b75f3d8d04]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20241031-053513
base:   86e3904dcdc7e70e3257fc1de294a1b75f3d8d04
patch link:    https://lore.kernel.org/r/20241031-starqltechn_integration_upstream-v8-3-2fa666c2330e%40gmail.com
patch subject: [PATCH v8 3/7] mfd: Add new driver for MAX77705 PMIC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241103/202411030141.DTmej8oX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241103/202411030141.DTmej8oX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411030141.DTmej8oX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mfd/max77705.c:8:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2223:
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
>> drivers/mfd/max77705.c:129:6: warning: variable 'pmic_rev' is uninitialized when used here [-Wuninitialized]
     129 |         if (pmic_rev != MAX77705_PASS3) {
         |             ^~~~~~~~
   drivers/mfd/max77705.c:108:13: note: initialize the variable 'pmic_rev' to silence this warning
     108 |         u8 pmic_rev;
         |                    ^
         |                     = '\0'
   5 warnings generated.


vim +/pmic_rev +129 drivers/mfd/max77705.c

   100	
   101	static int max77705_i2c_probe(struct i2c_client *i2c)
   102	{
   103		struct max77693_dev *max77705;
   104		struct regmap_irq_chip_data *irq_data;
   105		struct irq_domain *domain;
   106		int ret;
   107		unsigned int pmic_rev_value;
   108		u8 pmic_rev;
   109	
   110	
   111		max77705 = devm_kzalloc(&i2c->dev, sizeof(*max77705), GFP_KERNEL);
   112		if (!max77705)
   113			return -ENOMEM;
   114	
   115		max77705->i2c = i2c;
   116		max77705->dev = &i2c->dev;
   117		max77705->irq = i2c->irq;
   118		max77705->type = TYPE_MAX77705;
   119		i2c_set_clientdata(i2c, max77705);
   120	
   121		max77705->regmap = devm_regmap_init_i2c(i2c, &max77705_regmap_config);
   122	
   123		if (IS_ERR(max77705->regmap))
   124			return PTR_ERR(max77705->regmap);
   125	
   126		if (regmap_read(max77705->regmap, MAX77705_PMIC_REG_PMICREV, &pmic_rev_value) < 0)
   127			return -ENODEV;
   128	
 > 129		if (pmic_rev != MAX77705_PASS3) {
   130			dev_err(max77705->dev, "rev.0x%x is not tested",
   131				pmic_rev);
   132			return -ENODEV;
   133		}
   134	
   135		max77705->regmap_leds = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
   136	
   137		if (IS_ERR(max77705->regmap_leds))
   138			return PTR_ERR(max77705->regmap_leds);
   139	
   140		ret = devm_regmap_add_irq_chip(max77705->dev, max77705->regmap,
   141						max77705->irq,
   142						IRQF_ONESHOT | IRQF_SHARED, 0,
   143						&max77705_topsys_irq_chip,
   144						&irq_data);
   145	
   146		if (ret)
   147			dev_err(max77705->dev, "failed to add irq chip: %d\n", ret);
   148	
   149		/* Unmask interrupts from all blocks in interrupt source register */
   150		ret = regmap_update_bits(max77705->regmap,
   151					 MAX77705_PMIC_REG_INTSRC_MASK,
   152					 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);
   153	
   154		if (ret < 0) {
   155			dev_err(max77705->dev,
   156				"Could not unmask interrupts in INTSRC: %d\n", ret);
   157			return ret;
   158		}
   159	
   160		domain = regmap_irq_get_domain(irq_data);
   161	
   162		ret = devm_mfd_add_devices(max77705->dev, PLATFORM_DEVID_NONE,
   163					   max77705_devs, ARRAY_SIZE(max77705_devs),
   164					   NULL, 0, domain);
   165	
   166		if (ret) {
   167			dev_err(max77705->dev, "Failed to register child devices: %d\n", ret);
   168			return ret;
   169		}
   170	
   171		device_init_wakeup(max77705->dev, true);
   172	
   173		return 0;
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

