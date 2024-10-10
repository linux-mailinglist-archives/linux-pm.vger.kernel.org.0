Return-Path: <linux-pm+bounces-15496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA39993E1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3CDCB22364
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061051CFEDD;
	Thu, 10 Oct 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Km089xt7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50231991B8;
	Thu, 10 Oct 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593198; cv=none; b=iI+ngfTO3GrXKu26bcAVWzkV7firC8OPF87AE1xTk1lzmEDJ3XmbhvBkt1M7pNXp9HlqpECaJcji5xbwyGNbaGF9aFR38LF3nuHz87sHIzEDAPFXiqp+DR+UxWw9cpzA39PrrBQQi0N78uhUwuj5MlMiS225//xHoIi/g3AdyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593198; c=relaxed/simple;
	bh=S1ahpzpXNdPKM3/solNYAwx4dKLcG2Uf70uStU5gJNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3Np8zar9Ozda2QHks2tvJAjhRWysQsMpgmUWvifflQuBTHiBhKIFUP9ilMEH7bPKrudOayFbO7bEPPLmmnDJif/TdPeCaoABBQj33OJnw4wv4ufyhDcUNRG7G4frfQ34Abjp2FnUd3u6lk3X7FILrV3uYlpPIME4RIU5+MUCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Km089xt7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728593197; x=1760129197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1ahpzpXNdPKM3/solNYAwx4dKLcG2Uf70uStU5gJNo=;
  b=Km089xt7jjBBbrl1FoamTn66FSve28nFF6jr53gcGDgoHJw4nkW80N+y
   zNPLIfZu4tB+wi0LIFu4ZkY7oKQALbmBj2quPyrTHsPFwVyRmFP0FH8T6
   Sx/zv0RMHvQMFU5efSb+ScA3MK7U+UWcTct+9RyQxu/0tW+UZ9LJ2XdTz
   ytcRhEUjOaBlqDb6n4gEDDJq+8+73cieF5amb9GWlieV1io1x52YbLr9X
   6mIT7VFybQGtOy7wtIR+67uGuA19FuqCiywyhHqDcCC/RlXYyKZ+Mbw9J
   S1CI2dsX0ivEMWh1GpiMXvDACGJLULhBmqvSHczB0YCvSxWcBXaylBaip
   g==;
X-CSE-ConnectionGUID: UcdaIAkQSA68nzUn9VDuyg==
X-CSE-MsgGUID: C3qr7vFzTTyfIbR2bG3e5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27429745"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="27429745"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 13:46:36 -0700
X-CSE-ConnectionGUID: to4zHtkIQx2umYFIna6ERg==
X-CSE-MsgGUID: 53zt824LRBeCJ7+J+CsTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76803645"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Oct 2024 13:46:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz03K-000BFr-0D;
	Thu, 10 Oct 2024 20:46:30 +0000
Date: Fri, 11 Oct 2024 04:45:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v6 6/7] power: supply: max77705: Add fuel gauge driver
 for Maxim 77705
Message-ID: <202410110404.etzjIhE5-lkp@intel.com>
References: <20241007-starqltechn_integration_upstream-v6-6-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-6-0d38b5090c57@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 58ca61c1a866bfdaa5e19fb19a2416764f847d75]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/power-supply-add-undervoltage-health-status-property/20241008-000014
base:   58ca61c1a866bfdaa5e19fb19a2416764f847d75
patch link:    https://lore.kernel.org/r/20241007-starqltechn_integration_upstream-v6-6-0d38b5090c57%40gmail.com
patch subject: [PATCH v6 6/7] power: supply: max77705: Add fuel gauge driver for Maxim 77705
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241011/202410110404.etzjIhE5-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410110404.etzjIhE5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410110404.etzjIhE5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/max77705_fuel_gauge.c:220:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     220 |         case POWER_SUPPLY_PROP_MANUFACTURER:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/max77705_fuel_gauge.c:227:6: note: uninitialized use occurs here
     227 |         if (ret)
         |             ^~~
   drivers/power/supply/max77705_fuel_gauge.c:217:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
     217 |         case POWER_SUPPLY_PROP_MODEL_NAME:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/max77705_fuel_gauge.c:227:6: note: uninitialized use occurs here
     227 |         if (ret)
         |             ^~~
   drivers/power/supply/max77705_fuel_gauge.c:169:9: note: initialize the variable 'ret' to silence this warning
     169 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +/ret +220 drivers/power/supply/max77705_fuel_gauge.c

   162	
   163	static int max77705_fg_get_property(struct power_supply *psy,
   164					    enum power_supply_property psp,
   165					    union power_supply_propval *val)
   166	{
   167		struct max77705_fuelgauge_data *fuelgauge =
   168		    power_supply_get_drvdata(psy);
   169		int ret;
   170	
   171		switch (psp) {
   172		case POWER_SUPPLY_PROP_STATUS:
   173			ret = max77705_battery_get_status(fuelgauge, &val->intval);
   174			break;
   175		case POWER_SUPPLY_PROP_PRESENT:
   176			ret = max77705_fg_check_battery_present(fuelgauge, &val->intval);
   177			break;
   178		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   179			ret = max77705_fg_read_reg(fuelgauge, VCELL_REG, &val->intval);
   180			break;
   181		case POWER_SUPPLY_PROP_VOLTAGE_OCV:
   182			ret = max77705_fg_read_reg(fuelgauge, VFOCV_REG, &val->intval);
   183			break;
   184		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
   185			ret = max77705_fg_read_reg(fuelgauge, AVR_VCELL_REG, &val->intval);
   186			break;
   187		case POWER_SUPPLY_PROP_CURRENT_NOW:
   188			ret = max77705_fg_read_reg(fuelgauge, CURRENT_REG, &val->intval);
   189			break;
   190		case POWER_SUPPLY_PROP_CURRENT_AVG:
   191			ret = max77705_fg_read_reg(fuelgauge, AVG_CURRENT_REG, &val->intval);
   192			break;
   193		case POWER_SUPPLY_PROP_CHARGE_NOW:
   194			ret = max77705_fg_read_reg(fuelgauge, REMCAP_REP_REG, &val->intval);
   195			break;
   196		case POWER_SUPPLY_PROP_CHARGE_FULL:
   197			ret = max77705_fg_read_reg(fuelgauge, FULLCAP_REP_REG, &val->intval);
   198			break;
   199		case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
   200			ret = max77705_fg_read_reg(fuelgauge, DESIGNCAP_REG, &val->intval);
   201			break;
   202		case POWER_SUPPLY_PROP_CAPACITY:
   203			ret = max77705_fg_read_reg(fuelgauge, SOCREP_REG, &val->intval);
   204			break;
   205		case POWER_SUPPLY_PROP_TEMP:
   206			ret = max77705_fg_read_temp(fuelgauge, &val->intval);
   207			break;
   208		case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
   209			ret = max77705_fg_read_reg(fuelgauge, TIME_TO_EMPTY_REG, &val->intval);
   210			break;
   211		case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
   212			ret = max77705_fg_read_reg(fuelgauge, TIME_TO_FULL_REG, &val->intval);
   213			break;
   214		case POWER_SUPPLY_PROP_CYCLE_COUNT:
   215			ret = max77705_fg_read_reg(fuelgauge, CYCLES_REG, &val->intval);
   216			break;
   217		case POWER_SUPPLY_PROP_MODEL_NAME:
   218			val->strval = max77705_fuelgauge_model;
   219			break;
 > 220		case POWER_SUPPLY_PROP_MANUFACTURER:
   221			val->strval = max77705_fuelgauge_manufacturer;
   222			break;
   223		default:
   224			return -EINVAL;
   225		}
   226	
   227		if (ret)
   228			return ret;
   229	
   230		max77705_unit_adjustment(fuelgauge, psp, val);
   231	
   232		return 0;
   233	}
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

