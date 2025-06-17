Return-Path: <linux-pm+bounces-28923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF45ADDD4E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 22:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2A6194005F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0D25524D;
	Tue, 17 Jun 2025 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8vS5rjj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E9155C88;
	Tue, 17 Jun 2025 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192955; cv=none; b=mhhztWH1K5JCYkomQEMaGxUASUxd6FOwtItRa9aabQ4xO8BOMXZ6ZVylO2cUat4WuqcDy4J/9RdVwrROfSq9/iahgUTi3Og+FaaoMOCeWHJyBoq449K3imnPzmu3jp3FeFqAvyRpN9pYowvIc/wHwKL6axQd7LB/m06U5rZ1oIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192955; c=relaxed/simple;
	bh=q1SGR7cquCfqIcHgDM+KF+k+8AQGKd0ZfPTWkoXLe20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrqmSdgBVS71fmSSzfrrWnn5YDNdgB03wAK/m8ArFE2tSdQ/SPynRTEZF5qN4BpedaOZop+L6Zg2zijRn6kIcP3AC4U8pSmoy6HF1nXivlQUYDiVzOTgh89bM+HYofdk3Z4FPWzVrvG72aTp92RwHrcOzGjo2tbVUDAQdhA1jXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8vS5rjj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750192954; x=1781728954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q1SGR7cquCfqIcHgDM+KF+k+8AQGKd0ZfPTWkoXLe20=;
  b=g8vS5rjj264+D8tbMXPv5SB7P9CKplc4HPM9clC2RpYpA+n8dJXwEipt
   /kYvOe9OjgWWpXVZ3dKmMRrwC0U7O0MHzC68+MunvlMgaqxmCLKY5W4/4
   0xz26rSAQVepTVazr7mAvH4k3NIrZmMv7Ih9oAcquUqjB+JmpfkPDbt/Y
   uZ1PfPH7E+Ev/D2hEPwinvKdxWm2sCKVUj0k4Gp5Ztk8LIzlw6zipHqLP
   s9NFDbWKLlwk3WajS+yEvRFbz+YxC9lCmmS0IclvRinzVGX5GFnFh7luk
   1OGx2IrWhTTkJ9oZN/5zBeHRfwLOdjlk/W/Jo8jc5PJpCeSx5vcO7Tk/w
   w==;
X-CSE-ConnectionGUID: W5QXtVt9Q8uWVjy0HiReig==
X-CSE-MsgGUID: kMbbmpjeTAWJEo1KNW8JVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52092276"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52092276"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 13:42:33 -0700
X-CSE-ConnectionGUID: kCU4Wz79RNqXXf+CqVELjg==
X-CSE-MsgGUID: +3KcfnBIQ8mKBIY2uYtsig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149315947"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Jun 2025 13:42:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRd8T-000I4w-25;
	Tue, 17 Jun 2025 20:42:25 +0000
Date: Wed, 18 Jun 2025 04:41:41 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v10 2/7] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Message-ID: <202506180402.ly0g2TQe-lkp@intel.com>
References: <20250617094945.3619360-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617094945.3619360-3-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on broonie-regulator/for-next chrome-platform/for-next chrome-platform/for-firmware-next linus/master v6.16-rc2 next-20250617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250617-175433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250617094945.3619360-3-o.rempel%40pengutronix.de
patch subject: [PATCH v10 2/7] reboot: hw_protection_trigger: use standardized numeric shutdown/reboot reasons instead of strings
config: hexagon-randconfig-001-20250618 (https://download.01.org/0day-ci/archive/20250618/202506180402.ly0g2TQe-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250618/202506180402.ly0g2TQe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506180402.ly0g2TQe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/regulator/core.c:5280:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    5280 |         default:
         |         ^
   drivers/regulator/core.c:5280:2: note: insert '__attribute__((fallthrough));' to silence this warning
    5280 |         default:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/regulator/core.c:5280:2: note: insert 'break;' to avoid fall-through
    5280 |         default:
         |         ^
         |         break; 
   1 warning generated.


vim +5280 drivers/regulator/core.c

  5253	
  5254	/**
  5255	 * regulator_handle_critical - Handle events for system-critical regulators.
  5256	 * @rdev: The regulator device.
  5257	 * @event: The event being handled.
  5258	 *
  5259	 * This function handles critical events such as under-voltage, over-current,
  5260	 * and unknown errors for regulators deemed system-critical. On detecting such
  5261	 * events, it triggers a hardware protection shutdown with a defined timeout.
  5262	 */
  5263	static void regulator_handle_critical(struct regulator_dev *rdev,
  5264					      unsigned long event)
  5265	{
  5266		enum psc_reason pscr;
  5267	
  5268		if (!rdev->constraints->system_critical)
  5269			return;
  5270	
  5271		switch (event) {
  5272		case REGULATOR_EVENT_UNDER_VOLTAGE:
  5273			pscr = PSCR_UNDER_VOLTAGE;
  5274			break;
  5275		case REGULATOR_EVENT_OVER_CURRENT:
  5276			pscr = PSCR_OVER_CURRENT;
  5277			break;
  5278		case REGULATOR_EVENT_FAIL:
  5279			pscr = PSCR_REGULATOR_FAILURE;
> 5280		default:
  5281			pscr = PSCR_UNKNOWN;
  5282		}
  5283	
  5284		hw_protection_trigger(pscr,
  5285				      rdev->constraints->uv_less_critical_window_ms);
  5286	}
  5287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

