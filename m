Return-Path: <linux-pm+bounces-34679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF216B57F8A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B073B5D47
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126B341AB6;
	Mon, 15 Sep 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aaw7untd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8C34167D;
	Mon, 15 Sep 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947765; cv=none; b=cMQ60/8ios3tNOv9uhofS+BtwulGL9kEBkMdy7Mo6oF4sRx3yQtTIJ1op8L7b0G2PgWuthYYIx0HvWwTuAJwlTEr+tgmAuUo1ChUOL0x/EeM2HCOK4p2JUBKSCiFGvHet6nq/sBYOpe5p/kVdeQ3Ntd4WusquwycneG6xKL6e2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947765; c=relaxed/simple;
	bh=qzDJZ6MIVaKjCDoPQ7eYvhjd24ErbN5nstetVspBJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT3h5JD5P6t4yNbrTrZb4Cunl6wsQ7DlS1ykpQnp61vha/GoS73NzcJ+QmaeHE0seJf2oPFs1aSoQ7CaIOw4WhZf+JRvnqGgvuQIZ3jPSvrKR/kNNq4Un+YOIMtcoXLvcO4yhW+z38QBHX6miNyf7+WkFcxofIunXnpH1T15wOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aaw7untd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757947763; x=1789483763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzDJZ6MIVaKjCDoPQ7eYvhjd24ErbN5nstetVspBJWE=;
  b=Aaw7untdVMPxvdcVD2lbeKovYWlwreSgqUj75j6NJ8paP0hFgKfY2MaI
   nM/+CHIlphgBp2Dbwmn8wxaFxlCGWxrUllJDK0x8znktMKDh+ST2CV/aE
   VZ8VvW1sZDTd2Aql4xWoy5geXfqYw90hoaH4+7z2AXFCCfTcdRLH/wSAe
   uRKXL9DMGmhjBb6hnuC/YKDwJczyVPKHm1hB/g4Qlps67MuoH8Kzt26PC
   wDThY5Qso4H3MMNP2zyQAABYZPrVjK39rtTxr3l1m0v14y9q0mQs2BgMg
   dhgsjptBceNh02Qq7eg9mVFNogJUoOSWtc8PZUVNiBred0B3wxPCsKByh
   Q==;
X-CSE-ConnectionGUID: 44cHvJjbTz+uproUJm8GdA==
X-CSE-MsgGUID: sXpPcs64SOivOED7oNVGsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="62837288"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="62837288"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:37:03 -0700
X-CSE-ConnectionGUID: icW+tYUUQeqOVdgjfXiksg==
X-CSE-MsgGUID: wUiI5kB1Sm6pIh+A7sUphA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174477461"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Sep 2025 07:36:59 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyAJp-0000Jn-0W;
	Mon, 15 Sep 2025 14:36:37 +0000
Date: Mon, 15 Sep 2025 22:35:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan.Wanner@microchip.com, claudiu.beznea@tuxon.dev, sre@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	linux@armlinux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: at91: PM: implement selection of LPM
Message-ID: <202509152248.NjJj2xwQ-lkp@intel.com>
References: <e72d9af1326cf44888059270263afde875ccc994.1757519351.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72d9af1326cf44888059270263afde875ccc994.1757519351.git.Ryan.Wanner@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on cbeznea/tests linus/master v6.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Wanner-microchip-com/dt-bindings-power-reset-atmel-sama5d2-shdwc-add-lpm-binding/20250911-002354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/e72d9af1326cf44888059270263afde875ccc994.1757519351.git.Ryan.Wanner%40microchip.com
patch subject: [PATCH 2/4] ARM: at91: PM: implement selection of LPM
config: arm-randconfig-r131-20250915 (https://download.01.org/0day-ci/archive/20250915/202509152248.NjJj2xwQ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 21857ae337e0892a5522b6e7337899caa61de2a6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250915/202509152248.NjJj2xwQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509152248.NjJj2xwQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-at91/pm.c:283:75: sparse: sparse: Using plain integer as NULL pointer
   arch/arm/mach-at91/pm.c:1101:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void ( *static [assigned] [toplevel] at91_suspend_sram_fn )( ... ) @@     got void [noderef] __iomem * @@
   arch/arm/mach-at91/pm.c:1101:30: sparse:     expected void ( *static [assigned] [toplevel] at91_suspend_sram_fn )( ... )
   arch/arm/mach-at91/pm.c:1101:30: sparse:     got void [noderef] __iomem *

vim +283 arch/arm/mach-at91/pm.c

   271	
   272	static int at91_pm_prepare_lpm(unsigned int pm_mode)
   273	{
   274		struct platform_device *pdev;
   275		int ndevices, i, ret;
   276		struct of_phandle_args lpmspec;
   277	
   278		if ((pm_mode != AT91_PM_ULP0 && pm_mode != AT91_PM_ULP1) ||
   279		    !soc_pm.shdwc_np)
   280			return 0;
   281	
   282		ndevices = of_count_phandle_with_args(soc_pm.shdwc_np,
 > 283						      "microchip,lpm-connection", 0);
   284		if (ndevices < 0)
   285			return 0;
   286	
   287		soc_pm.data.lpm = 1;
   288		for (i = 0; i < ndevices; i++) {
   289			ret = of_parse_phandle_with_args(soc_pm.shdwc_np,
   290							 "microchip,lpm-connection",
   291							 NULL, i, &lpmspec);
   292			if (ret < 0) {
   293				if (ret == -ENOENT) {
   294					continue;
   295				} else {
   296					soc_pm.data.lpm = 0;
   297					return ret;
   298				}
   299			}
   300	
   301			pdev = of_find_device_by_node(lpmspec.np);
   302			if (!pdev)
   303				continue;
   304	
   305			if (device_may_wakeup(&pdev->dev)) {
   306				if (pm_mode == AT91_PM_ULP1) {
   307					/*
   308					 * ULP1 wake-up sources are limited. Ignore it if not
   309					 * in soc_pm.ws_ids.
   310					 */
   311					if (at91_pm_device_in_list(pdev, soc_pm.ws_ids))
   312						soc_pm.data.lpm = 0;
   313				} else {
   314					soc_pm.data.lpm = 0;
   315				}
   316			}
   317	
   318			put_device(&pdev->dev);
   319			if (!soc_pm.data.lpm)
   320				break;
   321		}
   322	
   323		return 0;
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

