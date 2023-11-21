Return-Path: <linux-pm+bounces-51-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFB7F34D8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F41C20B09
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AFF5B1EA;
	Tue, 21 Nov 2023 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2Z+lWyJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79035A4;
	Tue, 21 Nov 2023 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700587293; x=1732123293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPFNAp0rBeOeoHA+0LkUJewIhopjNxORZEBoCvlOfDA=;
  b=E2Z+lWyJsYnEM9DU9SurtJr4HIUJC7MvALpkaE50kH5+ewX8YAoDzzPN
   cKAR3kjaELKHwVsOwXL9XCpWGtNQ5U/pbY30Ri95ICDtkrE34nEvfD2fH
   XPfBobH8IlPDMe3dLiqczFWeZBFKbmVgNkdBVqjfza+nDFdsAWZchaN8Y
   YRkbZrh97A4LhCNQntF3fLyItZV8PRhhhi29iVbvqdTjKC2J75O691kNN
   Xkt5d+B5L5Mrbjc3CmdJVqPXW9HCZmeLwv0MbTCEoMwl+Tc4INDIonC8N
   N1zkbQeb5d10J0FxdMlI0P8V2VeclD26sIkLapSK6lFnPtMFgdD9vXBvh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10555047"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10555047"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1013974523"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1013974523"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2023 09:21:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5URD-000858-2i;
	Tue, 21 Nov 2023 17:21:27 +0000
Date: Wed, 22 Nov 2023 01:21:01 +0800
From: kernel test robot <lkp@intel.com>
To: Hermes Zhang <Hermes.Zhang@axis.com>, sre@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@axis.com, Hermes Zhang <chenhuiz@axis.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: bq24190_charger: Add support for
  BQ24296
Message-ID: <202311220111.umAlhsjl-lkp@intel.com>
References: <20231121070505.3061304-3-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070505.3061304-3-Hermes.Zhang@axis.com>

Hi Hermes,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hermes-Zhang/dt-bindings-power-supply-bq24190-Add-BQ24296-compatible/20231121-151103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20231121070505.3061304-3-Hermes.Zhang%40axis.com
patch subject: [PATCH v3 2/2] power: supply: bq24190_charger: Add support for  BQ24296
config: powerpc64-randconfig-r071-20231121 (https://download.01.org/0day-ci/archive/20231122/202311220111.umAlhsjl-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220111.umAlhsjl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220111.umAlhsjl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/bq24190_charger.c:1975:16: error: use of undeclared identifier 'bq24190_vbus_desc'
    1975 |                 .vbus_desc = bq24190_vbus_desc,
         |                              ^
   drivers/power/supply/bq24190_charger.c:1984:16: error: use of undeclared identifier 'bq24190_vbus_desc'
    1984 |                 .vbus_desc = bq24190_vbus_desc,
         |                              ^
   drivers/power/supply/bq24190_charger.c:1993:16: error: use of undeclared identifier 'bq24190_vbus_desc'
    1993 |                 .vbus_desc = bq24190_vbus_desc,
         |                              ^
   drivers/power/supply/bq24190_charger.c:2002:16: error: use of undeclared identifier 'bq24190_vbus_desc'
    2002 |                 .vbus_desc = bq24190_vbus_desc,
         |                              ^
>> drivers/power/supply/bq24190_charger.c:2011:16: error: use of undeclared identifier 'bq24296_vbus_desc'
    2011 |                 .vbus_desc = bq24296_vbus_desc,
         |                              ^
   5 errors generated.


vim +/bq24190_vbus_desc +1975 drivers/power/supply/bq24190_charger.c

  1971	
  1972	static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
  1973		[BQ24190] = {
  1974			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
> 1975			.vbus_desc = bq24190_vbus_desc,
  1976			.check_chip = bq24190_check_chip,
  1977			.set_chg_config = bq24190_battery_set_chg_config,
  1978			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  1979			.get_ntc_status = bq24190_charger_get_ntc_status,
  1980			.set_otg_vbus = bq24190_set_otg_vbus,
  1981		},
  1982		[BQ24192] = {
  1983			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
  1984			.vbus_desc = bq24190_vbus_desc,
  1985			.check_chip = bq24190_check_chip,
  1986			.set_chg_config = bq24190_battery_set_chg_config,
  1987			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  1988			.get_ntc_status = bq24190_charger_get_ntc_status,
  1989			.set_otg_vbus = bq24190_set_otg_vbus,
  1990		},
  1991		[BQ24192i] = {
  1992			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
  1993			.vbus_desc = bq24190_vbus_desc,
  1994			.check_chip = bq24190_check_chip,
  1995			.set_chg_config = bq24190_battery_set_chg_config,
  1996			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  1997			.get_ntc_status = bq24190_charger_get_ntc_status,
  1998			.set_otg_vbus = bq24190_set_otg_vbus,
  1999		},
  2000		[BQ24196] = {
  2001			.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
  2002			.vbus_desc = bq24190_vbus_desc,
  2003			.check_chip = bq24190_check_chip,
  2004			.set_chg_config = bq24190_battery_set_chg_config,
  2005			.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
  2006			.get_ntc_status = bq24190_charger_get_ntc_status,
  2007			.set_otg_vbus = bq24190_set_otg_vbus,
  2008		},
  2009		[BQ24296] = {
  2010			.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
> 2011			.vbus_desc = bq24296_vbus_desc,
  2012			.check_chip = bq24296_check_chip,
  2013			.set_chg_config = bq24296_battery_set_chg_config,
  2014			.ntc_fault_mask = BQ24296_REG_F_NTC_FAULT_MASK,
  2015			.get_ntc_status = bq24296_charger_get_ntc_status,
  2016			.set_otg_vbus = bq24296_set_otg_vbus,
  2017		},
  2018	};
  2019	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

