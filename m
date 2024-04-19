Return-Path: <linux-pm+bounces-6712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CD8AAC9F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 12:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B0D1C21629
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117237EF1D;
	Fri, 19 Apr 2024 10:13:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA487EF0A
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521633; cv=none; b=SvFHOzWm/cFzTWzqw7IJ7v3Nk4Oyah7If2UNUHX9iiuTTNlZzmylBDEXLTqiVK/u+POHUscFHEJ7LF97/Yqz0WbJ3jgagFltovok/NF1Mq8YD8lxLxk/+8qwThyWGHXPXA3LUEGiBjcFKZdQT6e46si1o+T7FIrsH11o051CllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521633; c=relaxed/simple;
	bh=LKIVKPFH7jBDkCcE13455K2zhipXjgyozxFUV5gxx/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFdmVt0u09V0SWPL6aTZwksW+hzsRMLZN6yLtEx3Y16zoZRggikdBcORcQ23K7LXA/ngkqrJ9hY9WwqNpsNwql7YVXHkkuFg5Y4Q9LsQ5qWVQvKH6hWW5auMBbYXiEQxCngvlcBaI/W3pFE1uG3TqlR4zHVQ7/1TCPNr37MfLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAF272F;
	Fri, 19 Apr 2024 03:14:18 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A14CC3F792;
	Fri, 19 Apr 2024 03:13:49 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:13:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: kernel test robot <lkp@intel.com>, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, oe-kbuild-all@lists.linux.dev, Jernej Skrabec
 <jernej.skrabec@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [vireshk-pm:cpufreq/arm/linux-next 6/10]
 drivers/cpufreq/sun50i-cpufreq-nvmem.c:128:44: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of
 size 2
Message-ID: <20240419111345.028ad7ec@donnerap.manchester.arm.com>
In-Reply-To: <202404191715.LDwMm2gP-lkp@intel.com>
References: <202404191715.LDwMm2gP-lkp@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:21 +0800
kernel test robot <lkp@intel.com> wrote:

Hi,

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> head:   09d0aaa0ae9c80ff9569393b206226c1008801b1
> commit: 6cc4bcceff9af0e6be9738096d95e4ba75e75123 [6/10] cpufreq: sun50i: Refactor speed bin decoding
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240419/202404191715.LDwMm2gP-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404191715.LDwMm2gP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404191715.LDwMm2gP-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/cpufreq/sun50i-cpufreq-nvmem.c: In function 'sun50i_cpufreq_nvmem_probe':
> >> drivers/cpufreq/sun50i-cpufreq-nvmem.c:128:44: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]  
>      128 |         snprintf(name, MAX_NAME_LEN, "speed%d", speed);
>          |                                            ^~
>    drivers/cpufreq/sun50i-cpufreq-nvmem.c:128:38: note: directive argument in the range [0, 2147483647]
>      128 |         snprintf(name, MAX_NAME_LEN, "speed%d", speed);
>          |                                      ^~~~~~~~~
>    drivers/cpufreq/sun50i-cpufreq-nvmem.c:128:9: note: 'snprintf' output between 7 and 16 bytes into a destination of size 7
>      128 |         snprintf(name, MAX_NAME_LEN, "speed%d", speed);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So I see the problem: "speed" must fit into one decimal digit. At the
moment it's fine, because "speed" is returned by one of the *_efuse_xlate
functions. For the H6, the output is masked by 0x7, so can never be larger
than that. For the H616, the return value is a constant selected in a
switch/case, which is at most "4" at the moment, so it's safe as well.

So is there some established way to communicate this, to appease gcc here?
Would explicitly checking for the range and bailing out solve this? Or is
the some kind of assert to make gcc happy?
Or do we just increase MAX_NAME_LEN?

Cheers,
Andre


> 
> 
> vim +128 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> 
> f328584f7bff86 Yangtao Li        2019-06-12  108  
> f328584f7bff86 Yangtao Li        2019-06-12  109  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
> f328584f7bff86 Yangtao Li        2019-06-12  110  {
> 298098e55a6fcc Viresh Kumar      2022-05-26  111  	int *opp_tokens;
> f328584f7bff86 Yangtao Li        2019-06-12  112  	char name[MAX_NAME_LEN];
> f328584f7bff86 Yangtao Li        2019-06-12  113  	unsigned int cpu;
> 6cc4bcceff9af0 Brandon Cheo Fusi 2024-04-18  114  	int speed;
> f328584f7bff86 Yangtao Li        2019-06-12  115  	int ret;
> f328584f7bff86 Yangtao Li        2019-06-12  116  
> 298098e55a6fcc Viresh Kumar      2022-05-26  117  	opp_tokens = kcalloc(num_possible_cpus(), sizeof(*opp_tokens),
> f328584f7bff86 Yangtao Li        2019-06-12  118  			     GFP_KERNEL);
> 298098e55a6fcc Viresh Kumar      2022-05-26  119  	if (!opp_tokens)
> f328584f7bff86 Yangtao Li        2019-06-12  120  		return -ENOMEM;
> f328584f7bff86 Yangtao Li        2019-06-12  121  
> 6cc4bcceff9af0 Brandon Cheo Fusi 2024-04-18  122  	speed = sun50i_cpufreq_get_efuse();
> 6cc4bcceff9af0 Brandon Cheo Fusi 2024-04-18  123  	if (speed < 0) {
> 298098e55a6fcc Viresh Kumar      2022-05-26  124  		kfree(opp_tokens);
> 6cc4bcceff9af0 Brandon Cheo Fusi 2024-04-18  125  		return speed;
> 1aa24a8f3b5133 Xiaobing Luo      2022-04-23  126  	}
> f328584f7bff86 Yangtao Li        2019-06-12  127  
> f328584f7bff86 Yangtao Li        2019-06-12 @128  	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> f328584f7bff86 Yangtao Li        2019-06-12  129  
> f328584f7bff86 Yangtao Li        2019-06-12  130  	for_each_possible_cpu(cpu) {
> f328584f7bff86 Yangtao Li        2019-06-12  131  		struct device *cpu_dev = get_cpu_device(cpu);
> f328584f7bff86 Yangtao Li        2019-06-12  132  
> f328584f7bff86 Yangtao Li        2019-06-12  133  		if (!cpu_dev) {
> f328584f7bff86 Yangtao Li        2019-06-12  134  			ret = -ENODEV;
> f328584f7bff86 Yangtao Li        2019-06-12  135  			goto free_opp;
> f328584f7bff86 Yangtao Li        2019-06-12  136  		}
> f328584f7bff86 Yangtao Li        2019-06-12  137  
> 298098e55a6fcc Viresh Kumar      2022-05-26  138  		opp_tokens[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
> 298098e55a6fcc Viresh Kumar      2022-05-26  139  		if (opp_tokens[cpu] < 0) {
> 298098e55a6fcc Viresh Kumar      2022-05-26  140  			ret = opp_tokens[cpu];
> f328584f7bff86 Yangtao Li        2019-06-12  141  			pr_err("Failed to set prop name\n");
> f328584f7bff86 Yangtao Li        2019-06-12  142  			goto free_opp;
> f328584f7bff86 Yangtao Li        2019-06-12  143  		}
> f328584f7bff86 Yangtao Li        2019-06-12  144  	}
> f328584f7bff86 Yangtao Li        2019-06-12  145  
> f328584f7bff86 Yangtao Li        2019-06-12  146  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> f328584f7bff86 Yangtao Li        2019-06-12  147  							  NULL, 0);
> f328584f7bff86 Yangtao Li        2019-06-12  148  	if (!IS_ERR(cpufreq_dt_pdev)) {
> 298098e55a6fcc Viresh Kumar      2022-05-26  149  		platform_set_drvdata(pdev, opp_tokens);
> f328584f7bff86 Yangtao Li        2019-06-12  150  		return 0;
> f328584f7bff86 Yangtao Li        2019-06-12  151  	}
> f328584f7bff86 Yangtao Li        2019-06-12  152  
> f328584f7bff86 Yangtao Li        2019-06-12  153  	ret = PTR_ERR(cpufreq_dt_pdev);
> f328584f7bff86 Yangtao Li        2019-06-12  154  	pr_err("Failed to register platform device\n");
> f328584f7bff86 Yangtao Li        2019-06-12  155  
> f328584f7bff86 Yangtao Li        2019-06-12  156  free_opp:
> 298098e55a6fcc Viresh Kumar      2022-05-26  157  	for_each_possible_cpu(cpu)
> 298098e55a6fcc Viresh Kumar      2022-05-26  158  		dev_pm_opp_put_prop_name(opp_tokens[cpu]);
> 298098e55a6fcc Viresh Kumar      2022-05-26  159  	kfree(opp_tokens);
> f328584f7bff86 Yangtao Li        2019-06-12  160  
> f328584f7bff86 Yangtao Li        2019-06-12  161  	return ret;
> f328584f7bff86 Yangtao Li        2019-06-12  162  }
> f328584f7bff86 Yangtao Li        2019-06-12  163  
> 
> :::::: The code at line 128 was first introduced by commit
> :::::: f328584f7bff86858249bb358f1adcecde48388a cpufreq: Add sun50i nvmem based CPU scaling driver
> 
> :::::: TO: Yangtao Li <tiny.windzz@gmail.com>
> :::::: CC: Viresh Kumar <viresh.kumar@linaro.org>
> 


