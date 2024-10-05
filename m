Return-Path: <linux-pm+bounces-15222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49886991B6C
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2024 01:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C3A1F204C3
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62DB1537DB;
	Sat,  5 Oct 2024 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNSU3jW4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594C13DBBC;
	Sat,  5 Oct 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728171576; cv=none; b=m9lKyfHHpxZsF99HwacVUzHRyeOuOm+DttG9CXamEolRcQVlF/EmfXoXvDTdPsTmWWxdsFO3R2P6W7kMnJlNBVaggwFxFqAJQY6xIT2p+/EAT22dDgIe2xPfBp3aFXeuOK7YvDNmBsM9H8V9yryFI/jtdKNrV6vGmfzIQe4GVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728171576; c=relaxed/simple;
	bh=O8tC0S8QUi71diq0Y1j9O7wXnaj13Q1oToMjagGlSoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtBY7Mj0ZJ4owpmW1dFI2mGvi6DLtzV+LbX/wLSPa8z1uvf5emgR68upAKRl7EyzgLy3f6R1WpBPfhjGpJO/GAOptx7QU4RqR0kVUU6g7svDV3rzD0BtnIs/xAWj81a9BGo2lxAn7cTK5pW9vTPSP+VEBQRMYFeD45TVPp7S2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNSU3jW4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728171574; x=1759707574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O8tC0S8QUi71diq0Y1j9O7wXnaj13Q1oToMjagGlSoA=;
  b=VNSU3jW4Dz/uWiEBR0YzSwPS80ULU4t423yh/Wy+Oc/Wj/fblhWvTmoc
   mMIOd/qqe61FUPOdOE5kCW7Ao5gxRjKwzy6JZw4dJI9BS7OnRVHjErsM+
   FDeegSKtEBJn+TC+KZqW8D1vB33LuUPJiCWxFB0SZSMf2QPvEvKR7VlYm
   hg0Ti7LTanPj5175XjTP30Q6rO9Dj9V0sWKEzO8wFVj+dyYpRa5H/KBSS
   qnHFMVgszD08e1opKVvyvgT95zZ8ZizU0GJLMgLCdx3b7pl0tvQy3XUhL
   Ka0/vjyXqDCZ1wvPC1k+5u5tbikaoOveA1MttMbLBQzmGq46aIZ8+kMk0
   g==;
X-CSE-ConnectionGUID: XY9msbdmQIegMgrloniW1g==
X-CSE-MsgGUID: 0aKh4O9CRUmfmd2YQFYTtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="37926479"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="37926479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 16:39:33 -0700
X-CSE-ConnectionGUID: G25MZ7dYQxa0TwadM4sJwg==
X-CSE-MsgGUID: U4vC1SloQk6p+BeRU1TzOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="75206039"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Oct 2024 16:39:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxEMy-0003S6-1D;
	Sat, 05 Oct 2024 23:39:28 +0000
Date: Sun, 6 Oct 2024 07:39:10 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 4/4] power: supply: hwmon: move interface to private
 header
Message-ID: <202410060751.fvcDrsTY-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 27cc6fdf720183dce1dbd293483ec5a9cb6b595e]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/power-supply-core-use-device-mutex-wrappers/20241005-181114
base:   27cc6fdf720183dce1dbd293483ec5a9cb6b595e
patch link:    https://lore.kernel.org/r/20241005-power-supply-cleanups-v1-4-45303b2d0a4d%40weissschuh.net
patch subject: [PATCH 4/4] power: supply: hwmon: move interface to private header
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060751.fvcDrsTY-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/power/supply/power_supply_hwmon.c: power_supply.h is included more than once.

vim +3 drivers/power/supply/power_supply_hwmon.c

   > 3	 *  power_supply_hwmon.c - power supply hwmon support.
     4	 */
     5	
     6	#include <linux/err.h>
     7	#include <linux/hwmon.h>
   > 8	#include <linux/power_supply.h>
     9	#include <linux/slab.h>
  > 10	#include "power_supply.h"
    11	
  > 12	#include "power_supply.h"
    13	
  > 14	struct power_supply_hwmon {
    15		struct power_supply *psy;
    16		unsigned long *props;
    17	};
    18	
    19	static const char *const ps_temp_label[] = {
    20		"temp",
    21		"ambient temp",
    22	};
    23	
  > 24	static int power_supply_hwmon_in_to_property(u32 attr)
    25	{
    26		switch (attr) {
    27		case hwmon_in_average:
    28			return POWER_SUPPLY_PROP_VOLTAGE_AVG;
    29		case hwmon_in_min:
    30			return POWER_SUPPLY_PROP_VOLTAGE_MIN;
    31		case hwmon_in_max:
    32			return POWER_SUPPLY_PROP_VOLTAGE_MAX;
    33		case hwmon_in_input:
    34			return POWER_SUPPLY_PROP_VOLTAGE_NOW;
    35		default:
    36			return -EINVAL;
    37		}
    38	}
    39	
  > 40	static int power_supply_hwmon_curr_to_property(u32 attr)
    41	{
    42		switch (attr) {
    43		case hwmon_curr_average:
    44			return POWER_SUPPLY_PROP_CURRENT_AVG;
    45		case hwmon_curr_max:
    46			return POWER_SUPPLY_PROP_CURRENT_MAX;
    47		case hwmon_curr_input:
    48			return POWER_SUPPLY_PROP_CURRENT_NOW;
    49		default:
    50			return -EINVAL;
    51		}
    52	}
    53	
  > 54	static int power_supply_hwmon_power_to_property(u32 attr)
    55	{
    56		switch (attr) {
    57		case hwmon_power_input:
    58			return POWER_SUPPLY_PROP_POWER_NOW;
    59		case hwmon_power_average:
    60			return POWER_SUPPLY_PROP_POWER_AVG;
    61		default:
    62			return -EINVAL;
    63		}
    64	}
    65	
  > 66	static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
    67	{
    68		if (channel) {
    69			switch (attr) {
    70			case hwmon_temp_input:
    71				return POWER_SUPPLY_PROP_TEMP_AMBIENT;
    72			case hwmon_temp_min_alarm:
    73				return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN;
    74			case hwmon_temp_max_alarm:
    75				return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX;
    76			default:
    77				break;
    78			}
    79		} else {
    80			switch (attr) {
    81			case hwmon_temp_input:
    82				return POWER_SUPPLY_PROP_TEMP;
    83			case hwmon_temp_max:
    84				return POWER_SUPPLY_PROP_TEMP_MAX;
    85			case hwmon_temp_min:
    86				return POWER_SUPPLY_PROP_TEMP_MIN;
    87			case hwmon_temp_min_alarm:
    88				return POWER_SUPPLY_PROP_TEMP_ALERT_MIN;
    89			case hwmon_temp_max_alarm:
    90				return POWER_SUPPLY_PROP_TEMP_ALERT_MAX;
    91			default:
    92				break;
    93			}
    94		}
    95	
    96		return -EINVAL;
    97	}
    98	
    99	static int
 > 100	power_supply_hwmon_to_property(enum hwmon_sensor_types type,
   101				       u32 attr, int channel)
   102	{
   103		switch (type) {
   104		case hwmon_in:
 > 105			return power_supply_hwmon_in_to_property(attr);
   106		case hwmon_curr:
 > 107			return power_supply_hwmon_curr_to_property(attr);
   108		case hwmon_power:
 > 109			return power_supply_hwmon_power_to_property(attr);
   110		case hwmon_temp:
 > 111			return power_supply_hwmon_temp_to_property(attr, channel);
   112		default:
   113			return -EINVAL;
   114		}
   115	}
   116	
 > 117	static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
   118						   u32 attr)
   119	{
   120		return type == hwmon_temp && attr == hwmon_temp_label;
   121	}
   122	
   123	struct hwmon_type_attr_list {
   124		const u32 *attrs;
   125		size_t n_attrs;
   126	};
   127	
   128	static const u32 ps_temp_attrs[] = {
   129		hwmon_temp_input,
   130		hwmon_temp_min, hwmon_temp_max,
   131		hwmon_temp_min_alarm, hwmon_temp_max_alarm,
   132	};
   133	
   134	static const struct hwmon_type_attr_list ps_type_attrs[hwmon_max] = {
   135		[hwmon_temp] = { ps_temp_attrs, ARRAY_SIZE(ps_temp_attrs) },
   136	};
   137	
 > 138	static bool power_supply_hwmon_has_input(
 > 139		const struct power_supply_hwmon *psyhw,
   140		enum hwmon_sensor_types type, int channel)
   141	{
   142		const struct hwmon_type_attr_list *attr_list = &ps_type_attrs[type];
   143		size_t i;
   144	
   145		for (i = 0; i < attr_list->n_attrs; ++i) {
 > 146			int prop = power_supply_hwmon_to_property(type,
   147				attr_list->attrs[i], channel);
   148	
   149			if (prop >= 0 && test_bit(prop, psyhw->props))
   150				return true;
   151		}
   152	
   153		return false;
   154	}
   155	
 > 156	static bool power_supply_hwmon_is_writable(enum hwmon_sensor_types type,
   157						   u32 attr)
   158	{
   159		switch (type) {
   160		case hwmon_in:
   161			return attr == hwmon_in_min ||
   162			       attr == hwmon_in_max;
   163		case hwmon_curr:
   164			return attr == hwmon_curr_max;
   165		case hwmon_temp:
   166			return attr == hwmon_temp_max ||
   167			       attr == hwmon_temp_min ||
   168			       attr == hwmon_temp_min_alarm ||
   169			       attr == hwmon_temp_max_alarm;
   170		default:
   171			return false;
   172		}
   173	}
   174	
 > 175	static umode_t power_supply_hwmon_is_visible(const void *data,
   176						     enum hwmon_sensor_types type,
   177						     u32 attr, int channel)
   178	{
 > 179		const struct power_supply_hwmon *psyhw = data;
   180		int prop;
   181	
 > 182		if (power_supply_hwmon_is_a_label(type, attr)) {
 > 183			if (power_supply_hwmon_has_input(psyhw, type, channel))
   184				return 0444;
   185			else
   186				return 0;
   187		}
   188	
 > 189		prop = power_supply_hwmon_to_property(type, attr, channel);
   190		if (prop < 0 || !test_bit(prop, psyhw->props))
   191			return 0;
   192	
   193		if (power_supply_property_is_writeable(psyhw->psy, prop) > 0 &&
 > 194		    power_supply_hwmon_is_writable(type, attr))
   195			return 0644;
   196	
   197		return 0444;
   198	}
   199	
 > 200	static int power_supply_hwmon_read_string(struct device *dev,
   201						  enum hwmon_sensor_types type,
   202						  u32 attr, int channel,
   203						  const char **str)
   204	{
   205		switch (type) {
   206		case hwmon_temp:
   207			*str = ps_temp_label[channel];
   208			break;
   209		default:
   210			/* unreachable, but see:
   211			 * gcc bug #51513 [1] and clang bug #978 [2]
   212			 *
   213			 * [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51513
   214			 * [2] https://github.com/ClangBuiltLinux/linux/issues/978
   215			 */
   216			break;
   217		}
   218	
   219		return 0;
   220	}
   221	
   222	static int
 > 223	power_supply_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
   224				u32 attr, int channel, long *val)
   225	{
 > 226		struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
   227		struct power_supply *psy = psyhw->psy;
   228		union power_supply_propval pspval;
   229		int ret, prop;
   230	
 > 231		prop = power_supply_hwmon_to_property(type, attr, channel);
   232		if (prop < 0)
   233			return prop;
   234	
   235		ret  = power_supply_get_property(psy, prop, &pspval);
   236		if (ret)
   237			return ret;
   238	
   239		switch (type) {
   240		/*
   241		 * Both voltage and current is reported in units of
   242		 * microvolts/microamps, so we need to adjust it to
   243		 * milliamps(volts)
   244		 */
   245		case hwmon_curr:
   246		case hwmon_in:
   247			pspval.intval = DIV_ROUND_CLOSEST(pspval.intval, 1000);
   248			break;
   249		case hwmon_power:
   250			/*
   251			 * Power properties are already in microwatts.
   252			 */
   253			break;
   254		/*
   255		 * Temp needs to be converted from 1/10 C to milli-C
   256		 */
   257		case hwmon_temp:
   258			if (check_mul_overflow(pspval.intval, 100,
   259					       &pspval.intval))
   260				return -EOVERFLOW;
   261			break;
   262		default:
   263			return -EINVAL;
   264		}
   265	
   266		*val = pspval.intval;
   267	
   268		return 0;
   269	}
   270	
   271	static int
 > 272	power_supply_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
   273				 u32 attr, int channel, long val)
   274	{
 > 275		struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
   276		struct power_supply *psy = psyhw->psy;
   277		union power_supply_propval pspval;
   278		int prop;
   279	
 > 280		prop = power_supply_hwmon_to_property(type, attr, channel);
   281		if (prop < 0)
   282			return prop;
   283	
   284		pspval.intval = val;
   285	
   286		switch (type) {
   287		/*
   288		 * Both voltage and current is reported in units of
   289		 * microvolts/microamps, so we need to adjust it to
   290		 * milliamps(volts)
   291		 */
   292		case hwmon_curr:
   293		case hwmon_in:
   294			if (check_mul_overflow(pspval.intval, 1000,
   295					       &pspval.intval))
   296				return -EOVERFLOW;
   297			break;
   298		/*
   299		 * Temp needs to be converted from 1/10 C to milli-C
   300		 */
   301		case hwmon_temp:
   302			pspval.intval = DIV_ROUND_CLOSEST(pspval.intval, 100);
   303			break;
   304		default:
   305			return -EINVAL;
   306		}
   307	
   308		return power_supply_set_property(psy, prop, &pspval);
   309	}
   310	
 > 311	static const struct hwmon_ops power_supply_hwmon_ops = {
 > 312		.is_visible	= power_supply_hwmon_is_visible,
 > 313		.read		= power_supply_hwmon_read,
 > 314		.write		= power_supply_hwmon_write,
 > 315		.read_string	= power_supply_hwmon_read_string,
   316	};
   317	
 > 318	static const struct hwmon_channel_info * const power_supply_hwmon_info[] = {
   319		HWMON_CHANNEL_INFO(temp,
   320				   HWMON_T_LABEL     |
   321				   HWMON_T_INPUT     |
   322				   HWMON_T_MAX       |
   323				   HWMON_T_MIN       |
   324				   HWMON_T_MIN_ALARM |
   325				   HWMON_T_MAX_ALARM,
   326	
   327				   HWMON_T_LABEL     |
   328				   HWMON_T_INPUT     |
   329				   HWMON_T_MIN_ALARM |
   330				   HWMON_T_MAX_ALARM),
   331	
   332		HWMON_CHANNEL_INFO(curr,
   333				   HWMON_C_AVERAGE |
   334				   HWMON_C_MAX     |
   335				   HWMON_C_INPUT),
   336	
   337		HWMON_CHANNEL_INFO(power,
   338				   HWMON_P_INPUT |
   339				   HWMON_P_AVERAGE),
   340	
   341		HWMON_CHANNEL_INFO(in,
   342				   HWMON_I_AVERAGE |
   343				   HWMON_I_MIN     |
   344				   HWMON_I_MAX     |
   345				   HWMON_I_INPUT),
   346		NULL
   347	};
   348	
 > 349	static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
 > 350		.ops = &power_supply_hwmon_ops,
 > 351		.info = power_supply_hwmon_info,
   352	};
   353	
   354	int power_supply_add_hwmon_sysfs(struct power_supply *psy)
   355	{
   356		const struct power_supply_desc *desc = psy->desc;
 > 357		struct power_supply_hwmon *psyhw;
   358		struct device *dev = &psy->dev;
   359		struct device *hwmon;
   360		int ret, i;
   361		const char *name;
   362	
   363		if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
   364				       GFP_KERNEL))
   365			return -ENOMEM;
   366	
   367		psyhw = devm_kzalloc(dev, sizeof(*psyhw), GFP_KERNEL);
   368		if (!psyhw) {
   369			ret = -ENOMEM;
   370			goto error;
   371		}
   372	
   373		psyhw->psy = psy;
   374		psyhw->props = devm_bitmap_zalloc(dev,
   375						  POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
   376						  GFP_KERNEL);
   377		if (!psyhw->props) {
   378			ret = -ENOMEM;
   379			goto error;
   380		}
   381	
   382		for (i = 0; i < desc->num_properties; i++) {
   383			const enum power_supply_property prop = desc->properties[i];
   384	
   385			switch (prop) {
   386			case POWER_SUPPLY_PROP_CURRENT_AVG:
   387			case POWER_SUPPLY_PROP_CURRENT_MAX:
   388			case POWER_SUPPLY_PROP_CURRENT_NOW:
   389			case POWER_SUPPLY_PROP_POWER_AVG:
   390			case POWER_SUPPLY_PROP_POWER_NOW:
   391			case POWER_SUPPLY_PROP_TEMP:
   392			case POWER_SUPPLY_PROP_TEMP_MAX:
   393			case POWER_SUPPLY_PROP_TEMP_MIN:
   394			case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
   395			case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
   396			case POWER_SUPPLY_PROP_TEMP_AMBIENT:
   397			case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
   398			case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
   399			case POWER_SUPPLY_PROP_VOLTAGE_AVG:
   400			case POWER_SUPPLY_PROP_VOLTAGE_MIN:
   401			case POWER_SUPPLY_PROP_VOLTAGE_MAX:
   402			case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   403				set_bit(prop, psyhw->props);
   404				break;
   405			default:
   406				break;
   407			}
   408		}
   409	
   410		name = psy->desc->name;
   411		if (strchr(name, '-')) {
   412			char *new_name;
   413	
   414			new_name = devm_kstrdup(dev, name, GFP_KERNEL);
   415			if (!new_name) {
   416				ret = -ENOMEM;
   417				goto error;
   418			}
   419			strreplace(new_name, '-', '_');
   420			name = new_name;
   421		}
   422		hwmon = devm_hwmon_device_register_with_info(dev, name,
   423							psyhw,
 > 424							&power_supply_hwmon_chip_info,
   425							NULL);
   426		ret = PTR_ERR_OR_ZERO(hwmon);
   427		if (ret)
   428			goto error;
   429	
   430		devres_close_group(dev, power_supply_add_hwmon_sysfs);
   431		return 0;
   432	error:
   433		devres_release_group(dev, NULL);
   434		return ret;
   435	}
   436	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

