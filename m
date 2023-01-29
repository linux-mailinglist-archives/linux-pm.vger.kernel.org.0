Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC403680112
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jan 2023 20:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjA2TA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Jan 2023 14:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjA2TAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2023 14:00:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441311969A;
        Sun, 29 Jan 2023 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675018824; x=1706554824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qcLePQTbrzoLvq+ElRVOT/zcQr0y/IMDSu9rw90ydJ4=;
  b=EmpB0/dZ3ieBAkwgEtfdOZVUYlB42m59sHmfhn3cKtmzK4HCorvKeRK3
   D8quRut1uBE2haOyDEhqyTyv2bqDtNjB1QxIwG34ZAux2ZYMKlDXb44wF
   FNyJhIEXrSEnb9IRbnUB+B626c4zuL0T6lyo8T14mFKWsx50x9ZVwnlax
   7104DKtwhNIN7L5Lgi03cSmxNTThp8OZ4O50jIa5SSz4eI1nHHATPpoeS
   uMfSyrfmUkQ4ZejDf245v24DZktVkzM2803dnalVocppsm9rBZu9iiTpA
   JQ6ZuepQ6j5IsjhYtYpmLqCBmLg0jzO+ZtK3klAK65WRPc4PviNKO691Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="307071745"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="307071745"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 11:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="806429240"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="806429240"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2023 11:00:21 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMCua-00032E-1L;
        Sun, 29 Jan 2023 19:00:20 +0000
Date:   Mon, 30 Jan 2023 03:00:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] power: supply: add Qualcomm PMI8998 SMB2 Charger
 driver
Message-ID: <202301300204.VMpH8OI5-lkp@intel.com>
References: <20230127230506.3140297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127230506.3140297-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Caleb,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on robh/for-next linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Caleb-Connolly/dt-bindings-power-supply-qcom-pmi8998-charger-add-bindings-for-smb2-driver/20230128-172503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20230127230506.3140297-1-caleb.connolly%40linaro.org
patch subject: [PATCH v7 1/2] power: supply: add Qualcomm PMI8998 SMB2 Charger driver
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20230130/202301300204.VMpH8OI5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/703a352943e95de330efc87cd3feab1c6534603a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Caleb-Connolly/dt-bindings-power-supply-qcom-pmi8998-charger-add-bindings-for-smb2-driver/20230128-172503
        git checkout 703a352943e95de330efc87cd3feab1c6534603a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/bluetooth/ drivers/net/ethernet/mediatek/ drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/qcom_pmi8998_charger.c: In function 'smb2_probe':
>> drivers/power/supply/qcom_pmi8998_charger.c:979:62: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'const void *' [-Wformat=]
     979 |         desc->name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
         |                                                             ~^
         |                                                              |
         |                                                              char *
         |                                                             %p
     980 |                                     device_get_match_data(chip->dev));
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                     |
         |                                     const void *


vim +979 drivers/power/supply/qcom_pmi8998_charger.c

   934	
   935	static int smb2_probe(struct platform_device *pdev)
   936	{
   937		struct power_supply_config supply_config = {};
   938		struct power_supply_desc *desc;
   939		struct smb2_chip *chip;
   940		int rc, irq;
   941	
   942		chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
   943		if (!chip)
   944			return -ENOMEM;
   945	
   946		chip->dev = &pdev->dev;
   947		chip->name = pdev->name;
   948	
   949		chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
   950		if (!chip->regmap)
   951			return dev_err_probe(chip->dev, -ENODEV,
   952					     "failed to locate the regmap\n");
   953	
   954		rc = device_property_read_u32(chip->dev, "reg", &chip->base);
   955		if (rc < 0)
   956			return dev_err_probe(chip->dev, rc,
   957					     "Couldn't read base address\n");
   958	
   959		chip->usb_in_v_chan = devm_iio_channel_get(chip->dev, "usbin_v");
   960		if (IS_ERR(chip->usb_in_v_chan))
   961			return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_v_chan),
   962					     "Couldn't get usbin_v IIO channel\n");
   963	
   964		chip->usb_in_i_chan = devm_iio_channel_get(chip->dev, "usbin_i");
   965		if (IS_ERR(chip->usb_in_i_chan)) {
   966			return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_i_chan),
   967					     "Couldn't get usbin_i IIO channel\n");
   968		}
   969	
   970		rc = smb2_init_hw(chip);
   971		if (rc < 0)
   972			return rc;
   973	
   974		supply_config.drv_data = chip;
   975		supply_config.of_node = pdev->dev.of_node;
   976	
   977		desc = devm_kzalloc(chip->dev, sizeof(smb2_psy_desc), GFP_KERNEL);
   978		memcpy(desc, &smb2_psy_desc, sizeof(smb2_psy_desc));
 > 979		desc->name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
   980					    device_get_match_data(chip->dev));
   981	
   982		chip->chg_psy =
   983			devm_power_supply_register(chip->dev, desc, &supply_config);
   984		if (IS_ERR(chip->chg_psy))
   985			return dev_err_probe(chip->dev, PTR_ERR(chip->chg_psy),
   986					     "failed to register power supply\n");
   987	
   988		rc = power_supply_get_battery_info(chip->chg_psy, &chip->batt_info);
   989		if (rc)
   990			return dev_err_probe(chip->dev, rc,
   991					     "Failed to get battery info\n");
   992	
   993		rc = devm_delayed_work_autocancel(chip->dev, &chip->status_change_work,
   994						  smb2_status_change_work);
   995		if (rc)
   996			return dev_err_probe(chip->dev, rc,
   997					     "Failed to init status change work\n");
   998	
   999		rc = (chip->batt_info->voltage_max_design_uv - 3487500) / 7500 + 1;
  1000		rc = regmap_update_bits(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG,
  1001					FLOAT_VOLTAGE_SETTING_MASK, rc);
  1002		if (rc < 0)
  1003			return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
  1004	
  1005		rc = smb2_init_irq(chip, &irq, "bat-ov", smb2_handle_batt_overvoltage);
  1006		if (rc < 0)
  1007			return rc;
  1008	
  1009		rc = smb2_init_irq(chip, &chip->cable_irq, "usb-plugin",
  1010				   smb2_handle_usb_plugin);
  1011		if (rc < 0)
  1012			return rc;
  1013	
  1014		rc = smb2_init_irq(chip, &irq, "usbin-icl-change",
  1015				   smb2_handle_usb_icl_change);
  1016		if (rc < 0)
  1017			return rc;
  1018		rc = smb2_init_irq(chip, &irq, "wdog-bark", smb2_handle_wdog_bark);
  1019		if (rc < 0)
  1020			return rc;
  1021	
  1022		rc = dev_pm_set_wake_irq(chip->dev, chip->cable_irq);
  1023		if (rc < 0)
  1024			return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
  1025	
  1026		platform_set_drvdata(pdev, chip);
  1027	
  1028		/* Initialise charger state */
  1029		schedule_delayed_work(&chip->status_change_work, 0);
  1030	
  1031		return 0;
  1032	}
  1033	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
