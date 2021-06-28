Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1154D3B57EC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 05:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhF1DqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 23:46:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:1134 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhF1DqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Jun 2021 23:46:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="188262449"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="188262449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 20:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="643192622"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2021 20:43:50 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxiBZ-0008P7-S5; Mon, 28 Jun 2021 03:43:49 +0000
Date:   Mon, 28 Jun 2021 11:43:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] power: supply: core: Parse battery type/technology
Message-ID: <202106281132.flR2cWk3-lkp@intel.com>
References: <20210627234515.3057935-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627234515.3057935-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

I love your patch! Perhaps something to improve:

[auto build test WARNING on power-supply/for-next]
[also build test WARNING on v5.13 next-20210625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Linus-Walleij/dt-bindings-power-Extend-battery-bindings-with-type/20210628-074842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
compiler: nios2-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/power/supply/power_supply_core.c:622:6: warning: Redundant assignment of 'err' to itself. [selfAssignment]
    err = err = of_property_read_string(battery_np, "battery-type", &value);
        ^

vim +/err +622 drivers/power/supply/power_supply_core.c

   564	
   565	int power_supply_get_battery_info(struct power_supply *psy,
   566					  struct power_supply_battery_info *info)
   567	{
   568		struct power_supply_resistance_temp_table *resist_table;
   569		struct device_node *battery_np;
   570		const char *value;
   571		int err, len, index;
   572		const __be32 *list;
   573	
   574		info->technology                     = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
   575		info->energy_full_design_uwh         = -EINVAL;
   576		info->charge_full_design_uah         = -EINVAL;
   577		info->voltage_min_design_uv          = -EINVAL;
   578		info->voltage_max_design_uv          = -EINVAL;
   579		info->precharge_current_ua           = -EINVAL;
   580		info->charge_term_current_ua         = -EINVAL;
   581		info->constant_charge_current_max_ua = -EINVAL;
   582		info->constant_charge_voltage_max_uv = -EINVAL;
   583		info->temp_ambient_alert_min         = INT_MIN;
   584		info->temp_ambient_alert_max         = INT_MAX;
   585		info->temp_alert_min                 = INT_MIN;
   586		info->temp_alert_max                 = INT_MAX;
   587		info->temp_min                       = INT_MIN;
   588		info->temp_max                       = INT_MAX;
   589		info->factory_internal_resistance_uohm  = -EINVAL;
   590		info->resist_table = NULL;
   591	
   592		for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
   593			info->ocv_table[index]       = NULL;
   594			info->ocv_temp[index]        = -EINVAL;
   595			info->ocv_table_size[index]  = -EINVAL;
   596		}
   597	
   598		if (!psy->of_node) {
   599			dev_warn(&psy->dev, "%s currently only supports devicetree\n",
   600				 __func__);
   601			return -ENXIO;
   602		}
   603	
   604		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
   605		if (!battery_np)
   606			return -ENODEV;
   607	
   608		err = of_property_read_string(battery_np, "compatible", &value);
   609		if (err)
   610			goto out_put_node;
   611	
   612		if (strcmp("simple-battery", value)) {
   613			err = -ENODEV;
   614			goto out_put_node;
   615		}
   616	
   617		/* The property and field names below must correspond to elements
   618		 * in enum power_supply_property. For reasoning, see
   619		 * Documentation/power/power_supply_class.rst.
   620		 */
   621	
 > 622		err = err = of_property_read_string(battery_np, "battery-type", &value);
   623		if (!err) {
   624			if (!strcmp("nickel-cadmium", value))
   625				info->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
   626			else if (!strcmp("nickel-metal-hydride", value))
   627				info->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
   628			else if (!strcmp("lithium-ion", value))
   629				/* Imprecise lithium-ion type */
   630				info->technology = POWER_SUPPLY_TECHNOLOGY_LION;
   631			else if (!strcmp("lithium-ion-polymer", value))
   632				info->technology = POWER_SUPPLY_TECHNOLOGY_LIPO;
   633			else if (!strcmp("lithium-ion-iron-phosphate", value))
   634				info->technology = POWER_SUPPLY_TECHNOLOGY_LiFe;
   635			else if (!strcmp("lithium-ion-manganese-oxide", value))
   636				info->technology = POWER_SUPPLY_TECHNOLOGY_LiMn;
   637			else
   638				dev_warn(&psy->dev, "%s unknown battery type\n", value);
   639		}
   640	
   641		of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
   642				     &info->energy_full_design_uwh);
   643		of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
   644				     &info->charge_full_design_uah);
   645		of_property_read_u32(battery_np, "voltage-min-design-microvolt",
   646				     &info->voltage_min_design_uv);
   647		of_property_read_u32(battery_np, "voltage-max-design-microvolt",
   648				     &info->voltage_max_design_uv);
   649		of_property_read_u32(battery_np, "trickle-charge-current-microamp",
   650				     &info->tricklecharge_current_ua);
   651		of_property_read_u32(battery_np, "precharge-current-microamp",
   652				     &info->precharge_current_ua);
   653		of_property_read_u32(battery_np, "precharge-upper-limit-microvolt",
   654				     &info->precharge_voltage_max_uv);
   655		of_property_read_u32(battery_np, "charge-term-current-microamp",
   656				     &info->charge_term_current_ua);
   657		of_property_read_u32(battery_np, "re-charge-voltage-microvolt",
   658				     &info->charge_restart_voltage_uv);
   659		of_property_read_u32(battery_np, "over-voltage-threshold-microvolt",
   660				     &info->overvoltage_limit_uv);
   661		of_property_read_u32(battery_np, "constant-charge-current-max-microamp",
   662				     &info->constant_charge_current_max_ua);
   663		of_property_read_u32(battery_np, "constant-charge-voltage-max-microvolt",
   664				     &info->constant_charge_voltage_max_uv);
   665		of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
   666				     &info->factory_internal_resistance_uohm);
   667	
   668		of_property_read_u32_index(battery_np, "ambient-celsius",
   669					   0, &info->temp_ambient_alert_min);
   670		of_property_read_u32_index(battery_np, "ambient-celsius",
   671					   1, &info->temp_ambient_alert_max);
   672		of_property_read_u32_index(battery_np, "alert-celsius",
   673					   0, &info->temp_alert_min);
   674		of_property_read_u32_index(battery_np, "alert-celsius",
   675					   1, &info->temp_alert_max);
   676		of_property_read_u32_index(battery_np, "operating-range-celsius",
   677					   0, &info->temp_min);
   678		of_property_read_u32_index(battery_np, "operating-range-celsius",
   679					   1, &info->temp_max);
   680	
   681		len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
   682		if (len < 0 && len != -EINVAL) {
   683			err = len;
   684			goto out_put_node;
   685		} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
   686			dev_err(&psy->dev, "Too many temperature values\n");
   687			err = -EINVAL;
   688			goto out_put_node;
   689		} else if (len > 0) {
   690			of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
   691						   info->ocv_temp, len);
   692		}
   693	
   694		for (index = 0; index < len; index++) {
   695			struct power_supply_battery_ocv_table *table;
   696			char *propname;
   697			int i, tab_len, size;
   698	
   699			propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
   700			list = of_get_property(battery_np, propname, &size);
   701			if (!list || !size) {
   702				dev_err(&psy->dev, "failed to get %s\n", propname);
   703				kfree(propname);
   704				power_supply_put_battery_info(psy, info);
   705				err = -EINVAL;
   706				goto out_put_node;
   707			}
   708	
   709			kfree(propname);
   710			tab_len = size / (2 * sizeof(__be32));
   711			info->ocv_table_size[index] = tab_len;
   712	
   713			table = info->ocv_table[index] =
   714				devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
   715			if (!info->ocv_table[index]) {
   716				power_supply_put_battery_info(psy, info);
   717				err = -ENOMEM;
   718				goto out_put_node;
   719			}
   720	
   721			for (i = 0; i < tab_len; i++) {
   722				table[i].ocv = be32_to_cpu(*list);
   723				list++;
   724				table[i].capacity = be32_to_cpu(*list);
   725				list++;
   726			}
   727		}
   728	
   729		list = of_get_property(battery_np, "resistance-temp-table", &len);
   730		if (!list || !len)
   731			goto out_put_node;
   732	
   733		info->resist_table_size = len / (2 * sizeof(__be32));
   734		resist_table = info->resist_table = devm_kcalloc(&psy->dev,
   735								 info->resist_table_size,
   736								 sizeof(*resist_table),
   737								 GFP_KERNEL);
   738		if (!info->resist_table) {
   739			power_supply_put_battery_info(psy, info);
   740			err = -ENOMEM;
   741			goto out_put_node;
   742		}
   743	
   744		for (index = 0; index < info->resist_table_size; index++) {
   745			resist_table[index].temp = be32_to_cpu(*list++);
   746			resist_table[index].resistance = be32_to_cpu(*list++);
   747		}
   748	
   749	out_put_node:
   750		of_node_put(battery_np);
   751		return err;
   752	}
   753	EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
   754	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
