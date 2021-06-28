Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49D3B572D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 04:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhF1CXR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 22:23:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:30609 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF1CXR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Jun 2021 22:23:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="204870617"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="gz'50?scan'50,208,50";a="204870617"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 19:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="gz'50?scan'50,208,50";a="456136875"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2021 19:20:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxgtE-0008Nu-Vz; Mon, 28 Jun 2021 02:20:49 +0000
Date:   Mon, 28 Jun 2021 10:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] power: supply: core: Parse battery type/technology
Message-ID: <202106281003.Yr5RaqE0-lkp@intel.com>
References: <20210627234515.3057935-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20210627234515.3057935-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--NzB8fVQJ5HfG6fxh
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
config: arm64-randconfig-r033-20210628 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 4c92e31dd0f1bd152eda883af20ff7fbcaa14945)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/2bf6622db1c3b0d7e5cad624e16c0a448d37547b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Linus-Walleij/dt-bindings-power-Extend-battery-bindings-with-type/20210628-074842
        git checkout 2bf6622db1c3b0d7e5cad624e16c0a448d37547b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 

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

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tQEA

--NzB8fVQJ5HfG6fxh--
