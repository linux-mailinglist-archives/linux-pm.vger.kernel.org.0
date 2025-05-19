Return-Path: <linux-pm+bounces-27297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9461ABB48D
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D78C1892D5F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 05:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B92066F7;
	Mon, 19 May 2025 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CE0w6WwO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3F1FF1C7;
	Mon, 19 May 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634337; cv=none; b=dqod75jfAqU+aibuAfrx0w/CZJNw6mgFQjvLPHg1hT9mqxMa7M1pbeDYTBk5V7yazyZC8rIeBfEhke3nlepcu6Emq1Qh6tnBhPA+kSDKTf6lgkKFhX77WUW3x0/+1KtA23ji71vMj7SxPwqc0AtTEF54+lmV1UxGYTw2ju8hWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634337; c=relaxed/simple;
	bh=V+uTJfNAlt+eTwGKfdtk7Aw4sPh5/5YlJ42c3mBtdFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3pF+kbtt4/MASm8Ld9GmgmZJyjIVkrM9m3gwUV1Tgt9V3mxcOLf/NCX/EiSatcnCyNb1s7/FtmkSuP4rVTGBQw1cNTQnMJ1Qi6l5uY2pnUh4LCCdd337aAVmMp3mEp9XNDMRSwatSpyH09S4tPiGwnT7Px7bgPe8bZZJkTnEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CE0w6WwO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747634336; x=1779170336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+uTJfNAlt+eTwGKfdtk7Aw4sPh5/5YlJ42c3mBtdFk=;
  b=CE0w6WwOi8fbOfpL3UlTAlsvAFuwinsFSiD4FH8MchfjDxwrjooIK8To
   8ThitDC8Lo3yLxcCDxL3ETEQQqv2OtUPu1dYmacHKIDhn3nF+wJRMQ3+P
   etcyWm80+39AF3fSurQcao2BAA48EUEaA9SQFcSChfm/27CE3Sj3LdlTs
   9QEL8O1F5OINqVDPzf1dsjSOvDUtotrHcleDyFRR4J6o0WINm1g945Ysb
   7dqEvTANNLm1OeHijsnnCULLAim66/YeN8BJHF1RWzxek7pBmNHR+o8dx
   irnKZYeftPdMXdMOh4c1DbX8ZsNHGgF5Qj2Bi6WZFpjEzILOmrVwvChGc
   A==;
X-CSE-ConnectionGUID: e6XKzEHERtixF4MG+FNc0w==
X-CSE-MsgGUID: CjSL7aczSZqI0d+IDvJ6dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53336333"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53336333"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:58:52 -0700
X-CSE-ConnectionGUID: XXlEr0BlS0uOimkdzmH2/Q==
X-CSE-MsgGUID: zBUN46WgTf6FANBZw9Iusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139766796"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 May 2025 22:58:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGtWR-000LB1-07;
	Mon, 19 May 2025 05:58:47 +0000
Date: Mon, 19 May 2025 13:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Han <hanchunchao@inspur.com>, krzk@kernel.org, sre@kernel.org,
	akpm@linux-foundation.org, lee@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH V2] charger: max14577: Handle NULL pdata when CONFIG_OF
 is not set
Message-ID: <202505191305.un0tzZu1-lkp@intel.com>
References: <20250519014804.2244-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519014804.2244-1-hanchunchao@inspur.com>

Hi Charles,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Han/charger-max14577-Handle-NULL-pdata-when-CONFIG_OF-is-not-set/20250519-095431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250519014804.2244-1-hanchunchao%40inspur.com
patch subject: [PATCH V2] charger: max14577: Handle NULL pdata when CONFIG_OF is not set
config: sh-randconfig-002-20250519 (https://download.01.org/0day-ci/archive/20250519/202505191305.un0tzZu1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505191305.un0tzZu1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505191305.un0tzZu1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/power/supply/max14577_charger.c: In function 'max14577_charger_dt_init':
>> drivers/power/supply/max14577_charger.c:504:16: error: returning 'int' from a function with return type 'struct max14577_charger_platform_data *' makes pointer from integer without a cast [-Wint-conversion]
     504 |         return -ENODATA;
         |                ^


vim +504 drivers/power/supply/max14577_charger.c

   454	
   455	#ifdef CONFIG_OF
   456	static struct max14577_charger_platform_data *max14577_charger_dt_init(
   457			struct platform_device *pdev)
   458	{
   459		struct max14577_charger_platform_data *pdata;
   460		struct device_node *np = pdev->dev.of_node;
   461		int ret;
   462	
   463		if (!np) {
   464			dev_err(&pdev->dev, "No charger OF node\n");
   465			return ERR_PTR(-EINVAL);
   466		}
   467	
   468		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
   469		if (!pdata)
   470			return ERR_PTR(-ENOMEM);
   471	
   472		ret = of_property_read_u32(np, "maxim,constant-uvolt",
   473				&pdata->constant_uvolt);
   474		if (ret) {
   475			dev_err(&pdev->dev, "Cannot parse maxim,constant-uvolt field from DT\n");
   476			return ERR_PTR(ret);
   477		}
   478	
   479		ret = of_property_read_u32(np, "maxim,fast-charge-uamp",
   480				&pdata->fast_charge_uamp);
   481		if (ret) {
   482			dev_err(&pdev->dev, "Cannot parse maxim,fast-charge-uamp field from DT\n");
   483			return ERR_PTR(ret);
   484		}
   485	
   486		ret = of_property_read_u32(np, "maxim,eoc-uamp", &pdata->eoc_uamp);
   487		if (ret) {
   488			dev_err(&pdev->dev, "Cannot parse maxim,eoc-uamp field from DT\n");
   489			return ERR_PTR(ret);
   490		}
   491	
   492		ret = of_property_read_u32(np, "maxim,ovp-uvolt", &pdata->ovp_uvolt);
   493		if (ret) {
   494			dev_err(&pdev->dev, "Cannot parse maxim,ovp-uvolt field from DT\n");
   495			return ERR_PTR(ret);
   496		}
   497	
   498		return pdata;
   499	}
   500	#else /* CONFIG_OF */
   501	static struct max14577_charger_platform_data *max14577_charger_dt_init(
   502			struct platform_device *pdev)
   503	{
 > 504		return -ENODATA;
   505	}
   506	#endif /* CONFIG_OF */
   507	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

