Return-Path: <linux-pm+bounces-24249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5FA67416
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB73D7ACC4B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AF20CCD0;
	Tue, 18 Mar 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAye3SLa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6220CCCD;
	Tue, 18 Mar 2025 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301455; cv=none; b=aqdd5Q4KUajBDf98yysz5UjPju9TvizHZ8ulXmOYF3vLwg/nUG5F6fb7qDrhi/JbWt5r1aAKnpAC2wFQdvtnNQMA6vVXleBqSb8r5DoA8DplevrwU2Q02R0AQjOEJ/+rC/Wac385S3CoaC2T32IdojwLkBpQN90cizlG2ufziII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301455; c=relaxed/simple;
	bh=yLn+TNXVMhehXRKYhEHda1j3Z6SP3WHyEcxrp/VZbRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBv2M8EJTWWQ8EksDgIVsydNDLLHopd8qM5lKDDVz0B6fUSxoGBDHhDjrm+Gyj6o6lOsUSxJppo3QsBX4Bf+S8jZDMYPlb+J9baHoYIRJcLbnVDnkOzcMRZDFLNW9+GKxj5GFKnlHObHCY0Xs9/EUfwyFdPrbHfI2gYYSVsw+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAye3SLa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742301450; x=1773837450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yLn+TNXVMhehXRKYhEHda1j3Z6SP3WHyEcxrp/VZbRE=;
  b=OAye3SLaV59gw0IZzPW9EO/c1c9kratSsueTsvk6Jmpk0Ywup5CoJ77b
   PygiyTkWVR1HmB3cXBJkrMeGrxHR1YeX8iapV2qVcJoPLxXNUZJWJghDM
   C/V6i9TzMf6zAxT8XZK467XVU3voDDrY0odRKjNnMxEForZOutlAGOoCc
   QoFRj0sEo2MUoWZIAUZoc4fOGYqpM0T4KG1N23ozjfdD0A5TJg6qVz44T
   tK8XT4tMgNhxTMvQ2pWmL1tzGqlr24KChv8tYm4h4Awhk/UJi6mlg1cjl
   tAulFP+O1vQjm8JcaXTv07gO4vtu+IcrHPHY5T0LQ9ow/T0vHe2+wj9IY
   g==;
X-CSE-ConnectionGUID: Z8EAfZH6S2SVWDlkoxoOPA==
X-CSE-MsgGUID: 2xBMOCnDQR+xhVRYr9s09Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824292"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="54824292"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 05:37:19 -0700
X-CSE-ConnectionGUID: 02u19VQZTfKCfwVwJfzsFw==
X-CSE-MsgGUID: cDJM3aYtQSuaD9d6HinG7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="121979427"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:37:15 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuWC1-000Dkl-0C;
	Tue, 18 Mar 2025 12:37:13 +0000
Date: Tue, 18 Mar 2025 20:36:20 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v5 6/7] regulator: set Power State Change Reason before
 hw_protection_shutdown()
Message-ID: <202503182046.kOuLXxTn-lkp@intel.com>
References: <20250310103732.423542-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310103732.423542-7-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on broonie-regulator/for-next rafael-pm/thermal linus/master v6.14-rc7]
[cannot apply to next-20250317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250310-184319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250310103732.423542-7-o.rempel%40pengutronix.de
patch subject: [PATCH v5 6/7] regulator: set Power State Change Reason before hw_protection_shutdown()
config: m68k-randconfig-r073-20250314 (https://download.01.org/0day-ci/archive/20250318/202503182046.kOuLXxTn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503182046.kOuLXxTn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503182046.kOuLXxTn-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/regulator/core.o: in function `regulator_handle_critical':
>> drivers/regulator/core.c:5270:(.text+0x20c6): undefined reference to `set_power_state_change_reason'


vim +5270 drivers/regulator/core.c

  5234	
  5235	/**
  5236	 * regulator_handle_critical - Handle events for system-critical regulators.
  5237	 * @rdev: The regulator device.
  5238	 * @event: The event being handled.
  5239	 *
  5240	 * This function handles critical events such as under-voltage, over-current,
  5241	 * and unknown errors for regulators deemed system-critical. On detecting such
  5242	 * events, it triggers a hardware protection shutdown with a defined timeout.
  5243	 */
  5244	static void regulator_handle_critical(struct regulator_dev *rdev,
  5245					      unsigned long event)
  5246	{
  5247		enum pscr_reason pscr;
  5248		const char *reason = NULL;
  5249	
  5250		if (!rdev->constraints->system_critical)
  5251			return;
  5252	
  5253		switch (event) {
  5254		case REGULATOR_EVENT_UNDER_VOLTAGE:
  5255			reason = "System critical regulator: voltage drop detected";
  5256			pscr = PSCR_UNDER_VOLTAGE;
  5257			break;
  5258		case REGULATOR_EVENT_OVER_CURRENT:
  5259			reason = "System critical regulator: over-current detected";
  5260			pscr = PSCR_OVER_CURRENT;
  5261			break;
  5262		case REGULATOR_EVENT_FAIL:
  5263			reason = "System critical regulator: unknown error";
  5264			pscr = PSCR_REGULATOR_FAILURE;
  5265		}
  5266	
  5267		if (!reason)
  5268			return;
  5269	
> 5270		set_power_state_change_reason(pscr);
  5271		hw_protection_shutdown(reason,
  5272				       rdev->constraints->uv_less_critical_window_ms);
  5273	}
  5274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

