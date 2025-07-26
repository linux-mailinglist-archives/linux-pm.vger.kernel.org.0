Return-Path: <linux-pm+bounces-31428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A83B12B73
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36887A54C2
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A71287519;
	Sat, 26 Jul 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ic2Nguly"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD82286D64;
	Sat, 26 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547347; cv=none; b=EbnZH9Q66Iuf1TOSpfW3FriZaa+W0TUDoCrIH5w/fi0YBPUVW2aTUPPH+XVMmHa9zTF9nid07GnTt0AR7nWDG3u/a5ZPBStpPWBI0Im5tyZgwjQl4mj7Yf3Xx7zdmoVlI0zUl6rCAHnPwBAtoVgDwCn8iguxramgJtJqDHFlvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547347; c=relaxed/simple;
	bh=4nJ5EbKqFFx2lpy8dOJoVhsWwHjeidGSjgGMiaPauwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuGewW+JnNXxRwGGr6cI6sTI76qUqRBsagGnOoCeS41VnZ75uRfXnHtCNnyXH+2Fe/8a0YJFCPvf0SzmkAike93++IyGxqO5iQk7qMKOFm+T91oRSvITTcmN9KGYNSmHLrynCDmOl8VyRfUPH9fo0eJQ9sV/9sBW5bBCMfjf3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ic2Nguly; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753547346; x=1785083346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nJ5EbKqFFx2lpy8dOJoVhsWwHjeidGSjgGMiaPauwQ=;
  b=Ic2Nguly+GTRgxOweDmfcdTPdeGKwqn12Gf5qm1mNMpj7JpwRrEkL+/s
   hMiPKGiowiiBQYl27T6TlixKPsEQtPc8gkSvqYTcuA5OvtgokFV2UL2Po
   ITHaI73A4kh0RIEKk/h5n4ikJUUszDDUizKYnUY6NBXEFSCcKzp41pFCH
   qEdIGAn9wrBp7gAd7jNNcWo1BgfrR3ZLliqEZuL9ZIVF/OHESkCWasyeN
   Df1MA6fxcUKoBYKF3hKbmrE7bRb4mFREcge2swgWGmPrIWSw14aYFVhVC
   l/InmfRrVBh11nGSCebFCBnEA/8Kefq2+/5TImbDDpwExD95di56htviy
   A==;
X-CSE-ConnectionGUID: l+vYqcW/REOzmcl+iweeFw==
X-CSE-MsgGUID: UoJyBk7YRkO3wl1rS6dMDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="56007411"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56007411"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:29:02 -0700
X-CSE-ConnectionGUID: zHESocjQSLSM6H11QMoi3w==
X-CSE-MsgGUID: 1fwaTo3oQ6mzp4p/9dJsJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161531068"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jul 2025 09:28:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufhlY-000M6J-2J;
	Sat, 26 Jul 2025 16:28:56 +0000
Date: Sun, 27 Jul 2025 00:28:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jackie Liu <liuyun01@kylinos.cn>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom: make LMH select QCOM_SCM
Message-ID: <202507270052.BYR6Xdlk-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on a933d3dc1968fcfb0ab72879ec304b1971ed1b9a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/thermal-qcom-make-LMH-select-QCOM_SCM/20250725-215843
base:   a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
patch link:    https://lore.kernel.org/r/20250725-lmh-scm-v1-1-84246981f435%40oss.qualcomm.com
patch subject: [PATCH] thermal: qcom: make LMH select QCOM_SCM
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250727/202507270052.BYR6Xdlk-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250727/202507270052.BYR6Xdlk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270052.BYR6Xdlk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/qcom/lmh.c:46:3: error: call to undeclared function 'generic_handle_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      46 |                 generic_handle_irq(irq);
         |                 ^
>> drivers/thermal/qcom/lmh.c:53:33: error: call to undeclared function 'irq_data_get_irq_chip_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      53 |         struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
         |                                        ^
>> drivers/thermal/qcom/lmh.c:53:22: error: incompatible integer to pointer conversion initializing 'struct lmh_hw_data *' with an expression of type 'int' [-Wint-conversion]
      53 |         struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
         |                             ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/qcom/lmh.c:56:2: error: call to undeclared function 'writel'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      56 |         writel(0xff, lmh_data->base + LMH_REG_DCVS_INTR_CLR);
         |         ^
   drivers/thermal/qcom/lmh.c:62:33: error: call to undeclared function 'irq_data_get_irq_chip_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      62 |         struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
         |                                        ^
   drivers/thermal/qcom/lmh.c:62:22: error: incompatible integer to pointer conversion initializing 'struct lmh_hw_data *' with an expression of type 'int' [-Wint-conversion]
      62 |         struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
         |                             ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/qcom/lmh.c:67:24: error: variable has incomplete type 'struct irq_chip'
      67 | static struct irq_chip lmh_irq_chip = {
         |                        ^
   include/linux/irqdomain.h:21:8: note: forward declaration of 'struct irq_chip'
      21 | struct irq_chip;
         |        ^
>> drivers/thermal/qcom/lmh.c:83:2: error: call to undeclared function 'irq_set_lockdep_class'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      83 |         irq_set_lockdep_class(irq, &lmh_lock_key, &lmh_request_key);
         |         ^
>> drivers/thermal/qcom/lmh.c:84:2: error: call to undeclared function 'irq_set_chip_and_handler'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      84 |         irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
         |         ^
>> drivers/thermal/qcom/lmh.c:84:47: error: use of undeclared identifier 'handle_simple_irq'
      84 |         irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
         |                                                      ^
>> drivers/thermal/qcom/lmh.c:85:2: error: call to undeclared function 'irq_set_chip_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      85 |         irq_set_chip_data(irq, lmh_data);
         |         ^
>> drivers/thermal/qcom/lmh.c:219:2: error: call to undeclared function 'irq_set_status_flags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     219 |         irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
         |         ^
>> drivers/thermal/qcom/lmh.c:219:38: error: use of undeclared identifier 'IRQ_NOAUTOEN'
     219 |         irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
         |                                             ^
   13 errors generated.


vim +/generic_handle_irq +46 drivers/thermal/qcom/lmh.c

53bca371cdf7ad Thara Gopinath    2021-08-09   38  
53bca371cdf7ad Thara Gopinath    2021-08-09   39  static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
53bca371cdf7ad Thara Gopinath    2021-08-09   40  {
53bca371cdf7ad Thara Gopinath    2021-08-09   41  	struct lmh_hw_data *lmh_data = data;
53bca371cdf7ad Thara Gopinath    2021-08-09   42  	int irq = irq_find_mapping(lmh_data->domain, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09   43  
53bca371cdf7ad Thara Gopinath    2021-08-09   44  	/* Call the cpufreq driver to handle the interrupt */
53bca371cdf7ad Thara Gopinath    2021-08-09   45  	if (irq)
53bca371cdf7ad Thara Gopinath    2021-08-09  @46  		generic_handle_irq(irq);
53bca371cdf7ad Thara Gopinath    2021-08-09   47  
46a891e45be97c Bjorn Andersson   2022-03-16   48  	return IRQ_HANDLED;
53bca371cdf7ad Thara Gopinath    2021-08-09   49  }
53bca371cdf7ad Thara Gopinath    2021-08-09   50  
53bca371cdf7ad Thara Gopinath    2021-08-09   51  static void lmh_enable_interrupt(struct irq_data *d)
53bca371cdf7ad Thara Gopinath    2021-08-09   52  {
53bca371cdf7ad Thara Gopinath    2021-08-09  @53  	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
53bca371cdf7ad Thara Gopinath    2021-08-09   54  
53bca371cdf7ad Thara Gopinath    2021-08-09   55  	/* Clear the existing interrupt */
53bca371cdf7ad Thara Gopinath    2021-08-09  @56  	writel(0xff, lmh_data->base + LMH_REG_DCVS_INTR_CLR);
53bca371cdf7ad Thara Gopinath    2021-08-09   57  	enable_irq(lmh_data->irq);
53bca371cdf7ad Thara Gopinath    2021-08-09   58  }
53bca371cdf7ad Thara Gopinath    2021-08-09   59  
53bca371cdf7ad Thara Gopinath    2021-08-09   60  static void lmh_disable_interrupt(struct irq_data *d)
53bca371cdf7ad Thara Gopinath    2021-08-09   61  {
53bca371cdf7ad Thara Gopinath    2021-08-09   62  	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
53bca371cdf7ad Thara Gopinath    2021-08-09   63  
53bca371cdf7ad Thara Gopinath    2021-08-09   64  	disable_irq_nosync(lmh_data->irq);
53bca371cdf7ad Thara Gopinath    2021-08-09   65  }
53bca371cdf7ad Thara Gopinath    2021-08-09   66  
53bca371cdf7ad Thara Gopinath    2021-08-09  @67  static struct irq_chip lmh_irq_chip = {
53bca371cdf7ad Thara Gopinath    2021-08-09   68  	.name           = "lmh",
53bca371cdf7ad Thara Gopinath    2021-08-09   69  	.irq_enable	= lmh_enable_interrupt,
53bca371cdf7ad Thara Gopinath    2021-08-09   70  	.irq_disable	= lmh_disable_interrupt
53bca371cdf7ad Thara Gopinath    2021-08-09   71  };
53bca371cdf7ad Thara Gopinath    2021-08-09   72  
53bca371cdf7ad Thara Gopinath    2021-08-09   73  static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
53bca371cdf7ad Thara Gopinath    2021-08-09   74  {
53bca371cdf7ad Thara Gopinath    2021-08-09   75  	struct lmh_hw_data *lmh_data = d->host_data;
f16beaaee248ea Dmitry Baryshkov  2024-10-11   76  	static struct lock_class_key lmh_lock_key;
f16beaaee248ea Dmitry Baryshkov  2024-10-11   77  	static struct lock_class_key lmh_request_key;
53bca371cdf7ad Thara Gopinath    2021-08-09   78  
f16beaaee248ea Dmitry Baryshkov  2024-10-11   79  	/*
f16beaaee248ea Dmitry Baryshkov  2024-10-11   80  	 * This lock class tells lockdep that GPIO irqs are in a different
f16beaaee248ea Dmitry Baryshkov  2024-10-11   81  	 * category than their parents, so it won't report false recursion.
f16beaaee248ea Dmitry Baryshkov  2024-10-11   82  	 */
f16beaaee248ea Dmitry Baryshkov  2024-10-11  @83  	irq_set_lockdep_class(irq, &lmh_lock_key, &lmh_request_key);
53bca371cdf7ad Thara Gopinath    2021-08-09  @84  	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
53bca371cdf7ad Thara Gopinath    2021-08-09  @85  	irq_set_chip_data(irq, lmh_data);
53bca371cdf7ad Thara Gopinath    2021-08-09   86  
53bca371cdf7ad Thara Gopinath    2021-08-09   87  	return 0;
53bca371cdf7ad Thara Gopinath    2021-08-09   88  }
53bca371cdf7ad Thara Gopinath    2021-08-09   89  
53bca371cdf7ad Thara Gopinath    2021-08-09   90  static const struct irq_domain_ops lmh_irq_ops = {
53bca371cdf7ad Thara Gopinath    2021-08-09   91  	.map = lmh_irq_map,
53bca371cdf7ad Thara Gopinath    2021-08-09   92  	.xlate = irq_domain_xlate_onecell,
53bca371cdf7ad Thara Gopinath    2021-08-09   93  };
53bca371cdf7ad Thara Gopinath    2021-08-09   94  
53bca371cdf7ad Thara Gopinath    2021-08-09   95  static int lmh_probe(struct platform_device *pdev)
53bca371cdf7ad Thara Gopinath    2021-08-09   96  {
53bca371cdf7ad Thara Gopinath    2021-08-09   97  	struct device *dev = &pdev->dev;
53bca371cdf7ad Thara Gopinath    2021-08-09   98  	struct device_node *np = dev->of_node;
53bca371cdf7ad Thara Gopinath    2021-08-09   99  	struct device_node *cpu_node;
53bca371cdf7ad Thara Gopinath    2021-08-09  100  	struct lmh_hw_data *lmh_data;
53bca371cdf7ad Thara Gopinath    2021-08-09  101  	int temp_low, temp_high, temp_arm, cpu_id, ret;
cf0c54db636c91 Thara Gopinath    2022-01-06  102  	unsigned int enable_alg;
53bca371cdf7ad Thara Gopinath    2021-08-09  103  	u32 node_id;
53bca371cdf7ad Thara Gopinath    2021-08-09  104  
d9d3490c48df57 Konrad Dybcio     2024-03-09  105  	if (!qcom_scm_is_available())
d9d3490c48df57 Konrad Dybcio     2024-03-09  106  		return -EPROBE_DEFER;
d9d3490c48df57 Konrad Dybcio     2024-03-09  107  
53bca371cdf7ad Thara Gopinath    2021-08-09  108  	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
53bca371cdf7ad Thara Gopinath    2021-08-09  109  	if (!lmh_data)
53bca371cdf7ad Thara Gopinath    2021-08-09  110  		return -ENOMEM;
53bca371cdf7ad Thara Gopinath    2021-08-09  111  
53bca371cdf7ad Thara Gopinath    2021-08-09  112  	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  113  	if (IS_ERR(lmh_data->base))
53bca371cdf7ad Thara Gopinath    2021-08-09  114  		return PTR_ERR(lmh_data->base);
53bca371cdf7ad Thara Gopinath    2021-08-09  115  
53bca371cdf7ad Thara Gopinath    2021-08-09  116  	cpu_node = of_parse_phandle(np, "cpus", 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  117  	if (!cpu_node)
53bca371cdf7ad Thara Gopinath    2021-08-09  118  		return -EINVAL;
53bca371cdf7ad Thara Gopinath    2021-08-09  119  	cpu_id = of_cpu_node_to_id(cpu_node);
53bca371cdf7ad Thara Gopinath    2021-08-09  120  	of_node_put(cpu_node);
53bca371cdf7ad Thara Gopinath    2021-08-09  121  
53bca371cdf7ad Thara Gopinath    2021-08-09  122  	ret = of_property_read_u32(np, "qcom,lmh-temp-high-millicelsius", &temp_high);
53bca371cdf7ad Thara Gopinath    2021-08-09  123  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  124  		dev_err(dev, "missing qcom,lmh-temp-high-millicelsius property\n");
53bca371cdf7ad Thara Gopinath    2021-08-09  125  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  126  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  127  
53bca371cdf7ad Thara Gopinath    2021-08-09  128  	ret = of_property_read_u32(np, "qcom,lmh-temp-low-millicelsius", &temp_low);
53bca371cdf7ad Thara Gopinath    2021-08-09  129  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  130  		dev_err(dev, "missing qcom,lmh-temp-low-millicelsius property\n");
53bca371cdf7ad Thara Gopinath    2021-08-09  131  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  132  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  133  
53bca371cdf7ad Thara Gopinath    2021-08-09  134  	ret = of_property_read_u32(np, "qcom,lmh-temp-arm-millicelsius", &temp_arm);
53bca371cdf7ad Thara Gopinath    2021-08-09  135  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  136  		dev_err(dev, "missing qcom,lmh-temp-arm-millicelsius property\n");
53bca371cdf7ad Thara Gopinath    2021-08-09  137  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  138  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  139  
53bca371cdf7ad Thara Gopinath    2021-08-09  140  	/*
53bca371cdf7ad Thara Gopinath    2021-08-09  141  	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
53bca371cdf7ad Thara Gopinath    2021-08-09  142  	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
53bca371cdf7ad Thara Gopinath    2021-08-09  143  	 * of a dt match table.
53bca371cdf7ad Thara Gopinath    2021-08-09  144  	 */
53bca371cdf7ad Thara Gopinath    2021-08-09  145  	if (cpu_id == 0) {
53bca371cdf7ad Thara Gopinath    2021-08-09  146  		node_id = LMH_CLUSTER0_NODE_ID;
53bca371cdf7ad Thara Gopinath    2021-08-09  147  	} else if (cpu_id == 4) {
53bca371cdf7ad Thara Gopinath    2021-08-09  148  		node_id = LMH_CLUSTER1_NODE_ID;
53bca371cdf7ad Thara Gopinath    2021-08-09  149  	} else {
53bca371cdf7ad Thara Gopinath    2021-08-09  150  		dev_err(dev, "Wrong CPU id associated with LMh node\n");
53bca371cdf7ad Thara Gopinath    2021-08-09  151  		return -EINVAL;
53bca371cdf7ad Thara Gopinath    2021-08-09  152  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  153  
53bca371cdf7ad Thara Gopinath    2021-08-09  154  	if (!qcom_scm_lmh_dcvsh_available())
53bca371cdf7ad Thara Gopinath    2021-08-09  155  		return -EINVAL;
53bca371cdf7ad Thara Gopinath    2021-08-09  156  
cf0c54db636c91 Thara Gopinath    2022-01-06  157  	enable_alg = (uintptr_t)of_device_get_match_data(dev);
cf0c54db636c91 Thara Gopinath    2022-01-06  158  
cf0c54db636c91 Thara Gopinath    2022-01-06  159  	if (enable_alg) {
53bca371cdf7ad Thara Gopinath    2021-08-09  160  		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
53bca371cdf7ad Thara Gopinath    2021-08-09  161  					 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  162  		if (ret)
53bca371cdf7ad Thara Gopinath    2021-08-09  163  			dev_err(dev, "Error %d enabling current subfunction\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  164  
53bca371cdf7ad Thara Gopinath    2021-08-09  165  		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
53bca371cdf7ad Thara Gopinath    2021-08-09  166  					 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  167  		if (ret)
53bca371cdf7ad Thara Gopinath    2021-08-09  168  			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  169  
53bca371cdf7ad Thara Gopinath    2021-08-09  170  		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
53bca371cdf7ad Thara Gopinath    2021-08-09  171  					 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  172  		if (ret)
53bca371cdf7ad Thara Gopinath    2021-08-09  173  			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  174  
53bca371cdf7ad Thara Gopinath    2021-08-09  175  		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
53bca371cdf7ad Thara Gopinath    2021-08-09  176  					 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  177  		if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  178  			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  179  			return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  180  		}
53bca371cdf7ad Thara Gopinath    2021-08-09  181  
53bca371cdf7ad Thara Gopinath    2021-08-09  182  		ret = qcom_scm_lmh_profile_change(0x1);
53bca371cdf7ad Thara Gopinath    2021-08-09  183  		if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  184  			dev_err(dev, "Error %d changing profile\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  185  			return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  186  		}
cf0c54db636c91 Thara Gopinath    2022-01-06  187  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  188  
53bca371cdf7ad Thara Gopinath    2021-08-09  189  	/* Set default thermal trips */
53bca371cdf7ad Thara Gopinath    2021-08-09  190  	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
53bca371cdf7ad Thara Gopinath    2021-08-09  191  				 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  192  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  193  		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  194  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  195  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  196  
53bca371cdf7ad Thara Gopinath    2021-08-09  197  	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
53bca371cdf7ad Thara Gopinath    2021-08-09  198  				 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  199  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  200  		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  201  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  202  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  203  
53bca371cdf7ad Thara Gopinath    2021-08-09  204  	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
53bca371cdf7ad Thara Gopinath    2021-08-09  205  				 LMH_NODE_DCVS, node_id, 0);
53bca371cdf7ad Thara Gopinath    2021-08-09  206  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  207  		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
53bca371cdf7ad Thara Gopinath    2021-08-09  208  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  209  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  210  
53bca371cdf7ad Thara Gopinath    2021-08-09  211  	lmh_data->irq = platform_get_irq(pdev, 0);
7ee2c3c0dac372 Jiri Slaby (SUSE  2025-06-11  212) 	lmh_data->domain = irq_domain_create_linear(dev_fwnode(dev), 1, &lmh_irq_ops, lmh_data);
53bca371cdf7ad Thara Gopinath    2021-08-09  213  	if (!lmh_data->domain) {
53bca371cdf7ad Thara Gopinath    2021-08-09  214  		dev_err(dev, "Error adding irq_domain\n");
53bca371cdf7ad Thara Gopinath    2021-08-09  215  		return -EINVAL;
53bca371cdf7ad Thara Gopinath    2021-08-09  216  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  217  
53bca371cdf7ad Thara Gopinath    2021-08-09  218  	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
53bca371cdf7ad Thara Gopinath    2021-08-09 @219  	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
53bca371cdf7ad Thara Gopinath    2021-08-09  220  	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
53bca371cdf7ad Thara Gopinath    2021-08-09  221  			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
53bca371cdf7ad Thara Gopinath    2021-08-09  222  			       "lmh-irq", lmh_data);
53bca371cdf7ad Thara Gopinath    2021-08-09  223  	if (ret) {
53bca371cdf7ad Thara Gopinath    2021-08-09  224  		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
53bca371cdf7ad Thara Gopinath    2021-08-09  225  		irq_domain_remove(lmh_data->domain);
53bca371cdf7ad Thara Gopinath    2021-08-09  226  		return ret;
53bca371cdf7ad Thara Gopinath    2021-08-09  227  	}
53bca371cdf7ad Thara Gopinath    2021-08-09  228  
53bca371cdf7ad Thara Gopinath    2021-08-09  229  	return 0;
53bca371cdf7ad Thara Gopinath    2021-08-09  230  }
53bca371cdf7ad Thara Gopinath    2021-08-09  231  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

