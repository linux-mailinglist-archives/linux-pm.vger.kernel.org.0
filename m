Return-Path: <linux-pm+bounces-8501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B08D74B2
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC701C21107
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA11374E9;
	Sun,  2 Jun 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9b+KQKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E95661;
	Sun,  2 Jun 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717322698; cv=none; b=KEGPsryG62OZdhRREgJzkZkhCY/c/P88zbUkZdwgUjD3Fh+okPUHqRY1oeV6GwSJ85EZpYnEXejhq0aJB3gyAPwfeFbQv9F4ZeGAk3jFNVDVEbM7ip3L8Ql6A9Q057TKoYRYAatTuf0ICaZZS4HOC2gO4bBQxFJ4tJbrF0hnNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717322698; c=relaxed/simple;
	bh=/MZ6JyQgfC8q+jekdYlu/KTOQNp4pGs6FWJdulhkfM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm9avFBggvxYWyGnEO5y3f+325lF8QjPiJW4QmwnIzh7iiS0bvccli8A0/JHcWdoPhzzdSpKrBc4vE6RwFVj4QmiHib1Hktr9GokDvn+xwF7QRXjnfJpsYOS2JMi1jsKRXih55f6zh5sqy2HbUv+eyO6H7RQCLKGGNKgNNOoEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9b+KQKi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717322696; x=1748858696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MZ6JyQgfC8q+jekdYlu/KTOQNp4pGs6FWJdulhkfM4=;
  b=P9b+KQKiTowksGtnO07zAW3Y33p4cilMbJO4PeKdOWDS1aFaRIwoH1rE
   LgNu922xu57R2Pv6UzOGgPp4FslOvuX63DxTvoJ4KWT69LMGFwiHq4olM
   6gHU4VCTWj6zL+ylTVWDPyqKfi66a5gN8Q+nVy3oFdDg293+QawnLKVaF
   yrFcy8EfD8ZumamgqJohK+kkE9DZTHWhBQ0HbtBG2+49Ba/alPa+ZYvkC
   PZy4x3EX3D2YBE2tzQtztoW4g4lExZfckUFs/Y2V0KI3vE0IDjOYU/sW6
   P4xB3B9jBUBCrilu6lbDY6r3K337clGL3afu48oeaqxaJM9ztHCqb6z1L
   w==;
X-CSE-ConnectionGUID: wgHLNnXnRdi+AOlcqyzrAQ==
X-CSE-MsgGUID: FcweUzFqQNCLA5kLPxJWJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="31357340"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="31357340"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 03:04:55 -0700
X-CSE-ConnectionGUID: b3xmZUKTRtqNQ2JLysp9Dg==
X-CSE-MsgGUID: B5YG2nNLR7y5GZ406AVITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="36694143"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 02 Jun 2024 03:04:52 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDi53-000Jvj-2o;
	Sun, 02 Jun 2024 10:04:49 +0000
Date: Sun, 2 Jun 2024 18:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: samsung-sdi-battery: Constify struct
 power_supply_maintenance_charge_table
Message-ID: <202406021726.CTOur77o-lkp@intel.com>
References: <02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.10-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/power-supply-samsung-sdi-battery-Constify-struct-power_supply_maintenance_charge_table/20240602-000031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH 2/2] power: supply: samsung-sdi-battery: Constify struct power_supply_maintenance_charge_table
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240602/202406021726.CTOur77o-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240602/202406021726.CTOur77o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406021726.CTOur77o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/power/supply/ab8500_chargalg.c: In function 'ab8500_chargalg_algorithm':
>> drivers/power/supply/ab8500_chargalg.c:1465:20: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1465 |                 mt = power_supply_get_maintenance_charging_setting(bi, 0);
         |                    ^
   drivers/power/supply/ab8500_chargalg.c:1498:20: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1498 |                 mt = power_supply_get_maintenance_charging_setting(bi, 1);
         |                    ^


vim +/const +1465 drivers/power/supply/ab8500_chargalg.c

6aa35ab9db2c9c drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1217  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1218  /**
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1219   * ab8500_chargalg_algorithm() - Main function for the algorithm
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1220   * @di:		pointer to the ab8500_chargalg structure
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1221   *
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1222   * This is the main control function for the charging algorithm.
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1223   * It is called periodically or when something happens that will
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1224   * trigger a state change
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1225   */
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1226  static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1227  {
25fd330370ac40 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-12-15  1228  	struct power_supply_battery_info *bi = di->bm->bi;
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1229  	struct power_supply_maintenance_charge_table *mt;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1230  	int charger_status;
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1231  	int ret;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1232  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1233  	/* Collect data from all power_supply class devices */
68ade0976df797 drivers/power/supply/ab8500_chargalg.c Sebastian Reichel   2024-03-01  1234  	power_supply_for_each_device(di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1235  
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1236  	ab8500_chargalg_end_of_charge(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1237  	ab8500_chargalg_check_temp(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1238  	ab8500_chargalg_check_charger_voltage(di);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1239  
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1240  	charger_status = ab8500_chargalg_check_charger_connection(di);
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1241  
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1242  	if (is_ab8500(di->parent)) {
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1243  		ret = ab8500_chargalg_check_charger_enable(di);
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1244  		if (ret < 0)
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1245  			dev_err(di->dev, "Checking charger is enabled error"
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1246  					": Returned Value %d\n", ret);
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1247  	}
4dcdf57773fd45 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-14  1248  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1249  	/*
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1250  	 * First check if we have a charger connected.
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1251  	 * Also we don't allow charging of unknown batteries if configured
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1252  	 * this way
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1253  	 */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1254  	if (!charger_status ||
b0284de05e07d5 drivers/power/abx500_chargalg.c        Lee Jones           2012-11-30  1255  		(di->events.batt_unknown && !di->bm->chg_unknown_bat)) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1256  		if (di->charge_state != STATE_HANDHELD) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1257  			di->events.safety_timer_expired = false;
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1258  			ab8500_chargalg_state_to(di, STATE_HANDHELD_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1259  		}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1260  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1261  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1262  	/* Safety timer expiration */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1263  	else if (di->events.safety_timer_expired) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1264  		if (di->charge_state != STATE_SAFETY_TIMER_EXPIRED)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1265  			ab8500_chargalg_state_to(di,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1266  				STATE_SAFETY_TIMER_EXPIRED_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1267  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1268  	/*
8652b62ee6f157 drivers/power/supply/ab8500_chargalg.c Colin Ian King      2022-03-02  1269  	 * Check if any interrupts has occurred
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1270  	 * that will prevent us from charging
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1271  	 */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1272  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1273  	/* Battery removed */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1274  	else if (di->events.batt_rem) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1275  		if (di->charge_state != STATE_BATT_REMOVED)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1276  			ab8500_chargalg_state_to(di, STATE_BATT_REMOVED_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1277  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1278  	/* Main or USB charger not ok. */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1279  	else if (di->events.mainextchnotok || di->events.usbchargernotok) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1280  		/*
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1281  		 * If vbus_collapsed is set, we have to lower the charger
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1282  		 * current, which is done in the normal state below
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1283  		 */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1284  		if (di->charge_state != STATE_CHG_NOT_OK &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1285  				!di->events.vbus_collapsed)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1286  			ab8500_chargalg_state_to(di, STATE_CHG_NOT_OK_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1287  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1288  	/* VBUS, Main or VBAT OVV. */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1289  	else if (di->events.vbus_ovv ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1290  			di->events.main_ovv ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1291  			di->events.batt_ovv ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1292  			!di->chg_info.usb_chg_ok ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1293  			!di->chg_info.ac_chg_ok) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1294  		if (di->charge_state != STATE_OVV_PROTECT)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1295  			ab8500_chargalg_state_to(di, STATE_OVV_PROTECT_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1296  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1297  	/* USB Thermal, stop charging */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1298  	else if (di->events.main_thermal_prot ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1299  		di->events.usb_thermal_prot) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1300  		if (di->charge_state != STATE_HW_TEMP_PROTECT)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1301  			ab8500_chargalg_state_to(di,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1302  				STATE_HW_TEMP_PROTECT_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1303  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1304  	/* Battery temp over/under */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1305  	else if (di->events.btemp_underover) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1306  		if (di->charge_state != STATE_TEMP_UNDEROVER)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1307  			ab8500_chargalg_state_to(di,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1308  				STATE_TEMP_UNDEROVER_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1309  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1310  	/* Watchdog expired */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1311  	else if (di->events.ac_wd_expired ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1312  		di->events.usb_wd_expired) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1313  		if (di->charge_state != STATE_WD_EXPIRED)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1314  			ab8500_chargalg_state_to(di, STATE_WD_EXPIRED_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1315  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1316  	/* Battery temp high/low */
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1317  	else if (di->events.btemp_low || di->events.btemp_high) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1318  		if (di->charge_state != STATE_TEMP_LOWHIGH)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1319  			ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1320  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1321  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1322  	dev_dbg(di->dev,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1323  		"[CHARGALG] Vb %d Ib_avg %d Ib_inst %d Tb %d Cap %d Maint %d "
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1324  		"State %s Active_chg %d Chg_status %d AC %d USB %d "
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1325  		"AC_online %d USB_online %d AC_CV %d USB_CV %d AC_I %d "
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1326  		"USB_I %d AC_Vset %d AC_Iset %d USB_Vset %d USB_Iset %d\n",
2a5f41830aadc2 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1327  		di->batt_data.volt_uv,
9c20899da46b85 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1328  		di->batt_data.avg_curr_ua,
83e5aa77d1120f drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1329  		di->batt_data.inst_curr_ua,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1330  		di->batt_data.temp,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1331  		di->batt_data.percent,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1332  		di->maintenance_chg,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1333  		states[di->charge_state],
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1334  		di->chg_info.charger_type,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1335  		di->charge_status,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1336  		di->chg_info.conn_chg & AC_CHG,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1337  		di->chg_info.conn_chg & USB_CHG,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1338  		di->chg_info.online_chg & AC_CHG,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1339  		di->chg_info.online_chg & USB_CHG,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1340  		di->events.ac_cv_active,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1341  		di->events.usb_cv_active,
83e5aa77d1120f drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1342  		di->chg_info.ac_curr_ua,
83e5aa77d1120f drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1343  		di->chg_info.usb_curr_ua,
bc6e0287140216 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1344  		di->chg_info.ac_vset_uv,
83e5aa77d1120f drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1345  		di->chg_info.ac_iset_ua,
bc6e0287140216 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1346  		di->chg_info.usb_vset_uv,
83e5aa77d1120f drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1347  		di->chg_info.usb_iset_ua);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1348  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1349  	switch (di->charge_state) {
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1350  	case STATE_HANDHELD_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1351  		ab8500_chargalg_stop_charging(di);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1352  		di->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1353  		ab8500_chargalg_state_to(di, STATE_HANDHELD);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1354  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1355  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1356  	case STATE_HANDHELD:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1357  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1358  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1359  	case STATE_BATT_REMOVED_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1360  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1361  		ab8500_chargalg_state_to(di, STATE_BATT_REMOVED);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1362  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1363  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1364  	case STATE_BATT_REMOVED:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1365  		if (!di->events.batt_rem)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1366  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1367  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1368  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1369  	case STATE_HW_TEMP_PROTECT_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1370  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1371  		ab8500_chargalg_state_to(di, STATE_HW_TEMP_PROTECT);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1372  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1373  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1374  	case STATE_HW_TEMP_PROTECT:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1375  		if (!di->events.main_thermal_prot &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1376  				!di->events.usb_thermal_prot)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1377  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1378  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1379  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1380  	case STATE_OVV_PROTECT_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1381  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1382  		ab8500_chargalg_state_to(di, STATE_OVV_PROTECT);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1383  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1384  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1385  	case STATE_OVV_PROTECT:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1386  		if (!di->events.vbus_ovv &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1387  				!di->events.main_ovv &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1388  				!di->events.batt_ovv &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1389  				di->chg_info.usb_chg_ok &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1390  				di->chg_info.ac_chg_ok)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1391  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1392  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1393  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1394  	case STATE_CHG_NOT_OK_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1395  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1396  		ab8500_chargalg_state_to(di, STATE_CHG_NOT_OK);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1397  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1398  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1399  	case STATE_CHG_NOT_OK:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1400  		if (!di->events.mainextchnotok &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1401  				!di->events.usbchargernotok)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1402  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1403  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1404  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1405  	case STATE_SAFETY_TIMER_EXPIRED_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1406  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1407  		ab8500_chargalg_state_to(di, STATE_SAFETY_TIMER_EXPIRED);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1408  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1409  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1410  	case STATE_SAFETY_TIMER_EXPIRED:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1411  		/* We exit this state when charger is removed */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1412  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1413  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1414  	case STATE_NORMAL_INIT:
05906f58c82259 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-01-29  1415  		if (bi->constant_charge_current_max_ua == 0)
05906f58c82259 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-01-29  1416  			/* "charging" with 0 uA */
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1417  			ab8500_chargalg_stop_charging(di);
4d3b4aa58ac9e1 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-15  1418  		else {
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1419  			ab8500_chargalg_start_charging(di,
bc6e0287140216 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-11-20  1420  				bi->constant_charge_voltage_max_uv,
05906f58c82259 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-01-29  1421  				bi->constant_charge_current_max_ua);
4d3b4aa58ac9e1 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-15  1422  		}
4d3b4aa58ac9e1 drivers/power/abx500_chargalg.c        Lee Jones           2013-02-15  1423  
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1424  		ab8500_chargalg_state_to(di, STATE_NORMAL);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1425  		ab8500_chargalg_start_safety_timer(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1426  		ab8500_chargalg_stop_maintenance_timer(di);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1427  		init_maxim_chg_curr(di);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1428  		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1429  		di->eoc_cnt = 0;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1430  		di->maintenance_chg = false;
297d716f6260cc drivers/power/abx500_chargalg.c        Krzysztof Kozlowski 2015-03-12  1431  		power_supply_changed(di->chargalg_psy);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1432  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1433  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1434  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1435  	case STATE_NORMAL:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1436  		handle_maxim_chg_curr(di);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1437  		if (di->charge_status == POWER_SUPPLY_STATUS_FULL &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1438  			di->maintenance_chg) {
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1439  			/*
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1440  			 * The battery is fully charged, check if we support
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1441  			 * maintenance charging else go back to waiting for
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1442  			 * the recharge voltage limit.
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1443  			 */
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1444  			if (!power_supply_supports_maintenance_charging(bi))
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1445  				ab8500_chargalg_state_to(di,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1446  					STATE_WAIT_FOR_RECHARGE_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1447  			else
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1448  				ab8500_chargalg_state_to(di,
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1449  					STATE_MAINTENANCE_A_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1450  		}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1451  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1452  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1453  	/* This state will be used when the maintenance state is disabled */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1454  	case STATE_WAIT_FOR_RECHARGE_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1455  		ab8500_chargalg_hold_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1456  		ab8500_chargalg_state_to(di, STATE_WAIT_FOR_RECHARGE);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1457  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1458  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1459  	case STATE_WAIT_FOR_RECHARGE:
6aa35ab9db2c9c drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1460  		if (ab8500_chargalg_time_to_restart(di))
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1461  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1462  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1463  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1464  	case STATE_MAINTENANCE_A_INIT:
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26 @1465  		mt = power_supply_get_maintenance_charging_setting(bi, 0);
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1466  		if (!mt) {
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1467  			/* No maintenance A state, go back to normal */
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1468  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1469  			power_supply_changed(di->chargalg_psy);
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1470  			break;
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1471  		}
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1472  		ab8500_chargalg_stop_safety_timer(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1473  		ab8500_chargalg_start_maintenance_timer(di,
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1474  			mt->charge_safety_timer_minutes);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1475  		ab8500_chargalg_start_charging(di,
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1476  			mt->charge_voltage_max_uv,
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1477  			mt->charge_current_max_ua);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1478  		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_A);
297d716f6260cc drivers/power/abx500_chargalg.c        Krzysztof Kozlowski 2015-03-12  1479  		power_supply_changed(di->chargalg_psy);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1480  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1481  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1482  	case STATE_MAINTENANCE_A:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1483  		if (di->events.maintenance_timer_expired) {
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1484  			ab8500_chargalg_stop_maintenance_timer(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1485  			ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1486  		}
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1487  		/*
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1488  		 * This happens if the voltage drops too quickly during
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1489  		 * maintenance charging, especially in older batteries.
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1490  		 */
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1491  		if (ab8500_chargalg_time_to_restart(di)) {
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1492  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1493  			dev_info(di->dev, "restarted charging from maintenance state A - battery getting old?\n");
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1494  		}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1495  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1496  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1497  	case STATE_MAINTENANCE_B_INIT:
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1498  		mt = power_supply_get_maintenance_charging_setting(bi, 1);
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1499  		if (!mt) {
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1500  			/* No maintenance B state, go back to normal */
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1501  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1502  			power_supply_changed(di->chargalg_psy);
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1503  			break;
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1504  		}
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1505  		ab8500_chargalg_start_maintenance_timer(di,
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1506  			mt->charge_safety_timer_minutes);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1507  		ab8500_chargalg_start_charging(di,
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1508  			mt->charge_voltage_max_uv,
d72ce7d3247862 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1509  			mt->charge_current_max_ua);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1510  		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B);
297d716f6260cc drivers/power/abx500_chargalg.c        Krzysztof Kozlowski 2015-03-12  1511  		power_supply_changed(di->chargalg_psy);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1512  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1513  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1514  	case STATE_MAINTENANCE_B:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1515  		if (di->events.maintenance_timer_expired) {
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1516  			ab8500_chargalg_stop_maintenance_timer(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1517  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1518  		}
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1519  		/*
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1520  		 * This happens if the voltage drops too quickly during
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1521  		 * maintenance charging, especially in older batteries.
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1522  		 */
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1523  		if (ab8500_chargalg_time_to_restart(di)) {
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1524  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1525  			dev_info(di->dev, "restarted charging from maintenance state B - battery getting old?\n");
e08f8a118514c9 drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-04-15  1526  		}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1527  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1528  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1529  	case STATE_TEMP_LOWHIGH_INIT:
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1530  		if (di->events.btemp_low) {
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1531  			ab8500_chargalg_start_charging(di,
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1532  				       bi->alert_low_temp_charge_voltage_uv,
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1533  				       bi->alert_low_temp_charge_current_ua);
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1534  		} else if (di->events.btemp_high) {
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1535  			ab8500_chargalg_start_charging(di,
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1536  				       bi->alert_high_temp_charge_voltage_uv,
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1537  				       bi->alert_high_temp_charge_current_ua);
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1538  		} else {
8652b62ee6f157 drivers/power/supply/ab8500_chargalg.c Colin Ian King      2022-03-02  1539  			dev_err(di->dev, "neither low or high temp event occurred\n");
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1540  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1541  			break;
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1542  		}
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1543  		ab8500_chargalg_stop_maintenance_timer(di);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1544  		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1545  		ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
297d716f6260cc drivers/power/abx500_chargalg.c        Krzysztof Kozlowski 2015-03-12  1546  		power_supply_changed(di->chargalg_psy);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1547  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1548  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1549  	case STATE_TEMP_LOWHIGH:
0e8b903b522b5a drivers/power/supply/ab8500_chargalg.c Linus Walleij       2022-02-26  1550  		if (!di->events.btemp_low && !di->events.btemp_high)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1551  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1552  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1553  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1554  	case STATE_WD_EXPIRED_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1555  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1556  		ab8500_chargalg_state_to(di, STATE_WD_EXPIRED);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1557  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1558  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1559  	case STATE_WD_EXPIRED:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1560  		if (!di->events.ac_wd_expired &&
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1561  				!di->events.usb_wd_expired)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1562  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1563  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1564  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1565  	case STATE_TEMP_UNDEROVER_INIT:
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1566  		ab8500_chargalg_stop_charging(di);
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1567  		ab8500_chargalg_state_to(di, STATE_TEMP_UNDEROVER);
df561f6688fef7 drivers/power/supply/abx500_chargalg.c Gustavo A. R. Silva 2020-08-23  1568  		fallthrough;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1569  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1570  	case STATE_TEMP_UNDEROVER:
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1571  		if (!di->events.btemp_underover)
c5b64a990e7f3b drivers/power/supply/ab8500_chargalg.c Linus Walleij       2021-07-13  1572  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1573  		break;
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1574  	}
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1575  
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1576  	/* Start charging directly if the new state is a charge state */
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1577  	if (di->charge_state == STATE_NORMAL_INIT ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1578  			di->charge_state == STATE_MAINTENANCE_A_INIT ||
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1579  			di->charge_state == STATE_MAINTENANCE_B_INIT)
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1580  		queue_work(di->chargalg_wq, &di->chargalg_work);
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1581  }
1668f81159fb72 drivers/power/abx500_chargalg.c        Arun Murthy         2012-02-29  1582  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

