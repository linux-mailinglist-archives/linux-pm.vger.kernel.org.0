Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250453B5727
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 04:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhF1CRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 22:17:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:16186 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhF1CRS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Jun 2021 22:17:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207913232"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="gz'50?scan'50,208,50";a="207913232"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 19:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="gz'50?scan'50,208,50";a="407553500"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2021 19:14:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxgnQ-0008Nh-S9; Mon, 28 Jun 2021 02:14:48 +0000
Date:   Mon, 28 Jun 2021 10:13:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] power: supply: core: Parse battery type/technology
Message-ID: <202106281018.Skl2p8R7-lkp@intel.com>
References: <20210627234515.3057935-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20210627234515.3057935-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I love your patch! Perhaps something to improve:

[auto build test WARNING on power-supply/for-next]
[also build test WARNING on v5.13 next-20210625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Linus-Walleij/dt-bindings-power-Extend-battery-bindings-with-type/20210628-074842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: mips-randconfig-r011-20210628 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 4c92e31dd0f1bd152eda883af20ff7fbcaa14945)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/2bf6622db1c3b0d7e5cad624e16c0a448d37547b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Linus-Walleij/dt-bindings-power-Extend-battery-bindings-with-type/20210628-074842
        git checkout 2bf6622db1c3b0d7e5cad624e16c0a448d37547b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/supply/power_supply_core.c:622:12: warning: multiple unsequenced modifications to 'err' [-Wunsequenced]
           err = err = of_property_read_string(battery_np, "battery-type", &value);
               ~     ^
   1 warning generated.


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

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
QPCtL8X3IFZ433ucBW4s5ini/wDo9Cq1p2gBAA==

--zYM0uCDKw75PZbzx--
