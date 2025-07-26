Return-Path: <linux-pm+bounces-31427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F7B12B6E
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77056AA1BD1
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2628688D;
	Sat, 26 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X29jtUK7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA6242D68;
	Sat, 26 Jul 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547345; cv=none; b=RIHe6+kr+CYegu4ApPf4yKSlJ78aYwGasbBGrAfCNJ6l0HshEGRpi8rql7kH/MUVzONDdxXFXXBIABrJvRXp3N2wlq5WQw0EWEXIqHxLOyW5EPHE8I7GEEmMWesN3eVcHqjxD12HGwHX0eddncg/URSOWcBKjjyX8dhI5gv8p/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547345; c=relaxed/simple;
	bh=G/K8pyDeP9S9JTCEMrl6oTquQe3ReUsv74LpUNzL4K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJSzGS2Bvxn5wYRp7KVmrIaxMFT/wYmQV5wwancsMgJZ3pLqgz9Z91//kv2CDnKRP3T6dWmlvUackMqlgEd8OdHIfuvu7Zj1/T7Rr/Tx1AoGKU4npgBYsrFtfCXnXaG1a8iM8ZAsGa7IxuITK7fgiealwUgBitHRhqIji8iuOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X29jtUK7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753547343; x=1785083343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/K8pyDeP9S9JTCEMrl6oTquQe3ReUsv74LpUNzL4K8=;
  b=X29jtUK7iHAWeyHaxTN83X/ogR3QFwM7NYr34+7qnw0/OJP1LmZfZq6X
   Aj6sI05b48tYa0ofaJO0GsBRgBQsMS1WJxGKDtkp6X6h5NE6c9wxzIA2f
   EKncTOcjbwMhJCWd4Uu+wWWld2aUdrIaYEqUhBvcOanaIE2afi3IbQ17w
   Ygt05E44atzyERk6b7E570w9/0ikT4ns+CAa1vY3YYfCnIW2uFYrkCx61
   yhGfiTJj/tMNdnQD2itLRQHiqpEPhkGhzP4IQ6CTHjGcTSECsuGuXtGpY
   5QdHjjbKCVzEErz1gqbOw0Ph4WACgE+sN40dGxQobKlXsmm3j5VTImBRn
   Q==;
X-CSE-ConnectionGUID: mMNeMfRSQSCjITwq53loSw==
X-CSE-MsgGUID: sKdgHIIeR26C1JA7Nsu2ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="56007404"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56007404"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:29:02 -0700
X-CSE-ConnectionGUID: 4sWF6xspS2OA3rgPzX1tuA==
X-CSE-MsgGUID: yxtOoSrbTXyHdcniL0C43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161531066"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jul 2025 09:28:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufhlY-000M6L-2O;
	Sat, 26 Jul 2025 16:28:56 +0000
Date: Sun, 27 Jul 2025 00:28:31 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jackie Liu <liuyun01@kylinos.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom: make LMH select QCOM_SCM
Message-ID: <202507270042.KdK0KKht-lkp@intel.com>
References: <20250725-lmh-scm-v1-1-84246981f435@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-lmh-scm-v1-1-84246981f435@oss.qualcomm.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a933d3dc1968fcfb0ab72879ec304b1971ed1b9a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/thermal-qcom-make-LMH-select-QCOM_SCM/20250725-215843
base:   a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
patch link:    https://lore.kernel.org/r/20250725-lmh-scm-v1-1-84246981f435%40oss.qualcomm.com
patch subject: [PATCH] thermal: qcom: make LMH select QCOM_SCM
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250727/202507270042.KdK0KKht-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250727/202507270042.KdK0KKht-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270042.KdK0KKht-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/qcom/lmh.c: In function 'lmh_handle_irq':
   drivers/thermal/qcom/lmh.c:46:17: error: implicit declaration of function 'generic_handle_irq' [-Wimplicit-function-declaration]
      46 |                 generic_handle_irq(irq);
         |                 ^~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c: In function 'lmh_enable_interrupt':
   drivers/thermal/qcom/lmh.c:53:40: error: implicit declaration of function 'irq_data_get_irq_chip_data'; did you mean 'irq_domain_get_irq_data'? [-Wimplicit-function-declaration]
      53 |         struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                        irq_domain_get_irq_data
   drivers/thermal/qcom/lmh.c:53:40: error: initialization of 'struct lmh_hw_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/thermal/qcom/lmh.c:56:9: error: implicit declaration of function 'writel' [-Wimplicit-function-declaration]
      56 |         writel(0xff, lmh_data->base + LMH_REG_DCVS_INTR_CLR);
         |         ^~~~~~
   drivers/thermal/qcom/lmh.c: In function 'lmh_disable_interrupt':
   drivers/thermal/qcom/lmh.c:62:40: error: initialization of 'struct lmh_hw_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      62 |         struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c: At top level:
   drivers/thermal/qcom/lmh.c:67:15: error: variable 'lmh_irq_chip' has initializer but incomplete type
      67 | static struct irq_chip lmh_irq_chip = {
         |               ^~~~~~~~
   drivers/thermal/qcom/lmh.c:68:10: error: 'struct irq_chip' has no member named 'name'
      68 |         .name           = "lmh",
         |          ^~~~
>> drivers/thermal/qcom/lmh.c:68:27: warning: excess elements in struct initializer
      68 |         .name           = "lmh",
         |                           ^~~~~
   drivers/thermal/qcom/lmh.c:68:27: note: (near initialization for 'lmh_irq_chip')
   drivers/thermal/qcom/lmh.c:69:10: error: 'struct irq_chip' has no member named 'irq_enable'
      69 |         .irq_enable     = lmh_enable_interrupt,
         |          ^~~~~~~~~~
   drivers/thermal/qcom/lmh.c:69:27: warning: excess elements in struct initializer
      69 |         .irq_enable     = lmh_enable_interrupt,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:69:27: note: (near initialization for 'lmh_irq_chip')
   drivers/thermal/qcom/lmh.c:70:10: error: 'struct irq_chip' has no member named 'irq_disable'
      70 |         .irq_disable    = lmh_disable_interrupt
         |          ^~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:70:27: warning: excess elements in struct initializer
      70 |         .irq_disable    = lmh_disable_interrupt
         |                           ^~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:70:27: note: (near initialization for 'lmh_irq_chip')
   drivers/thermal/qcom/lmh.c: In function 'lmh_irq_map':
   drivers/thermal/qcom/lmh.c:83:9: error: implicit declaration of function 'irq_set_lockdep_class' [-Wimplicit-function-declaration]
      83 |         irq_set_lockdep_class(irq, &lmh_lock_key, &lmh_request_key);
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:84:9: error: implicit declaration of function 'irq_set_chip_and_handler' [-Wimplicit-function-declaration]
      84 |         irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:84:54: error: 'handle_simple_irq' undeclared (first use in this function)
      84 |         irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
         |                                                      ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:84:54: note: each undeclared identifier is reported only once for each function it appears in
   drivers/thermal/qcom/lmh.c:85:9: error: implicit declaration of function 'irq_set_chip_data'; did you mean 'irq_set_irqchip_state'? [-Wimplicit-function-declaration]
      85 |         irq_set_chip_data(irq, lmh_data);
         |         ^~~~~~~~~~~~~~~~~
         |         irq_set_irqchip_state
   drivers/thermal/qcom/lmh.c: In function 'lmh_probe':
   drivers/thermal/qcom/lmh.c:219:9: error: implicit declaration of function 'irq_set_status_flags' [-Wimplicit-function-declaration]
     219 |         irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/lmh.c:219:45: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
     219 |         irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
         |                                             ^~~~~~~~~~~~
         |                                             IRQF_NO_AUTOEN
   drivers/thermal/qcom/lmh.c: At top level:
   drivers/thermal/qcom/lmh.c:67:24: error: storage size of 'lmh_irq_chip' isn't known
      67 | static struct irq_chip lmh_irq_chip = {
         |                        ^~~~~~~~~~~~


vim +68 drivers/thermal/qcom/lmh.c

53bca371cdf7ad Thara Gopinath 2021-08-09  66  
53bca371cdf7ad Thara Gopinath 2021-08-09 @67  static struct irq_chip lmh_irq_chip = {
53bca371cdf7ad Thara Gopinath 2021-08-09 @68  	.name           = "lmh",
53bca371cdf7ad Thara Gopinath 2021-08-09  69  	.irq_enable	= lmh_enable_interrupt,
53bca371cdf7ad Thara Gopinath 2021-08-09  70  	.irq_disable	= lmh_disable_interrupt
53bca371cdf7ad Thara Gopinath 2021-08-09  71  };
53bca371cdf7ad Thara Gopinath 2021-08-09  72  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

