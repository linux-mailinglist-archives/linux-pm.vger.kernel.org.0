Return-Path: <linux-pm+bounces-15262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE213992D05
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6B828662A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59671D358F;
	Mon,  7 Oct 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1CIejin"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F711D2F7C;
	Mon,  7 Oct 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307195; cv=none; b=ShqjUFB0BskUQC4Z9huzQ3BAg8JF/jEJZfTV7+WRYB4LE2wgeZjLsYdAR5w9M1FM91+qdyGbQx79VEgRiswzi53aKlxedkbxJppGzfwLm09x0KbR/l49nwPHMZCujrc0hcybzKU3Fim3MpZ7GVY5SLuqi55qSo473KYJh75wt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307195; c=relaxed/simple;
	bh=/e2E4Nsq+0Xkd5BF5AuSOGCkhvFjFskozi3D9yL97JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdRaOzKFB8oz4CdCQxt0oICXnT3QIEALtdV87ncPTkT4rCUSkP6DCLIwJfbEjjcuklFgW8eOYyq8PHk9ClD4CH9WxeSGNv1wFHjhcIXpu3kBS7FQPsbba1JcGI49+UY/RtnJBGH93ODc/O9P2V5rOubspf74ziCXlmZlMM7a/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1CIejin; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728307195; x=1759843195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/e2E4Nsq+0Xkd5BF5AuSOGCkhvFjFskozi3D9yL97JI=;
  b=Z1CIejinADd8ZpXr+BCqfl3GRVqNwH5Z2b+p66W09VT/IPbNwDImKnVD
   0yLaKjjCd9ZRExGJL8MqFjXK5P+M20lG8rZOgduJsb7ip2tMC+0aLl66t
   Qk0YHxgY22tDFQRWEbB7iiYDKL6WqT1mO4OE0fsEV9tuH0cgZjHYyHhNz
   mTguJNC9SoD0ZIBwoG9JEy3BRJnIrG9MFpBOtTORJg2ocKrn6i6yZBTTt
   628Fu5nZmcYSflISuFysd3qiCXSC032Ihf43ZgtoOISsSCuZcMmgQ3CeC
   BnkvcLD/GOpWXcBhPpV9Vw+CQMsDH7FcGoHNj1R++3sk51cIl4YWTMFsY
   Q==;
X-CSE-ConnectionGUID: FWLPKi5wRyOE8iI46dVxxA==
X-CSE-MsgGUID: pH2cOo3XTmaGvg4JZtq+JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27265844"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27265844"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:19:54 -0700
X-CSE-ConnectionGUID: fh6P6qQvQMq8c9iM7VC/xQ==
X-CSE-MsgGUID: JSDqF9XzRSqXW0n+5D48+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106306643"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Oct 2024 06:19:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxneP-00051K-2P;
	Mon, 07 Oct 2024 13:19:49 +0000
Date: Mon, 7 Oct 2024 21:19:33 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 4/4] power: supply: hwmon: move interface to private
 header
Message-ID: <202410072120.3jlD28CJ-lkp@intel.com>
References: <20241005-power-supply-cleanups-v1-4-45303b2d0a4d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005-power-supply-cleanups-v1-4-45303b2d0a4d@weissschuh.net>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 27cc6fdf720183dce1dbd293483ec5a9cb6b595e]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/power-supply-core-use-device-mutex-wrappers/20241005-181114
base:   27cc6fdf720183dce1dbd293483ec5a9cb6b595e
patch link:    https://lore.kernel.org/r/20241005-power-supply-cleanups-v1-4-45303b2d0a4d%40weissschuh.net
patch subject: [PATCH 4/4] power: supply: hwmon: move interface to private header
config: x86_64-randconfig-003-20241007 (https://download.01.org/0day-ci/archive/20241007/202410072120.3jlD28CJ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410072120.3jlD28CJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410072120.3jlD28CJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/power/supply/power_supply_hwmon.c:12:
>> drivers/power/supply/power_supply.h:41:20: error: redefinition of 'power_supply_update_leds'
      41 | static inline void power_supply_update_leds(struct power_supply *psy) {}
         |                    ^
   drivers/power/supply/power_supply.h:41:20: note: previous definition is here
      41 | static inline void power_supply_update_leds(struct power_supply *psy) {}
         |                    ^
   In file included from drivers/power/supply/power_supply_hwmon.c:12:
>> drivers/power/supply/power_supply.h:42:19: error: redefinition of 'power_supply_create_triggers'
      42 | static inline int power_supply_create_triggers(struct power_supply *psy)
         |                   ^
   drivers/power/supply/power_supply.h:42:19: note: previous definition is here
      42 | static inline int power_supply_create_triggers(struct power_supply *psy)
         |                   ^
   In file included from drivers/power/supply/power_supply_hwmon.c:12:
>> drivers/power/supply/power_supply.h:44:20: error: redefinition of 'power_supply_remove_triggers'
      44 | static inline void power_supply_remove_triggers(struct power_supply *psy) {}
         |                    ^
   drivers/power/supply/power_supply.h:44:20: note: previous definition is here
      44 | static inline void power_supply_remove_triggers(struct power_supply *psy) {}
         |                    ^
   3 errors generated.


vim +/power_supply_update_leds +41 drivers/power/supply/power_supply.h

4a11b59d828366 drivers/power/power_supply.h Anton Vorontsov 2007-05-04  40  
4a11b59d828366 drivers/power/power_supply.h Anton Vorontsov 2007-05-04 @41  static inline void power_supply_update_leds(struct power_supply *psy) {}
4a11b59d828366 drivers/power/power_supply.h Anton Vorontsov 2007-05-04 @42  static inline int power_supply_create_triggers(struct power_supply *psy)
4a11b59d828366 drivers/power/power_supply.h Anton Vorontsov 2007-05-04  43  { return 0; }
4a11b59d828366 drivers/power/power_supply.h Anton Vorontsov 2007-05-04 @44  static inline void power_supply_remove_triggers(struct power_supply *psy) {}
4a11b59d828366 drivers/power/power_supply.h Anton Vorontsov 2007-05-04  45  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

