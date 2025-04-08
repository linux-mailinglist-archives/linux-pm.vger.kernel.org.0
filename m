Return-Path: <linux-pm+bounces-24971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3581A81919
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 01:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E557A58E3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437561E1E04;
	Tue,  8 Apr 2025 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2qC5mW5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED21A7262
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153392; cv=none; b=Vj+PmxTmzo512ENYv6y104Q8x5lzUF9o/IS0gk7ZX7x7IA0WlxBg7cWuE6P68OHI8AriIGkoKQoTO5z2ysjpHICF5Z3SwWp/ofk9uwA0z773jLwu3yIHXxQKXqk/VroCLodDyF/nZ0acsaulpSqijmQO0uVAcdelCMd4erRd81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153392; c=relaxed/simple;
	bh=UbXnSkgbAR2H+qxuJh8dv9nYNbheOqinisbQKe6UxCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrgRj18CUifsJGzzTYXXhamjfugrsiJN/KVS+SKskeTlElzVwXMCt4g+GuwY4PsBsJHwMz2EwuHxSvSD18ZFbiO2RHTXOel6EcEo28eUvA9hG3r3T+IVASCUDKsmIghdg3kSU/alTiwgRzAcpDBAIhTs4zAhiboMTxFz5iZ4SvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2qC5mW5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744153390; x=1775689390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UbXnSkgbAR2H+qxuJh8dv9nYNbheOqinisbQKe6UxCE=;
  b=m2qC5mW5c+Vug5/t838uFCHq66XPF3Wvx1v6atKgV1kCbeXaYMR1jPdz
   NFKOr2ZTNw9kDFJCw7ZFUmdjqDhDzFOfX/kTZYXvzXYy5z4lS6soW7sMX
   h8kNnPpyg2RARSoaTIsLAHhG+ErC+W+tYMURVdgYALgAWYOleODNAmL7N
   JuFb/zB3gGtxVCzeRccWKciT36o9oEPXpWFflIMACjSCTe/lp0hI0uKHO
   lb63uBZSAUkeMxdLuIpKRex3swWI8mf8sL8URkEXok78elSfE/rUu9iKg
   fkLKD/CRmRjt2XhgwRpBTSCHgxkrO63GJ193OagV1TugAuai/HZb69HiY
   Q==;
X-CSE-ConnectionGUID: UFGzK9W/R1azTSeQDrRcbQ==
X-CSE-MsgGUID: a4d42C/zQNe37F75c+pc0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45496698"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45496698"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 16:03:09 -0700
X-CSE-ConnectionGUID: INM1MURsQeeR18w4UR6xqA==
X-CSE-MsgGUID: KmUkegnGQP2eLVVP+StdzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133390164"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Apr 2025 16:03:07 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2HyC-00083f-29;
	Tue, 08 Apr 2025 23:03:04 +0000
Date: Wed, 9 Apr 2025 07:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jelle van der Waa <jvanderw@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
	Jelle van der Waa <jvanderwaa@redhat.com>
Subject: Re: [PATCH 1/1] power: supply: support charge_types in extensions
Message-ID: <202504090646.w9GLxe17-lkp@intel.com>
References: <20250407201845.332348-2-jvanderw@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407201845.332348-2-jvanderw@redhat.com>

Hi Jelle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.15-rc1 next-20250408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jelle-van-der-Waa/power-supply-support-charge_types-in-extensions/20250408-045501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250407201845.332348-2-jvanderw%40redhat.com
patch subject: [PATCH 1/1] power: supply: support charge_types in extensions
config: i386-buildonly-randconfig-004-20250409 (https://download.01.org/0day-ci/archive/20250409/202504090646.w9GLxe17-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504090646.w9GLxe17-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504090646.w9GLxe17-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/test_power.c:148:51: warning: | has lower precedence than ==; == will be evaluated first [-Wparentheses]
     148 |         return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/power/supply/test_power.c:148:51: note: place parentheses around the '==' expression to silence this warning
     148 |         return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
         |                                                          ^
         |                (                                        )
   drivers/power/supply/test_power.c:148:51: note: place parentheses around the | expression to evaluate it first
     148 |         return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
         |                                                          ^                               
         |                       (                                                                  )
   1 warning generated.


vim +148 drivers/power/supply/test_power.c

   144	
   145	static int test_power_battery_property_is_writeable(struct power_supply *psy,
   146							    enum power_supply_property psp)
   147	{
 > 148		return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR | POWER_SUPPLY_PROP_CHARGE_TYPES;
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

