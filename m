Return-Path: <linux-pm+bounces-12708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62A95B14B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5609C285AC0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD817C7BF;
	Thu, 22 Aug 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfIJUEwz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961414EC5E;
	Thu, 22 Aug 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318229; cv=none; b=K0YUK7B+vitgOOTUkALVTsAXyYwWGFtU2xdXgea/Uv/PGzmE8LkO/1+skA7xwxyHkSqgp+CFJfmlt4XT17hdIra0LtZTVP6f+P6UbDz5UFnun0zMf1hIaXjWljCZ80E/L9/wnZngi5O70xXKihLb5ExHrZPFkEdDS28MqJYR5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318229; c=relaxed/simple;
	bh=a5Snna/TCExFOBfUIFiYvqGHUQEeHIaNkMpIs4WHu8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nadxenfgYBD1Qld5nGUOQu3e8Ty1dfs7XsQDvN8hl7g6wmS04sWZBNvT7k48yBNHLBWn2XHCY876ydyQwbf0vM741VVYfLRSVW3k41hnPMuErTjksmILa9yGrCWo92iZ/93KMCd+0Gwx/K5dASxbgUFquyO/h7a/JSeSyimtaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfIJUEwz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724318227; x=1755854227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a5Snna/TCExFOBfUIFiYvqGHUQEeHIaNkMpIs4WHu8A=;
  b=EfIJUEwzlkMAinuQCWyEPjS1gMj2GTY2jbtjwi8VYqImC0I7p/1gtD2a
   hbMlav1lteFVfH0fegdjf4ZcaiMFMUyfgZMizIicFWqeMHEMGrOn1nLWN
   ABSlSk6g8KYILtm37UCJG6mNlzjJcAZdl0EmAy+A+yZIMR6eyGHrWT3fG
   p/yjc2i75jXRcQ2d1bQSwOd6OCpmuWvuma3EK59dgn2eimDJy4pAfTvP+
   Yh8Y4+dBp0mwJJ6BYijjJQbaK3Oo/Gdud1nMoIxph7I1njNjxrg9JndPR
   cDc4t1EQzge6uBQ1ij5QCx1hatO8KuJhBljabAZr69ZDswUwhcZNWECyc
   g==;
X-CSE-ConnectionGUID: tvX7+ivzTom8L8a0BhbAdA==
X-CSE-MsgGUID: +tr8jDRBRouHrPEWC7tsIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22873220"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22873220"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 02:17:06 -0700
X-CSE-ConnectionGUID: zS7NKeLJSZSG3G3mv54SEQ==
X-CSE-MsgGUID: 07cnPwn5Q6OwHFPvUiRG7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66267241"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Aug 2024 02:17:00 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh3w9-000Cd0-1m;
	Thu, 22 Aug 2024 09:16:57 +0000
Date: Thu, 22 Aug 2024 17:16:40 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Wahren <wahrenst@gmx.net>, Russell King <linux@armlinux.org.uk>,
	Doug Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH V3 7/9] usb: dwc2: Refactor backup/restore of registers
Message-ID: <202408221629.jv9AgCrF-lkp@intel.com>
References: <20240821214052.6800-8-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821214052.6800-8-wahrenst@gmx.net>

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on arm/for-next arm/fixes v6.11-rc4 next-20240822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Wahren/mailbox-bcm2835-Fix-timeout-during-suspend-mode/20240822-063725
base:   linus/master
patch link:    https://lore.kernel.org/r/20240821214052.6800-8-wahrenst%40gmx.net
patch subject: [PATCH V3 7/9] usb: dwc2: Refactor backup/restore of registers
config: x86_64-randconfig-161-20240822 (https://download.01.org/0day-ci/archive/20240822/202408221629.jv9AgCrF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221629.jv9AgCrF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221629.jv9AgCrF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/dwc2/gadget.c:5605:28: warning: variable 'dr' set but not used [-Wunused-but-set-variable]
    5605 |         struct dwc2_dregs_backup *dr;
         |                                   ^
   1 warning generated.


vim +/dr +5605 drivers/usb/dwc2/gadget.c

be2b960e57154a Artur Petrosyan 2021-04-08  5588  
be2b960e57154a Artur Petrosyan 2021-04-08  5589  /*
be2b960e57154a Artur Petrosyan 2021-04-08  5590   * dwc2_gadget_exit_partial_power_down() - Exit controller from device partial
be2b960e57154a Artur Petrosyan 2021-04-08  5591   * power down.
be2b960e57154a Artur Petrosyan 2021-04-08  5592   *
be2b960e57154a Artur Petrosyan 2021-04-08  5593   * @hsotg: Programming view of the DWC_otg controller
be2b960e57154a Artur Petrosyan 2021-04-08  5594   * @restore: indicates whether need to restore the registers or not.
be2b960e57154a Artur Petrosyan 2021-04-08  5595   *
be2b960e57154a Artur Petrosyan 2021-04-08  5596   * Return: non-zero if failed to exit device partial power down.
be2b960e57154a Artur Petrosyan 2021-04-08  5597   *
be2b960e57154a Artur Petrosyan 2021-04-08  5598   * This function is for exiting from device mode partial power down.
be2b960e57154a Artur Petrosyan 2021-04-08  5599   */
be2b960e57154a Artur Petrosyan 2021-04-08  5600  int dwc2_gadget_exit_partial_power_down(struct dwc2_hsotg *hsotg,
be2b960e57154a Artur Petrosyan 2021-04-08  5601  					bool restore)
be2b960e57154a Artur Petrosyan 2021-04-08  5602  {
be2b960e57154a Artur Petrosyan 2021-04-08  5603  	u32 pcgcctl;
be2b960e57154a Artur Petrosyan 2021-04-08  5604  	u32 dctl;
be2b960e57154a Artur Petrosyan 2021-04-08 @5605  	struct dwc2_dregs_backup *dr;
be2b960e57154a Artur Petrosyan 2021-04-08  5606  	int ret = 0;
be2b960e57154a Artur Petrosyan 2021-04-08  5607  
be2b960e57154a Artur Petrosyan 2021-04-08  5608  	dr = &hsotg->dr_backup;
be2b960e57154a Artur Petrosyan 2021-04-08  5609  
be2b960e57154a Artur Petrosyan 2021-04-08  5610  	dev_dbg(hsotg->dev, "Exiting device partial Power Down started.\n");
be2b960e57154a Artur Petrosyan 2021-04-08  5611  
be2b960e57154a Artur Petrosyan 2021-04-08  5612  	pcgcctl = dwc2_readl(hsotg, PCGCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5613  	pcgcctl &= ~PCGCTL_STOPPCLK;
be2b960e57154a Artur Petrosyan 2021-04-08  5614  	dwc2_writel(hsotg, pcgcctl, PCGCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5615  
be2b960e57154a Artur Petrosyan 2021-04-08  5616  	pcgcctl = dwc2_readl(hsotg, PCGCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5617  	pcgcctl &= ~PCGCTL_PWRCLMP;
be2b960e57154a Artur Petrosyan 2021-04-08  5618  	dwc2_writel(hsotg, pcgcctl, PCGCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5619  
be2b960e57154a Artur Petrosyan 2021-04-08  5620  	pcgcctl = dwc2_readl(hsotg, PCGCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5621  	pcgcctl &= ~PCGCTL_RSTPDWNMODULE;
be2b960e57154a Artur Petrosyan 2021-04-08  5622  	dwc2_writel(hsotg, pcgcctl, PCGCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5623  
be2b960e57154a Artur Petrosyan 2021-04-08  5624  	udelay(100);
be2b960e57154a Artur Petrosyan 2021-04-08  5625  	if (restore) {
78c09c66698a77 Stefan Wahren   2024-08-21  5626  		ret = dwc2_gadget_restore_critical_registers(hsotg);
78c09c66698a77 Stefan Wahren   2024-08-21  5627  		if (ret)
be2b960e57154a Artur Petrosyan 2021-04-08  5628  			return ret;
be2b960e57154a Artur Petrosyan 2021-04-08  5629  	}
be2b960e57154a Artur Petrosyan 2021-04-08  5630  
be2b960e57154a Artur Petrosyan 2021-04-08  5631  	/* Set the Power-On Programming done bit */
be2b960e57154a Artur Petrosyan 2021-04-08  5632  	dctl = dwc2_readl(hsotg, DCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5633  	dctl |= DCTL_PWRONPRGDONE;
be2b960e57154a Artur Petrosyan 2021-04-08  5634  	dwc2_writel(hsotg, dctl, DCTL);
be2b960e57154a Artur Petrosyan 2021-04-08  5635  
be2b960e57154a Artur Petrosyan 2021-04-08  5636  	/* Set in_ppd flag to 0 as here core exits from suspend. */
be2b960e57154a Artur Petrosyan 2021-04-08  5637  	hsotg->in_ppd = 0;
be2b960e57154a Artur Petrosyan 2021-04-08  5638  	hsotg->lx_state = DWC2_L0;
be2b960e57154a Artur Petrosyan 2021-04-08  5639  
be2b960e57154a Artur Petrosyan 2021-04-08  5640  	dev_dbg(hsotg->dev, "Exiting device partial Power Down completed.\n");
be2b960e57154a Artur Petrosyan 2021-04-08  5641  	return ret;
be2b960e57154a Artur Petrosyan 2021-04-08  5642  }
012466fc8ccc01 Artur Petrosyan 2021-04-13  5643  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

