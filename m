Return-Path: <linux-pm+bounces-30663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF8B0115F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 04:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE758551E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD970191F84;
	Fri, 11 Jul 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaSP2puf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227B155C87;
	Fri, 11 Jul 2025 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202176; cv=none; b=GYsXip40EdihTEawTUt4CJikCldBfwZ3fFyugCcc0sqN6pWGp9NI36ru6D//iXhcDeSsj+7nXCyWITZ+g3sw2G69IhujcbZG0Gh0oWE0brw83SgyvA7X/U9PKWnsDcfNAMLR8xeJCLaC3GZ7aN4RVCZgou1rzS8WLt3g8Su1CNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202176; c=relaxed/simple;
	bh=LLjZv6YaeoDc4SEEKroZA66mxOHL4zJDsp3M43OYKV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P88a4e3KHQpXwrQGidu+doHFf54XBsGEP/QF29MqqjSCODrjYTZOCsZQI7FBZ6CKg6bkiINizbxoRbt3RRECt4ZSYEFslRADxQTsQ2Ezx9oKkPQwuoT+Vj/89hVWBAIAcdFS6zarcp/1O3ckVP022JIrfurjBeHzjvAk0XVt1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaSP2puf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752202175; x=1783738175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLjZv6YaeoDc4SEEKroZA66mxOHL4zJDsp3M43OYKV4=;
  b=BaSP2pufH6pDRl6JL1M6inJpBfoffZWis7MO2Y77g8XWU77Um1Py+Rxh
   g6czriBWNyKoEku5sIJ5OyydR++7KwgL4Q9HayerUf5bzKFHqt9dJIew0
   vzoSX4/2mTO6ERGcX6MaqQa7j9YM1GT53LR7MUeveXyOL0eBDm3EJtSuf
   nz9mjs2/LtxUcDTvEcfhGHEKPIeExxnm3b25WQwthAfeiMWhr38OPEOfD
   oz9AKbFYcAQy9WtcVB5TK/3FgdPANSn7ldkn4xowuvnD+JCm+VYjXgsdV
   kWVJQtl8OQMjMIvbzJ8O1VlFTTFpmkW/vmy6Yv4kVMRprgHoFBUHeeJCX
   w==;
X-CSE-ConnectionGUID: mYhOt9fsQjmB5yPECn2oJw==
X-CSE-MsgGUID: KIVOvhvpTvu0CDILKFeyeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="53604569"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="53604569"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:49:35 -0700
X-CSE-ConnectionGUID: diX3w/CCSQOd3a1b8DOe9A==
X-CSE-MsgGUID: 6Z1BSWOoSwiK5I6R6DFClw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="161817339"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 19:49:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua3pG-0005l9-01;
	Fri, 11 Jul 2025 02:49:26 +0000
Date: Fri, 11 Jul 2025 10:48:44 +0800
From: kernel test robot <lkp@intel.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Elliot Berman <elliotb317@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Stephen Boyd <swboyd@chromium.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Andre Draszik <andre.draszik@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH v10 01/10] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <202507111052.smU9DwLS-lkp@intel.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>

Hi Shivendra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 58ba80c4740212c29a1cf9b48f588e60a7612209]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivendra-Pratap/power-reset-reboot-mode-Add-device-tree-node-based-registration/20250710-172104
base:   58ba80c4740212c29a1cf9b48f588e60a7612209
patch link:    https://lore.kernel.org/r/20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85%40oss.qualcomm.com
patch subject: [PATCH v10 01/10] power: reset: reboot-mode: Add device tree node-based registration
config: riscv-randconfig-002-20250711 (https://download.01.org/0day-ci/archive/20250711/202507111052.smU9DwLS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507111052.smU9DwLS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507111052.smU9DwLS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/reset/reboot-mode.c:15: warning: "pr_fmt" redefined
      15 | #define pr_fmt(fmt)     "reboot-mode: " fmt
         | 
   In file included from include/asm-generic/bug.h:28,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/current.h:13,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/power/reset/reboot-mode.c:6:
   include/linux/printk.h:397: note: this is the location of the previous definition
     397 | #define pr_fmt(fmt) fmt
         | 


vim +/pr_fmt +15 drivers/power/reset/reboot-mode.c

    13	
    14	#define PREFIX "mode-"
  > 15	#define pr_fmt(fmt)	"reboot-mode: " fmt
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

