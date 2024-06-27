Return-Path: <linux-pm+bounces-10099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B791A159
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26FD1C21C51
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DC78C9A;
	Thu, 27 Jun 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eg6xybTK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4550285;
	Thu, 27 Jun 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476679; cv=none; b=leRF0FqBqzIhGGWH1jFNInzvisgZxqA17rIrFEZlmvi02aCoAwcK5y+/FhlguZn0dCyzX8baKsP4Mr9ACnn/OVBDKRZifpqmFq3Un63iWky9Pr5rgkyW9dGe7/BjWhDudergEQXEpZq5YHMRGuBCVM2P/uRB3/hvRcCIPV4Qnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476679; c=relaxed/simple;
	bh=nrcED+kfNOJnZI80OvRQZgPNWlUT47kK8X+bKOmviCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbVBsi4eE63PMXtXRmXFbsh2WUhQDNj7OZTK0E3SuaxToShJTSbNy6mIC064YcEmcppIoR/TmuRxzCB1bv+QQSfCYnKklcHulhwwj0eNbennJm27wMHa6A9kLNr3KA+mgwEclsI+q03jeS2n9oWrmfGpO0tMXJo5d6a/hmnMu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eg6xybTK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719476676; x=1751012676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nrcED+kfNOJnZI80OvRQZgPNWlUT47kK8X+bKOmviCM=;
  b=eg6xybTKYGhPZMv/ujzj2LmgCaDKyQ7yQtGDYVmdaEF8bW87ZsvSevRG
   uNIdrIuQECQ0npH/39VLojTk14yxbWiXFTozUOIGTlwbef4gaG8a3fEAY
   nsz7G2jlj+0Dka5FIN7AE0kU8ShtUGin247Aelda4RWBTrJGsvtXDPvLq
   XX9U+saeJZmLCrRvWf43F12EaQ8IQ1QDrOGcL1GB/Y5urucs5sddmFa9D
   pNdQjKTMUQeiJaSwIO9iuNVSaoItW+rgUyED9pIuTHecXWgv5svTE3ldy
   rY6WTDyY41nL6vyqo/0fP/QwjLwNiA5SBe9iFY2Qwq2iM3AyAjMiadAuA
   Q==;
X-CSE-ConnectionGUID: DnqKiHpPQaOky7xircWvfg==
X-CSE-MsgGUID: z1GxZ3QHQMGMzSI0W+HN8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16732457"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16732457"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 01:24:36 -0700
X-CSE-ConnectionGUID: glugGBpTT1yyzfQ3hLwEGA==
X-CSE-MsgGUID: T9QHmxmfQZW2EwUhcgfaTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44944816"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Jun 2024 01:24:31 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMkQf-000G3N-1Q;
	Thu, 27 Jun 2024 08:24:29 +0000
Date: Thu, 27 Jun 2024 16:23:56 +0800
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
Subject: Re: [PATCH v2 3/3] ARM: dts: sti: add thermal-zones support on
 stih418
Message-ID: <202406271638.0fz7OuJT-lkp@intel.com>
References: <20240625-thermal-v2-3-bf8354ed51ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-thermal-v2-3-bf8354ed51ee@gmail.com>

Hi Raphael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/thermal-st-switch-from-CONFIG_PM_SLEEP-guards-to-pm_sleep_ptr/20240626-090203
base:   0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
patch link:    https://lore.kernel.org/r/20240625-thermal-v2-3-bf8354ed51ee%40gmail.com
patch subject: [PATCH v2 3/3] ARM: dts: sti: add thermal-zones support on stih418
config: arm-randconfig-051-20240627 (https://download.01.org/0day-ci/archive/20240627/202406271638.0fz7OuJT-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406271638.0fz7OuJT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406271638.0fz7OuJT-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/st/stih418.dtsi:51.28-79.5: Warning (thermal_sensors_property): /thermal-zones/cpu-thermal: Missing property '#thermal-sensor-cells' in node /soc/thermal@91a0000 or bad phandle (referred from thermal-sensors[0])
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks: failed to match any schema with compatible: ['st,stih418-clk', 'simple-bus']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a9@92b0000: failed to match any schema with compatible: ['st,clkgen-c32']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a9@92b0000/clockgen-a9-pll: failed to match any schema with compatible: ['st,stih418-clkgen-plla9']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a9@92b0000/clk-m-a9: failed to match any schema with compatible: ['st,stih407-clkgen-a9-mux', 'st,clkgen-mux']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a9@92b0000/clk-m-a9: failed to match any schema with compatible: ['st,stih407-clkgen-a9-mux', 'st,clkgen-mux']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a@90ff000: failed to match any schema with compatible: ['st,clkgen-c32']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a@90ff000/clk-s-a0-pll: failed to match any schema with compatible: ['st,clkgen-pll0-a0']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a@90ff000/clk-s-a0-flexgen: failed to match any schema with compatible: ['st,flexgen', 'st,flexgen-stih410-a0']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-a@90ff000/clk-s-a0-flexgen: failed to match any schema with compatible: ['st,flexgen', 'st,flexgen-stih410-a0']
   arch/arm/boot/dts/st/stih418-b2199.dtb: /clocks/clockgen-c@9103000: failed to match any schema with compatible: ['st,clkgen-c32']
--
>> arch/arm/boot/dts/st/stih418.dtsi:51.28-79.5: Warning (thermal_sensors_property): /thermal-zones/cpu-thermal: Missing property '#thermal-sensor-cells' in node /soc/thermal@91a0000 or bad phandle (referred from thermal-sensors[0])
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks: failed to match any schema with compatible: ['st,stih418-clk', 'simple-bus']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a9@92b0000: failed to match any schema with compatible: ['st,clkgen-c32']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a9@92b0000/clockgen-a9-pll: failed to match any schema with compatible: ['st,stih418-clkgen-plla9']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a9@92b0000/clk-m-a9: failed to match any schema with compatible: ['st,stih407-clkgen-a9-mux', 'st,clkgen-mux']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a9@92b0000/clk-m-a9: failed to match any schema with compatible: ['st,stih407-clkgen-a9-mux', 'st,clkgen-mux']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a@90ff000: failed to match any schema with compatible: ['st,clkgen-c32']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a@90ff000/clk-s-a0-pll: failed to match any schema with compatible: ['st,clkgen-pll0-a0']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a@90ff000/clk-s-a0-flexgen: failed to match any schema with compatible: ['st,flexgen', 'st,flexgen-stih410-a0']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-a@90ff000/clk-s-a0-flexgen: failed to match any schema with compatible: ['st,flexgen', 'st,flexgen-stih410-a0']
   arch/arm/boot/dts/st/stih418-b2264.dtb: /clocks/clockgen-c@9103000: failed to match any schema with compatible: ['st,clkgen-c32']

vim +51 arch/arm/boot/dts/st/stih418.dtsi

  > 51			cpu_thermal: cpu-thermal {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

