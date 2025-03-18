Return-Path: <linux-pm+bounces-24262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D5A67D29
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 20:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9952F421503
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED21DED57;
	Tue, 18 Mar 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KubIvSsB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C11A23B7;
	Tue, 18 Mar 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326466; cv=none; b=hGsBT2CCWCIhrMXM6p+ONz033pNa8lSmYj0i8xJeTZbK2vtJ3NQ7oMyKZEPSq+xotrU2TXdqx6Cu//Pp/vjOeuxVwgCXQpLXWg3mJ+StD48yMowS6y5edpBQ7EeNONdmbuVtSj8WxMLjGfayVlxKYu6APdX/KNR4SBWRIFttX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326466; c=relaxed/simple;
	bh=C8Mn8jjigjBdi2QgwOVjWcNl2z8rbXqGfKQEAPX+v5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO67c7V6vZyu5QjPQsx2ZfKS7sZL+CXFAWCbpKctp58ZkTWKFAZ7ZAPUKZujWmQiaLi0pNtScQf4aXeq3ZGBG7DpwGUsnKAClr8Kt8NqVtD13N7TSX6Im/bR2UfkuEHfd1H0A1vxbhB4rdFLYBQrKo9t35YfCULtBJCtwAv2dDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KubIvSsB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742326464; x=1773862464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C8Mn8jjigjBdi2QgwOVjWcNl2z8rbXqGfKQEAPX+v5s=;
  b=KubIvSsBWsiPPMqhQ4+4qSlYQOYjuh6cXimgJk2t/Ur8xKyKsyCuYfpv
   8FSPd7EAtSBrdC7F5oTJAAdPrV3xUuAwNov+pY0FSu69EjJE/nb8k/JcY
   UEHB3TCbPSQwXJ+LUFNG0p1YgnktqAJm6OpXc2OSYBZODubB4INk/SKRV
   Z1kOAIgdoCmK+7N70VArswj0W5Okwuo8DeZT49rQivreM3RLWXV26byZy
   im2WBLhdPremS0TAXZuyHQmwI1nLpl7jAKg5mSzr6lHyD+DnIB9yeI75N
   F92qGp9HWxtLQxvfLzFFfSqLLBOurD1GjPpGwfPii90tHO8O6MfOBzTm8
   A==;
X-CSE-ConnectionGUID: Swjf+5UySu+GWvSqK0320Q==
X-CSE-MsgGUID: wG1BWGCNQMOeLnbuhsrVKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43677546"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43677546"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:34:24 -0700
X-CSE-ConnectionGUID: U/lYe6NjTkORTdzmbE19ww==
X-CSE-MsgGUID: ZXMSfbsWSsSH0P7ZIdNF9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="127028371"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Mar 2025 12:34:20 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuche-000E8M-0m;
	Tue, 18 Mar 2025 19:34:18 +0000
Date: Wed, 19 Mar 2025 03:33:25 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v5 7/7] thermal: core: Record PSCR before
 hw_protection_shutdown()
Message-ID: <202503190248.stJdS2ru-lkp@intel.com>
References: <20250310103732.423542-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310103732.423542-8-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on broonie-regulator/for-next rafael-pm/thermal linus/master v6.14-rc7]
[cannot apply to next-20250318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250310-184319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250310103732.423542-8-o.rempel%40pengutronix.de
patch subject: [PATCH v5 7/7] thermal: core: Record PSCR before hw_protection_shutdown()
config: m68k-randconfig-r073-20250314 (https://download.01.org/0day-ci/archive/20250319/202503190248.stJdS2ru-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503190248.stJdS2ru-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503190248.stJdS2ru-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/thermal/thermal_core.o: in function `thermal_zone_device_halt':
>> drivers/thermal/thermal_core.c:384:(.text.unlikely+0x24): undefined reference to `set_power_state_change_reason'
   m68k-linux-ld: drivers/regulator/core.o: in function `regulator_handle_critical':
   drivers/regulator/core.c:5270:(.text+0x20c6): undefined reference to `set_power_state_change_reason'


vim +384 drivers/thermal/thermal_core.c

   372	
   373	static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdown)
   374	{
   375		/*
   376		 * poweroff_delay_ms must be a carefully profiled positive value.
   377		 * Its a must for forced_emergency_poweroff_work to be scheduled.
   378		 */
   379		int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
   380		const char *msg = "Temperature too high";
   381	
   382		dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
   383	
 > 384		set_power_state_change_reason(PSCR_OVERTEMPERATURE);
   385	
   386		if (shutdown)
   387			hw_protection_shutdown(msg, poweroff_delay_ms);
   388		else
   389			hw_protection_reboot(msg, poweroff_delay_ms);
   390	}
   391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

