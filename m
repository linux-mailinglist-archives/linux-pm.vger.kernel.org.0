Return-Path: <linux-pm+bounces-19801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F549FD914
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 06:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338C416321F
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 05:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476770812;
	Sat, 28 Dec 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOyJ687e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49004481D1;
	Sat, 28 Dec 2024 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735364682; cv=none; b=BRQqNTkWKQ1g9FQcA7W+OvI0K3IeC/W5eNXd05oekL+rMByQT67xgXD0sKBzzl8ct1U/n5EQkXwWhfHgfDXRJXzpCv8yiNxltXgw/FcPMGqgkYk88QzUYdOC0qazNth9kY8nj2ueuCZgRwIpE5rvKfzyBcUjaFyQiyZo6olmXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735364682; c=relaxed/simple;
	bh=7+MJqD3C48EXjWCp0o71PXcfiXhqzoReRXFzpsHCzo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfllSON1QY8spM7lMhztshXevEtttbzC9dR5GMtJNgsGmkBu1beWsNZ0hvz1ZazdyKStc4h3N2C2V5qZwLwGO+uAsHSu7on6MWr2lLcByE9m65Q167X7me573tk2Y4GU94kHDDAk1I4GQAnX8vJqp5pnmKZI/zLCiG2VEzEqMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOyJ687e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735364680; x=1766900680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7+MJqD3C48EXjWCp0o71PXcfiXhqzoReRXFzpsHCzo0=;
  b=bOyJ687eMAhhLh/rZMQy+EMFayaEEv6UWQrO8+dhiD6YQ/zdLJyKCuhL
   JUaGgjpLK7HqowqI0na9LrpCXnU4OBncsX8LGG5cYk7HvlqbRAgflOEON
   d+1pOMc5Sma15IGJreOp1cdztx2VLAVID8EofE2Y6kAY+8KDfWQanqg4m
   b9EQ4R+WSuIz0W9zeYzCCcwOLPssrA/2nQ8KNDG6VccodkIiW5X2pCVJz
   BTI1iZjmIvrziaJvZIm3kyS8Eux1U1kjLNO9m42JenKmHKrntAXK8DozJ
   VfSFRQmivOa3+9ywe45uqbNn1C9pcTzRdWui1g2WRl3VTIovOJ2zwQbrO
   Q==;
X-CSE-ConnectionGUID: ZNu6eXL8T2OCoq6YIgBWQw==
X-CSE-MsgGUID: U/pGrjBaTyiLcbah+hjO8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="35864197"
X-IronPort-AV: E=Sophos;i="6.12,271,1728975600"; 
   d="scan'208";a="35864197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 21:44:40 -0800
X-CSE-ConnectionGUID: BbyMppGaSKywwZy7sbq9gg==
X-CSE-MsgGUID: XIGLvPlGQVWDxl/TReHwHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,271,1728975600"; 
   d="scan'208";a="100492194"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Dec 2024 21:44:35 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRPcm-0003tE-25;
	Sat, 28 Dec 2024 05:44:32 +0000
Date: Sat, 28 Dec 2024 13:43:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 06/12] rtc: stm32: Use resource managed API to simplify
 code
Message-ID: <202412281302.N1Bd2W48-lkp@intel.com>
References: <20241228-wake_irq-v1-6-09cfca77cd47@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228-wake_irq-v1-6-09cfca77cd47@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/PM-sleep-wakeirq-Introduce-device-managed-variant-of-dev_pm_set_wake_irq/20241228-091859
base:   8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
patch link:    https://lore.kernel.org/r/20241228-wake_irq-v1-6-09cfca77cd47%40nxp.com
patch subject: [PATCH 06/12] rtc: stm32: Use resource managed API to simplify code
config: arm64-randconfig-003-20241228 (https://download.01.org/0day-ci/archive/20241228/202412281302.N1Bd2W48-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241228/202412281302.N1Bd2W48-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412281302.N1Bd2W48-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kasan/kasan_test.o
ERROR: modpost: "devm_pm_set_wake_irq" [drivers/input/touchscreen/ti_am335x_tsc.ko] undefined!
>> ERROR: modpost: "devm_pm_set_wake_irq" [drivers/rtc/rtc-stm32.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

