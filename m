Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4690553649
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiFUPiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352887AbiFUPiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 11:38:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA1BC0C
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655825884; x=1687361884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nAlE/nIO7+m2+e5Bf42dx1Kks3QKFV40CBSbAaPKD7g=;
  b=VhpNdva2oSqcKwmguY43Tk7BIy9c7fOCPqbzEQ2onyMVHujWaZ+N5Zij
   ORsF8KTaM3+n8fzfQdrmqfbIh9Oe/TkAG+viSuB0B/4IelqI1PivvrHdr
   YTZ//ElcCrsuA5MEpZjCth8j/BRrljYRR/EerhrBqUVSNBKSPprQN3zpR
   fa79uEP4m4cj4y+1FCg8jdpxLV9cDZ5AzrHiBhZ7ULz+ISoq+uaLKI1bt
   9Z9pDZdk9ES/upPjmU7clfjX4I8Bgmr7a/GmDQ+dMIhci5rbaKNYhAUUe
   1BCPIzDzS7DcKJqIS23qLRtt7NfyzadUY+3UgqvnYlEN5hMNC2ifubEIz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281213239"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="281213239"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 08:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="585814394"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2022 08:38:02 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3fx4-00005f-0T;
        Tue, 21 Jun 2022 15:38:02 +0000
Date:   Tue, 21 Jun 2022 23:37:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang He <windhl@126.com>, sre@kernel.org, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] power/supply/olpc_battery: Hold the reference returned
 by of_find_compatible_node
Message-ID: <202206212323.c8gOHmJb-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220621/202206212323.c8gOHmJb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/911b0892099263f0acd11bd5ae75509f9ac677db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-He/power-supply-olpc_battery-Hold-the-reference-returned-by-of_find_compatible_node/20220621-152751
        git checkout 911b0892099263f0acd11bd5ae75509f9ac677db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/power/supply/olpc_battery.c: In function 'olpc_battery_probe':
>> drivers/power/supply/olpc_battery.c:653:67: error: expected ';' before 'if'
     653 |         np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")
         |                                                                   ^
         |                                                                   ;
     654 |         if (np) {
         |         ~~                                                         
   drivers/power/supply/olpc_battery.c:639:17: warning: unused variable 'status' [-Wunused-variable]
     639 |         uint8_t status;
         |                 ^~~~~~
>> drivers/power/supply/olpc_battery.c:638:29: warning: variable 'np' set but not used [-Wunused-but-set-variable]
     638 |         struct device_node *np;
         |                             ^~


vim +653 drivers/power/supply/olpc_battery.c

   632	
   633	static int olpc_battery_probe(struct platform_device *pdev)
   634	{
   635		struct power_supply_config bat_psy_cfg = {};
   636		struct power_supply_config ac_psy_cfg = {};
   637		struct olpc_battery_data *data;
 > 638		struct device_node *np;
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
