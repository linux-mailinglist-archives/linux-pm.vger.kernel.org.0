Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4A287F9B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 02:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgJIAwB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 20:52:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:32960 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgJIAwB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 20:52:01 -0400
IronPort-SDR: T/6Wsi6qI/RAA7anZt5EeVLFoV55FZScNZ+JCQlVDHaeOjC9mBj4A6FCuCofspEXqz6pjSKdtI
 hwhVE94jZAeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="152346032"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="gz'50?scan'50,208,50";a="152346032"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 17:51:59 -0700
IronPort-SDR: c8J05FFw380pbnYoHG2G9QVV8YUv1SCfoQFZY+TzS7Kf2j4Zrad3rtFId3hkAmlcLDyelIoPbm
 WMmF5gVvVOzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="gz'50?scan'50,208,50";a="354683652"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2020 17:51:56 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQgdX-00002y-SD; Fri, 09 Oct 2020 00:51:55 +0000
Date:   Fri, 9 Oct 2020 08:51:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Murphy <dmurphy@ti.com>, sre@kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v3 2/2] power: supply: bq25790: Introduce the BQ25790
 charger driver
Message-ID: <202010090800.yCulmNLd-lkp@intel.com>
References: <20201008154356.19692-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20201008154356.19692-2-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on power-supply/for-next]
[also build test WARNING on linus/master v5.9-rc8 next-20201008]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dan-Murphy/dt-bindings-power-Add-the-bq25790-dt-bindings/20201008-234450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: riscv-randconfig-r031-20201009 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 8da0df3d6dcc0dd42740be60b0da4ec201190904)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/bc435a97ea513a3f4baa45b167b623a82187f9d3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dan-Murphy/dt-bindings-power-Add-the-bq25790-dt-bindings/20201008-234450
        git checkout bc435a97ea513a3f4baa45b167b623a82187f9d3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/supply/bq25790_charger.c:624:21: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
                   if (state.fault_1 && (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
                                     ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/bq25790_charger.c:624:21: note: use '&' for a bitwise operation
                   if (state.fault_1 && (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
                                     ^~
                                     &
   drivers/power/supply/bq25790_charger.c:624:21: note: remove constant to silence this warning
                   if (state.fault_1 && (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
                                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/power/supply/bq25790_charger.c:1102:36: warning: unused variable 'bq25790_acpi_match' [-Wunused-const-variable]
   static const struct acpi_device_id bq25790_acpi_match[] = {
                                      ^
   2 warnings generated.

vim +624 drivers/power/supply/bq25790_charger.c

   537	
   538	static int bq25790_get_property(struct power_supply *psy,
   539					enum power_supply_property psp,
   540					union power_supply_propval *val)
   541	{
   542		struct bq25790_device *bq = power_supply_get_drvdata(psy);
   543		struct bq25790_state state;
   544		int ret = 0;
   545	
   546		mutex_lock(&bq->lock);
   547		ret = bq25790_get_state(bq, &state);
   548		mutex_unlock(&bq->lock);
   549		if (ret)
   550			return ret;
   551	
   552		switch (psp) {
   553		case POWER_SUPPLY_PROP_STATUS:
   554			if (!state.chrg_type || (state.chrg_type == BQ25790_OTG_MODE))
   555				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
   556			else if (!state.chrg_status)
   557				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
   558			else if (state.chrg_status == BQ25790_TERM_CHRG)
   559				val->intval = POWER_SUPPLY_STATUS_FULL;
   560			else
   561				val->intval = POWER_SUPPLY_STATUS_CHARGING;
   562			break;
   563		case POWER_SUPPLY_PROP_CHARGE_TYPE:
   564			switch (state.chrg_status) {
   565			case BQ25790_TRICKLE_CHRG:
   566				val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
   567				break;
   568			case BQ25790_PRECHRG:
   569				val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
   570				break;
   571			case BQ25790_FAST_CHRG:
   572				val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
   573				break;
   574			case BQ25790_TAPER_CHRG:
   575				val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
   576				break;
   577			case BQ25790_TOP_OFF_CHRG:
   578				val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
   579				break;
   580			case BQ25790_NOT_CHRGING:
   581				val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
   582				break;
   583			default:
   584				val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
   585			}
   586			break;
   587		case POWER_SUPPLY_PROP_MANUFACTURER:
   588			val->strval = BQ25790_MANUFACTURER;
   589			break;
   590	
   591		case POWER_SUPPLY_PROP_MODEL_NAME:
   592			val->strval = BQ25790_NAME;
   593			break;
   594	
   595		case POWER_SUPPLY_PROP_ONLINE:
   596			val->intval = state.online;
   597			break;
   598		case POWER_SUPPLY_PROP_USB_TYPE:
   599			if (!state.chrg_type) {
   600				val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
   601				break;
   602			}
   603			switch (state.chrg_type) {
   604			case BQ25790_USB_SDP:
   605				val->intval = POWER_SUPPLY_USB_TYPE_SDP;
   606				break;
   607			case BQ25790_USB_CDP:
   608				val->intval = POWER_SUPPLY_USB_TYPE_CDP;
   609				break;
   610			case BQ25790_USB_DCP:
   611				val->intval = POWER_SUPPLY_USB_TYPE_DCP;
   612				break;
   613			case BQ25790_OTG_MODE:
   614				val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
   615				break;
   616	
   617			default:
   618				val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
   619				break;
   620			}
   621			break;
   622	
   623		case POWER_SUPPLY_PROP_HEALTH:
 > 624			if (state.fault_1 && (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
   625				val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
   626			else
   627				val->intval = POWER_SUPPLY_HEALTH_GOOD;
   628	
   629			switch (state.health) {
   630			case BQ25790_TEMP_HOT:
   631				val->intval = POWER_SUPPLY_HEALTH_HOT;
   632				break;
   633			case BQ25790_TEMP_WARM:
   634				val->intval = POWER_SUPPLY_HEALTH_WARM;
   635				break;
   636			case BQ25790_TEMP_COOL:
   637				val->intval = POWER_SUPPLY_HEALTH_COOL;
   638				break;
   639			case BQ25790_TEMP_COLD:
   640				val->intval = POWER_SUPPLY_HEALTH_COLD;
   641				break;
   642			}
   643			break;
   644		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
   645			ret = bq25790_get_ichg_curr(bq);
   646			if (ret < 0)
   647				return ret;
   648	
   649			val->intval = ret;
   650			break;
   651	
   652		case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
   653			ret = bq25790_get_chrg_volt(bq);
   654			if (ret < 0)
   655				return ret;
   656	
   657			val->intval = ret;
   658			break;
   659	
   660		case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
   661			ret = bq25790_get_prechrg_curr(bq);
   662			if (ret < 0)
   663				return ret;
   664	
   665			val->intval = ret;
   666			break;
   667		case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
   668			ret = bq25790_get_term_curr(bq);
   669			if (ret < 0)
   670				return ret;
   671	
   672			val->intval = ret;
   673			break;
   674		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   675			val->intval = state.vbus_adc;
   676			break;
   677		case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
   678			ret = bq25790_get_input_volt_lim(bq);
   679			if (ret < 0)
   680				return ret;
   681	
   682			val->intval = ret;
   683			break;
   684		case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
   685			ret = bq25790_get_input_curr_lim(bq);
   686			if (ret < 0)
   687				return ret;
   688	
   689			val->intval = ret;
   690			break;
   691		default:
   692			return -EINVAL;
   693		}
   694	
   695		return ret;
   696	}
   697	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--
