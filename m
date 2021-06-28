Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF633B572C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 04:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhF1CVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 22:21:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:16499 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231924AbhF1CVQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Jun 2021 22:21:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207694667"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="gz'50?scan'50,208,50";a="207694667"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 19:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="gz'50?scan'50,208,50";a="640722720"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 19:18:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxgrI-0008Nq-VD; Mon, 28 Jun 2021 02:18:48 +0000
Date:   Mon, 28 Jun 2021 10:18:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] power: supply: core: Parse battery type/technology
Message-ID: <202106281035.IJIRlDos-lkp@intel.com>
References: <20210627234515.3057935-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20210627234515.3057935-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pWyiEgJYm5f9v55/
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
config: alpha-randconfig-r003-20210628 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2bf6622db1c3b0d7e5cad624e16c0a448d37547b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Linus-Walleij/dt-bindings-power-Extend-battery-bindings-with-type/20210628-074842
        git checkout 2bf6622db1c3b0d7e5cad624e16c0a448d37547b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/power_supply_core.c: In function 'power_supply_get_battery_info':
>> drivers/power/supply/power_supply_core.c:622:6: warning: operation on 'err' may be undefined [-Wsequence-point]
     622 |  err = err = of_property_read_string(battery_np, "battery-type", &value);
         |  ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--pWyiEgJYm5f9v55/--
