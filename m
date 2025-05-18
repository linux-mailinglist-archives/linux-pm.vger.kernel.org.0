Return-Path: <linux-pm+bounces-27277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121BABB0BF
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B721897980
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27B18A6C4;
	Sun, 18 May 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGRC2IXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6454B1E5E;
	Sun, 18 May 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747584227; cv=none; b=lPW4TRNqfFiYS9QdLZJa7oFLRSb5vcMeqdwnKagIFYtc/ilB8Y01+jwioS/wde3olQcNcgdwcQna0Ip03EuJN/dFuqeXcrEtxGSiEmKW27d3ZdDn6vqfA+O7hmnfDTgt3RWcROwvNTWEuBblfvnVJU+L7wQ7mzumTKQEX6gFiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747584227; c=relaxed/simple;
	bh=NEn4CVT3vMiLLPE655kPeSKolXUSHA2Tv96ka1G5+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0/1MybWDJabmpnk51TZwukh/iCz45Bmo1PIiyuAy40AwJhwzK2Rk2VHeaJUupHbxCFP/37HrbW8jGREnJsWKpd58JTA0C5iZsraP+J+tAOr0XdOW+iVcGq8ZwPP8G3vwTXVY0lol9pQFfeZLuY+8aUBv1rNcehcjwfNQV3W/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGRC2IXP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747584225; x=1779120225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEn4CVT3vMiLLPE655kPeSKolXUSHA2Tv96ka1G5+B4=;
  b=CGRC2IXP2BFqbEZi8EgapsTI7Nye5AoND1jqNKBHiZeDtLKP+eTaHZHW
   g95vj1jwE6K6Pee4X0FhNUuip44v3YUOwSguQaOCt1HzZQQF1d1C+fO0W
   modGC+f1WSF/dmNHwokYcTFkJHLmRIz2rzSrf6zVtvR38h4Gj1MdJEzEr
   umoSvNWjNdNfPUdq5i1GK4EPPb1Od98pMPHI6HvRL2jHG4ua8qMKaGx3p
   PT+Aw8slWsECJtzDfutmS6uig0v8k4aJ8M/dn4zXOXvShm7dteeXXI/7I
   KetjPxtiu4N/m4NbNeqT/sG8u09VGknNMfPMCFbyxP4RMi/pX1QK+ApIy
   w==;
X-CSE-ConnectionGUID: yvJYNEeIQhO+QEzVLb/KOg==
X-CSE-MsgGUID: 2cFyyHjVQH6ixMuDpqGacA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="74887795"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="74887795"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 09:03:45 -0700
X-CSE-ConnectionGUID: yM6flAhGTmq8jKPvsW8hfw==
X-CSE-MsgGUID: Vj6WNdPERD2wU5GMCOlTXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="139558967"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 May 2025 09:03:42 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGgUF-000Krj-2t;
	Sun, 18 May 2025 16:03:39 +0000
Date: Mon, 19 May 2025 00:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-imx@nxp.com,
	linux-input@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 7/9] input: pf1550: add onkey support
Message-ID: <202505182355.Of8g2bwa-lkp@intel.com>
References: <7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode@savoirfairelinux.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b1d8766052eb0534b27edda8af1865d53621bd6a]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Kayode/dt-bindings-power-supply-add-pf1550/20250517-030259
base:   b1d8766052eb0534b27edda8af1865d53621bd6a
patch link:    https://lore.kernel.org/r/7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode%40savoirfairelinux.com
patch subject: [PATCH v2 7/9] input: pf1550: add onkey support
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250518/202505182355.Of8g2bwa-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250518/202505182355.Of8g2bwa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505182355.Of8g2bwa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/keyboard/pf1550_onkey.c: In function 'pf1550_onkey_resume':
>> drivers/input/keyboard/pf1550_onkey.c:171:30: warning: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744073709551552' to '4294967232' [-Woverflow]
     171 |                              ~(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     172 |                              ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI));
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +171 drivers/input/keyboard/pf1550_onkey.c

   162	
   163	static int pf1550_onkey_resume(struct device *dev)
   164	{
   165		struct platform_device *pdev = to_platform_device(dev);
   166		struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
   167	
   168		if (!device_may_wakeup(&pdev->dev))
   169			regmap_write(onkey->pf1550->regmap,
   170				     PF1550_PMIC_REG_ONKEY_INT_MASK0,
 > 171				     ~(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
   172				     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI));
   173		else
   174			disable_irq_wake(onkey->pf1550->irq);
   175	
   176		return 0;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

