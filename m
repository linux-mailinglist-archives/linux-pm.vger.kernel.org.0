Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CD55340D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiFUNyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiFUNyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 09:54:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3519C19
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655819647; x=1687355647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gnnPunYnez1c2VI/4VDVO7sF6xavt6JSpptivWVcwM=;
  b=Ri9uEoqxb5Tyna/fEWkm87K9zohOy3oFaDDza9g3EPVnLURSwRTDOvS1
   ZZ7SyxED78A67uYCVRHWqiQ8Y5xA/cYTFN+aV+K6Bd7SHcJn2JcBFsDxO
   0cyQONcfzQSsB+w8ISaRpU7EKaFr23FRhvaGp2sYlyykWL5hZSfRwDgCN
   yqHEPQ9uybM5C6o/nJWmmkL4/h9Qdsh7H62eLOsBaYXbw4nSYDmKQWIZ1
   kqFUBI/Wt1zmpfMKtC3wvlnp+0Al43aMHuPFxdMpjSPneUwzD5Puc90GD
   T2P2t5cujCpMtLzY8XW0sFEqEMdXEfDxVyC/tvauSE36wsKDeZ3mJZ/g8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341805635"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341805635"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833585136"
Received: from lkp-server02.sh.intel.com (HELO 08b4593be841) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 06:54:05 -0700
Received: from kbuild by 08b4593be841 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3eKS-00002L-Ul;
        Tue, 21 Jun 2022 13:54:04 +0000
Date:   Tue, 21 Jun 2022 21:53:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang He <windhl@126.com>, sre@kernel.org, linux-pm@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH] power/supply/olpc_battery: Hold the reference returned
 by of_find_compatible_node
Message-ID: <202206212155.CveAC2KI-lkp@intel.com>
References: <20220621072408.4080461-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621072408.4080461-1-windhl@126.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Liang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-He/power-supply-olpc_battery-Hold-the-reference-returned-by-of_find_compatible_node/20220621-152751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: hexagon-randconfig-r041-20220621 (https://download.01.org/0day-ci/archive/20220621/202206212155.CveAC2KI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/911b0892099263f0acd11bd5ae75509f9ac677db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-He/power-supply-olpc_battery-Hold-the-reference-returned-by-of_find_compatible_node/20220621-152751
        git checkout 911b0892099263f0acd11bd5ae75509f9ac677db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/power/supply/olpc_battery.c:653:60: error: expected ';' after expression
           np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")
                                                                     ^
                                                                     ;
   1 error generated.


vim +653 drivers/power/supply/olpc_battery.c

   632	
   633	static int olpc_battery_probe(struct platform_device *pdev)
   634	{
   635		struct power_supply_config bat_psy_cfg = {};
   636		struct power_supply_config ac_psy_cfg = {};
   637		struct olpc_battery_data *data;
   638		struct device_node *np;
   639		uint8_t status;
   640		uint8_t ecver;
   641		int ret;
   642	
   643		data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
   644		if (!data)
   645			return -ENOMEM;
   646		platform_set_drvdata(pdev, data);
   647	
   648		/* See if the EC is already there and get the EC revision */
   649		ret = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
   650		if (ret)
   651			return ret;
   652	
 > 653		np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")
   654		if (np) {
   655			of_node_put(np);
   656			/* XO 1.75 */
   657			data->new_proto = true;
   658			data->little_endian = true;
   659		} else if (ecver > 0x44) {
   660			/* XO 1 or 1.5 with a new EC firmware. */
   661			data->new_proto = true;
   662		} else if (ecver < 0x44) {
   663			/*
   664			 * We've seen a number of EC protocol changes; this driver
   665			 * requires the latest EC protocol, supported by 0x44 and above.
   666			 */
   667			printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
   668				"battery driver.\n", ecver);
   669			return -ENXIO;
   670		}
   671	
   672		ret = olpc_ec_cmd(EC_BAT_STATUS, NULL, 0, &status, 1);
   673		if (ret)
   674			return ret;
   675	
   676		/* Ignore the status. It doesn't actually matter */
   677	
   678		ac_psy_cfg.of_node = pdev->dev.of_node;
   679		ac_psy_cfg.drv_data = data;
   680	
   681		data->olpc_ac = devm_power_supply_register(&pdev->dev, &olpc_ac_desc,
   682									&ac_psy_cfg);
   683		if (IS_ERR(data->olpc_ac))
   684			return PTR_ERR(data->olpc_ac);
   685	
   686		if (of_device_is_compatible(pdev->dev.of_node, "olpc,xo1.5-battery")) {
   687			/* XO-1.5 */
   688			olpc_bat_desc.properties = olpc_xo15_bat_props;
   689			olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
   690		} else {
   691			/* XO-1 */
   692			olpc_bat_desc.properties = olpc_xo1_bat_props;
   693			olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
   694		}
   695	
   696		bat_psy_cfg.of_node = pdev->dev.of_node;
   697		bat_psy_cfg.drv_data = data;
   698		bat_psy_cfg.attr_grp = olpc_bat_sysfs_groups;
   699	
   700		data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc,
   701									&bat_psy_cfg);
   702		if (IS_ERR(data->olpc_bat))
   703			return PTR_ERR(data->olpc_bat);
   704	
   705		if (olpc_ec_wakeup_available()) {
   706			device_set_wakeup_capable(&data->olpc_ac->dev, true);
   707			device_set_wakeup_capable(&data->olpc_bat->dev, true);
   708		}
   709	
   710		return 0;
   711	}
   712	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
