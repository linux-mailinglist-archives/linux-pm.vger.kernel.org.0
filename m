Return-Path: <linux-pm+bounces-18831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA899E9BAD
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C4F281E49
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389D1465BA;
	Mon,  9 Dec 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3/XxFVX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED0148316;
	Mon,  9 Dec 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761806; cv=none; b=XhLJbW6SUktcXZDGLcclITrhmsaqlej21YrRAczkl5F01DZyg0r0QbvXv1AvP3WT/nJVYdaZBvdiY9OpxW0njZyblDcRW/h3IVW9eWZerB3ZxkkuHeqdX79Z/Fne32w2jUF388Kg3ACOE35j6NHEmIB8kQcBZotwgY3YpAa6g4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761806; c=relaxed/simple;
	bh=Lyt9qdOiLP1zElgb7DW5128anurEE4jCACdvrq1D9vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YITXDIDCuVzGLcq6Fgw+uOUJ8H1019ZLstTSKx/PQayIWtyi2WgQHwRQcM+O0q8VpNEKVMeo15/QqCyVkDAOyAuvvBHwVOFev65AEYsx8jAcG9qj9hfdJfe1C4dpWDk3T6slA5f52EOz70H11pK0jWydkebx0pYtGqPTjptigPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3/XxFVX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733761804; x=1765297804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lyt9qdOiLP1zElgb7DW5128anurEE4jCACdvrq1D9vQ=;
  b=E3/XxFVXDOfw8QVe43hikCWzFNh5Ur+Wr2WskSD3KkVDRu1lGhhQG/Fc
   PhnjSMCzzJypRpj53tZs8mKZ4EVD+LdM3EdldomrwVV9TtLe2GHDd7i9L
   621fybhoOaTCZiQUh8jQxl+PE1vRNTKATNvvjutMgphv2DXDQ88B13Qm5
   ih9EOVcebo4EjhORCRuNB2iafZMia87lpX3CxW/sX3Oz2GnZ1MNvIvmiR
   TSNUglWLuV3KAa4dsgxk0J3UUg5ATSsqWB222SRXvgSTF1Vzkcq9C8pDK
   aaW/FfNY9Ldk9afMsnG5nIqIG6VaHGRubYkTjvJzKMAxO2hGV8+4lyZh8
   g==;
X-CSE-ConnectionGUID: dg989196TyWG1E1YOL9qsQ==
X-CSE-MsgGUID: l0QV+HTORhuR6IM1AV9t8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34306648"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34306648"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:30:04 -0800
X-CSE-ConnectionGUID: SDkVm3V4StSPJUjX2sNrCg==
X-CSE-MsgGUID: ggrtIes9QFy7ULPM/3X3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94824930"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Dec 2024 08:29:59 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKgdv-0004bb-2m;
	Mon, 09 Dec 2024 16:29:55 +0000
Date: Tue, 10 Dec 2024 00:29:21 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 04/14] power: supply: ab8500: use
 power_supply_for_each_psy()
Message-ID: <202412092219.bRJmBwIP-lkp@intel.com>
References: <20241208-power-supply-dev_to_psy-v1-4-f95de9117558@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-4-f95de9117558@weissschuh.net>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 39f3bd9c9a27d526858da153090376decdf7bfea]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/power-supply-mm8013-use-accessor-for-driver-data/20241208-210605
base:   39f3bd9c9a27d526858da153090376decdf7bfea
patch link:    https://lore.kernel.org/r/20241208-power-supply-dev_to_psy-v1-4-f95de9117558%40weissschuh.net
patch subject: [PATCH 04/14] power: supply: ab8500: use power_supply_for_each_psy()
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20241209/202412092219.bRJmBwIP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412092219.bRJmBwIP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412092219.bRJmBwIP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/ab8500_btemp.c:543:49: warning: 'struct power_supply_ext' declared inside parameter list will not be visible outside of this definition or declaration
     543 | static int ab8500_btemp_get_ext_psy_data(struct power_supply_ext *ext, void *data)
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/power/supply/ab8500_btemp.c: In function 'ab8500_btemp_get_ext_psy_data':
   drivers/power/supply/ab8500_btemp.c:546:54: error: invalid use of undefined type 'struct power_supply_ext'
     546 |         const char **supplicants = (const char **)ext->supplied_to;
         |                                                      ^~
   drivers/power/supply/ab8500_btemp.c:558:42: error: invalid use of undefined type 'struct power_supply_ext'
     558 |         j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
         |                                          ^~
   drivers/power/supply/ab8500_btemp.c:563:28: error: invalid use of undefined type 'struct power_supply_ext'
     563 |         for (j = 0; j < ext->desc->num_properties; j++) {
         |                            ^~
   drivers/power/supply/ab8500_btemp.c:565:27: error: invalid use of undefined type 'struct power_supply_ext'
     565 |                 prop = ext->desc->properties[j];
         |                           ^~
   drivers/power/supply/ab8500_btemp.c:567:47: error: passing argument 1 of 'power_supply_get_property' from incompatible pointer type [-Wincompatible-pointer-types]
     567 |                 if (power_supply_get_property(ext, prop, &ret))
         |                                               ^~~
         |                                               |
         |                                               struct power_supply_ext *
   In file included from drivers/power/supply/ab8500_btemp.c:21:
   include/linux/power_supply.h:855:59: note: expected 'struct power_supply *' but argument is of type 'struct power_supply_ext *'
     855 | extern int power_supply_get_property(struct power_supply *psy,
         |                                      ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/power/supply/ab8500_btemp.c:572:36: error: invalid use of undefined type 'struct power_supply_ext'
     572 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_btemp.c: In function 'ab8500_btemp_external_power_changed':
   drivers/power/supply/ab8500_btemp.c:619:40: error: passing argument 2 of 'power_supply_for_each_psy' from incompatible pointer type [-Wincompatible-pointer-types]
     619 |         power_supply_for_each_psy(psy, ab8500_btemp_get_ext_psy_data);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                        |
         |                                        int (*)(struct power_supply_ext *, void *)
   include/linux/power_supply.h:885:56: note: expected 'int (*)(struct power_supply *, void *)' but argument is of type 'int (*)(struct power_supply_ext *, void *)'
     885 | extern int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data));
         |                                                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/power/supply/ab8500_chargalg.c:847:52: warning: 'struct power_supply_ext' declared inside parameter list will not be visible outside of this definition or declaration
     847 | static int ab8500_chargalg_get_ext_psy_data(struct power_supply_ext *ext, void *data)
         |                                                    ^~~~~~~~~~~~~~~~
   drivers/power/supply/ab8500_chargalg.c: In function 'ab8500_chargalg_get_ext_psy_data':
   drivers/power/supply/ab8500_chargalg.c:850:54: error: invalid use of undefined type 'struct power_supply_ext'
     850 |         const char **supplicants = (const char **)ext->supplied_to;
         |                                                      ^~
   drivers/power/supply/ab8500_chargalg.c:859:42: error: invalid use of undefined type 'struct power_supply_ext'
     859 |         j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
         |                                          ^~
   drivers/power/supply/ab8500_chargalg.c:868:40: error: passing argument 1 of 'power_supply_get_property' from incompatible pointer type [-Wincompatible-pointer-types]
     868 |         if (!power_supply_get_property(ext, POWER_SUPPLY_PROP_CAPACITY, &ret)) {
         |                                        ^~~
         |                                        |
         |                                        struct power_supply_ext *
   In file included from drivers/power/supply/ab8500_chargalg.c:24:
   include/linux/power_supply.h:855:59: note: expected 'struct power_supply *' but argument is of type 'struct power_supply_ext *'
     855 | extern int power_supply_get_property(struct power_supply *psy,
         |                                      ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/power/supply/ab8500_chargalg.c:874:28: error: invalid use of undefined type 'struct power_supply_ext'
     874 |         for (j = 0; j < ext->desc->num_properties; j++) {
         |                            ^~
   drivers/power/supply/ab8500_chargalg.c:876:27: error: invalid use of undefined type 'struct power_supply_ext'
     876 |                 prop = ext->desc->properties[j];
         |                           ^~
   drivers/power/supply/ab8500_chargalg.c:882:28: error: invalid use of undefined type 'struct power_supply_ext'
     882 |                         ext->desc->type == POWER_SUPPLY_TYPE_MAINS)
         |                            ^~
   In file included from drivers/power/supply/ab8500_chargalg.c:35:
   drivers/power/supply/ab8500_chargalg.c:883:59: error: passing argument 1 of 'power_supply_get_drvdata' from incompatible pointer type [-Wincompatible-pointer-types]
     883 |                         di->ac_chg = psy_to_ux500_charger(ext);
         |                                                           ^~~
         |                                                           |
         |                                                           struct power_supply_ext *
   drivers/power/supply/ab8500-chargalg.h:18:58: note: in definition of macro 'psy_to_ux500_charger'
      18 | #define psy_to_ux500_charger(x) power_supply_get_drvdata(x)
         |                                                          ^
   include/linux/power_supply.h:883:60: note: expected 'struct power_supply *' but argument is of type 'struct power_supply_ext *'
     883 | extern void *power_supply_get_drvdata(struct power_supply *psy);
         |                                       ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/power/supply/ab8500_chargalg.c:885:28: error: invalid use of undefined type 'struct power_supply_ext'
     885 |                         ext->desc->type == POWER_SUPPLY_TYPE_USB)
         |                            ^~
   drivers/power/supply/ab8500_chargalg.c:886:60: error: passing argument 1 of 'power_supply_get_drvdata' from incompatible pointer type [-Wincompatible-pointer-types]
     886 |                         di->usb_chg = psy_to_ux500_charger(ext);
         |                                                            ^~~
         |                                                            |
         |                                                            struct power_supply_ext *
   drivers/power/supply/ab8500-chargalg.h:18:58: note: in definition of macro 'psy_to_ux500_charger'
      18 | #define psy_to_ux500_charger(x) power_supply_get_drvdata(x)
         |                                                          ^
   include/linux/power_supply.h:883:60: note: expected 'struct power_supply *' but argument is of type 'struct power_supply_ext *'
     883 | extern void *power_supply_get_drvdata(struct power_supply *psy);
         |                                       ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/power/supply/ab8500_chargalg.c:888:47: error: passing argument 1 of 'power_supply_get_property' from incompatible pointer type [-Wincompatible-pointer-types]
     888 |                 if (power_supply_get_property(ext, prop, &ret))
         |                                               ^~~
         |                                               |
         |                                               struct power_supply_ext *
   include/linux/power_supply.h:855:59: note: expected 'struct power_supply *' but argument is of type 'struct power_supply_ext *'
     855 | extern int power_supply_get_property(struct power_supply *psy,
         |                                      ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/power/supply/ab8500_chargalg.c:892:36: error: invalid use of undefined type 'struct power_supply_ext'
     892 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:939:36: error: invalid use of undefined type 'struct power_supply_ext'
     939 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:984:36: error: invalid use of undefined type 'struct power_supply_ext'
     984 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:1068:36: error: invalid use of undefined type 'struct power_supply_ext'
    1068 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:1084:36: error: invalid use of undefined type 'struct power_supply_ext'
    1084 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:1109:36: error: invalid use of undefined type 'struct power_supply_ext'
    1109 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:1127:36: error: invalid use of undefined type 'struct power_supply_ext'
    1127 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c:1143:36: error: invalid use of undefined type 'struct power_supply_ext'
    1143 |                         switch (ext->desc->type) {
         |                                    ^~
   drivers/power/supply/ab8500_chargalg.c: In function 'ab8500_chargalg_algorithm':
   drivers/power/supply/ab8500_chargalg.c:1233:53: error: passing argument 2 of 'power_supply_for_each_psy' from incompatible pointer type [-Wincompatible-pointer-types]
    1233 |         power_supply_for_each_psy(di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     int (*)(struct power_supply_ext *, void *)
   include/linux/power_supply.h:885:56: note: expected 'int (*)(struct power_supply *, void *)' but argument is of type 'int (*)(struct power_supply_ext *, void *)'
     885 | extern int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data));
         |                                                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +543 drivers/power/supply/ab8500_btemp.c

   542	
 > 543	static int ab8500_btemp_get_ext_psy_data(struct power_supply_ext *ext, void *data)
   544	{
   545		struct power_supply *psy;
   546		const char **supplicants = (const char **)ext->supplied_to;
   547		struct ab8500_btemp *di;
   548		union power_supply_propval ret;
   549		int j;
   550	
   551		psy = (struct power_supply *)data;
   552		di = power_supply_get_drvdata(psy);
   553	
   554		/*
   555		 * For all psy where the name of your driver
   556		 * appears in any supplied_to
   557		 */
   558		j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
   559		if (j < 0)
   560			return 0;
   561	
   562		/* Go through all properties for the psy */
   563		for (j = 0; j < ext->desc->num_properties; j++) {
   564			enum power_supply_property prop;
   565			prop = ext->desc->properties[j];
   566	
   567			if (power_supply_get_property(ext, prop, &ret))
   568				continue;
   569	
   570			switch (prop) {
   571			case POWER_SUPPLY_PROP_PRESENT:
   572				switch (ext->desc->type) {
   573				case POWER_SUPPLY_TYPE_MAINS:
   574					/* AC disconnected */
   575					if (!ret.intval && di->events.ac_conn) {
   576						di->events.ac_conn = false;
   577					}
   578					/* AC connected */
   579					else if (ret.intval && !di->events.ac_conn) {
   580						di->events.ac_conn = true;
   581						if (!di->events.usb_conn)
   582							ab8500_btemp_periodic(di, true);
   583					}
   584					break;
   585				case POWER_SUPPLY_TYPE_USB:
   586					/* USB disconnected */
   587					if (!ret.intval && di->events.usb_conn) {
   588						di->events.usb_conn = false;
   589					}
   590					/* USB connected */
   591					else if (ret.intval && !di->events.usb_conn) {
   592						di->events.usb_conn = true;
   593						if (!di->events.ac_conn)
   594							ab8500_btemp_periodic(di, true);
   595					}
   596					break;
   597				default:
   598					break;
   599				}
   600				break;
   601			default:
   602				break;
   603			}
   604		}
   605		return 0;
   606	}
   607	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

