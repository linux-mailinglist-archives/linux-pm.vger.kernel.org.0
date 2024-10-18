Return-Path: <linux-pm+bounces-15977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE79A4350
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E415A2818CB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C983202640;
	Fri, 18 Oct 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Thi6R4xP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493D9200CB8;
	Fri, 18 Oct 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267794; cv=none; b=jpEaSI1uMsHDR1lNCr7FSnDSf8UlITOzNfmLe72D7qxXHoccOojRi+bwYiAfgyXu1JMvEsB00VPIlV/ZSA0e72jUp3U9dKpVpj1m5yg1UWt1XIaGVuazuOthfDf95S3FxgzfNanKiyxjDWfo0GRladerZNR+vBhl7uaxMHkw3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267794; c=relaxed/simple;
	bh=HdjnmFHZ6Xw7oO5nQowfoWY7yJAqQKqxmuY33sxUdng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzxKficI6gE5yNWrlmj9E0ZtgK5YeTBK0s0xRmdDa8THlTLlTZE2d88/RmIH95FFaG5CID8NID3HhJTU1K6fJCAZxWavBUgZCaS+aoy4BEeyIKWGr6wE5PKTJoPHLkzIer7QercC+fGmXB40QxuZvF+b5IIrrSow5MjYoCSLps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Thi6R4xP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729267792; x=1760803792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdjnmFHZ6Xw7oO5nQowfoWY7yJAqQKqxmuY33sxUdng=;
  b=Thi6R4xP+1H2T6gCL3WHYiFlWyXMgph/FjoVfWVZGncUzBeIdReJ6ljT
   SjIwqg31B9YmliRe/CX6nc+yPz3cEpQmiq4fNZmVomOcg1cvwaITV3F80
   CjucfGyvlRV/X/Dfgw2FtRE2LK0ScJvqMaD3C0EapLs140UP/p/8uPxxH
   y1HG7yEGuNGHDea/a9en7gcnZvRF3ECMiRFqA/x+iEo6jskVKoMqW/Jax
   kfFjKK0R0A2hlntuKHU3S87ehKvFDFRK55gNMQQ62ysdUes1mlWW2C/P3
   r3d2yc1hrOxxJcmxhJ3mdJlQvzpe0Fq0i9jk57945f0I6ht0Le+VuC0w3
   w==;
X-CSE-ConnectionGUID: g0a6MgzVSPaQMWuE97howg==
X-CSE-MsgGUID: pqEZqz//Tg6axuGoQs+UWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39351135"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39351135"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 09:09:52 -0700
X-CSE-ConnectionGUID: GYtBrye3TiOQx2JqaqGINg==
X-CSE-MsgGUID: i/YI6FnoQc2A2hXpYjyiUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109730096"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Oct 2024 09:09:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1pXu-000O0H-0J;
	Fri, 18 Oct 2024 16:09:46 +0000
Date: Sat, 19 Oct 2024 00:09:29 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
Message-ID: <202410182328.IP4meFxF-lkp@intel.com>
References: <20241017143830.1656-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017143830.1656-2-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/thermal-Add-support-for-Airoha-EN7581-thermal-sensor/20241017-224102
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20241017143830.1656-2-ansuelsmth%40gmail.com
patch subject: [PATCH v2 2/2] thermal: Add support for Airoha EN7581 thermal sensor
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241018/202410182328.IP4meFxF-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410182328.IP4meFxF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410182328.IP4meFxF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/airoha_thermal.c:239:39: error: incomplete definition of type 'struct thermal_zone_device'
     239 |         struct airoha_thermal_priv *priv = tz->devdata;
         |                                            ~~^
   include/linux/thermal.h:32:8: note: forward declaration of 'struct thermal_zone_device'
      32 | struct thermal_zone_device;
         |        ^
   drivers/thermal/airoha_thermal.c:268:39: error: incomplete definition of type 'struct thermal_zone_device'
     268 |         struct airoha_thermal_priv *priv = tz->devdata;
         |                                            ~~^
   include/linux/thermal.h:32:8: note: forward declaration of 'struct thermal_zone_device'
      32 | struct thermal_zone_device;
         |        ^
   drivers/thermal/airoha_thermal.c:466:10: error: incomplete definition of type 'struct thermal_zone_device'
     466 |         priv->tz->tzp->offset = priv->default_offset;
         |         ~~~~~~~~^
   include/linux/thermal.h:32:8: note: forward declaration of 'struct thermal_zone_device'
      32 | struct thermal_zone_device;
         |        ^
   drivers/thermal/airoha_thermal.c:467:10: error: incomplete definition of type 'struct thermal_zone_device'
     467 |         priv->tz->tzp->slope = priv->default_slope;
         |         ~~~~~~~~^
   include/linux/thermal.h:32:8: note: forward declaration of 'struct thermal_zone_device'
      32 | struct thermal_zone_device;
         |        ^
   4 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +239 drivers/thermal/airoha_thermal.c

   236	
   237	static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
   238	{
 > 239		struct airoha_thermal_priv *priv = tz->devdata;
   240		int min, max, avg_temp, temp_adc;
   241		int i;
   242	
   243		/* Get the starting temp */
   244		temp_adc = airoha_get_thermal_ADC(priv);
   245		min = temp_adc;
   246		max = temp_adc;
   247		avg_temp = temp_adc;
   248	
   249		/* Make 5 more measurement and average the temp ADC difference */
   250		for (i = 0; i < 5; i++) {
   251			temp_adc = airoha_get_thermal_ADC(priv);
   252			avg_temp += temp_adc;
   253			if (temp_adc > max)
   254				max = temp_adc;
   255			if (temp_adc < min)
   256				min = temp_adc;
   257		}
   258		avg_temp = avg_temp - max - min;
   259		avg_temp /= 4;
   260	
   261		*temp = RAW_TO_TEMP(priv, avg_temp);
   262		return 0;
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

