Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118A357F596
	for <lists+linux-pm@lfdr.de>; Sun, 24 Jul 2022 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGXO6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jul 2022 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXO6K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jul 2022 10:58:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C71115E;
        Sun, 24 Jul 2022 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658674688; x=1690210688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cuvkrhzlEUw4A7cMtPXRouMT3Zl03RtOHrTbf9z657s=;
  b=alwJfKgzOEOmhNPG4mxKdbEIL/IKimBfe/GFczM6wgvwby8xmuPInhui
   ABxtnYJgufVsmOMe0tEjXou3jTEOmPDPvSetUeKuTBMCbTZSso/5YKBFi
   pq+LW1eMIP0V5JR6Dm726uK9RFaVLP8Zeu5QklRWAYbh6aozWlZpO/Oki
   qC+poDP8dn/J/aaZ2r29JFMv0XtdngqUoYUqvBpiIppCaaknMdfxrdXGQ
   L/EnEcwVsXF9g4wPcq+FGudXwqZSjYOE7qwvKkyG7QcQYgg+b4+0p3NNP
   U6U+lQe6r4639iWrQPmyJyGLCToFYlTskrIGI3lfVvuoGmXYLVkDxjUPh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274410246"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="274410246"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="667196563"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2022 07:58:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFd3S-0003vr-2s;
        Sun, 24 Jul 2022 14:58:02 +0000
Date:   Sun, 24 Jul 2022 22:58:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [RESEND 3/4 v7] power: supply: Add charger driver for Rockchip
 RK817
Message-ID: <202207242227.mttUkfTB-lkp@intel.com>
References: <20220721161718.29800-4-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721161718.29800-4-macroalpha82@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chris,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on sre-power-supply/for-next rockchip/for-next linus/master v5.19-rc7 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/power-supply-Add-Support-for-RK817-Charger/20220722-002431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220724/202207242227.mttUkfTB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/008e6f0d590e275cbb56d4506b5638156506dd40
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chris-Morgan/power-supply-Add-Support-for-RK817-Charger/20220722-002431
        git checkout 008e6f0d590e275cbb56d4506b5638156506dd40
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/rk817_charger.c: In function 'rk817_read_or_set_full_charge_on_boot':
>> drivers/power/supply/rk817_charger.c:701:33: warning: variable 'soc_tmp3' set but not used [-Wunused-but-set-variable]
     701 |         int soc_tmp1, soc_tmp2, soc_tmp3;
         |                                 ^~~~~~~~
>> drivers/power/supply/rk817_charger.c:701:23: warning: variable 'soc_tmp2' set but not used [-Wunused-but-set-variable]
     701 |         int soc_tmp1, soc_tmp2, soc_tmp3;
         |                       ^~~~~~~~
>> drivers/power/supply/rk817_charger.c:701:13: warning: variable 'soc_tmp1' set but not used [-Wunused-but-set-variable]
     701 |         int soc_tmp1, soc_tmp2, soc_tmp3;
         |             ^~~~~~~~


vim +/soc_tmp3 +701 drivers/power/supply/rk817_charger.c

   692	
   693	static int
   694	rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
   695					struct power_supply_battery_info *bat_info)
   696	{
   697		struct rk808 *rk808 = charger->rk808;
   698		u8 bulk_reg[4];
   699		u32 boot_voltage, boot_charge_mah, tmp;
   700		int ret, reg, off_time;
 > 701		int soc_tmp1, soc_tmp2, soc_tmp3;
   702		bool first_boot;
   703	
   704		/* Check if the battery is uninitalized. If it is, the columb counter
   705		 * needs to be set up.
   706		 */
   707		ret = regmap_read(rk808->regmap, RK817_GAS_GAUGE_GG_STS, &reg);
   708		if (ret < 0)
   709			return ret;
   710		first_boot = reg & RK817_BAT_CON;
   711		/* If the battery is uninitialized, use the poweron voltage and an ocv
   712		 * lookup to guess our charge. The number won't be very accurate until
   713		 * we hit either our minimum voltage (0%) or full charge (100%).
   714		 */
   715		if (first_boot) {
   716			regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
   717					 bulk_reg, 2);
   718			tmp = get_unaligned_be16(bulk_reg);
   719			boot_voltage = (charger->voltage_k * tmp) +
   720					1000 * charger->voltage_b;
   721			/* Since only implementation has no working thermistor, assume
   722			 * 20C for OCV lookup. If lookup fails, report error with OCV
   723			 * table.
   724			 */
   725			charger->soc = power_supply_batinfo_ocv2cap(bat_info,
   726								    boot_voltage,
   727								    20) * 1000;
   728			if (charger->soc < 0)
   729				charger->soc = 0;
   730	
   731			/* Guess that full charge capacity is the design capacity */
   732			charger->fcc_mah = charger->bat_charge_full_design_uah / 1000;
   733			/* Set battery as "set up". BSP driver uses this value even
   734			 * though datasheet claims it's a read-only value.
   735			 */
   736			regmap_write_bits(rk808->regmap, RK817_GAS_GAUGE_GG_STS,
   737					  RK817_BAT_CON, 0);
   738			/* Save nvram values */
   739			ret = rk817_record_battery_nvram_values(charger);
   740			if (ret < 0)
   741				return ret;
   742		} else {
   743			ret = rk817_read_battery_nvram_values(charger);
   744			if (ret < 0)
   745				return ret;
   746	
   747			regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
   748					 bulk_reg, 4);
   749			tmp = get_unaligned_be32(bulk_reg);
   750			if (tmp < 0)
   751				tmp = 0;
   752			boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
   753							    charger->res_div) / 1000;
   754			/* Check if the columb counter has been off for more than 300
   755			 * minutes as it tends to drift downward. If so, re-init soc
   756			 * with the boot voltage instead. Note the unit values for the
   757			 * OFF_CNT register appear to be in decaminutes and stops
   758			 * counting at 2550 (0xFF) minutes. BSP kernel used OCV, but
   759			 * for me occasionally that would show invalid values. Boot
   760			 * voltage is only accurate for me on first poweron (not
   761			 * reboots), but we shouldn't ever encounter an OFF_CNT more
   762			 * than 0 on a reboot anyway.
   763			 */
   764			regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_time);
   765			if (off_time >= 30) {
   766				regmap_bulk_read(rk808->regmap,
   767						 RK817_GAS_GAUGE_PWRON_VOL_H,
   768						 bulk_reg, 2);
   769				tmp = get_unaligned_be16(bulk_reg);
   770				boot_voltage = (charger->voltage_k * tmp) +
   771						1000 * charger->voltage_b;
   772				charger->soc =
   773					power_supply_batinfo_ocv2cap(bat_info,
   774								     boot_voltage,
   775								     20) * 1000;
   776			} else {
   777				charger->soc = (boot_charge_mah * 1000 * 100 /
   778						charger->fcc_mah);
   779			}
   780		}
   781	
   782		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
   783				 bulk_reg, 2);
   784		tmp = get_unaligned_be16(bulk_reg);
   785		boot_voltage = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
   786		soc_tmp1 = power_supply_batinfo_ocv2cap(bat_info,
   787							boot_voltage, 20) * 1000;
   788		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
   789				 bulk_reg, 4);
   790		tmp = get_unaligned_be32(bulk_reg);
   791		if (tmp < 0)
   792			tmp = 0;
   793		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
   794		soc_tmp2 = (boot_charge_mah * 1000 * 100 / charger->fcc_mah);
   795		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
   796				 bulk_reg, 2);
   797		tmp = get_unaligned_be16(bulk_reg);
   798		boot_voltage = (charger->voltage_k * tmp) + 1000 * charger->voltage_b;
   799		soc_tmp3 = power_supply_batinfo_ocv2cap(bat_info,
   800							boot_voltage, 20) * 1000;
   801	
   802		/* Now we have our full charge capacity and soc, init the columb
   803		 * counter.
   804		 */
   805		boot_charge_mah = charger->soc * charger->fcc_mah / 100 / 1000;
   806		if (boot_charge_mah > charger->fcc_mah)
   807			boot_charge_mah = charger->fcc_mah;
   808		tmp = CHARGE_TO_ADC(boot_charge_mah, charger->res_div);
   809		put_unaligned_be32(tmp, bulk_reg);
   810		ret = regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
   811				  bulk_reg, 4);
   812		if (ret < 0)
   813			return ret;
   814	
   815		/* Set QMAX value to max design capacity. */
   816		tmp = CHARGE_TO_ADC((charger->bat_charge_full_design_uah / 1000),
   817				    charger->res_div);
   818		put_unaligned_be32(tmp, bulk_reg);
   819		ret = regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_MAX_H3,
   820					bulk_reg, 4);
   821		if (ret < 0)
   822			return ret;
   823	
   824		return 0;
   825	}
   826	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
