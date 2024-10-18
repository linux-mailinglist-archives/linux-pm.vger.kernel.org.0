Return-Path: <linux-pm+bounces-15915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9739A3486
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 07:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AD21F2498D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8317C22B;
	Fri, 18 Oct 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRl36x8/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE717279E;
	Fri, 18 Oct 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230494; cv=none; b=iqiVZ2f4T8SBZm39sFtfaTr/g+Susztvfs4IsGFfz+9fqClmZIica8CJfNsUsNI5kBKfNRNOlpSnNzQcqxVoma4fzNffthbisUjZV2cvzC0dhB1EFCcuLwj2k24rcRbNSyyee5QTFct6yFyE7xYMAjK9ppUUgJxEllMcUJxiuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230494; c=relaxed/simple;
	bh=5ed+YXIRKt4R1p86u7Yp1C2teLt4n1R3+K0CLW/7p24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRiswBOYD8NmMtpIeIo6Z2Uwb+rogKCHoLrK1Ev6htRyzBUtx5SdYubJyZYGZquD2ji3+GTHr4O5W18SAOEJUXyQbzDCyz1sc13h9tejqPRIE0/Hb7NVl0FHnVaSemWRuuEaajOCblVJcPBMTqApEI9EL+uaLuSnQqHAfq9w4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRl36x8/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729230493; x=1760766493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ed+YXIRKt4R1p86u7Yp1C2teLt4n1R3+K0CLW/7p24=;
  b=aRl36x8/D1h9NsBWJN8xWlVoAXSen3uH/8fG9zf1LoNl+KPeUFer9brq
   G2d2hhG6sd/spdVrdt4Cr/BlBsMFJXXdmiStLHegX6t1hRzPVU13xLKt9
   J6pQdnEgADVIx6sKguk8EhoRiE3yvOCRT8evhqb8WCyD2rtz9ALa16LtC
   YDEoae2qVY6qVQs5dv/7We4G5+U0fvg+Mb09jx/tfyhEqi/BpWumHhbAj
   P75pZhqB5Sgi8GtzmyGqA6YIWEtCUaDGBtbXdvlZda/VbnbMKQFoM4VSQ
   z0TAND3pRU7Edfg7J3XNd/+ZQqHa5Vb/2FZo7BaH9FrDWfOOUqx9AWBWF
   w==;
X-CSE-ConnectionGUID: k1eHSKoyTIm9kY0Z57x/DQ==
X-CSE-MsgGUID: mE/v2xKdRwi+OBvC4PB+SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28847431"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28847431"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:48:13 -0700
X-CSE-ConnectionGUID: fqPiXShaQuKN4thSghkR9w==
X-CSE-MsgGUID: r8blsmJFSrCj+OKC6tfH1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83596370"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 22:48:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1fqI-000NK7-1Q;
	Fri, 18 Oct 2024 05:48:06 +0000
Date: Fri, 18 Oct 2024 13:47:51 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
Message-ID: <202410181340.S74lBfUS-lkp@intel.com>
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
[also build test ERROR on linus/master v6.12-rc3 next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/thermal-Add-support-for-Airoha-EN7581-thermal-sensor/20241017-224102
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20241017143830.1656-2-ansuelsmth%40gmail.com
patch subject: [PATCH v2 2/2] thermal: Add support for Airoha EN7581 thermal sensor
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241018/202410181340.S74lBfUS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181340.S74lBfUS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181340.S74lBfUS-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/airoha_thermal.c: In function 'airoha_thermal_get_temp':
>> drivers/thermal/airoha_thermal.c:239:46: error: invalid use of undefined type 'struct thermal_zone_device'
     239 |         struct airoha_thermal_priv *priv = tz->devdata;
         |                                              ^~
   drivers/thermal/airoha_thermal.c: In function 'airoha_thermal_set_trips':
   drivers/thermal/airoha_thermal.c:268:46: error: invalid use of undefined type 'struct thermal_zone_device'
     268 |         struct airoha_thermal_priv *priv = tz->devdata;
         |                                              ^~
   drivers/thermal/airoha_thermal.c: In function 'airoha_thermal_probe':
   drivers/thermal/airoha_thermal.c:466:17: error: invalid use of undefined type 'struct thermal_zone_device'
     466 |         priv->tz->tzp->offset = priv->default_offset;
         |                 ^~
   drivers/thermal/airoha_thermal.c:467:17: error: invalid use of undefined type 'struct thermal_zone_device'
     467 |         priv->tz->tzp->slope = priv->default_slope;
         |                 ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


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

