Return-Path: <linux-pm+bounces-10082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F38919A2A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 23:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA861C21CB6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 21:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D78194080;
	Wed, 26 Jun 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OP7lTMc9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF924433B3;
	Wed, 26 Jun 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439137; cv=none; b=ZvbjtzplSDd6V6bV8P8q8tkp4zx3M3Zojr/ERByP5LzRvm3bFQrWYYApksGzXcLSRFAwfUwzxqfbGiSSzQnG1yuqfKuWQqmmGFk7JHVdqpp/cC1pMNiH+UuZiTwAUvxj9DVdYnc6g6pv3NWWHnFBCxA+u4VSgWqeg9e630veskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439137; c=relaxed/simple;
	bh=hyCc2dx2iCJpyOWsnjpyBn130Gj3NHXIlTdpzmWt8/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na58kQzSYdibxmiKhJ2+GD3oaazgshU0PEGeO3OIOLH8qGaTdbK7NcRQIoIl4Wps3+btNa1522bPbVr4oqDF98k4MgMVsL/PpRg95vKxk6wu9/O35M7pHunsQc/vZgDtuHv7yvNoviNk3Yv0igiuSfOT5Qr7LYM27DR4stjxRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OP7lTMc9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719439136; x=1750975136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hyCc2dx2iCJpyOWsnjpyBn130Gj3NHXIlTdpzmWt8/s=;
  b=OP7lTMc9mwIjJnYPunpe5Zx2ueQue8mrmqkVsEuaRnzOX+Pg9sJ7Xrl2
   7MSRhufdqDjgwbw3L6Ba+KAKumBfdQtWgeiHX2OvfNgKd7F8L32poYofX
   NLQUuZ0+biPn4FI8OFr5Lto3g8uGVBZstGBJeYH8Frg5+aCfjCC+wmRx7
   UDaeuRqeMEIcbFLY9UoLzkp67+SKNeCwkVSN5cQgBUdOIop8IHguucSyq
   D1UpNsak2/ZOdwRTwfM+GWfbfr5gG1UWv5FD4pepIj7B7QgrcDN3fEkw2
   TV2jg0VwYCbf0mgDfLhsDe4T5ESYLRrPYg/D1tdz7iUCZG88MH+vkciOp
   Q==;
X-CSE-ConnectionGUID: bsDCmnJMQu+j3zdssRQYsw==
X-CSE-MsgGUID: aZV9Nd+mQXGdasrc9cMdDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16423341"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16423341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 14:58:55 -0700
X-CSE-ConnectionGUID: vx5PnEDkTEOuaVKadVDm7A==
X-CSE-MsgGUID: tX4s7/KHQJeoxy8Sw+d/CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49064537"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Jun 2024 14:58:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMafA-000Fav-1y;
	Wed, 26 Jun 2024 21:58:48 +0000
Date: Thu, 27 Jun 2024 05:58:25 +0800
From: kernel test robot <lkp@intel.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thermal: sti: depend on THERMAL_OF subsystem
Message-ID: <202406270530.kN5wIswi-lkp@intel.com>
References: <20240625-thermal-v2-2-bf8354ed51ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-thermal-v2-2-bf8354ed51ee@gmail.com>

Hi Raphael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/thermal-st-switch-from-CONFIG_PM_SLEEP-guards-to-pm_sleep_ptr/20240626-090203
base:   0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
patch link:    https://lore.kernel.org/r/20240625-thermal-v2-2-bf8354ed51ee%40gmail.com
patch subject: [PATCH v2 2/3] thermal: sti: depend on THERMAL_OF subsystem
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240627/202406270530.kN5wIswi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270530.kN5wIswi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270530.kN5wIswi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/st/st_thermal.c: In function 'st_thermal_register':
>> drivers/thermal/st/st_thermal.c:147:13: warning: variable 'polling_delay' set but not used [-Wunused-but-set-variable]
     147 |         int polling_delay;
         |             ^~~~~~~~~~~~~


vim +/polling_delay +147 drivers/thermal/st/st_thermal.c

60aef7ce455653 Lee Jones           2014-06-05  138  
60aef7ce455653 Lee Jones           2014-06-05  139  int st_thermal_register(struct platform_device *pdev,
60aef7ce455653 Lee Jones           2014-06-05  140  			const struct of_device_id *st_thermal_of_match)
60aef7ce455653 Lee Jones           2014-06-05  141  {
60aef7ce455653 Lee Jones           2014-06-05  142  	struct st_thermal_sensor *sensor;
60aef7ce455653 Lee Jones           2014-06-05  143  	struct device *dev = &pdev->dev;
60aef7ce455653 Lee Jones           2014-06-05  144  	struct device_node *np = dev->of_node;
60aef7ce455653 Lee Jones           2014-06-05  145  	const struct of_device_id *match;
60aef7ce455653 Lee Jones           2014-06-05  146  
60aef7ce455653 Lee Jones           2014-06-05 @147  	int polling_delay;
60aef7ce455653 Lee Jones           2014-06-05  148  	int ret;
60aef7ce455653 Lee Jones           2014-06-05  149  
60aef7ce455653 Lee Jones           2014-06-05  150  	if (!np) {
60aef7ce455653 Lee Jones           2014-06-05  151  		dev_err(dev, "device tree node not found\n");
60aef7ce455653 Lee Jones           2014-06-05  152  		return -EINVAL;
60aef7ce455653 Lee Jones           2014-06-05  153  	}
60aef7ce455653 Lee Jones           2014-06-05  154  
60aef7ce455653 Lee Jones           2014-06-05  155  	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
60aef7ce455653 Lee Jones           2014-06-05  156  	if (!sensor)
60aef7ce455653 Lee Jones           2014-06-05  157  		return -ENOMEM;
60aef7ce455653 Lee Jones           2014-06-05  158  
60aef7ce455653 Lee Jones           2014-06-05  159  	sensor->dev = dev;
60aef7ce455653 Lee Jones           2014-06-05  160  
60aef7ce455653 Lee Jones           2014-06-05  161  	match = of_match_device(st_thermal_of_match, dev);
60aef7ce455653 Lee Jones           2014-06-05  162  	if (!(match && match->data))
60aef7ce455653 Lee Jones           2014-06-05  163  		return -EINVAL;
60aef7ce455653 Lee Jones           2014-06-05  164  
60aef7ce455653 Lee Jones           2014-06-05  165  	sensor->cdata = match->data;
60aef7ce455653 Lee Jones           2014-06-05  166  	if (!sensor->cdata->ops)
60aef7ce455653 Lee Jones           2014-06-05  167  		return -EINVAL;
60aef7ce455653 Lee Jones           2014-06-05  168  
60aef7ce455653 Lee Jones           2014-06-05  169  	sensor->ops = sensor->cdata->ops;
60aef7ce455653 Lee Jones           2014-06-05  170  
331a5fc9f2ed28 Nicolas Boichat     2015-07-08  171  	ret = (sensor->ops->regmap_init)(sensor);
60aef7ce455653 Lee Jones           2014-06-05  172  	if (ret)
60aef7ce455653 Lee Jones           2014-06-05  173  		return ret;
60aef7ce455653 Lee Jones           2014-06-05  174  
60aef7ce455653 Lee Jones           2014-06-05  175  	ret = st_thermal_alloc_regfields(sensor);
60aef7ce455653 Lee Jones           2014-06-05  176  	if (ret)
60aef7ce455653 Lee Jones           2014-06-05  177  		return ret;
60aef7ce455653 Lee Jones           2014-06-05  178  
60aef7ce455653 Lee Jones           2014-06-05  179  	sensor->clk = devm_clk_get(dev, "thermal");
60aef7ce455653 Lee Jones           2014-06-05  180  	if (IS_ERR(sensor->clk)) {
60aef7ce455653 Lee Jones           2014-06-05  181  		dev_err(dev, "failed to fetch clock\n");
60aef7ce455653 Lee Jones           2014-06-05  182  		return PTR_ERR(sensor->clk);
60aef7ce455653 Lee Jones           2014-06-05  183  	}
60aef7ce455653 Lee Jones           2014-06-05  184  
60aef7ce455653 Lee Jones           2014-06-05  185  	if (sensor->ops->register_enable_irq) {
60aef7ce455653 Lee Jones           2014-06-05  186  		ret = sensor->ops->register_enable_irq(sensor);
60aef7ce455653 Lee Jones           2014-06-05  187  		if (ret)
60aef7ce455653 Lee Jones           2014-06-05  188  			return ret;
60aef7ce455653 Lee Jones           2014-06-05  189  	}
60aef7ce455653 Lee Jones           2014-06-05  190  
60aef7ce455653 Lee Jones           2014-06-05  191  	ret = st_thermal_sensor_on(sensor);
60aef7ce455653 Lee Jones           2014-06-05  192  	if (ret)
60aef7ce455653 Lee Jones           2014-06-05  193  		return ret;
60aef7ce455653 Lee Jones           2014-06-05  194  
60aef7ce455653 Lee Jones           2014-06-05  195  	ret = st_thermal_calibration(sensor);
60aef7ce455653 Lee Jones           2014-06-05  196  	if (ret)
60aef7ce455653 Lee Jones           2014-06-05  197  		goto sensor_off;
60aef7ce455653 Lee Jones           2014-06-05  198  
60aef7ce455653 Lee Jones           2014-06-05  199  	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
60aef7ce455653 Lee Jones           2014-06-05  200  
60aef7ce455653 Lee Jones           2014-06-05  201  	sensor->thermal_dev =
9819ef601045bf Raphael Gallais-Pou 2024-06-25  202  		devm_thermal_of_zone_register(dev, 0, sensor, &st_tz_ops);
60aef7ce455653 Lee Jones           2014-06-05  203  	if (IS_ERR(sensor->thermal_dev)) {
9819ef601045bf Raphael Gallais-Pou 2024-06-25  204  		dev_err(dev, "failed to register thermal of zone\n");
60aef7ce455653 Lee Jones           2014-06-05  205  		ret = PTR_ERR(sensor->thermal_dev);
60aef7ce455653 Lee Jones           2014-06-05  206  		goto sensor_off;
60aef7ce455653 Lee Jones           2014-06-05  207  	}
60aef7ce455653 Lee Jones           2014-06-05  208  
60aef7ce455653 Lee Jones           2014-06-05  209  	platform_set_drvdata(pdev, sensor);
60aef7ce455653 Lee Jones           2014-06-05  210  
9819ef601045bf Raphael Gallais-Pou 2024-06-25  211  	/*
9819ef601045bf Raphael Gallais-Pou 2024-06-25  212  	 * devm_thermal_of_zone_register() doesn't enable hwmon by default
9819ef601045bf Raphael Gallais-Pou 2024-06-25  213  	 * Enable it here
9819ef601045bf Raphael Gallais-Pou 2024-06-25  214  	 */
9819ef601045bf Raphael Gallais-Pou 2024-06-25  215  	return devm_thermal_add_hwmon_sysfs(dev, sensor->thermal_dev);
60aef7ce455653 Lee Jones           2014-06-05  216  
60aef7ce455653 Lee Jones           2014-06-05  217  sensor_off:
60aef7ce455653 Lee Jones           2014-06-05  218  	st_thermal_sensor_off(sensor);
60aef7ce455653 Lee Jones           2014-06-05  219  
60aef7ce455653 Lee Jones           2014-06-05  220  	return ret;
60aef7ce455653 Lee Jones           2014-06-05  221  }
60aef7ce455653 Lee Jones           2014-06-05  222  EXPORT_SYMBOL_GPL(st_thermal_register);
60aef7ce455653 Lee Jones           2014-06-05  223  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

