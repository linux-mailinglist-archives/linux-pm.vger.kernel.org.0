Return-Path: <linux-pm+bounces-16502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E39B1872
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29789B22FD8
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB71D47A3;
	Sat, 26 Oct 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQ4Ju955"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0A1E50B;
	Sat, 26 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948690; cv=none; b=mvMJJUMME5+L7wTKhDdJfWLFavOwIkRGlu+ddmgna/uafdI7c7xWWWfiDqw+xMBZxnOdngi9GEf2Y8T8FaM+o5BN3vHB6OBnqByRhxb0moLorn0cRzcCecL1u5kLIRpNsOJmPsNgvlnB8uTPn5himP8Slm66wUggGeSqNDcnAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948690; c=relaxed/simple;
	bh=WjWsN0BbqZ+ckDcOfpUetYKweI82x5iGSxAhBNqAuDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3eQOvX3FKaIXqKrn7BAZOiDoGj2k/97SIATH5qQhrUZ9aiX/uoA3HQTJ9FSBrDVGzLnjvoh8hbj5RZh8HEwBsUhOsK8ac4RsYDkKSRylTufp2QgHbWcSrmwCVovryeLGzG4iA9YkkKpiJIbCriuZcmS6f2woMJz1TOivNn8YqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQ4Ju955; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729948688; x=1761484688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WjWsN0BbqZ+ckDcOfpUetYKweI82x5iGSxAhBNqAuDg=;
  b=hQ4Ju955V7LvNuc206+n31BmpmAZfR+51aqMm1BHK0x6suDBzPd7TDUw
   3EJhfJ8sth7RybOPsI25hCoSbtEzu7J4jeSyN1xxBsxSCORuqd/fJLjp7
   X3PYGuLg5iFZWthuLt4lLv18Dh9vjjjLad/6fWBkTmfxES+OKnIyngZRo
   bYRbtVlhXvun43478BLH85lzMJL4ntBVCY5dngZ+IrIsk3mz/S/QZiWrZ
   Q5RUwZQZMLWNGb1Jg7a3O6OYNdWh0bOTQEBbXTAW2kIdwwbV4jTNWHozN
   IY9tTr3ipl8Livm9CTenHvMgUj1VSLbmJ18+QcGeTg0uA+EAgp2a0geD2
   Q==;
X-CSE-ConnectionGUID: EFYFuyXTTb6nqnc/hMYATg==
X-CSE-MsgGUID: RUAGTXXiRo6pY9JkMEn5iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40150235"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40150235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 06:18:08 -0700
X-CSE-ConnectionGUID: /OYILA24ToSvrqTwVHf5Wg==
X-CSE-MsgGUID: hYG2gfQvT+Sl12TvfHhyzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="80813600"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Oct 2024 06:18:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4gg5-000Zge-2G;
	Sat, 26 Oct 2024 13:18:01 +0000
Date: Sat, 26 Oct 2024 21:17:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v7 3/7] mfd: Add new driver for MAX77705 PMIC
Message-ID: <202410262035.of6zMB8v-lkp@intel.com>
References: <20241023-starqltechn_integration_upstream-v7-3-9bfaa3f4a1a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-starqltechn_integration_upstream-v7-3-9bfaa3f4a1a0@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 63b3ff03d91ae8f875fe8747c781a521f78cde17]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20241024-034645
base:   63b3ff03d91ae8f875fe8747c781a521f78cde17
patch link:    https://lore.kernel.org/r/20241023-starqltechn_integration_upstream-v7-3-9bfaa3f4a1a0%40gmail.com
patch subject: [PATCH v7 3/7] mfd: Add new driver for MAX77705 PMIC
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241026/202410262035.of6zMB8v-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410262035.of6zMB8v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410262035.of6zMB8v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mfd/max77705.c: In function 'max77705_i2c_probe':
>> drivers/mfd/max77705.c:107:12: warning: variable 'pmic_ver' set but not used [-Wunused-but-set-variable]
     107 |         u8 pmic_ver, pmic_rev;
         |            ^~~~~~~~


vim +/pmic_ver +107 drivers/mfd/max77705.c

    99	
   100	static int max77705_i2c_probe(struct i2c_client *i2c)
   101	{
   102		struct max77693_dev *max77705;
   103		struct regmap_irq_chip_data *irq_data;
   104		struct irq_domain *domain;
   105		int ret;
   106		unsigned int pmic_rev_value;
 > 107		u8 pmic_ver, pmic_rev;
   108	
   109	
   110		max77705 = devm_kzalloc(&i2c->dev, sizeof(*max77705), GFP_KERNEL);
   111		if (!max77705)
   112			return -ENOMEM;
   113	
   114		max77705->i2c = i2c;
   115		max77705->dev = &i2c->dev;
   116		max77705->irq = i2c->irq;
   117		max77705->type = TYPE_MAX77705;
   118		i2c_set_clientdata(i2c, max77705);
   119	
   120		max77705->regmap = devm_regmap_init_i2c(i2c, &max77705_regmap_config);
   121	
   122		if (IS_ERR(max77705->regmap))
   123			return PTR_ERR(max77705->regmap);
   124	
   125		if (regmap_read(max77705->regmap, MAX77705_PMIC_REG_PMICREV, &pmic_rev_value) < 0)
   126			return -ENODEV;
   127	
   128		pmic_rev = pmic_rev_value & MAX77705_REVISION_MASK;
   129		pmic_ver = (pmic_rev_value & MAX77705_VERSION_MASK) >> MAX77705_VERSION_SHIFT;
   130	
   131		if (pmic_rev != MAX77705_PASS3) {
   132			dev_err(max77705->dev, "rev.0x%x is not tested",
   133				pmic_rev);
   134			return -ENODEV;
   135		}
   136	
   137		max77705->regmap_leds = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
   138	
   139		if (IS_ERR(max77705->regmap_leds))
   140			return PTR_ERR(max77705->regmap_leds);
   141	
   142		ret = devm_regmap_add_irq_chip(max77705->dev, max77705->regmap,
   143						max77705->irq,
   144						IRQF_ONESHOT | IRQF_SHARED, 0,
   145						&max77705_topsys_irq_chip,
   146						&irq_data);
   147	
   148		if (ret)
   149			dev_err(max77705->dev, "failed to add irq chip: %d\n", ret);
   150	
   151		/* Unmask interrupts from all blocks in interrupt source register */
   152		ret = regmap_update_bits(max77705->regmap,
   153					 MAX77705_PMIC_REG_INTSRC_MASK,
   154					 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);
   155	
   156		if (ret < 0) {
   157			dev_err(max77705->dev,
   158				"Could not unmask interrupts in INTSRC: %d\n", ret);
   159			return ret;
   160		}
   161	
   162		domain = regmap_irq_get_domain(irq_data);
   163	
   164		ret = devm_mfd_add_devices(max77705->dev, PLATFORM_DEVID_NONE,
   165					   max77705_devs, ARRAY_SIZE(max77705_devs),
   166					   NULL, 0, domain);
   167	
   168		if (ret) {
   169			dev_err(max77705->dev, "Failed to register child devices: %d\n", ret);
   170			return ret;
   171		}
   172	
   173		device_init_wakeup(max77705->dev, true);
   174	
   175		return 0;
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

